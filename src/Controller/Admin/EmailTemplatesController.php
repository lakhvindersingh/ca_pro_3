<?php 
/**
 * CakePHP(tm) : Rapid Development Framework (http://cakephp.org)
 * Copyright (c) Cake Software Foundation, Inc. (http://cakefoundation.org)
 *
 * Licensed under The MIT License
 * For full copyright and license information, please see the LICENSE.txt
 * Redistributions of files must retain the above copyright notice.
 *
 * @copyright Copyright (c) Cake Software Foundation, Inc. (http://cakefoundation.org)
 * @link      http://cakephp.org CakePHP(tm) Project
 * @since     0.2.9
 * @license   http://www.opensource.org/licenses/mit-license.php MIT License
 */
namespace App\Controller\Admin;

use App\Controller\AppController;
use Cake\Event\Event;
use Cake\Core\Configure;
use Cake\Network\Exception\NotFoundException;
use Cake\View\Exception\MissingTemplateException;
use Cake\ORM\TableRegistry;
use Cake\I18n\Time;
use Cake\Network\Email\Email;
use Cake\Utility\Text;
use Cake\Routing\Router;
use Cake\View\Helper\SessionHelper;
use Cake\Network\Session\DatabaseSession;
use Cake\Auth\DefaultPasswordHasher;
use Cake\Validation\Validator;
use Cake\Utility\Inflector;

class EmailTemplatesController extends AppController
{
	public $paginate = [
        'limit' => ADMINPAGINATIONLIMIT,
		'sortWhitelist' => [
			'EmailTemplates.id', 
			'EmailTemplates.title',
			'EmailTemplates.slug',
			'EmailTemplates.subject',
			'EmailTemplates.from_email',
			'EmailTemplates.created',
			'EmailTemplates.status_id'
		],
        'order' => [
            'EmailTemplates.id' => 'desc'
        ]
    ];
    
			
    public function initialize(){
		parent::initialize();
		$this->viewBuilder()->layout('admin/admin');
		$this->loadComponent('Paginator');
	}
	
	/**
	 * @name index
	 * Purpose : This method is used to display/search email template list, Active, inactive and delete email template 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if successful login
	 */
	 
	public function index()
    {
		$templates = $this->EmailTemplates->find('all');
		$templates = $this->paginate($templates);
		
		if($this->request->is(['post', 'put'])){
    		
    		$action = isset($this->request->data['option']) ? $this->request->data['option'] : '';
			$ids = isset($this->request->data['ids']) ? $this->request->data['ids'] : '';
		
    		if(!empty($action))
    		{
				if(!empty($ids))
				{
					switch($action)
					{
						case 'delete':
							
								$deletedIds = [];
								foreach($ids as $id){
									$entity = $this->EmailTemplates->get($id);
									$result = $this->EmailTemplates->delete($entity);
									if($result){
										$deletedIds[] = $id;
									}
								}

								$deletedCount = count($deletedIds);
								$userC = "Email Template";
								if($deletedCount > 1)
									$userC = "Email Templates";

								$this->Flash->set('Selected '.$userC.' deleted', [
									'element' => 'success'
								]);
								return $this->redirect(['action'=>'index', 'prefix' => 'admin']);
							
						break;
						case 'active':
								$usersTable = TableRegistry::get('Users');
								$deletedIds = [];
								foreach($ids as $id){
									$entity = $this->EmailTemplates->get($id);
									$entity->status_id = 1;
									$result = $this->EmailTemplates->save($entity);
									if($result){
										$deletedIds[] = $id;
									}
								}

								$deletedCount = count($deletedIds);
								$userC = "Email Template";
								if($deletedCount > 1)
									$userC = "Email Templates";

								$this->Flash->set('Selected '.$userC.' Activated', [
									'element' => 'success'
								]);
								return $this->redirect(['action'=>'index', 'prefix' => 'admin']);
						break;
						case 'deactive':
								$usersTable = TableRegistry::get('Users');
								$deletedIds = [];
								foreach($ids as $id){
									$entity = $this->EmailTemplates->get($id);
									$entity->status_id = 0;
									$result = $this->EmailTemplates->save($entity);
									if($result){
										$deletedIds[] = $id;
									}
								}

								$deletedCount = count($deletedIds);
								$userC = "Email Template";
								if($deletedCount > 1)
									$userC = "Email Templates";

								$this->Flash->set('Selected '.$userC.' De-activated', [
									'element' => 'success'
								]);
								return $this->redirect(['action'=>'index', 'prefix' => 'admin']);
						break;
					}	
				}else
				{
					$this->Flash->error('Select Email Template to complete process!', [
						'element' => 'error'
					]);
				}
    		}else{
    			$this->Flash->error('Select Action first to complete process!', [
				    'element' => 'error'
				]);
    		}
    	}
    	
		$keyword = '';
    	if(isset($_GET['keyword']) && !empty($_GET['keyword'])){
			$keyword = $_GET['keyword'];
			
			$options['fields'] 			= 	[];
			$options['order'] 			= 	['EmailTemplates.id' =>'DESC'];
			$options['conditions'][] 	= 	['OR' => 
												[
													['EmailTemplates.title LIKE' 		=> '%'.$keyword.'%'],
													['EmailTemplates.slug LIKE' 		=> '%'.$keyword.'%'],
													['EmailTemplates.subject LIKE' 		=> '%'.$keyword.'%'],
													['EmailTemplates.from_email LIKE' 	=> '%'.$keyword.'%'],
													['EmailTemplates.created LIKE' 		=> '%'.$keyword.'%']
												]
											];
			$templates = $this->EmailTemplates->find('all', $options); 
		}


		$this->set(compact(['keyword', 'templates']));
    }
    
    /**
	 * @name add
	 * Purpose : This method is used to add email template 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if successful login
	 */
	 
    public function add()
    {
        if($this->request->is(['post', 'put'])){
			$this->loadModel('EmailTemplates');
			$emails = $this->EmailTemplates->newEntity();
			$emails = $this->EmailTemplates->patchEntity($emails, $this->request->data);
			
			if($this->EmailTemplates->save($emails)){
				$this->Flash->success(
						__('Email Template added successfully'),
						'default',
						[],
						''
					);
				return $this->redirect(['action'=>'index']);
			}else{
				$this->Flash->error(
						__('Email Template is not added, try again later.'),
						'default',
						[],
						''
					);
			}
		}
    }
    
    /**
	 * @name edit
	 * Purpose : This method is used to edit email template
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if successful login
	 */
	 
    public function edit($id = null)
    {
		if (!$id) {
            $this->Flash->error(
						__('Invalid Email Templates'),
						'default',
						[],
						''
					);
			return $this->redirect(['action'=>'index']);
        }
        $this->loadModel('EmailTemplates');
        if($this->request->is(['post', 'put'])){
			$emails = $this->EmailTemplates->get($this->request->data['id']);
			$emails = $this->EmailTemplates->patchEntity($emails, $this->request->data);
			if($this->EmailTemplates->save($emails)){
				$this->Flash->success(
						__('Email Template updated successfully'),
						'default',
						[],
						''
					);
				return $this->redirect(['action'=>'index']);
			}else{
				$this->Flash->error(
						__('Email Template is not updated, try again later.'),
						'default',
						[],
						''
					);
			}
		}
        
        $emailTemplate = $this->EmailTemplates->get($id);
        $this->set(compact(['emailTemplate']));
    }
}
