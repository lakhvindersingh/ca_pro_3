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

class StudentsController extends AppController
{
   
    public $paginate = [
        'limit' => ADMINPAGINATIONLIMIT,
		'sortWhitelist' => [
			'Students.id', 'Students.first_name', 'Students.created', 'Users.first_name', 'Students.status'
		],
        'order' => [
            'Students.id' => 'desc'
        ]
    ];
    
    public function initialize(){
		parent::initialize();
		$this->viewBuilder()->layout('admin/admin');
		$this->loadComponent('Paginator');
	}
	
	/**
	 * @name students
	 * Purpose : This method is used to display students list 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if successful login
	 */
	public function index(){
		$this->loadModel('Students');
		$students = $this->Students->find('all', ['contain'=>['Users']]);
		
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
							
								$studentsTable = TableRegistry::get('Students');
								$deletedIds = [];
								foreach($ids as $id){
									$entity = $studentsTable->get($id);
									$result = $studentsTable->delete($entity);
									if($result){
										$deletedIds[] = $id;
									}
								}

								$deletedCount = count($deletedIds);
								$userC = "Student";
								if($deletedCount > 1)
									$userC = "Students";

								$this->Flash->set('Selected '.$userC.' deleted', [
									'element' => 'success'
								]);
								return $this->redirect(['controller'=>'Students', 'action'=>'index', 'prefix' => 'admin']);
							
						break;
						case 'active':
								$studentsTable = TableRegistry::get('Students');
								$deletedIds = [];
								foreach($ids as $id){
									$entity = $studentsTable->get($id);
									$entity->status = 1;
									$result = $studentsTable->save($entity);
									if($result){
										$deletedIds[] = $id;
									}
								}

								$deletedCount = count($deletedIds);
								$userC = "Student";
								if($deletedCount > 1)
									$userC = "Students";

								$this->Flash->set('Selected '.$userC.' Activated', [
									'element' => 'success'
								]);
								return $this->redirect(['controller'=>'Students', 'action'=>'index', 'prefix' => 'admin']);
						break;
						case 'deactive':
								$studentsTable = TableRegistry::get('Students');
								$deletedIds = [];
								foreach($ids as $id){
									$entity = $studentsTable->get($id);
									$entity->status = 2;
									$result = $studentsTable->save($entity);
									if($result){
										$deletedIds[] = $id;
									}
								}

								$deletedCount = count($deletedIds);
								$userC = "Student";
								if($deletedCount > 1)
									$userC = "Students";

								$this->Flash->set('Selected '.$userC.' De-activated', [
									'element' => 'success'
								]);
								return $this->redirect(['controller'=>'Students', 'action'=>'index', 'prefix' => 'admin']);
						break;
					}	
				}else
				{
					$this->Flash->error('Select Users to complete process!', [
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
			$options['order'] 			= 	['Users.id' =>'DESC'];
			$options['conditions'][] 	= 	['Users.group_id' => '2'];
			$options['conditions'][] 	= 	['OR' => 
												[
													['Students.first_name LIKE' 	=> '%'.$keyword.'%'],
													['Students.last_name LIKE' 		=> '%'.$keyword.'%'],
													['Users.first_name LIKE' 		=> '%'.$keyword.'%'],
													['Users.last_name LIKE' 		=> '%'.$keyword.'%'],
													['Users.email LIKE' 			=> '%'.$keyword.'%'],
													['Users.created LIKE' 			=> '%'.$keyword.'%']
												]
											];
			$students = $this->Students->find('all', $options)->contain(['Users']); 
		}
		
    	$students = $this->paginate($students);
        $this->set(compact(['students', 'keyword']));
    }

    	/**
	* @name add
	* Purpose : This method is used to add new user
	* @author Pawan Bhatia
	* @access public
	* @return true
	*/
	public function add() {

		if($this->request->is('POST'))
		{
			$error = '';
			$this->loadModel('Students');
			$user_data = $this->request->data;
			$user_data['birthday'] = new Time($user_data['birthday']);
			
			$countUserAreas = $this->Students->countUserStudents($user_data['user_id'], ADD_STUDENT_LIMIT);

			if(!$countUserAreas){
				$error .= "You have already added ". ADD_STUDENT_LIMIT ." Student for selected Teacher.  ";
				$this->Flash->error(
						__($error),
						'default',
						[],
						''
					);
			}else{
				$user = $this->Students->newEntity($user_data);
				$errors = $user->errors();
				
				if(!empty($errors)) {
					foreach ($errors as $key => $value) {
						$error .= $value[array_keys($value)[0]].",  ";
					}
				}   
				 
				if(!empty($error)) {
					$this->Flash->error(
							__($error),
							'default',
							[],
							''
						);
				}
				else {
					
					$user = $this->Students->patchEntity($user, $user_data);
					if($this->Students->save($user))
					{
						$this->Flash->success(
							__('User successfully registered.'),
							'default',
							[],
							''
						);
						return $this->redirect(['action'=>'index', 'prefix'=>'admin']);
					} else
					{
						$this->Flash->error(
							__('User cannot be saved right now. Please try again.'),
							'default',
							[],
							''
						);
					}		
				}
			}
		}
		
		$this->loadModel('Users');
		$users = $this->Users->find('all', ['conditios'=>['group_id'=>'1']]);
		foreach($users as $user){
			$firstname = isset($user->first_name) ? $user->first_name : '';
			$lastname = isset($user->last_name) ? $user->last_name : '';
			$user_type = isset($user->user_type) ? $user->user_type : '';
			$user_type = ($user_type == 1) ? 'Primary' : 'Elementry';
			$usersList[$user->id] = $firstname. ' ' .$lastname. ' ('.$user_type.')';
		}
		$this->set(compact('usersList'));
	}
	
	/**
	 * @name AddCsv
	 * Purpose : This method is used to Add multiple Students using CSV file 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if successful edit else error
	 */
	public function addCsv()
    {
		if($this->request->is(['post'])){
			$fileData = $this->request->data['csv'];
			$modelName = 'Students';
			if($fileData['type'] == "text/csv"){
				
				if (is_uploaded_file($fileData['tmp_name'])) {
					$i = '';
					
					$handle = fopen($fileData['tmp_name'], "r");
					$header = fgetcsv($handle);
					$data	= [];
					
					while (($row = fgetcsv($handle)) !== FALSE) {
						$i++;
						foreach ($header as $k=>$head) {

							$this->loadComponent('Common');

							if (strpos($head,'.')!==false) {
								$h = explode('.',$head);

								if($h[1] == 'object_id'){
									
									if(isset($row[$k]) && !empty($row[$k]))
										$data[$i][$h[1]] = $row[$k];
									else
										$data[$i][$h[1]] = $this->Common->generateRandomString(10);
										
								}else{
									$data[$i][$h[1]]=(isset($row[$k])) ? $row[$k] : '';
								}
							}
							else{
								if($head == 'object_id'){
									
									if(isset($row[$k]) && !empty($row[$k]))
										$data[$i][$head] = $row[$k];
									else
										$data[$i][$head] = $this->Common->generateRandomString(10);
										
								}else{
									$data[$i][$head]=(isset($row[$k])) ? $row[$k] : '';
								}
							}
						}
					}
					
					$error = '';
					fclose($handle);

					foreach($data as $k=>$dd){
						
						$dd = $this->$modelName->newEntity($dd);
						$errors = $dd->errors();
						
						if(!empty($errors)){
							foreach ($errors as $key => $value) {
								$error .= "Row : ".$k." ".$value[array_keys($value)[0]].",  ";
							}
						}
						
						$dataSave = false;
						if(empty($error)){
							if($this->$modelName->save($dd)){
								$error .= '';
								$dataSave = true;
							}else{
								$error .='Row : '.$k.'Data import failed';
								$dataSave = false;
							}
						}else{
							
						}
						
					}
					if($dataSave){
						$this->Flash->success(
							__('Data Imported successfully.'),
							'default',
							[],
							''
						);
						return $this->redirect(['action'=>'index', 'prefix'=>'admin']);
					}else{
						$this->Flash->error(
							__('Data Importe failed. '. $error),
							'default',
							[],
							''
						);
					}
				}
			}else{
				$this->Flash->error(
					__('Select CSV file to import data.'),
					'default',
					[],
					''
				);
			}
		}
    }
    
	/**
	 * @name Edit
	 * Purpose : This method is used to edit user 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if successful edit else error
	 */
	public function edit($id = null)
    {
		if (!$id) {
            $this->Flash->success(
						__('Invalid user'),
						'default',
						[],
						''
					);
			return $this->redirect(['action'=>'index']);
        }
        
        if($this->request->is(['post', 'put'])){
			$userData = $this->Students->get($id);

			$this->request->data['birthday'] = new Time($this->request->data['birthday']);
			
			$user = $this->Students->patchEntity($userData, $this->request->data);
			if($savedUser = $this->Students->save($user)){
				$this->Flash->success(
						__('Student updated successfully'),
						'default',
						[],
						'auth'
					);
				return $this->redirect(['action'=>'index']);
			}
		}
		
        $this->loadModel('Users');
		$users = $this->Users->find('all', ['conditios'=>['group_id'=>'1']]);
		foreach($users as $user){
			$firstname = isset($user->first_name) ? $user->first_name : '';
			$lastname = isset($user->last_name) ? $user->last_name : '';
			$user_type = isset($user->user_type) ? $user->user_type : '';
			$user_type = ($user_type == 1) ? 'Primary' : 'Elementry';
			$usersList[$user->id] = $firstname. ' ' .$lastname. ' ('.$user_type.')';
		}
		
		$student = $this->Students->get($id, ['contain'=>['Users']]);
		$this->set(compact('student', 'usersList'));
    }
    
}
