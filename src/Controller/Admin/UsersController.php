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

class UsersController extends AppController
{
   
    public $paginate = [
        'limit' => ADMINPAGINATIONLIMIT,
		'sortWhitelist' => [
			'Users.id', 'Users.email', 'Users.created', 'Users.first_name', 'Users.user_type', 'Users.is_active'
		],
        'order' => [
            'Users.id' => 'desc'
        ]
    ];
    
    public function initialize(){
		parent::initialize();
		$this->Cookie->config([
			'expires' => '+10 days'
		]);
		$this->viewBuilder()->layout('admin/admin');
		$this->loadComponent('Paginator');
		$this->loadComponent('Captcha');
		$this->Auth->allow(['login', 'resetPassword']);
	}

	public function beforeFilter(\Cake\Event\Event $event){
		$this->Auth->allow(['add', 'captcha']);
	}

    function captcha()	{
        $this->autoRender = false;
        $this->viewBuilder()->layout('ajax');
        $this->Captcha->create();
    }

	/**
	 * @name index
	 * Purpose : This method is used to display/search users list, Active, inactive and delete Teachers 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if successful login
	 */
	public function index($group_id = 2){
		$users = $this->Users->find('all', ['conditions'=>['group_id'=>$group_id, 'NOT' => ['Users.id' => 27]]])->contain(['Countries']);
		die(print_r($users));
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
							
								$usersTable = TableRegistry::get('Users');
								$deletedIds = [];
								foreach($ids as $id){
									$entity = $usersTable->get($id);
									$result = $usersTable->delete($entity);
									if($result){
										$deletedIds[] = $id;
									}
								}

								$deletedCount = count($deletedIds);
								$userC = "Teacher";
								if($deletedCount > 1)
									$userC = "Teachers";

								$this->Flash->set('Selected '.$userC.' deleted', [
									'element' => 'success'
								]);
								return $this->redirect(['controller'=>'Users', 'action'=>'index', 'prefix' => 'admin']);
							
						break;
						case 'active':
								$usersTable = TableRegistry::get('Users');
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
								$userC = "Teacher";
								if($deletedCount > 1)
									$userC = "Teachers";

								$this->Flash->set('Selected '.$userC.' Activated', [
									'element' => 'success'
								]);
								return $this->redirect(['controller'=>'Users', 'action'=>'index', 'prefix' => 'admin']);
						break;
						case 'deactive':
								$usersTable = TableRegistry::get('Users');
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
								$userC = "Teacher";
								if($deletedCount > 1)
									$userC = "Teachers";

								$this->Flash->set('Selected '.$userC.' De-activated', [
									'element' => 'success'
								]);
								return $this->redirect(['controller'=>'Users', 'action'=>'index', 'prefix' => 'admin']);
						break;
					}	
				}else
				{
					$this->Flash->error('Select Teachers to complete process!', [
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
			$options['conditions'][] 	= 	['Users.group_id' => $group_id];
			$options['conditions'][] 	= 	['NOT' => ['Users.id' => 27]];
			$options['conditions'][] 	= 	['OR' => 
												[
													['Users.first_name LIKE' 	=> '%'.$keyword.'%'],
													['Users.last_name LIKE' 	=> '%'.$keyword.'%'],
													['Users.email LIKE' 		=> '%'.$keyword.'%'],
													['Users.created LIKE' 		=> '%'.$keyword.'%'],
													['Users.username LIKE' 		=> '%'.$keyword.'%'],
												]
											];
			$users = $this->Users->find('all', $options)->contain(['Countries']); 
		}

    	$users = $this->paginate($users);
        $this->set(compact('users', 'keyword', 'group_id'));
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
			$this->loadModel('Users');
			$user_data = $this->request->data;

			//$user_data['last_login'] = $this->request->header('timestamp');
			$user_data['status_id'] = 3;
				
			// In a controller action
			$this->loadComponent('Common');
			$randString = $this->Common->generateRandomString(25);
			$user_data['verification_token'] = $randString; 

			$sessionId = $this->Common->generateRandomString(25);
			$user_data['sessionId'] = $sessionId; 
			
			$this->Users->validator()->remove('password', 'compare');
			
			$user = $this->Users->newEntity($user_data);
			$errors = $user->errors();

			if(!empty($errors)) {
				foreach ($errors as $key => $value) {
					$error .= $value[array_keys($value)[0]].",  ";
				}
			}   
			 
			if(!empty($error)) {
				$this->Flash->success(
						__($error),
						'default',
						[],
						''
					);
			}
			else {
				
				$user = $this->Users->patchEntity($user, $user_data);

				if($this->Users->save($user))
				{
					
					$linkTag = "http://" . $_SERVER['SERVER_NAME'] . Router::url(array('controller' => 'Users', 'action' => 'verify_user', $user['email'],
				$user['verification_token'], 'prefix'=>false));

					$arr = array();
					$arr['{{name}}'] = $user['first_name']." ".$user['last_name'];
					$arr['{{activation_url}}'] = $linkTag;
					
					$this->loadModel('EmailTemplates');
					$email_content = $this->EmailTemplates->findBySlug('verify-email')->toArray();

					$subject = $email_content[0]->subject;
					
					$content = $email_content[0]->content;
					$content = str_replace(array_keys($arr), array_values($arr), $content);

					$email = new Email('default');
					$email->from($email_content[0]->from_email);
					$email->to($user['email']);
					$email->subject($subject);
					$email->replyTo($email_content[0]->reply_to);
					$email->emailFormat('html');
					
					$email->send($content);
					
					$this->Flash->success(
						__('Teacher successfully registered.'),
						'default',
						[],
						''
					);
					return $this->redirect(['action'=>'index', 'prefix'=>'admin']);
				} else
				{
					$this->Flash->success(
						__('Teacher cannot be saved right now. Please try again.'),
						'default',
						[],
						''
					);
				}		
			}
		}
	}
	
	/**
	 * @name AddCsv
	 * Purpose : This method is used to Add multiple area using CSV file 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if successful edit else error
	 */
	public function addCsv()
    {
		if($this->request->is(['post'])){
			$fileData = $this->request->data['csv'];
			$modelName = 'Users';
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
								
								if($h[1] == 'verification_token' || $h[1] == 'sessionId'){
									
									if(isset($row[$k]) && !empty($row[$k]))
										$data[$i][$h[1]] = $row[$k];
									else
										$data[$i][$h[1]] = $this->Common->generateRandomString(25);
										
								}else{
									$data[$i][$h[1]]=(isset($row[$k])) ? $row[$k] : '';
								}
							}
							else{
								if($head == 'verification_token' || $head == 'sessionId'){
									
									if(isset($row[$k]) && !empty($row[$k]))
										$data[$i][$head] = $row[$k];
									else
										$data[$i][$head] = $this->Common->generateRandomString(25);
										
								}else{
									$data[$i][$head]=(isset($row[$k])) ? $row[$k] : '';
								}
							}
						}
					}
					
					$error = '';
					fclose($handle);

					foreach($data as $k=>$dd){
						$this->$modelName->validator()->remove('password', 'compare');
						$dd = $this->$modelName->newEntity($dd);
						$errors = $dd->errors();
						
						if(!empty($errors)){
							foreach ($errors as $key => $value) {
								$error .= "Row : ".$k." ".$value[array_keys($value)[0]].", ";
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
							__('Data Import failed. '. $error),
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
						__('Invalid Teacher'),
						'default',
						[],
						''
					);
			return $this->redirect(['action'=>'index']);
        }
        
        if($this->request->is(['post', 'put'])){
			
			$error = '';
			
			if(isset($this->request->data['image']['name']) && !empty($this->request->data['image']['name'])){
				$image = $this->request->data['image'];
				
				$this->loadComponent('Utility');
				$img_return = $this->Utility->saveImageToServer($id, $image, USER_IMAGE_PATH);

				if($img_return['status'])
				{
					$this->request->data['image'] = $img_return['name'];
				} else
				{
					$error .= 'Image can not be uploaded.';
				}	
			}else{
				unset($this->request->data['image']);
			}
			
			if(empty($error)){
				$userData = $this->Users->get($id);
				$user = $this->Users->patchEntity($userData, $this->request->data);
				if($savedUser = $this->Users->save($user)){

					if($user->group_id == 1){
						$this->Flash->success(
							__('Admin updated successfully'),
							'default',
							[],
							''
						);
						return $this->redirect(['action'=>'index', 1]);
					}else{
						$this->Flash->success(
							__('Teacher updated successfully'),
							'default',
							[],
							''
						);
						return $this->redirect(['action'=>'index']);
					}
					
				}
				else{
					$this->Flash->error(
							__($error),
							'default',
							[],
							''
						);
				}
			}
			
		}
		
        $countriesTable = TableRegistry::get('Countries');
        $countries = $countriesTable->find('all', ['fields'=>['id', 'country']]);
        $countryList = [];
        foreach($countries as $country){
			$countryList[$country->id] = $country->country;
		}
		
		$user = $this->Users->get($id, ['contain'=>['Countries']]);
		$this->set(compact('user', 'countryList'));
    }
    
	/**
	 * @name login
	 * Purpose : This method is used to login 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if successful login
	 */
	 
	public function login() {
		$this->viewBuilder()->layout('admin/admin');
	
		if ($this->request->is('post')) {
			if ($this->request->data['remember_me'] == "1") {

				$cookie = array();
				$this->Cookie->write('RememberMe.username', $this->request->data['username']);
				$this->Cookie->write('RememberMe.password', $this->request->data['password']);
				unset($this->request->data['remember_me']);
			}
			
			$this->loadModel('Users');
			$this->Users->setCaptcha('securitycode', $this->Captcha->getCode('securitycode'));

			$user_data = $this->request->data;
			$user = $this->Auth->identify();
			//print_r($user); exit;
			
			$this->Users->validator()->remove('email');
			$this->Users->validator()->remove('username');
			$this->Users->validator()->remove('password');
			$this->Users->validator()->remove('first_name');
			$this->Users->validator()->remove('last_name');
			$this->Users->validator()->remove('classroom');
			$this->Users->validator()->remove('password', 'compare');

			// newEntity to validate captcha, It works on saving data
			$users = $this->Users->newEntity($user_data);

			$errors = $users->errors();

			if(empty($errors)){
				if ($user) {
					$this->Auth->setUser($user);

					if($user['is_active'] != 1){
						$this->Flash->error(
							__('Your account is not acitve, please contact website Administrator'),
							'default',
							[],
							'auth'
						);
						return $this->redirect($this->Auth->logout());
					}

					/*Updating user table last login*/
					$usersTable = TableRegistry::get('Users');
					$users = $usersTable->get($user['id']);

					$users->id = $user['id'];
					$users->last_login = Time::now();

					$usersTable->save($users);
					
					$this->Flash->success(
							__('User sucessfully logged in'),
							'default',
							[],
							'auth'
						);
					return $this->redirect($this->Auth->redirectUrl());
					
				} else {
					$this->Flash->error(
						__('Invalid user credentials. Please try again.'),
						'default',
						[],
						'auth'
					);
				}
			}else{
				$error = '';
				if(!empty($errors)) {
					foreach ($errors as $key => $value) {
						$error .= $value[array_keys($value)[0]].",  ";
					}
				}   
				 
				if(!empty($error)) {
					$this->Flash->success(
							__($error),
							'default',
							[],
							''
						);
				}

				$this->Auth->logout();
			}
		}
		
		
		$cookie = $this->Cookie->read('RememberMe');
		$this->set(compact('cookie'));

		/*
		 *  If want direct login via cookie uncomment code below
		 * 
		 */
		 
		/* 
		if(!empty($cookie)){
			$this->request->data = $cookie;
			
			$user = $this->Auth->identify();
			
			if ($user) {
				$this->Auth->setUser($user);

				if($user['is_active'] != 1){
					$this->Flash->error(
						__('Your account is not acitve, please contact website Administrator'),
						'default',
						[],
						'auth'
					);
					return $this->redirect($this->Auth->logout());
				}

				$usersTable = TableRegistry::get('Users');
				$users = $usersTable->get($user['id']);

				$users->id = $user['id'];
				$users->last_login = Time::now();

				$usersTable->save($users);
				
				$this->Flash->success(
						__('User sucessfully logged in'),
						'default',
						[],
						'auth'
					);
				return $this->redirect($this->Auth->redirectUrl());
			}
		}
		*/
	}
	
	/**
	* @name logout
	* Purpose : This method is used to logout user
	* @author Pawan Bhatia
	* @access public
	* @return true
	*/
	public function logout(){
		$this->Flash->success('You are now logged out.');
		$this->Cookie->delete('RememberMe');
		return $this->redirect($this->Auth->logout());
	}
	
	/**
	* @name changePassword
	* Purpose : This method is used to change password
	* @author Pawan Bhatia
	* @access public
	* @return true
	*/
	public function changePassword(){
		if($this->request->is(['post', ['put']]))
		{
			$id = $this->Auth->user('id');
			$user = $this->Users->get($id);
			
			$userData = $this->request->data;
			
			$passCheck = (new DefaultPasswordHasher)->check($userData['old_password'], $user->password);
			
				if($passCheck)
				{
					$error = '';
					$saveUser = $this->Users->patchEntity($user, $this->request->data);
					
					$errors = $saveUser->errors();
					
					if(!empty($errors)) {
						
						foreach ($errors as $key => $value) {
							$error .= $value[array_keys($value)[0]]."\n";
						}
					
						$this->Flash->error(
							__($error),
							'default',
							[],
							''
						);
					}else{
						$saveUser = $this->Users->save($saveUser);
						if($saveUser ) {
							$this->Flash->success(
								__('Password updated successfully.'),
								'default',
								[],
								''
							);
							return $this->redirect(['action'=>'changePassword']);
						}
						else{
							$this->Flash->error(
								__('The password could not be updated. Please try again'),
								'default',
								[],
								''
							);
						}		
					}
				}
				else
				{
					$this->Flash->error(
						__('Old password do not matched.'),
						'default',
						[],
						''
					);
				}
		}
				
	}
	
	public function forgotPassword(){
		$time = Time::now();
		
		$user = $this->Users->newEntity();

		$this->loadModel('PasswordRecoveries');
		$passwordRecovery = $this->PasswordRecoveries->newEntity();

		if ($this->request->is('post')) {

				$email = $this->request->data['email'];
				if($email){

				$users = $this->Users->find('all', ['conditions'=>['Users.email'=>$email]])->contain('Profiles');
				$user = $users->first();
				
				if(!empty($user)){
					unset($this->request->data['email']);
					
					$prevRecovery = $this->PasswordRecoveries->find('all', ['conditions'=>['PasswordRecoveries.user_id'=>$user->id]]);

					if(count($prevRecovery->all()) > 0){
						$this->PasswordRecoveries->deleteAll(['PasswordRecoveries.user_id'=>$user->id]);
					}

					$this->request->data['id'] = null;
					$this->request->data['user_id'] = $user->id;
					$this->request->data['token_key'] = Text::uuid();
					$this->request->data['expire'] = strtotime($time->modify('+5 days'));

					$passwordRecovery = $this->PasswordRecoveries->patchEntity($passwordRecovery, $this->request->data);
					if ($this->PasswordRecoveries->save($passwordRecovery)) {
						/*Send reset password email with URL*/
						$url = Router::url(['controller' => 'Users', 'action' => 'resetPassword', $this->request->data['token_key']], true);
						
						$emailSettings = Configure::read('Emails.forgot_password');
						// Email
						$params = [
							'to' => $email,
							'cc' => '',
							'bcc' => '',
							'mode' => 'html',
							'template' => 'custom_default',
							'from'=> $emailSettings['user']['from'],
							'subject' => $emailSettings['user']['subject'],
							'label' => '<b>'.ucfirst($user->role).'</b> '.$user->profile->firstname.' '.$user->profile->lastname.' reset password request.',
							'content' => [
									'title' => $emailSettings['user']['title'],
									'username' => $user->username,
									'firstname' => $user->profile->firstname,
									'lastname' => $user->profile->lastname,
									'url' => $url,
									'text' => $emailSettings['user']['text'],
								],
							'type' => 'FORGOT_PASSWORD',
							'system_category' => 'forgot_password',
							'module_type'	=> 'Users Module'
						];

						if($this->EmailTrigger->sendEmail('FORGOT_PASSWORD', $params)){
							$this->Flash->success(__('Password reset instruction is sent to '. $email. ', Check you email'));
							return $this->redirect(['action' => 'login']);
						}else{
							$this->Flash->success(__('Unable to send password reset instruction is sent to '. $email. ', please try again later'));
							return $this->redirect(['action' => 'resetPassword']);
						}
					}
					
				}else{
					$this->Flash->error(__($email. ' doesn\'t exist. Please check your email address.'));
					return $this->redirect(['action' => 'forgotPassword']);
				}
			}else{
					$this->Flash->error(__('Please enter valid email address.'));
					return $this->redirect(['action' => 'forgotPassword']);
			}
		}
    }

	public function resetPassword($token_key = null){
		$this->loadModel('PasswordRecoveries');
		$passwordRecovery = $this->PasswordRecoveries->newEntity();
		$user = $this->Users->newEntity();

		$prevData = $this->PasswordRecoveries->find('all', [
								'conditions'=>[
									'token_key'=>$token_key
								]]);
		$data = $prevData->first();
		/* If no data found*/
		if(empty($data)){
			$this->Flash->error(__('This URL is not valid.'));
			return $this->redirect(['action' => 'login']);
		}
		
		$data = $prevData->first();
		$tokenExpiredTime = $data->expire;
		$tokenTodaysTime = strtotime(Time::now());
		
		/*If token is expired*/
		if($tokenTodaysTime > $tokenExpiredTime){
			$this->Flash->error(__('The password reset token is expired'));
			return $this->redirect(['action' => 'login']);
		}

		if($this->request->is('post')){
			
			unset($this->request->data['password2']);

			$usersTable = TableRegistry::get('Users');
			$users = $usersTable->get($data->user_id, ['contain'=>'Profiles']); // article with id 12
			
			if(!empty($users)){
				$users->password = $this->request->data['password'];
				if ($usersTable->save($users)) {
					
					/*Delete Token from database*/
					$entity = $this->PasswordRecoveries->get($data->id);
					$result = $this->PasswordRecoveries->delete($entity);
					// Email
					$url = Router::url(['controller' => 'Users', 'action' => 'login', 'home'], true);
					$emailSettings = Configure::read('Emails.reset_password_done');
					$params = [
						'to' => $users->email,
						'cc' => '',
						'bcc' => '',
						'from'=> $emailSettings['user']['from'],
						'subject' => $emailSettings['user']['subject'],
						'mode' => 'html',
						'template' => 'custom_default',
						'label' => '<b>'.ucfirst($users->role).'</b> '.$users->profile->firstname.' '.$users->profile->lastname.' reset password request.',
						'content' => [
								'title' => $emailSettings['user']['title'],
								'username' => $users->username,
								'firstname' => $users->profile->firstname,
								'lastname' => $users->profile->lastname,
								'url' => $url,
								'text' => $emailSettings['user']['text'],
							],
						'type' => 'RESET_PASSWORD_DONE',
						'system_category' => 'reset_password',
						'module_type'	=> 'Users Module'
					];

					$this->EmailTrigger->sendEmail('RESET_PASSWORD_DONE', $params);
					
					$this->Flash->success(__('Your new password has been updated, you can login now.'));
					return $this->redirect(['action' => 'login']);
				}else{
					$this->Flash->error(__('Unable to update your new password, Please try again later.'));
					return $this->redirect(['action' => 'login']);
				}
			}else{
				$this->Flash->success(__('No user found.'));
				return $this->redirect(['action' => 'login']);
			}
		}
    }
	
	public function dashboard(){

    }

	public function login_as_user($id = null, $direction = 'right', $controller = 'contacts'){
		$this->autoRender = false;
		$this->layout = 'ajax';
		$session = $this->request->session();

		$id = base64_decode($id);
		$user = $session->read('Auth');
		$admin_id = $user['User']['id'];
		
		/*Updating user table last login*/
		$usersTable = TableRegistry::get('Users');
		$user = $this->Users->findAuth($usersTable, array('id'=>$id));
		
		if ($user) {
			
			$referer = isset($_SERVER['HTTP_REFERER']) ? $_SERVER['HTTP_REFERER'] : 'contacts/';
			if($user['status'] !== "Active"){
				$this->Flash->error(
					__('This account is not acitve'),
					'default',
					[],
					'auth'
				);
				return $this->redirect($referer);
			}
			$sessionReferer = $session->read('Auth.User.runtime_referer');
			
			$this->Auth->logout();
			$this->Auth->setUser($user);
			
			$users = $usersTable->get($user['id'], ['contain'=>'Profiles']);

			$users->id = $user['id'];
			$users->login_ip = $this->request->clientIp();
			$users->last_login = Time::now();

			$usersTable->save($users);

			$session->write('Auth.User.Profile', $users->profile);

			if($direction == 'right'){
				$session->write('Auth.User.runtime', 1);
				$session->write('Auth.User.runtime_from', $admin_id);
				$session->write('Auth.User.runtime_referer', $controller);
			}

			if($direction == 'left'){
				$session->delete('Auth.User.runtime');
				$session->delete('Auth.User.runtime_from');
				$session->delete('Auth.User.runtime_referer');
			}

			$role = $users->role;
			
			// Save Activity log short content in activity table
			$activity = [
				'user_id'	 => $user['id'],
				'profile_id' => $users->profile->id,
				'content'	 => $users->profile->firstname.' '.$users->profile->lastname.' logged in',
				'type'		 => 'login_as_user',
				'updated_by' => $this->Auth->user('Profile.id')
			];
			TableRegistry::get('Activities')->addActivity($activity);
			
			
			switch($role){
				case 'admin' : 
						return $this->redirect(['controller'=>$sessionReferer, 'action'=>'index', 'prefix' => false]);
					break;
			}
			
		} else {
			$this->Flash->error(
				__('Username or password is incorrect'),
				'default',
				[],
				'auth'
			);
		}
	}

	public function limits()
    {
		$this->loadModel('AddLimits');
		if($this->request->is('post')){
			
			$userData = $this->request->data;
	
			foreach($userData as $k=>$d){
				$sData['user_id']		= $this->Auth->user('id');
				$sData['type']			= $k;
				$sData['upto_limit']	= $d;
				$saveData[] = $sData;
			}
			
			foreach($saveData as $d){
				
				$addLimits	= $this->AddLimits->newEntity($d);
				$dbData		= $this->AddLimits->find('all', ['conditions' => ['type' => $d['type']]])->first();

				if(!empty($dbData))
				{
					$dbData		= $dbData->toArray();
					$addLimits	= $this->AddLimits->get($dbData['id']);
					$addLimits	= $this->AddLimits->patchEntity($addLimits, $d);
				}
				if($this->AddLimits->save($addLimits)){
					$this->Flash->success(
						__('Limit updated.'),
						'default',
						[],
						''
					);
				}else{
					$this->Flash->error(
						__('Unable to update limit, try again later.'),
						'default',
						[],
						''
					);
				}
			}
		}else{
			$dbLimitObj = $this->AddLimits->find('All')->hydrate(false)->toArray();
			foreach($dbLimitObj as $obj)
			{
				$setData[$obj['type']] = $obj['upto_limit'];
			}
			if(isset($setData) && !empty($setData)){
				$this->request->data = $setData;
			}
		}
    }
}
