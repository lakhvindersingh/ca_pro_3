<?php
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

class DashboardController extends AppController
{

    public $paginate = [
        'limit' => 5,
		'sortWhitelist' => [
			'Users.id', 'Users.email', 'Users.created'
		],
        'order' => [
            'Users.id' => 'desc'
        ]
    ];
	
	public function initialize(){
		parent::initialize();
		$this->viewBuilder()->layout('admin/admin');
		$this->loadComponent('Paginator');
	}
	
	/**
	* @name index
	* Purpose : This method is used to display Dashboard Home 
	* @author Pawan Bhatia
	* @access public
	* @return void
	*/
	 
	public function index()
    {
    	
    }


	public function listing($type = null)
    {
    	$this->viewBuilder()->layout('admin/admin_dashboard');
    	$usersTable = TableRegistry::get('Users');

    	if($this->request->is(['post', 'put'])){
    		
    		$action = isset($this->request->data['user_action']) ? $this->request->data['user_action'] : '';

    		if(!empty($action)){
    			switch($action)
	    		{
	    			case 'Delete':
	    				
							$usersTable = TableRegistry::get('Users');
							$ids = $this->request->data['user'];
							$deletedIds = [];
							foreach($ids as $id){
								$entity = $usersTable->get($id);
								$result = $usersTable->delete($entity);
								if($result){
									$deletedIds[] = $id;
								}
							}

							$deletedCount = count($deletedIds);
							$userC = "User";
							if($deletedCount > 1)
								$userC = "Users";

							$this->Flash->set('Selected '.$userC.' deleted', [
							    'element' => 'success'
							]);
							return $this->redirect(['controller'=>'Dashboard', 'action'=>'listing', 'prefix' => 'admin']);
						
	    			break;
	    			case 'Activate':
	    					$usersTable = TableRegistry::get('Users');
							$ids = $this->request->data['user'];
							$deletedIds = [];
							foreach($ids as $id){
								$entity = $usersTable->get($id);
								$entity->is_active = 1;
								$result = $usersTable->save($entity);
								if($result){
									$deletedIds[] = $id;
								}
							}

							$deletedCount = count($deletedIds);
							$userC = "User";
							if($deletedCount > 1)
								$userC = "Users";

							$this->Flash->set('Selected '.$userC.' Activated', [
							    'element' => 'success'
							]);
							return $this->redirect(['controller'=>'Dashboard', 'action'=>'listing', 'prefix' => 'admin']);
	    			break;
	    			case 'Deactivate':
	    					$usersTable = TableRegistry::get('Users');
							$ids = $this->request->data['user'];
							$deletedIds = [];
							foreach($ids as $id){
								$entity = $usersTable->get($id);
								$entity->is_active = 0;
								$result = $usersTable->save($entity);
								if($result){
									$deletedIds[] = $id;
								}
							}

							$deletedCount = count($deletedIds);
							$userC = "User";
							if($deletedCount > 1)
								$userC = "Users";

							$this->Flash->set('Selected '.$userC.' De-activated', [
							    'element' => 'success'
							]);
							return $this->redirect(['controller'=>'Dashboard', 'action'=>'listing', 'prefix' => 'admin']);
	    			break;
	    		}	
    		}else{
    			$this->Flash->set('Select Action first to complete process!', [
				    'element' => 'error'
				]);
    		}
    		
    	}
    	
    	if(!empty($type)){
    		$allUsers = $usersTable->find('all', ['conditions'=>['Users.role'=>$type],'contain'=>['Profiles']]);	
    	}else{
    		$allUsers = $usersTable->find('all', ['contain'=>['Profiles']]);	
    	}
    	
    	$allUsers = $this->paginate($allUsers);

    	$this->set(compact('allUsers'));
    }
   
	/**
	* @name getRuntimeElements
	* Purpose : This method is used to render elements using ajax during runtime
	* @author Pawan Bhatia
	* @access public
	* @return HTML
	*/
	public function getRuntimeElements()
    {
		$this->viewBuilder()->layout('ajax');
		$this->autoRender = false;
		if($this->request->is(['post', 'put'])){
			$action = isset($this->request->data['action']) ? $this->request->data['action'] : '';
			
			switch($action)
			{
				case 'getChapter':
					$area_id = isset($this->request->data['area_id']) ? $this->request->data['area_id'] : '';
					$this->loadModel('Chapters');
					$chaptersList = [];
					$chaptersObj = $this->Chapters->find('all', ['conditions'=>['Chapters.area_id'=>$area_id]]);
					
					foreach($chaptersObj as $chapter){
						$chaptersList[$chapter->id] = $chapter->title.' ( '.$chapter->object_id.' )';
					}
					$this->set(compact('chaptersList'));
					echo $this->render('/Element/getChapter');
					die;
				break;
				case 'getLesson':
					$chapter_id = isset($this->request->data['chapter_id']) ? $this->request->data['chapter_id'] : '';
					$this->loadModel('Lessons');
					$lessonsList = [];
					$lessonsObj = $this->Lessons->find('all', ['conditions'=>['Lessons.chapter_id'=>$chapter_id]]);
					
					foreach($lessonsObj as $lessons){
						$lessonsList[$lessons->id] = $lessons->title. ' ( '.$lessons->object_id.' )';
					}
					$this->set(compact('lessonsList'));
					echo $this->render('/Element/getLesson');
					die;
				break;
				default:
					
				break;
			}
		}
    }
}

