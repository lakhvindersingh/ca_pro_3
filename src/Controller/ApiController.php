<?php
/** 
*  Project : Fitfix 
*  Author : Bharat 
*  Creation Date : 25-June-2015 
*  Description : This is Api controller which will be called by the mobile devices
*/
namespace App\Controller;

use Cake\Event\Event;
use Cake\ORM\TableRegistry;
use Cake\Core\Configure;
use App\Controller\AppController;
use Cake\Routing\Router;
use Cake\Network\Email\Email;
use Cake\Auth\DefaultPasswordHasher;


class ApiController extends AppController {

	var $name = 'Api';
	var $limit = 10;
	var $page_number = 1;
	var $sessionId = 'login';
	var $logging = false;
	var $layout = false;
	var $autoRender = false;
	var $allowedActions = array('register','login', 'ForgetUsername', 'ForgetPassword');
	var $paginate_array = array();
	var $return = array();
	var $user_return_fields = array('id','name', 'phone', 'email');
	var $user = array();

/**
 * @name Send Response
 * Purpose : This method prints the response from any method when called
 * @author Bharat Borana
 * @access private
 * @return return the response data
 */
	private function __send_response()
	{
		echo json_encode($this->response);
		exit;
	}
	
       
	/**
	 * @name BeforeFilter
	 * Purpose : This method is called before every call to check if its authentic request
	 * @author Bharat Borana
	 * @access public
	 * @return returns true if authenticated else returns error
	 */

	public function test(){
		echo sha1(md5('123456'));
	}
	public function beforeFilter(Event $event)
	{
		parent::beforeFilter($event);
		$secret = SECRET_KEY_APP;
		/*
		$timestamp = $this->request->header('timestamp');
		$token = $this->request->header('token');

		$generate_token = sha1($secret . $timestamp);
		$this->sessionId
		if($generate_token != $token)
		{
			$this->response = array(
						'status' => 400,
						'message' => 'Invalid Credentials',
					);
			$this->__send_response();
		} else
		{
			$this->Auth->allow($this->request->action);
		}
		*/
		

		$this->Auth->allow($this->request->action);
		
		
		if(isset($this->request->data['page']))
		{
			$this->request->query['page'] = $this->request->data['page']; 
		}
		if(isset($this->request->data['limit']))
		{
			$this->request->query['limit'] = $this->request->data['limit']; 
		}
		if(isset($this->request->data['show']) && $this->request->data['show'] == 'all')
		{
			$this->limit = MAX_PAGINATION_LIMIT;
		}
		
		
		if(isset($this->request->query['page']))
		{
			$this->page_number = $this->request->query['page']; 
		}
		if(isset($this->request->query['limit']))
		{
			$this->limit = $this->request->query['limit']; 
		}
		if(isset($this->request->query['show']) && $this->request->query['show'] == 'all')
		{
			$this->limit = MAX_PAGINATION_LIMIT;
		}
		
		$this->paginate_array = array(
			'limit' => $this->limit,
			'page' => $this->page_number
		);
		
		$this->paginate = array(
			'limit' => ($this->limit == 0) ? 10 : $this->limit,
			'page' => $this->page_number,
		);
	}

	private function _login()
	{
		$this->loadModel('Users');
		$user = $this->Users->find(
 			'all', [
 				'conditions' => [
 					'Users.email' => $this->request->header('email'),
 				]
			]
		)->first();
		if(!empty($user))
		{
			return $user->toArray();
		} else {
			return false;
		}
	}


	private function _clean_file_name($filename)
	{
		return preg_replace("/[^a-z0-9\.]/", "", strtolower($filename));
	}

		 /////////////////////////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////USER METHODS START///////////////////////////////////////////
	   /////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * @name Register
 * Purpose : This method is used to register the user omn 
 * @author Bharat Borana
 * @access public
 * @return returns true if authenticated else returns error
 */
	public function registeruser()
	{
		header('Content-Type: application/json');

		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
		}
		
		$error = '';
		$this->loadModel('Users');
		$user_data = $this->request->data;

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
		    $this->response = array(
					'status' => 400,
					'message' => rtrim($error, ', ')
				);
		}
		else {

			$user = $this->Users->patchEntity($user, $user_data);
			if($this->Users->save($user))
			{
				$user = $this->Users->find('all',[
							'conditions' => [
								'Users.id'	=> $user['id'],
							],
							'contain'	=> ['Products', 'UserProducts.Products']
							])->first();


				$reponseUser['userdetails']['userId'] 				= $user['id'];
				$reponseUser['userdetails']['username'] 			= $user['username'];
				$reponseUser['userdetails']['sessionId'] 			= $user['sessionId'];
				$reponseUser['userdetails']['first_name'] 			= $user['first_name'];
				$reponseUser['userdetails']['last_name'] 			= $user['last_name'];
				$reponseUser['userdetails']['Email'] 				= $user['email'];
				$reponseUser['userdetails']['ProfilePicURL'] 		= $user['image'];
				$reponseUser['userdetails']['isVerified'] 			= $user['is_verified'];
				$reponseUser['userdetails']['isTrial'] 				= $user['is_trial'];
				$reponseUser['userdetails']['isPaid'] 				= $user['is_paid'];
				$reponseUser['userdetails']['user_type'] 			= $user['user_type'];


				if($user['gender'] == 1)
					$reponseUser['userdetails']['gender'] 				= 'Male';
				else	
					$reponseUser['userdetails']['gender'] 				= 'Female';
					
				
				// App Product to User
				$this->loadModel('UserProducts');
				
				if($user['product_id'] == 1)
					$nowStart = date('Y-m-d 00:00:01');
				else
					$nowStart = date('Y-m-d 00:00:01', strtotime('+'.ADD_SUBSCRIPTION_LIMIT.' days'));
				
				$userProductEntity = [
							'user_id'			=> $user['id'],
							'product_id'		=> $user['product_id'],
							'status_id'			=> 1,
							'pack_start_date'	=> $nowStart,
							'free_days'			=> ADD_SUBSCRIPTION_LIMIT,
						];

				$saveUP = $this->UserProducts->newEntity($userProductEntity);
				
				$saveUP->pack_start_date = $nowStart;
				
				if($savedUP = $this->UserProducts->save($saveUP))
				{
					$reponseUser['userdetails']['product_id'] 		= $user['product_id'];
					$reponseUser['userdetails']['subsLimit'] 		= ADD_SUBSCRIPTION_LIMIT;
					
					if(!empty($savedUP)){
						$reponseUser['userdetails']['subsDays'] 	= $this->SubscriptionLeftDays($savedUP['pack_start_date'], ADD_SUBSCRIPTION_LIMIT);
					}
				}
				
				$paymentUrl = Router::url([
						'controller' => 'payment', 
						'action' => 'process',
						$this->encode($user['id']),
						$this->encode($user['product_id']),
						$this->encode($user_data['sessionId']),
					], true);

				$reponseUser['userdetails']['paymentUrl'] 			= $paymentUrl;
				

				$linkTag = "http://" . $_SERVER['SERVER_NAME'] . Router::url(array('controller' => 'Users', 'action' => 'verify_user', $user['email'],
			$user['verification_token']));

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

				$responseMsg = '';
				if(!$email->send($content))
				{
					$this->log(print_r("=============================Email Failed==========================", true),'debug');
					$this->log(print_r($reponseUser, true),'debug');
				}

				$this->response = array(
					'status'	=> 200,
					'new_user'	=> 1,
					'message'	=> 'Registration was successful!  Please check your email to verify your account.',
					'data'		=> $reponseUser
				);
			} else
			{
				$this->response = array(
					'status' => 400,
					'message' => 'User cannot be saved right now. Please try again.',
				);
			}		
		}
		$this->__send_response();
	}

/**
 * @name Login
 * Purpose : This method is used to login the user omn 
 * @author Bharat Borana
 * @access public
 * @return returns true if authenticated else returns error
 */
	public function loginuser()
	{ 
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
			$this->__send_response();
		}
		
		$error = '';
		$this->loadModel('Users');

		$user_data = $this->request->data;
		
		if(!isset($user_data['username']) || empty($user_data['username']))
			$error .= 'Username is required for login.';
		
		if(!isset($user_data['password']) || empty($user_data['password']))
			$error .= 'Password is required for login.';
		
		if(empty($error)){ 
			$user = $this->Auth->identify();
			
			if($user){
				$this->Users->validator()->remove('password', 'compare');
				$this->loadComponent('Common');
				
				$sessionId = $this->Common->generateRandomString(25);
				$user_data['sessionId'] = $sessionId; 

				$user = $this->Users->get($user['id']);
				$userData = $this->Users->patchEntity($user, $user_data);
				
				if($this->Users->save($userData)){

					$user = $this->Users->find('all',[
							'conditions' => ['Users.id' => $user['id']],
							'contain'	=> ['Products', 'UserProducts.Products']
							])->first();

					if(!empty($user)){
						$user = $user->toArray();

						if($user['status_id']==1 && $user['is_verified']==1){
							
							if($user['image'])
							{
								$user['image'] = Router::url('/' . 'uploads' . DS . USER_IMAGE_URL . DS . $user['id'] . DS . $user['image'], true);
							}
							
							$this->Session = $this->request->session();
							$this->Session->write('sessionId', $user['sessionId']);
							$this->sessionId = $user['sessionId'];
							
							$reponseUser['userdetails']['userId'] 			= $user['id'];
							$reponseUser['userdetails']['username'] 		= $user['username'];
							$reponseUser['userdetails']['sessionId'] 		= $user['sessionId'];
							$reponseUser['userdetails']['first_name'] 		= $user['first_name'];
							$reponseUser['userdetails']['last_name'] 		= $user['last_name'];
							$reponseUser['userdetails']['classroom'] 		= $user['classroom'];
							$reponseUser['userdetails']['Email'] 			= $user['email'];
							$reponseUser['userdetails']['ProfilePicURL'] 	= $user['image'];
							$reponseUser['userdetails']['isVerified'] 		= $user['is_verified'];

							if($user['gender'] == 1)
								$reponseUser['userdetails']['gender'] 		= 'Male';
							else	
								$reponseUser['userdetails']['gender'] 		= 'Female';
								
							
							$reponseUser['userdetails']['userType'] 		= $user['user_type'];
							$reponseUser['userdetails']['isTrial'] 			= $user['is_trial'];
							$reponseUser['userdetails']['isPaid'] 			= $user['is_paid'];

							if(isset($user['user_product']['product_id']) && !empty($user['user_product']['product_id'])){
								$reponseUser['userdetails']['product_id'] 	= $user['user_product']['product_id'];
								$reponseUser['userdetails']['subsLimit'] 	= $user['user_product']['product']['validity'] + $user['user_product']['free_days'];
								$reponseUser['userdetails']['subsDays'] 	= $this->SubscriptionLeftDays($user['user_product']['pack_start_date'], $user['user_product']['product']['validity']);
							}
							else{
								$this->loadModel('UserProducts');
								
								$nowStart = date('Y-m-d 00:00:01');

								$userProductEntity = [
											'user_id'			=> $user['id'],
											'product_id'		=> 1,
											'status_id'			=> 1,
											'pack_start_date'	=> $nowStart,
											'free_days'			=> ADD_SUBSCRIPTION_LIMIT,
										];

								$saveUP = $this->UserProducts->newEntity($userProductEntity);

								$saveUP->pack_start_date = $nowStart;

								if($savedUP = $this->UserProducts->save($saveUP))
								{
									$reponseUser['userdetails']['product_id'] 		= $savedUP['product_id'];
									$reponseUser['userdetails']['subsLimit'] 		= ADD_SUBSCRIPTION_LIMIT;
									
									if(!empty($savedUP)){
										$reponseUser['userdetails']['subsDays'] 	= $this->SubscriptionLeftDays($savedUP['pack_start_date'],ADD_SUBSCRIPTION_LIMIT);
									}
								}
							}


							$paymentUrl = Router::url([
									'controller' => 'payment', 
									'action' => 'process',
									$this->encode($user['id']),
									$this->encode($user['product_id']),
									$this->encode($user_data['sessionId']),
								], true);

							$reponseUser['userdetails']['paymentUrl'] 			= $paymentUrl;
							$reponseUser['userdetails']['created'] 				= date('Y-m-d', strtotime($user['created']));

							$freeDays = $user['user_product']['free_days'] - $this->dateMinus(date('Y-m-d', strtotime($user['created'])), date('Y-m-d'), "%r%a");
							$reponseUser['userdetails']['is_free_used'] 		= $freeDays;
							
							$this->response = array(
								'status' => 200,
								'new_user' => 0,
								'message' => 'Logging in now', //'User successfully logged in.',
								'data' => $reponseUser
							);
						}
						else if($user['status_id']==1 && $user['is_verified']==0){
							$this->response = array(
								'status' => 400,
								'new_user' => 0,
								'message' => 'Please verify your email address.',
							);
						}
						else if($user['status_id']==2){
							$this->response = array(
								'status' => 400,
								'new_user' => 0,
								'message' => 'Your account has been deactivated.',
							);
						}
						else if($user['status_id']==3){
							$this->response = array(
								'status' => 400,
								'new_user' => 0,
								'message' => 'Please verify your email address.',
							);
						}
					}
					else{
						$this->response = array(
							'status' => 400,
							'message' => 'Invalid user.',
						);
					}
				}
				else{
					$this->response = array(
						'status' => 400,
						'message' => 'Unable to login. Please try again later.',
						'data' => $userData->errors()
					);
				}
			}
			else{
				$this->response = array(
							'status' => 400,
							'message' => 'Invalid credentials. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}
		
		$this->__send_response();
	}
	
	
	/**
	 * @name SubscriptionLeftDays
	 * Purpose : This method is used to 
	 * @author Bharat Borana
	 * @access public
	 * @return returns true if authenticated else returns error
	 */

	public function SubscriptionLeftDays($modified, $validity){
		
		$today = date('Y-m-d');
		$modified = date('Y-m-d', strtotime($modified));
		
		$planOverDate = date('Y-m-d', strtotime($modified. ' + '.$validity.' days'));
		
		$days = $this->dateMinus($today, date('Y-m-d', strtotime($planOverDate)), '%r%a');

		if($days >= 1){
			return intval($days);
		}
		else{
			return 0;
		}
	}

	public function dateMinus($date, $date2, $type = '%y') {
		if(empty($date)){
			return "";
		}
	    
		$datetime1 = new \DateTime($date);
		$datetime2 = new \DateTime($date2);
		$interval = $datetime1->diff($datetime2);
		return $interval->format($type);
	}

	/**
	 * @name checkSubscription
	 * Purpose : This method is used to 
	 * @author Bharat Borana
	 * @access public
	 * @return returns true if authenticated else returns error
	 */

	public function checkSubscription(){
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
		}
		
		$error = '';
		$this->loadModel('Users');

		$user_data = $this->request->data;

		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';

		if(empty($error)){

			$userObj = $this->Users->find('all',[
							'conditions' => [
								'Users.id'	=> $user_data['user_id'],
								'sessionId' => $user_data['sessionId'],
							],
							'contain'	=> ['Products', 'UserProducts.Products']
							])->first();

			if($userObj)
			{
				$userObj	= $userObj->toArray();
				
				$planStarted	= $userObj['user_product']['pack_start_date'];
				$totalDays		= $userObj['user_product']['product']['validity'] + $userObj['user_product']['free_days'];
				$is_trial		= $userObj['is_trial'];
				$is_paid		= $userObj['is_paid'];
				
				$daysOfSubscribe 	= $this->SubscriptionLeftDays($userObj['user_product']['pack_start_date'],$userObj['user_product']['product']['validity']);

				if($daysOfSubscribe <= 0)
				{
					$userObjData = $this->Users->get($user_data['user_id']);
					$userObjData->is_trial	= 1;
					$userObjData->is_paid	= 0;
					if($this->Users->save($userObjData))
					{
						$is_trial	= 1;
						$is_paid	= 0;
					}
				}
				
				$freeDays = $userObj['user_product']['free_days'] - $this->dateMinus(date('Y-m-d', strtotime($userObj['created'])), date('Y-m-d'), "%r%a");

				$data = [
					'user_created'	=> date('Y-m-d', strtotime($userObj['created'])),
					'created'		=> date('Y-m-d', strtotime($planStarted)),
					'is_trial'		=> $is_trial,
					'is_paid'		=> $is_paid,
					'product_id'	=> $userObj['user_product']['product_id'],
					'subsDays'		=> $daysOfSubscribe,
					'subsLimit'		=> $totalDays,
					'is_free_used'	=> $freeDays,
				];

				$this->response = array(
						'status'	=> 200,
						'message'	=> 'Subscription detail.',
						'data'		=> $data,
					);
			}
			else
			{
				$this->response = array(
						'status' => 400,
						'message' => 'No user found.',
					);
			}
			
		}
		else{
			$this->response = array(
				'status' => 400,
				'message' => rtrim($error, ', '),
			);
		}
		
		$this->__send_response();
	}
	
	/**
	 * @name upgradeSubscription
	 * Purpose : This method is used to 
	 * @author Bharat Borana
	 * @access public
	 * @return returns true if authenticated else returns error
	 */

	public function upgradeSubscription(){
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
		}
		
		$error = '';
		$this->loadModel('Users');

		$user_data = $this->request->data;

		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';

		if(!isset($user_data['product_id']) || empty($user_data['product_id']))
			$error .= 'Product Id is required.';

		if(empty($error)){

			$userObj = $this->Users->find('all',[
							'conditions' => [
								'Users.id'	=> $user_data['user_id'],
								'sessionId' => $user_data['sessionId'],
							],
							'contain'	=> ['Products', 'UserProducts.Products']
							])->first();

			if($userObj)
			{
				$paymentUrl = Router::url([
						'controller' => 'payment', 
						'action' => 'process',
						$this->encode($user_data['user_id']),
						$this->encode($user_data['product_id']),
						$this->encode($user_data['sessionId']),
					], true);

				$data['paymentUrl'] = $paymentUrl;


				$this->response = array(
						'status'	=> 200,
						'message'	=> 'Thank you! A payment link has been generated.',
						'data'		=> $data,
					);
			}
			else
			{
				$this->response = array(
						'status' => 400,
						'message' => 'No user found.',
					);
			}
		}
		else{
			$this->response = array(
				'status' => 400,
				'message' => rtrim($error, ', '),
			);
		}
		
		$this->__send_response();
	}

	/**
	 * @name Logout
	 * Purpose : This method is used to logout user
	 * @author Bharat Borana
	 * @access public
	 * @return returns true if authenticated else returns error
	 */

	public function logoutuser(){
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
		}
		
		$error = '';
		$this->loadModel('Users');

		$user_data = $this->request->data;

		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';

		if(empty($error)){
			$userObj = $this->Users->find('all',['conditions' => ['id' => $user_data['user_id'], 'sessionId' => $user_data['sessionId']]])->first();

			if($userObj)
			{
				$userObj->sessionId = '';
				if($savedUser = $this->Users->save($userObj)){

					$this->Session = $this->request->session();
					$this->Session->write('sessionId', '');
					$this->sessionId = '';

					if($this->Auth->logout()){
						$this->response = array(
							'status' => 200,
							'message' => 'User has been successfully logged out.'
						);
					}else
					{
						$this->response = array(
							'status' => 400,
							'message' => 'Unable to logged out.',
						);
					}
				}else
				{
					$this->response = array(
						'status' => 400,
						'message' => 'Unable to logged out.',
					);
				}	
			}
			else
			{
				$this->response = array(
						'status' => 400,
						'message' => 'No user found.',
					);
			}
			
		}
		else{
			$this->response = array(
				'status' => 400,
				'message' => rtrim($error, ', '),
			);
		}
		
		$this->__send_response();
	}
	
	/**
	 * @name forgot_password
	 * Purpose : This method is used to reset the password 
	 * @author Bharat Borana
	 * @access public
	 * @return returns true if password sent else returns error
	 */
	public function ForgetPassword()
	{
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
		}
		
		$error = '';
		$this->loadModel('Users');

		$user_data = $this->request->data;

		if(!isset($user_data['username']) || empty($user_data['username']))
			$error .= 'Username is Required.';
		
		if(!empty($error))
		{
			$this->response = array(
				'status' => 400,
				'message' => rtrim($error, ', ')
			);
		}else
	 	{
	 		$userObj = $this->Users->find('all',['conditions' => ['OR' =>[['username' => $user_data['username']],['email' => $user_data['username']] ]]])->first();
			
				
			if($userObj)
			{
				$user_data = $userObj->toArray();
				// In a controller action
				$this->loadComponent('Common');
				$randString = $this->Common->generateRandomString(8);
		
				if(true){
					$template = "forgot-password";
					$forgot_token = sha1(md5($user_data['password']));
					$forget_array = array('id' => $user_data['id'], 'token' => $forgot_token);
					$forget_url = Router::url(array('controller'=>'users','action'=>'reset_password', '?' => $forget_array),true);
					$token = array('{{name}}','{{email}}','{{forget_url}}');
					$token_value = array($user_data['first_name'] . " " . $user_data['last_name'], $user_data['email'], $forget_url);

          			$this->loadComponent('Common');
					$this->Common->_send_email($user_data['email'], $token, $token_value, $template, '');
					
					$this->response = array(
								'status' => 200,
								'message' => "Password sent to account email."
					);
				}
				else{
					$this->response = array(
							'status' => 400,
							'message' => "Forgot password update failed!"
					);
				}
			}
			else
			{
				$this->response = array(
							'status' => 400,
							'message' => "Email address not found."
				);
			}
		}
		$this->__send_response();
	}

	/**
	 * @name forgot_username
	 * Purpose : This method is used to reset the password 
	 * @author Bharat Borana
	 * @access public
	 * @return returns true if password sent else returns error
	 */
	public function ForgetUsername()
	{
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
		}
		
		$error = '';
		$this->loadModel('Users');

		$user_data = $this->request->data;

		if(!isset($user_data['email']) || empty($user_data['email']))
			$error .= 'Email is Required.';
		
		if(!empty($error))
		{
			$this->response = array(
				'status' => 400,
				'message' => rtrim($error, ', ')
			);
		}else
	 	{
	 		$userObj = $this->Users->find('all',['conditions' => ['OR' =>[['username' => $user_data['email']],['email' => $user_data['email']] ]]])->first();
			
				
			if($userObj)
			{
				$user_data = $userObj->toArray();
				// In a controller action
				$this->loadComponent('Common');
				$randString = $this->Common->generateRandomString(8);
		
				if(true){
					$template = "forgot-username";

					$token = array('{{name}}','{{email}}','{{username}}');
					$token_value = array($user_data['first_name'] . " " . $user_data['last_name'], $user_data['email'], $user_data['username']);

          			$this->loadComponent('Common');
					$this->Common->_send_email($user_data['email'], $token, $token_value, $template, '');
					
					$this->response = array(
								'status' => 200,
								'message' => "Username sent to account email."
					);
				}
				else{
					$this->response = array(
							'status' => 400,
							'message' => "Forgot username update failed!"
					);
				}
			}
			else
			{
				$this->response = array(
							'status' => 400,
							'message' => "Email address not found."
				);
			}
		}
		$this->__send_response();
	}

/**
 * @name Get countries
 * Purpose : This method is used to get countries data
 * @author Bharat Borana
 * @access public
 * @return returns true if countries found else returns error
 */
        
  function getCountries()
  {
    header('Content-Type: application/json');
		if(!$this->request->is('GET'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
		}
		
		$error = '';
		$this->loadModel('Countries');

 		$countries = $this->Countries->find('list',['keyField' => 'country','valueField' => 'country'])->toArray();
		
		$this->response = array(
				'status' => 200,
				'message' => 'Coutries found',
				'value' => $countries
			 );
  	$this->__send_response();
  }

 /**
 * @name Add Student
 * Purpose : This method is used to add student 
 * @author Bharat Borana
 * @access public
 * @return returns true if student added else returns error
 */
	public function AddStudent()
	{ 
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
				'status' => 400,
				'message' => 'Method not allowed',
			);
		}
		
		$error = '';
		$this->loadModel('Users');

		$user_data = $this->request->data;
		
		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';
		
		if(empty($error)){ 
			$userObj = $this->Users->find('all',['conditions' => ['id' => $user_data['user_id'], 'sessionId' => $user_data['sessionId']]])->first();
			
			if($userObj){
				
				$this->loadModel('Students');

				$countUserAreas = $this->Students->countUserStudents($user_data['user_id'], ADD_STUDENT_LIMIT);
				
				if(!$countUserAreas)
				{
					$error .= "You have already added ". ADD_STUDENT_LIMIT ." students. You cannot add more.";
				}

				$user = $userObj->toArray();

				
				if(isset($user_data['birthday']) && !empty($user_data['birthday']))
				{
					list($m, $d, $y) = explode('-', $user_data['birthday']);
					$user_data['birthday'] = date($m.'-'.$d.'-'.$y);
				}
				
				
				$student = $this->Students->newEntity($user_data);
				
				$errors = $student->errors();

				if(!empty($errors)) {
				    foreach ($errors as $key => $value) {
				    	$error .= $value[array_keys($value)[0]].",  ";
				    }
				}   
				 
				if(!empty($error)) {
				    $this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
				}
				else 
				{
					if($this->Students->save($student))
					{
						
						$s_firstname = $this->getStudentShortName($student['first_name'], 20);
						$s_lastname	 = $this->getStudentShortName($student['last_name'], 1);
						
						$reponseUser['StudentInfo']['studentId'] 			= $student['id'];
						$reponseUser['StudentInfo']['FirstName'] 			= $s_firstname;
						$reponseUser['StudentInfo']['LastName'] 			= $s_lastname;
						
						if(!empty($student['birthday'])){
							$reponseUser['StudentInfo']['BirthdayDate'] 		= date('m-d-Y', strtotime($student['birthday']));
							$reponseUser['StudentInfo']['Age'] 					= $this->age_from_dob(date('Y-m-d', strtotime($student['birthday'])));
						}
						
						if($student['status'] == 1)
							$reponseUser['StudentInfo']['Status'] 				= 'Active';
						else
							$reponseUser['StudentInfo']['Status'] 				= 'Inactive';
						
						
						
						$this->response = array(
							'status' => 200,
							'message' => 'Student successfully added.',
							'data' => $reponseUser
						);
					} else
					{
						$this->response = array(
							'status' => 100,
							'message' => 'Student cannot be saved right now. Please try again.',
						);
					}		
				}
				$this->__send_response();
			}
			else{
				$this->response = array(
							'status' => 400,
							'message' => 'Invalid credentials. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}
		
		$this->__send_response();
	}
	
	public function age_from_dob($dob) {
		if(empty($dob)){
			return "";
		}
	    
	    $year = date_create($dob)->diff(date_create('today'))->y;
	    $month = date_create($dob)->diff(date_create('today'))->m;
		
		if($month <= 0){
			$month = '';
		}else{
			$month = '.'.$month;
		}
		return $year.$month;
	}

	
	
	/**
 * @name Get Class
 * Purpose : This method is used to get Class data
 * @author Bharat Borana
 * @access public
 * @return returns true if class found else returns error
 */
        
	function getClass()
	{
		header('Content-Type: application/json');
		if(!$this->request->is('GET'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
		}
		$this->loadModel('Students');
		
		$error = '';
		$user_data = $this->request->data;

		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';
		
		if(empty($error)){ 

			$this->loadModel('Users');
			$userObj = $this->Users->find('all',['contain' => ['Students'], 'conditions' => ['id' => $user_data['user_id'], 'sessionId' => $user_data['sessionId']]])->first();

			if($userObj){
				$user = $userObj->toArray();
				
				$this->paginate = [
						'limit'	=> isset($user_data['limit']) ? $user_data['limit'] : 10,
						'page' => isset($user_data['page']) ? $user_data['page'] : '1',
					];
				
				$studentObj = $this->Students->find('all',
										['contain' => ['Users'], 
										'conditions' => [
											'Students.user_id' => $user_data['user_id']
										],
										'order' => 'birthday desc'
										])->hydrate(false);
				
				if($this->paginate['page'] <= 0){
					$this->paginate = [
						'limit'	=> 1000,
						'page' => 1,
					];
				}
				
				$studentObj = $this->paginate($studentObj);
				
				$studentObj = $studentObj->toArray();
				
				if(isset($studentObj) && !empty($studentObj)){
					$studentData = array();
					foreach ($studentObj as $key => $value) {
						$responseUser['StudentInfo']['studentId'] 				= $value['id'];
						$responseUser['StudentInfo']['FirstName'] 				= $this->getStudentShortName($value['first_name'], 20);
						$responseUser['StudentInfo']['LastName'] 				= $this->getStudentShortName($value['last_name'], 20);
						
						if(!empty($value['birthday']))
							$responseUser['StudentInfo']['BirthdayDate'] 		= date('m-d-Y', strtotime($value['birthday']));
							$responseUser['StudentInfo']['Age'] 				= $this->age_from_dob(date('Y-m-d', strtotime($value['birthday'])));
						
						if($value['status'] == 1)
							$reponseUser['StudentInfo']['Status'] 				= 'Active';
						else
							$reponseUser['StudentInfo']['Status'] 				= 'Inactive';
						

						$studentData[] = $responseUser;
					}
					
					$pageResponse = isset($this->request->params['paging']['Students']) ? $this->request->params['paging']['Students'] : '';
			
					$page = [];
					if(!empty($pageResponse)){
						$page['Page'] 			= $pageResponse['page'];
						$page['Limit'] 			= $pageResponse['perPage'];
						$page['HasPrevPage'] 	= ($pageResponse['prevPage'] != "") ? TRUE : FALSE;
						$page['HasNextPage'] 	= ($pageResponse['nextPage'] != "") ? TRUE : FALSE;
						$page['TotalCount'] 	= $pageResponse['count'];
						$page['TotalPage'] 		= $pageResponse['pageCount'];
					}
					
					$this->response = array(
							'status' => 200,
							'message' => 'Students found.',
							'pagination' => $page,
							'value' => $studentData
						 );

				}
				else{
					$this->response = array(
							'status' => 400,
							'message' => 'Student not found for this class.',
						);
				}
			}
			else
			{
				$this->response = array(
							'status' => 500,
							'message' => 'Invalid credentials. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}

  	$this->__send_response();
  } 

  /**
 * @name Add Notes
 * Purpose : This method is used to add notes 
 * @author Bharat Borana
 * @access public
 * @return returns true if notes added else returns error
 */
	public function AddNotes()
	{ 
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
				'status' => 400,
				'message' => 'Method not allowed',
			);
		}
		
		$error = '';
		$this->loadModel('Users');

		$user_data = $this->request->data;
		
		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';
		
		if(empty($error)){ 
			$userObj = $this->Users->find('all',['conditions' => ['id' => $user_data['user_id'], 'sessionId' => $user_data['sessionId']]])->first();
			
			if($userObj){
				$user = $userObj->toArray();

				$this->loadModel('Notes');
				$note = $this->Notes->newEntity($user_data);

				$errors = $note->errors();

				if(!empty($errors)) {
				    foreach ($errors as $key => $value) {
				    	$error .= $value[array_keys($value)[0]].",  ";
				    }
				}   
				 
				if(!empty($error)) {
				    $this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
				}
				else {
					
					$note->timestamp = $_SERVER['REQUEST_TIME'];
					if($this->Notes->save($note))
					{
						
						$reponseNotes['Note']['id'] 			= $note['id'];
						$reponseNotes['Note']['Noteheading'] 	= $note['title'];
						$reponseNotes['Note']['CreatedDate'] 	= $note['created'];
						$reponseNotes['Note']['ModifiedDate'] 	= $note['modified'];
						$reponseNotes['Note']['TimeStamp'] 		= $note['timestamp'];
						
						$this->response = array(
							'status' => 200,
							'message' => 'Notes added.',
							'data' => $reponseNotes
						);
					} else
					{
						$this->response = array(
							'status' => 400,
							'message' => 'Notes cannot be added right now. Please try again.',
						);
					}		
				}
				$this->__send_response();
			}
			else{
				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}
		
		$this->__send_response();
	}

	/**
	 * @name Get Notes
	 * Purpose : This method is used to get Notes data
	 * @author Bharat Borana
	 * @access public
	 * @return returns true if notes found else returns error
	 */
        
  	public function getNotes()
  	{
    	header('Content-Type: application/json');
		if(!$this->request->is('GET'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
		}
		
		$error = '';
		$user_data = $this->request->data;

		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';
		
		if(empty($error)){ 

			$this->loadModel('Users');
			$userObj = $this->Users->find('all',['contain' => ['Notes'],'conditions' => ['id' => $user_data['user_id'], 'sessionId' => $user_data['sessionId']]])->first();
			
			if($userObj){
				$user = $userObj->toArray();
				if(!empty($user)){
					
					$this->paginate = [
						'order' => [
							'Notes.id' => 'desc'
						],
						'limit'	=> isset($user_data['limit']) ? $user_data['limit'] : 10,
						'page' => isset($user_data['page']) ? $user_data['page'] : '1',
					];
					
					$this->loadModel('Notes');
					
					$notesObj = $this->Notes->find('all', ['conditions'=>['Notes.user_id'=>$user_data['user_id']]])->contain(['Users'])->hydrate(false);
					$notesObj = $this->paginate($notesObj);
					if($notesObj){
						$notes = $notesObj->toArray();
						if(isset($notes) && !empty($notes)){
							$notesData = array();
							foreach ($notes as $key => $note) {
								$reponseNotes['Note']['id'] 			= $note['id'];
								$reponseNotes['Note']['Noteheading'] 	= $note['title'];
								$reponseNotes['Note']['CreatedDate'] 	= $note['created'];
								$reponseNotes['Note']['ModifiedDate'] 	= $note['modified'];
								$reponseNotes['Note']['TimeStamp'] 		= $note['timestamp'];

								$notesData[] = $reponseNotes;
							}
							
							$pageResponse = isset($this->request->params['paging']['Notes']) ? $this->request->params['paging']['Notes'] : '';
			
							$page = [];
							if(!empty($pageResponse)){
								$page['Page'] 			= $pageResponse['page'];
								$page['Limit'] 			= $pageResponse['perPage'];
								$page['HasPrevPage'] 	= ($pageResponse['prevPage'] != "") ? TRUE : FALSE;
								$page['HasNextPage'] 	= ($pageResponse['nextPage'] != "") ? TRUE : FALSE;;
								$page['TotalCount'] 	= $pageResponse['count'];
								$page['TotalPage'] 		= $pageResponse['pageCount'];
							}
				
							$this->response = array(
									'status' => 200,
									'PageNo' => isset($user_data['page']) ? $user_data['page'] : '1',
									'message' => 'Notes found.',
									'pagination' => $page,
									'value' => $notesData,
								 );

						}
						else{
							$this->response = array(
									'status' => 400,
									'message' => 'Notes not found for this user.',
								);
						}
					}
				}else{
					$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
				}
			}
			else{
				$this->response = array(
						'status' => 500,
						'message' => 'Your session expired. Please try again.',
					);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}

  		$this->__send_response();
  	} 

  
  	/**
	 * @name View Notes
	 * Purpose : This method is used to get Notes data
	 * @author Bharat Borana
	 * @access public
	 * @return returns true if notes found else returns error
	 */
        
  	public function viewNotes()
  	{
    	header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
			$this->__send_response();
		}
		
		$error = '';
		$user_data = $this->request->data;

		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';
		
		if(!isset($user_data['notes_id']) || empty($user_data['notes_id']))
			$error .= 'Notes id is required.';

		if(empty($error)){ 

			$this->loadModel('Users');
			$userObj = $this->Users->find('all',
					['contain' => ['Notes'],
					'conditions' => ['Users.id' => $user_data['user_id'], 'Users.sessionId' => $user_data['sessionId']]])->first();
			
			if($userObj){
				
				$user = $userObj->toArray();

				$this->loadModel('Notes');
				$notesObj = $this->Notes->findById($user_data['notes_id'])->hydrate(false)->toArray();
				
				if(!empty($notesObj)){
					$notesData = array();
					foreach ($notesObj as $key => $note) {
						$reponseNotes['Note']['id'] 				= $note['id'];
						$reponseNotes['Note']['Noteheading'] 		= $note['title'];
						$reponseNotes['Note']['Notedescription'] 	= $note['description'];
						$reponseNotes['Note']['CreatedDate'] 		= $note['created'];
						$reponseNotes['Note']['ModifiedDate'] 		= $note['modified'];
						$reponseNotes['Note']['TimeStamp'] 			= $note['timestamp'];

						$this->response = array(
							'status' => 200,
							'message' => 'Notes found.',
							'data' => $reponseNotes
						 );
					}
				}
				else{
					$this->response = array(
							'status' => 400,
							'message' => 'Notes not found for this user.',
						);
				}
			}
			else
			{
				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}

  		$this->__send_response();
  	} 

/**
 * @name GetAccountInfo
 * Purpose : This method is used to get user details 
 * @author Bharat Borana
 * @access public
 * @return returns true if authenticated else returns error
 */
	public function GetAccountInfo()
	{ 
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
		}
		
		$error = '';
		$this->loadModel('Users');

		$user_data = $this->request->data;
		
		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session id is required.';
		
		if(empty($error)){ 
			$userObj = $this->Users->find('all',['conditions' => ['id' => $user_data['user_id'], 'sessionId' => $user_data['sessionId']]])->first();
			
			if(!empty($userObj)){
				
				$user = $userObj->toArray();

				if($user['image'])
				{
					$user['image'] = Router::url('/' . 'uploads' . DS . USER_IMAGE_URL . DS . $user['id'] . DS . $user['image'], true);
				}
				$reponseUser['userdetails']['userId'] 			= $user['id'];
				$reponseUser['userdetails']['username'] 		= $user['username'];
				$reponseUser['userdetails']['sessionId'] 		= $user['sessionId'];
				$reponseUser['userdetails']['first_name'] 		= $user['first_name'];
				$reponseUser['userdetails']['last_name'] 		= $user['last_name'];
				$reponseUser['userdetails']['classroom'] 		= $user['classroom'];
				$reponseUser['userdetails']['Email'] 			= $user['email'];
				$reponseUser['userdetails']['ProfilePicURL'] 	= $user['image'];
				$reponseUser['userdetails']['isVerified'] 		= $user['is_verified'];
				$reponseUser['userdetails']['isTrial'] 			= $user['is_trial'];
				$reponseUser['userdetails']['isPaid'] 			= $user['is_paid'];
				$reponseUser['userdetails']['userType']			= $user['user_type'];
				
				
				if($user['gender'] == 1)
					$reponseUser['userdetails']['gender'] = 'Male';
				else
					$reponseUser['userdetails']['gender'] = 'Female';
				
				/*
				if($user['user_type'] == 1)
					$reponseUser['userdetails']['userType'] 		= 'Primary';
				else
					$reponseUser['userdetails']['userType'] 		= 'Elementary';
				*/
				
				$this->response = array(
				'status' => 200,
				'message' => 'Success!',
				'data' => $reponseUser
				);	
			}
			else{
				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}	
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}
		
		$this->__send_response();
	}

/**
 * @name EditAccountInfo
 * Purpose : This method is used to get user details 
 * @author Bharat Borana
 * @access public
 * @return returns true if authenticated else returns error
 */
	public function EditAccountInfo()
	{ 
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
		}
		
		$error = '';
		$this->loadModel('Users');

		$user_data = $this->request->data;
		
		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session id is required.';
		
		if(empty($error)){ 
			$userObj = $this->Users->find('all',['conditions' => ['id' => $user_data['user_id'], 'sessionId' => $user_data['sessionId']]])->first();
			
			$this->Users->validator()->remove('password');
			$this->Users->validator()->remove('confirm_password');
			
			if($userObj){
				$user = $this->Users->patchEntity($userObj, $user_data);

				$errors = $user->errors();

				if(!empty($errors)) {
					foreach ($errors as $key => $value) {
						$error .= $value[array_keys($value)[0]].",  ";
					}
				}   
				
				if(!empty($error)) {
				$this->response = array(
						'status' => 400,
						'message' => rtrim($error, ', '),
					);
				}
				else {

					if($this->Users->save($user))
					{
						$user = $user->toArray();
						
						if($user['image'])
						{
							$user['image'] = Router::url('/' . 'uploads' . DS . USER_IMAGE_URL . DS . $user['id'] . DS . $user['image'], true);
						}
						$reponseUser['userdetails']['userId'] 			= $user['id'];
						$reponseUser['userdetails']['username'] 		= $user['username'];
						$reponseUser['userdetails']['sessionId'] 		= $user['sessionId'];
						$reponseUser['userdetails']['first_name'] 		= $user['first_name'];
						$reponseUser['userdetails']['last_name'] 		= $user['last_name'];
						$reponseUser['userdetails']['classroom'] 		= $user['classroom'];
						$reponseUser['userdetails']['Email'] 			= $user['email'];
						$reponseUser['userdetails']['ProfilePicURL'] 	= $user['image'];
						$reponseUser['userdetails']['isVerified'] 		= $user['is_verified'];
						$reponseUser['userdetails']['isTrial'] 			= $user['is_trial'];
						$reponseUser['userdetails']['isPaid'] 			= $user['is_paid'];
						$reponseUser['userdetails']['user_type'] 		= $user['user_type'];

						if($user['gender'] == 1)
							$reponseUser['userdetails']['gender'] 				= 'Male';
						else	
							$reponseUser['userdetails']['gender'] 				= 'Female';
							

						

						$this->response = array(
							'status' => 200,
							'message' => 'User successfully updated',
							'data' => $reponseUser
						);
					} else
					{
						$this->response = array(
							'status' => 500,
							'message' => 'Student cannot be saved right now. Please try again.',
						);
					}		
				}
				$this->__send_response();
			}
			else{
				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}	
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}
		
		$this->__send_response();
	}	

	/**
	 * @name change_password
	 * Purpose : This method is used to change the password 
	 * @author Bharat Borana
	 * @access public
	 * @return returns true if password sent else returns error
	 */
	public function changePassword()
	{
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
		}
		
		$error = '';
		$this->loadModel('Users');

		$user_data = $this->request->data;
		
		$this->Users->validator()->remove('password', 'compare');

		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';

		if(!isset($user_data['old_password']) || empty($user_data['old_password']))
			$error .= 'Old password is required.';

		if(!isset($user_data['new_password']) || empty($user_data['new_password']))
			$error .= 'New password is required.';
		
		if(!empty($error))
		{
			$this->response = array(
				'status' => 400,
				'message' => rtrim($error, ', ')
			);
		}else
	 	{
	 		$userObj = $this->Users->find('all',['conditions' => ['id' => $user_data['user_id'],'sessionId' => $user_data['sessionId']]])->first();
			
			if(!empty($userObj)){
				$users = $userObj->toArray();
				$passCheck = (new DefaultPasswordHasher)->check($user_data['old_password'], $users['password']);

				if($passCheck)
				{
					$saveUser = $this->Users->patchEntity($userObj, ['password' => $user_data['new_password']]);
					$saveUser = $this->Users->save($saveUser);
					if($saveUser ) {
						$this->response = array(
									'status' => 200,
									'message' => "Password updated successfully."
						);
					}
					else{
						$this->response = array(
								'status' =>500,
								'message' => "The password could not be updated. Please try again."
						);
					}
				}
				else
				{
					$this->response = array(
								'status' => 400,
								'message' => "Invalid password."
					);
				}
			}
			else{
				$this->response = array(
					'status' => 400,
					'message' => 'Invalid user. Please try again.',
				);
			}
			
		}
		$this->__send_response();
	}

	/**
	 * @name EditProfilepic
	 * Purpose : This method is used to edit profile picture
	 * @author Bharat Borana
	 * @access public
	 */
  public function EditProfilepic()
  {
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
				'status' => 405,
				'message' => 'Method not allowed',
			);
			$this->__send_response();
		}

		$error = '';
		$this->loadModel('Users');
		$data = $this->request->data;
		$sav_data = array();
		

		if(!isset($data['user_id']) || empty($data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($data['sessionId']) || empty($data['sessionId']))
			$error .= 'Session Id is required.';

		if(isset($data['image']))
		{
			if( !empty($data['image']) && $data['image']['error'] == 0)
			{
				$image = $data['image'];

				$userObj = $this->Users->find('all',['conditions' => ['id' => $data['user_id'], 'sessionId' => $data['sessionId']]])->first();
				
				if(!empty($userObj)){
					$users = $userObj->toArray();

					$this->loadComponent('Utility');
					$img_return = $this->Utility->saveImageToServer($data['user_id'], $image, USER_IMAGE_PATH);
					if($img_return['status'])
					{
						$sav_data['image'] = $img_return['name'];

					} else
					{
						$error .= 'Image can not be uploaded.';
					}	
				}
				else{
					$error .= 'Your session expired. Please try again.';
				}
				
			} else
			{
				$error .= 'Image not found.';
			}
		}
		else{
			$error .= 'Image not found.';
		}
		if(empty($error)){
			if(!empty($sav_data))
			{
				$user = $this->Users->patchEntity($userObj, $sav_data);
				if($user = $this->Users->save($user))
				{
					$user['image'] = Router::url('/' . 'uploads' . DS . USER_IMAGE_URL . DS . $user['id'] . DS . $user['image'], true);
					$reponseUser['userdetails'] = $user['image'];
					$this->response = array(
						'status' => 200,
						'message' => 'Profile has been updated.',
						'data' => $reponseUser,
					);
				} else
				{
					$this->response = array(
						'status' => 500,
						'message' => 'Profile cannot be updated right now. Please try again.',
					);
				}	
			} else
			{
				$this->response = array(
					'status' => 200,
					'message' => 'Profile not changed.',
				);
			}
		}
		else{
			$this->response = array(
				'status' => 200,
				'message' => rtrim($error, ', '),
			);
		}

		$this->__send_response();
  }

  /**
	 * @name Edit Notes
	 * Purpose : This method is used to edit notes 
	 * @author Bharat Borana
	 * @access public
	 * @return returns true if notes edited else returns error
	 */
	public function EditNotes()
	{ 
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
				'status' => 400,
				'message' => 'Method not allowed',
			);
		}
		
		$error = '';
		$this->loadModel('Notes');

		$user_data = $this->request->data;
		
		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';

		if(!isset($user_data['note_id']) || empty($user_data['note_id']))
			$error .= 'Note Id is required.';
		
		if(empty($error)){ 
			$notesObj = $this->Notes->find('all',['conditions' => ['id' => $user_data['note_id'], 'user_id' => $user_data['user_id']]])->first();
			
			if($notesObj){
				$notes = $notesObj->toArray();

				$note = $this->Notes->patchEntity($notesObj, $user_data);

				$errors = $note->errors();

				if(!empty($errors)) {
				    foreach ($errors as $key => $value) {
				    	$error .= $value[array_keys($value)[0]].",  ";
				    }
				}   
				 
				if(!empty($error)) {
				    $this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
				}
				else {
					$note->timestamp = $_SERVER['REQUEST_TIME'];
					if($this->Notes->save($note))
					{
						
						$reponseNotes['Note']['id'] 			= $note['id'];
						$reponseNotes['Note']['Noteheading'] 	= $note['title'];
						$reponseNotes['Note']['CreatedDate'] 	= $note['created'];
						$reponseNotes['Note']['ModifiedDate'] 	= $note['modified'];
						$reponseNotes['Note']['TimeStamp'] 		= $note['timestamp'];
						
						$this->response = array(
							'status' => 200,
							'message' => 'Note edited.',
							'data' => $reponseNotes
						);
					} else
					{
						$this->response = array(
							'status' => 500,
							'message' => 'Note cannot be edited right now. Please try again.',
						);
					}		
				}
				$this->__send_response();
			}
			else{
				$this->response = array(
							'status' => 400,
							'message' => 'Invalid note. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}
		
		$this->__send_response();
	}

	/**
	 * @name Delete Notes
	 * Purpose : This method is used to delete notes 
	 * @author Bharat Borana
	 * @access public
	 * @return returns true if notes deleted else returns error
	 */
	public function DeleteNotes()
	{ 
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
				'status' => 400,
				'message' => 'Method not allowed',
			);
		}
		
		$error = '';
		$this->loadModel('Notes');

		$user_data = $this->request->data;
		
		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';

		if(!isset($user_data['note_id']) || empty($user_data['note_id']))
			$error .= 'Note Id is required.';
		
		if(empty($error)){ 
			$notesObj = $this->Notes->find('all',['conditions' => ['id' => $user_data['note_id'],'user_id' => $user_data['user_id']]])->first();

			if($notesObj){
				$notes = $notesObj->toArray();

				if($this->Notes->delete($notesObj))
				{
					
					$this->response = array(
						'status' => 200,
						'message' => 'Notes deleted.',
					);
				} else
				{
					$this->response = array(
						'status' => 500,
						'message' => 'Notes cannot be deleted right now. Please try again.',
					);
				}		
				$this->__send_response();
			}
			else{
				$this->response = array(
							'status' => 400,
							'message' => 'Invalid note. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}
		
		$this->__send_response();
	}	  

	/**
	 * @name Delete Student
	 * Purpose : This method is used to delete students 
	 * @author Bharat Borana
	 * @access public
	 * @return returns true if students deleted else returns error
	 */
	public function DeleteStudent()
	{ 
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
				'status' => 400,
				'message' => 'Method not allowed',
			);
		}
		
		$error = '';
		$this->loadModel('Students');

		$user_data = $this->request->data;
		
		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';

		if(!isset($user_data['student_id']) || empty($user_data['student_id']))
			$error .= 'Student Id is required.';
		
		if(empty($error)){ 
			$studentObj = $this->Students->find('all',[
					'conditions' => ['id' => $user_data['student_id'],'user_id' => $user_data['user_id']],
					'contain'	=>	['StudentViews.Students']
					])->first();
			if($studentObj){
				$student = $studentObj->toArray();
				
				if($this->Students->delete($studentObj))
				{
					$this->loadModel('UserPlans');
					$userPlanData = $this->UserPlans->find('all', [
							'conditions' => ['UserPlans.user_id' => $user_data['user_id'], 'UserPlans.status' => 1],
							'contain'	=> ['StudentViews']
						])->hydrate(false);
					
					if(!empty($userPlanData))
					{
						$userPlanData = $userPlanData->toArray();
						foreach($userPlanData as $plan)
						{
							if(isset($plan['student_views']) && empty($plan['student_views']))
							{
								$planEntity = $this->UserPlans->get($plan['id']);
								$planEntity = $this->UserPlans->delete($planEntity);
							}
						}
					}

					$this->response = array(
						'status' => 200,
						'message' => 'Student deleted.',
					);
				} else
				{
					$this->response = array(
						'status' => 500,
						'message' => 'Student cannot be deleted right now. Please try again.',
					);
				}		
				$this->__send_response();
			}
			else{
				$this->response = array(
							'status' => 400,
							'message' => 'Invalid student. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}
		
		$this->__send_response();
	}
	
	/**
	 * @name Delete Account
	 * Purpose : This method is used to delete teacher account 
	 * @author Bharat Borana
	 * @access public
	 * @return returns true if students deleted else returns error
	 */
	public function DeleteMyAccount()
	{ 
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
				'status' => 400,
				'message' => 'Method not allowed',
			);
			$this->__send_response();
		}
		
		$error = '';
		$this->loadModel('Users');

		$user_data = $this->request->data;
		
		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';

		
		if(empty($error)){ 
			$studentObj = $this->Users->find('all',['conditions' => ['Users.id' => $user_data['user_id'], 'sessionId' => $user_data['sessionId']]])->first();

			if($studentObj){
				$notes = $studentObj->toArray();

				if($this->Users->delete($studentObj))
				{
					
					$this->response = array(
						'status' => 200,
						'message' => 'User account deleted.',
					);
				} else
				{
					$this->response = array(
						'status' => 500,
						'message' => 'User cannot be deleted right now. Please try again.',
					);
				}		
				$this->__send_response();
			}
			else{
				$this->response = array(
							'status' => 400,
							'message' => 'Invalid user. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}
		
		$this->__send_response();
	}

	/**
	 * @name Edit Students
	 * Purpose : This method is used to edit students 
	 * @author Bharat Borana
	 * @access public
	 * @return returns true if students edited else returns error
	 */
	public function EditStudent()
	{ 
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
				'status' => 400,
				'message' => 'Method not allowed',
			);
		}
		
		$error = '';
		$this->loadModel('Students');

		$user_data = $this->request->data;
		
		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';

		if(!isset($user_data['student_id']) || empty($user_data['student_id']))
			$error .= 'Student Id is required.';
		
		if(empty($error)){ 
			$studentsObj = $this->Students->find('all',['conditions' => ['id' => $user_data['student_id'], 'user_id' => $user_data['user_id']]])->first();
			
			if($studentsObj){
				$students = $studentsObj->toArray();

				$student = $this->Students->patchEntity($studentsObj, $user_data);

				$errors = $student->errors();

				if(!empty($errors)) {
				    foreach ($errors as $key => $value) {
				    	$error .= $value[array_keys($value)[0]].",  ";
				    }
				}   
				 
				if(!empty($error)) {
				    $this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
				}
				else {

					if($this->Students->save($student))
					{
						
						$reponseUser['StudentInfo']['studentId'] 		= $student['id'];
						$reponseUser['StudentInfo']['FirstName'] 		= $this->getStudentShortName($student['first_name'], 20);
						$reponseUser['StudentInfo']['LastName'] 		= $this->getStudentShortName($student['last_name'], 1);
						
						if(!empty($student['birthday'])){
							$reponseUser['StudentInfo']['BirthdayDate'] 	= date('m-d-Y', strtotime($student['birthday']));
							$reponseUser['StudentInfo']['Age'] 				= $this->age_from_dob(date('Y-m-d', strtotime($student['birthday'])));
							
						}
						
						
						if($student['status'] == 1)
							$reponseUser['StudentInfo']['Status'] 				= 'Active';
						else
							$reponseUser['StudentInfo']['Status'] 				= 'Inactive';
							

						$this->response = array(
							'status' => 200,
							'message' => 'Student edited.',
							'data' => $reponseUser
						);
					} else
					{
						$this->response = array(
							'status' => 500,
							'message' => 'Student cannot be edited right now. Please try again.',
						);
					}		
				}
				$this->__send_response();
			}
			else{
				$this->response = array(
							'status' => 400,
							'message' => 'Invalid student. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}
		
		$this->__send_response();
	} 
	
	/**
	 * @name generateAutoOrder
	 * Purpose : This method is used to generate new order
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if areas added else returns error
	 */

	public function generateAutoOrder($case = null){

		switch($case)
		{
			case 'area' : 
					$this->loadModel('Areas');
					$dataObj = $this->Areas->find('all')
												->order(['Areas.order_no' => 'DESC'])
												->first();
					if(!empty($dataObj)){
						$dataObj = $dataObj->toArray();
						return $dataObj['order_no'] + 1 ;	
					}else{
						$dataObj = $this->Areas->find('count');
						return $dataObj + 1;
					}
				break;
			case 'chapter' : 
					$this->loadModel('Chapters');
					$dataObj = $this->Chapters->find('all')
												->order(['Chapters.order_no' => 'DESC'])
												->first();
					if(!empty($dataObj)){
						$dataObj = $dataObj->toArray();
						return $dataObj['order_no'] + 1 ;	
					}else{
						$dataObj = $this->Chapters->find('count');
						return $dataObj + 1;
					}
				break;
			case 'lesson' : 
					$this->loadModel('Lessons');
					$dataObj = $this->Lessons->find('all')
												->order(['Lessons.order_no' => 'DESC'])
												->first();
					if(!empty($dataObj)){
						$dataObj = $dataObj->toArray();
						return $dataObj['order_no'] + 1 ;	
					}else{
						$dataObj = $this->Lessons->find('count');
						return $dataObj + 1;
					}
				break;
			case 'exercise' : 
					$this->loadModel('Exercises');
					$dataObj = $this->Exercises->find('all')
												->order(['Exercises.order_no' => 'DESC'])
												->first();
					if(!empty($dataObj)){
						$dataObj = $dataObj->toArray();
						return $dataObj['order_no'] + 1 ;	
					}else{
						$dataObj = $this->Exercises->find('count');
						return $dataObj + 1;
					}
				break;
			default:
					return rand(100, 1000);
				break;
		
		}
	}

	 /**
	 * @name Add Areas
	 * Purpose : This method is used to add areas 
	 * @author Bharat Borana
	 * @updated Pawan Bhatia
	 * @access public
	 * @return returns true if areas added else returns error
	 */
	public function AddAreas()
	{ 

		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
				'status' => 400,
				'message' => 'Method not allowed',
			);
		}
		
		$error = '';
		$this->loadModel('Users');

		$user_data = $this->request->data;
		
		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';
		
		if(empty($error)){ 
			$userObj = $this->Users->find('all',['conditions' => ['id' => $user_data['user_id'], 'sessionId' => $user_data['sessionId']]])->first();
			
			if($userObj){
				$user = $userObj->toArray();
				
				$areaColor = isset($user_data['area_color']) ? $user_data['area_color'] : '';
				
				$this->loadComponent('Common');
				$user_data['object_id'] 	= $this->Common->generateRandomString(10);
				$user_data['area_color'] 	= (!empty($areaColor)) ? $areaColor : $this->Common->getRandomColor();
				
				$this->loadModel('Areas');
				
				$countUserAreas = $this->Areas->countUserAreas($user['id'], $user_data['area_type'], ADD_AREA_LIMIT);

				if(!$countUserAreas){
					$error .= "You have already added ". ADD_AREA_LIMIT ." areas. You can not add more. ";
					$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
				}
				
				$area = $this->Areas->newEntity($user_data);

				$errors = $area->errors();
				
				if(!empty($errors)) {
				    foreach ($errors as $key => $value) {
				    	$error .= $value[array_keys($value)[0]].",  ";
				    }
				}   
				
				if(!empty($error)) {
				    $this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
				}
				else {
					$area->order_no = $this->generateAutoOrder('area');

					if($this->Areas->save($area))
					{
						$reponseAreas['Area']['id'] 			= $area['id'];
						$reponseAreas['Area']['objectId'] 		= $area['object_id'];
						$reponseAreas['Area']['Areaheading'] 	= $area['title'];
						$reponseAreas['Area']['userId'] 		= $area['user_id'];
						$reponseAreas['Area']['CreatedDate'] 	= $area['created'];
						$reponseAreas['Area']['ModifiedDate'] 	= $area['modified'];
						
						$this->response = array(
							'status' => 200,
							'message' => 'Area created successfully. ',
							'data' => $reponseAreas
						);
					} else
					{
						$this->response = array(
							'status' => 500,
							'message' => 'Areas cannot be added right now. Please try again.',
						);
					}		
				}
				$this->__send_response();
			}
			else{
				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}
		
		$this->__send_response();
	}

	/**
	 * @name GetDefaultAreas
	 * Purpose : This method is used to GetDefaultAreas
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if areas found else returns error
	 */

	public function getDefaultAreas($area_type = null){
		$this->loadModel('Areas');
		if(!empty($area_type)){
			$defaultList = $this->Areas->find('All', [
					'conditions'=>[
						'Areas.user_id'=>1, 
						'Areas.status'=>1, 
						'Areas.area_type'=>$area_type
					],
					'order' => ['Areas.order_no'=>'ASC']
					])->hydrate(false)->toArray();
		}else{
			$defaultList = $this->Areas->find('All', [
					'conditions'=>[
						'Areas.user_id'=>1, 
						'Areas.status'=>1
					],
					'order' => ['Areas.order_no'=>'ASC']
					])->hydrate(false)->toArray();
		}
		
		
		$returnArray['areas'] = $defaultList;
		return $returnArray;
	}

	/**
	 * @name getDefaultChapters
	 * Purpose : This method is used to getDefaultChapters
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if areas found else returns error
	 */

	public function getDefaultChapters($area_id = null){
		$this->loadModel('Chapters');
		if(!empty($area_id)){
			$defaultList = $this->Chapters->find('All', [
				'conditions'=>[
					'Chapters.area_id'=>$area_id, 
					'Chapters.user_id'=>1, 
					'Chapters.status'=>1
					],
				'order' => ['Chapters.order_no'=>'ASC']
				])->contain('Areas')->hydrate(false)->toArray();
		}else{
			$defaultList = $this->Chapters->find('All', [
				'conditions'=>[
					'Chapters.user_id'=>1, 
					'Chapters.status'=>1
				],
				'order' => ['Chapters.order_no'=>'ASC']
				])->contain('Areas')->hydrate(false)->toArray();
		}
		
		$returnArray['chapters'] = $defaultList;
		return $returnArray;
	}

	/**
	 * @name getDefaultLessons
	 * Purpose : This method is used to getDefaultLessons
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if areas found else returns error
	 */
	public function getDefaultLessons($area_id=null, $chapter_id = null){
		$this->loadModel('Lessons');
		if(!empty($area_id) && !empty($chapter_id)){
			$defaultList = $this->Lessons->find('All', [
								'conditions'=>[
									'Lessons.user_id'=>1, 
									'Lessons.status'=>1, 
									'Lessons.area_id'=>$area_id, 
									'Lessons.chapter_id'=>$chapter_id
								],
								'order' => ['Lessons.order_no'=>'ASC']
							])->contain(['Chapters', 'Areas'])->hydrate(false)->toArray();	
		}else{
			$defaultList = $this->Lessons->find('All', [
								'conditions'=>[
									'Lessons.user_id'=>1, 
									'Lessons.status'=>1
								],
								'order' => ['Lessons.order_no'=>'ASC']
							])->contain(['Chapters', 'Areas'])->hydrate(false)->toArray();	
		}
		
		
		$returnArray['lessons'] = $defaultList;
		return $returnArray;
	}

	/**
	 * @name getDefaultExercises
	 * Purpose : This method is used to getDefaultExercises
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if areas found else returns error
	 */
	public function getDefaultExercises($area_id=null, $chapter_id = null, $lesson_id = null){
		$this->loadModel('Exercises');
		if(!empty($area_id) && !empty($chapter_id) && !empty($lesson_id)){
			$defaultList = $this->Exercises->find('All', [
					'conditions'=>[
						'Exercises.user_id'=>1, 
						'Exercises.status'=>1, 
						'Exercises.area_id'=>$area_id, 
						'Exercises.chapter_id'=>$chapter_id, 
						'Exercises.lesson_id'=>$lesson_id
					],
					'order' => ['Exercises.order_no'=>'ASC']
					])->contain(['Chapters', 'Areas', 'Lessons'])->hydrate(false)->toArray();
		}else{
			$defaultList = $this->Exercises->find('All', [
				'conditions'=>[
					'Exercises.user_id'=>1, 
					'Exercises.status'=>1
				],
				'order' => ['Exercises.order_no'=>'ASC']
				])->contain(['Chapters', 'Areas', 'Lessons'])->hydrate(false)->toArray();		
		}
		
		$returnArray['exercises'] = $defaultList;
		return $returnArray;
	}

	public function getExercisesCheck($user_data = null){
		$this->loadModel('Users');
						
		$userObj = $this->Users->find('all', [
					'conditions'=> [
						'id' 				=> $user_data['user_id'], 
						'sessionId' 		=> $user_data['sessionId'],
						]
					])->contain([
							'Exercises.Lessons.Chapters.Areas' => [
								'joinType' => 'inner',
								'queryBuilder' =>
										function ($q) use ($user_data) {
											return $q->where([
											'AND' =>[
													'Exercises.area_id ' => $user_data['area_id'],
													'Exercises.chapter_id ' => $user_data['chapter_id'],
													'Exercises.lesson_id ' => $user_data['lesson_id'],
													'Exercises.status ' => 1
												]
											]);
							}]
					])->hydrate(false)->first();
		
		$defaultExercisesList = $this->getDefaultExercises($user_data['area_id'], $user_data['chapter_id'], $user_data['lesson_id']);
		$userObj = array_merge($userObj, $defaultExercisesList);
		return $userObj['exercises'];
	}

	/**
	 * @name Get Areas List
	 * Purpose : This method is used to get Area data
	 * @author Bharat Borana
	 * @access public
	 * @return returns true if areas found else returns error
	 */
			
	function GetAreasList()
	{
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
			$this->__send_response();
		}
		
		$error = '';
		$user_data = $this->request->data;

		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';
		
		if(empty($error)){ 

			$this->loadModel('Users');
			
			$userObj = $this->Users->find('all', [
						'conditions'=> [
							'id' 				=> $user_data['user_id'], 
							'sessionId' 		=> $user_data['sessionId'],
							]
						])->contain([
								'Areas' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($user_data) {
												return $q->where([
													'AND' =>[
														'Areas.status ' => 1
													]
												])->order(['Areas.order_no'=>'ASC']);
								}]
						])->first();
		
			if($userObj){
				$user = $userObj->toArray();

				$areasData = array();
				// Added default list

				$defaultAreasList = $this->getDefaultAreas($user['user_type']);
				$user = array_merge($user, $defaultAreasList);

				if(isset($user['areas']) && !empty($user['areas'])){

					foreach ($user['areas'] as $key => $area) {

						if($area['area_type'] == 1)
							$area['area_type'] = 'Primary';
						else
							$area['area_type'] = 'Elementry';
						
						$reponseAreas['Area']['areaColor'] 	= $area['area_color'];
						$reponseAreas['Area']['areaName'] 	= $area['title'];
						$reponseAreas['Area']['createdAt'] 	= $area['created'];
						$reponseAreas['Area']['AreaId'] 	= $area['id'];
						$reponseAreas['Area']['objectId'] 	= $area['object_id'];
						$reponseAreas['Area']['AreaType'] 	= $area['area_type'];
						$reponseAreas['Area']['updatedAt'] 	= $area['modified'];

						$areasData[] = $reponseAreas;
					}
					
					$this->response = array(
							'status' => 200,
							'message' => 'Areas found.',
							'value' => $areasData
						 );

				}
				else{
						$this->response = array(
							'status' => 404,
							'message' => 'Areas not found for this user.',
						);	
				}
			}
			else
			{
				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}

		$this->__send_response();
	} 

	public function getAuthUser($sessionId = null)
	{
		$this->loadModel('Users');
		$userObj = $this->Users->find('all',['conditions' => ['sessionId' => $sessionId]])->first();
		$userObj = $userObj->toArray();
		return $userObj['id'];
	}
   
   /**
	 * @name Edit Areas
	 * Purpose : This method is used to edit areas 
	 * @author Bharat Borana
	 * $Updated Pawan Bhatia
	 * @access public
	 * @return returns true if areas edited else returns error
	 */
	public function EditAreas()
	{ 
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
				'status' => 400,
				'message' => 'Method not allowed',
			);
			$this->__send_response();
		}
		// Edit mode 1 is true and rest is false
		
		if(EDIT_AREA === 1)
		{
			$error = '';
			$this->loadModel('Areas');

			$user_data = $this->request->data;
			
			if(!isset($user_data['user_id']) || empty($user_data['user_id']))
				$error .= 'User id is required.';
			
			if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
				$error .= 'Session Id is required.';

			if(!isset($user_data['area_id']) || empty($user_data['area_id']))
				$error .= 'Area Id is required.';
			
			if(empty($error)){
				
				$authId = $this->getAuthUser($user_data['sessionId']);

				$areasObj = $this->Areas->find('all',[
							'conditions' => [
								'id' => $user_data['area_id'], 
								'user_id' => $user_data['user_id']
							],
							'contain' => [
								'UserAreas' => [
									'joinType' => 'inner',
									'queryBuilder' =>
										function ($q) use ($authId) {
											return $q
											->where([
												'UserAreas.user_id' => $authId,
											]);
								}]
							]])->first();
				
				if($areasObj){
					$areas = $areasObj->toArray();

					if($authId != $user_data['user_id'])
					{
						$this->loadModel('UserAreas');
						$userAreaData = [
							'area_id'	=> $areas['id'],
							'user_id'	=> $authId,
							'action'	=> 'edit',
							'title'		=> $user_data['title'],
							'area_color'=> isset($user_data['area_color']) ? $user_data['area_color'] : $areas['area_color'],
						];

						if(empty($areas['user_areas']))
						{
							$userAreaData	= $this->UserAreas->newEntity($userAreaData);
						}
						else
						{
							$userAreaDb		= $this->UserAreas->get($areas['user_areas'][0]['id']);
							$userAreaData	= $this->UserAreas->patchEntity($userAreaDb, $userAreaData);
						}
						
						if($this->UserAreas->save($userAreaData))
						{
							$reponseAreas['Area']['id'] 			= $areas['id'];
							$reponseAreas['Area']['Areaheading'] 	= $user_data['title'];
							$reponseAreas['Area']['CreatedDate'] 	= $userAreaData['created'];
							$reponseAreas['Area']['ModifiedDate'] 	= $userAreaData['modified'];
							
							$this->response = array(
								'status' => 200,
								'message' => 'Area edited.',
								'data' => $reponseAreas
							);

						} else
						{
							$this->response = array(
								'status' => 500,
								'message' => 'Area cannot be edited right now. Please try again.',
							);
						}
					}
					else
					{
						$area = $this->Areas->patchEntity($areasObj, $user_data);

						$errors = $area->errors();

						if(!empty($errors)) {
							foreach ($errors as $key => $value) {
								$error .= $value[array_keys($value)[0]].",  ";
							}
						}   
						 
						if(!empty($error)) 
						{
							$this->response = array(
									'status' => 400,
									'message' => rtrim($error, ', '),
								);
						}
						else 
						{
							if($this->Areas->save($area))
							{
								
								$reponseAreas['Area']['id'] 			= $area['id'];
								$reponseAreas['Area']['Areaheading'] 	= $area['title'];
								$reponseAreas['Area']['CreatedDate'] 	= $area['created'];
								$reponseAreas['Area']['ModifiedDate'] 	= $area['modified'];
								
								$this->response = array(
									'status' => 200,
									'message' => 'Area edited.',
									'data' => $reponseAreas
								);
							} else
							{
								$this->response = array(
									'status' => 500,
									'message' => 'Area cannot be edited right now. Please try again.',
								);
							}		
						}
					}
					$this->__send_response();
				}
				else{
					$this->response = array(
								'status' => 400,
								'message' => 'Invalid area. Please try again.',
							);
				}
			}
			else{
				$this->response = array(
								'status' => 400,
								'message' => rtrim($error, ', '),
							);
			}
		}else
		{
			$this->response = array(
					'status' => 400,
					'message' => 'Area edit is not allowed.',
				);
		}
		
		$this->__send_response();
	}

	/**
	 * @name Delete Areas
	 * Purpose : This method is used to delete areas 
	 * @author Bharat Borana
	 * @access public
	 * @return returns true if areas deleted else returns error
	 */
	public function DeleteAreas()
	{ 
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
				'status' => 400,
				'message' => 'Method not allowed',
			);
		}
		
		if(DELETE_AREA === 1)
		{
			$error = '';
			$this->loadModel('Areas');

			$user_data = $this->request->data;
			
			if(!isset($user_data['user_id']) || empty($user_data['user_id']))
				$error .= 'User id is required.';
			
			if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
				$error .= 'Session Id is required.';

			if(!isset($user_data['area_id']) || empty($user_data['area_id']))
				$error .= 'Area Id is required.';
			
			if(empty($error)){ 
				
				$authId = $this->getAuthUser($user_data['sessionId']);

				$areasObj = $this->Areas->find('all',[
							'conditions' => [
								'id' => $user_data['area_id'], 
								'user_id' => $user_data['user_id']
							],
							'contain' => [
								'UserAreas' => [
									'joinType' => 'inner',
									'queryBuilder' =>
										function ($q) use ($authId) {
											return $q
											->where([
												'UserAreas.user_id' => $authId,
											]);
								}]
							]])->first();

				if($areasObj){
					$areas = $areasObj->toArray();
					if($authId != $user_data['user_id'])
					{
						$this->loadModel('UserAreas');
						$userAreaData = [
							'area_id'	=> $areas['id'],
							'user_id'	=> $authId,
							'action'	=> 'delete',
							'title'		=> $areas['title'],
							'area_color'=> $areas['area_color'],
						];

						if(empty($areas['user_areas']))
						{
							$userAreaData	= $this->UserAreas->newEntity($userAreaData);
						}
						else
						{
							$userAreaDb		= $this->UserAreas->get($areas['user_areas'][0]['id']);
							$userAreaData	= $this->UserAreas->patchEntity($userAreaDb, $userAreaData);
						}
						
						if($this->UserAreas->save($userAreaData))
						{
							$this->response = array(
								'status' => 200,
								'message' => 'Area deleted.',
							);

						} else
						{
							$this->response = array(
								'status' => 500,
								'message' => 'Area cannot be deleted right now. Please try again.',
							);
						}
					}
					else
					{
						if($this->Areas->delete($areasObj))
						{
							$this->response = array(
								'status' => 200,
								'message' => 'Area deleted.',
							);
						} else
						{
							$this->response = array(
								'status' => 500,
								'message' => 'Area cannot be deleted right now. Please try again.',
							);
						}
					}
							
					$this->__send_response();
				}
				else{
					$this->response = array(
								'status' => 400,
								'message' => 'Invalid area. Please try again.',
							);
				}
			}
			else{
				$this->response = array(
								'status' => 400,
								'message' => rtrim($error, ', '),
							);
			}
		}else
		{
			$this->response = array(
								'status' => 400,
								'message' => 'Deleting this area is not allowed.',
							);
		}
		
		
		$this->__send_response();
	}
	
	
	/**
	 * @name Add Chapter
	 * Purpose : This method is used to add chapter under area 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if areas added else returns error
	 */
	public function AddChapters()
	{ 

		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
				'status' => 400,
				'message' => 'Method not allowed',
			);
		}
		
		$error = '';
		$this->loadModel('Users');

		$user_data = $this->request->data;
		
		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';
			
		if(!isset($user_data['area_id']) || empty($user_data['area_id']))
			$error .= 'Area Id is required.';
		
		if(empty($error)){ 
			$userObj = $this->Users->find('all',['conditions' => ['id' => $user_data['user_id'], 'sessionId' => $user_data['sessionId']]])->first();
			
			if($userObj){
				$user = $userObj->toArray();
				
				$this->loadComponent('Common');
				$user_data['object_id'] = $this->Common->generateRandomString(10);
				
				$this->loadModel('Chapters');
				$chapter = $this->Chapters->newEntity($user_data);
				
				$errors = $chapter->errors();
				
				if(!empty($errors)) {
				    foreach ($errors as $key => $value) {
				    	$error .= $value[array_keys($value)[0]].",  ";
				    }
				}   
				
				if(!empty($error)) {
				    $this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
				}
				else {
					
					$chapter->order_no = $this->generateAutoOrder('chapter');

					if($this->Chapters->save($chapter))
					{
						$reponseChapters['Chapter']['id'] 				= $chapter['id'];
						$reponseChapters['Chapter']['objectId'] 		= $chapter['object_id'];
						$reponseChapters['Chapter']['ChapterHeading'] 	= $chapter['title'];
						$reponseChapters['Chapter']['CreatedDate'] 		= $chapter['created'];
						$reponseChapters['Chapter']['ModifiedDate'] 	= $chapter['modified'];
						
						$this->response = array(
							'status' => 200,
							'message' => 'Chapters created successfully.',
							'data' => $reponseChapters
						);
					} else
					{
						$this->response = array(
							'status' => 500,
							'message' => 'Chapters cannot be added right now. Please try again.',
						);
					}		
				}
				$this->__send_response();
			}
			else{
				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}
		
		$this->__send_response();
	}
	
	/**
	 * @name Edit Chapter
	 * Purpose : This method is used to edit chapter 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if chapter edited else returns error
	 */
	public function EditChapters()
	{ 
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
				'status' => 400,
				'message' => 'Method not allowed',
			);
		}
		
		$error = '';
		$this->loadModel('Chapters');

		$user_data = $this->request->data;
		
		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';

		if(!isset($user_data['chapter_id']) || empty($user_data['chapter_id']))
			$error .= 'Chapter Id is required.';
		
		if(empty($error)){ 
			
			$authId = $this->getAuthUser($user_data['sessionId']);

			$chaptersObj = $this->Chapters->find('all',[
					'conditions' => [
						'id' => $user_data['chapter_id'], 
						'user_id' => $user_data['user_id']
					],
					'contain' => [
						'UserChapters' => [
							'joinType' => 'inner',
							'queryBuilder' =>
								function ($q) use ($authId) {
									return $q
									->where([
										'UserChapters.user_id' => $authId,
									]);
						}]
					]])->first();
			
			if($chaptersObj){
				$chapters = $chaptersObj->toArray();

				if($authId != $user_data['user_id'])
				{
					$this->loadModel('UserChapters');
					$userNewData = [
						'chapter_id'=> $chapters['id'], 
						'area_id'	=> $chapters['area_id'],
						'user_id'	=> $authId,
						'action'	=> 'edit',
						'title'		=> $user_data['title'],
					];

					if(empty($chapters['user_chapters']))
					{
						$userNewData	= $this->UserChapters->newEntity($userNewData);
					}
					else
					{
						$userChapterDb	= $this->UserChapters->get($chapters['user_chapters'][0]['id']);
						$userNewData	= $this->UserChapters->patchEntity($userChapterDb, $userNewData);
					}
					
					if($this->UserChapters->save($userNewData))
					{
						
						$reponseChapters['Chapter']['id'] 				= $chapters['id'];
						$reponseChapters['Chapter']['ChapterHeading'] 	= $userNewData['title'];
						$reponseChapters['Chapter']['CreatedDate'] 		= $userNewData['created'];
						$reponseChapters['Chapter']['ModifiedDate'] 	= $userNewData['modified'];
						
						$this->response = array(
							'status' => 200,
							'message' => 'Chapter edited.',
							'data' => $reponseChapters
						);
					} else
					{
						$this->response = array(
							'status' => 500,
							'message' => 'Chapter cannot be edited right now. Please try again.',
						);
					}
				}
				else
				{
					$chapter = $this->Chapters->patchEntity($chaptersObj, $user_data);

					$errors = $chapter->errors();

					if(!empty($errors)) {
						foreach ($errors as $key => $value) {
							$error .= $value[array_keys($value)[0]].",  ";
						}
					}   
					 
					if(!empty($error)) {
						$this->response = array(
								'status' => 400,
								'message' => rtrim($error, ', '),
							);
					}
					else {

						if($this->Chapters->save($chapter))
						{
							
							$reponseChapters['Chapter']['id'] 				= $chapter['id'];
							$reponseChapters['Chapter']['ChapterHeading'] 	= $chapter['title'];
							$reponseChapters['Chapter']['CreatedDate'] 		= $chapter['created'];
							$reponseChapters['Chapter']['ModifiedDate'] 	= $chapter['modified'];
							
							$this->response = array(
								'status' => 200,
								'message' => 'Chapter edited.',
								'data' => $reponseChapters
							);
						} else
						{
							$this->response = array(
								'status' => 500,
								'message' => 'Chapter cannot be edited right now. Please try again.',
							);
						}		
					}
				}
				$this->__send_response();
			}
			else{
				$this->response = array(
							'status' => 400,
							'message' => 'Invalid Chapter. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}
		
		$this->__send_response();
	}
	
	
	/**
	 * @name deleteChapters
	 * Purpose : This method is used to Delete chapter 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if chapter edited else returns error
	 */
	public function DeleteChapters()
	{ 
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
				'status' => 400,
				'message' => 'Method not allowed',
			);
		}
		
		$error = '';
		$this->loadModel('Chapters');

		$user_data = $this->request->data;
		
		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';

		if(!isset($user_data['chapter_id']) || empty($user_data['chapter_id']))
			$error .= 'Chapter Id is required.';
		
		if(empty($error)){ 
			
			$authId = $this->getAuthUser($user_data['sessionId']);

			$chaptersObj = $this->Chapters->find('all',[
					'conditions' => [
						'id' => $user_data['chapter_id'], 
						'user_id' => $user_data['user_id']
					],
					'contain' => [
						'UserChapters' => [
							'joinType' => 'inner',
							'queryBuilder' =>
								function ($q) use ($authId) {
									return $q
									->where([
										'UserChapters.user_id' => $authId,
									]);
						}]
					]])->first();
		
			if($chaptersObj){
				
				$chapters = $chaptersObj->toArray();
				if($authId != $user_data['user_id'])
				{
					$this->loadModel('UserChapters');
					$userNewData = [
						'chapter_id'=> $chapters['id'], 
						'area_id'	=> $chapters['area_id'],
						'user_id'	=> $authId,
						'action'	=> 'delete',
						'title'		=> $chapters['title'],
					];

					if(empty($chapters['user_chapters']))
					{
						$userNewData	= $this->UserChapters->newEntity($userNewData);
					}
					else
					{
						$userChapterDb	= $this->UserChapters->get($chapters['user_chapters'][0]['id']);
						$userNewData	= $this->UserChapters->patchEntity($userChapterDb, $userNewData);
					}
					
					if($this->UserChapters->save($userNewData))
					{
						$this->response = array(
							'status' => 200,
							'message' => 'Chapter deleted.'
						);
					} else
					{
						$this->response = array(
							'status' => 500,
							'message' => 'Chapter cannot be edited right now. Please try again.',
						);
					}
				}else
				{
					if($this->Chapters->delete($chaptersObj))
					{
						$this->response = array(
							'status' => 200,
							'message' => 'Chapter deleted.'
						);
					} else
					{
						$this->response = array(
							'status' => 500,
							'message' => 'Chapter cannot be deleted right now. Please try again.',
						);
					}	
				}
					
				$this->__send_response();
			}
			else{
				$this->response = array(
							'status' => 400,
							'message' => 'Invalid Chapter. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}
		
		$this->__send_response();
	}	  
	
	/**
	 * @name Get Chapters List
	 * Purpose : This method is used to get Chapter data
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if areas found else returns error
	 */
			
	function GetChaptersList()
	{
		header('Content-Type: application/json');
		if(!$this->request->is('GET'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
		}
		
		$error = '';
		$user_data = $this->request->data;

		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';
			
		if(!isset($user_data['area_id']) || empty($user_data['area_id']))
			$error .= 'Area Id is required.';
		
		if(empty($error)){ 

			$this->loadModel('Users');
						
			$userObj = $this->Users->find('all', [
						'conditions'=> [
							'id' 				=> $user_data['user_id'], 
							'sessionId' 		=> $user_data['sessionId'],
							]
						])->contain([
								'Chapters.Areas' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($user_data) {
												return $q->where([
												'OR' =>[
														'Chapters.area_id ' => $user_data['area_id'],
														'Chapters.status ' => 1
													]
												])->order(['Chapters.order_no'=>'ASC']);
								}]
						])->first();
							
			if($userObj){
				$user = $userObj->toArray();
				
				$areasData = array();

				$defaultChaptersList = $this->getDefaultChapters($user_data['area_id']);
				$user = array_merge($user, $defaultChaptersList);

				if(isset($user['chapters']) && !empty($user['chapters'])){
					foreach ($user['chapters'] as $key => $area) {
						
						$reponseAreas['areanamePointer']['__type'] 		= "Pointer";
						$reponseAreas['areanamePointer']['className'] 	= "Area";
						$reponseAreas['areanamePointer']['AreaId'] 		= $area['area']['id'];
						$reponseAreas['areanamePointer']['objectId'] 	= $area['area']['object_id'];
						$reponseAreas['chapterName'] 					= $area['title'];
						$reponseAreas['createdAt'] 						= $area['created'];
						$reponseAreas['ChatperId'] 						= $area['id'];
						$reponseAreas['objectId'] 						= $area['object_id'];
						$reponseAreas['updatedAt'] 						= $area['modified'];

						$areasData[] = $reponseAreas;
					}
					
					$this->response = array(
							'status' => 200,
							'message' => 'Chapters found.',
							'value' => $areasData
						 );

				}
				else{
					$this->response = array(
							'status' => 404,
							'message' => 'Chapters not found for this user.',
						);
				}
			}
			else
			{
				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}

		$this->__send_response();
	} 
	
	/**
	 * @name Add Lessons
	 * Purpose : This method is used to add lesson under area -> chapter 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if areas added else returns error
	 */
	public function AddLessons()
	{ 
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
				'status' => 400,
				'message' => 'Method not allowed',
			);
		}
		
		$error = '';
		$this->loadModel('Users');

		$user_data = $this->request->data;
		
		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';
			
		if(!isset($user_data['area_id']) || empty($user_data['area_id']))
			$error .= 'Area Id is required.';
		
		if(!isset($user_data['chapter_id']) || empty($user_data['chapter_id']))
			$error .= 'Chapter Id is required.';	
		
		if(empty($error)){ 
			$userObj = $this->Users->find('all',['conditions' => ['id' => $user_data['user_id'], 'sessionId' => $user_data['sessionId']]])->first();
			
			if($userObj){
				$user = $userObj->toArray();
				
				$this->loadComponent('Common');
				$user_data['object_id'] = $this->Common->generateRandomString(10);
				
				$this->loadModel('Lessons');
				$lesson = $this->Lessons->newEntity($user_data);
				
				$errors = $lesson->errors();
				
				if(!empty($errors)) {
				    foreach ($errors as $key => $value) {
				    	$error .= $value[array_keys($value)[0]].",  ";
				    }
				}   
				
				if(!empty($error)) {
				    $this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
				}
				else {
					
					$lesson->order_no = $this->generateAutoOrder('lesson');

					if($this->Lessons->save($lesson))
					{
						
						$reponseLessons['Lesson']['id'] 				= $lesson['id'];
						$reponseLessons['Lesson']['objectId'] 			= $lesson['object_id'];
						$reponseLessons['Lesson']['LessonHeading'] 		= $lesson['title'];
						$reponseLessons['Lesson']['CreatedDate'] 		= $lesson['created'];
						$reponseLessons['Lesson']['ModifiedDate'] 		= $lesson['modified'];
						
						$this->response = array(
							'status' => 200,
							'message' => 'Lesson created successfully.',
							'data' => $reponseLessons
						);
					} else
					{
						$this->response = array(
							'status' => 500,
							'message' => 'Lesson cannot be added right now. Please try again.',
						);
					}		
				}
				$this->__send_response();
			}
			else{
				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}
		
		$this->__send_response();
	}
	
	/**
	 * @name Edit Lesson
	 * Purpose : This method is used to edit lesson 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if chapter edited else returns error
	 */
	public function EditLessons()
	{ 
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
				'status' => 400,
				'message' => 'Method not allowed',
			);
		}
		
		$error = '';
		$this->loadModel('Lessons');

		$user_data = $this->request->data;
		
		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';

		if(!isset($user_data['lesson_id']) || empty($user_data['lesson_id']))
			$error .= 'Lesson Id is required.';
		
		if(empty($error)){ 

			$authId = $this->getAuthUser($user_data['sessionId']);

			$lessonsObj = $this->Lessons->find('all',[
					'conditions' => [
						'id' => $user_data['lesson_id'],
						'user_id' => $user_data['user_id']
					],
					'contain' => [
						'UserLessons' => [
							'joinType' => 'inner',
							'queryBuilder' =>
								function ($q) use ($authId) {
									return $q
									->where([
										'UserLessons.user_id' => $authId,
									]);
						}]
					]])->first();

			if($lessonsObj){
				$lessons = $lessonsObj->toArray();
				
				if($authId != $user_data['user_id'])
				{
					$this->loadModel('UserLessons');
					$userNewData = [
						'lesson_id'	=> $lessons['id'], 
						'chapter_id'=> $lessons['chapter_id'], 
						'area_id'	=> $lessons['area_id'],
						'user_id'	=> $authId,
						'action'	=> 'edit',
						'title'		=> $user_data['title'],
					];

					if(empty($lessons['user_lessons']))
					{
						$userNewData	= $this->UserLessons->newEntity($userNewData);
					}
					else
					{
						$userLessonDb	= $this->UserLessons->get($lessons['user_lessons'][0]['id']);
						$userNewData	= $this->UserLessons->patchEntity($userLessonDb, $userNewData);
					}
					
					if($this->UserLessons->save($userNewData))
					{
						
						$reponseChapters['Lesson']['id'] 				= $lessons['id'];
						$reponseChapters['Lesson']['LessonsHeading'] 	= $userNewData['title'];
						$reponseChapters['Lesson']['CreatedDate'] 		= $userNewData['created'];
						$reponseChapters['Lesson']['ModifiedDate'] 		= $userNewData['modified'];
						
						$this->response = array(
							'status' => 200,
							'message' => 'Lesson edited.',
							'data' => $reponseChapters
						);
					} else
					{
						$this->response = array(
							'status' => 500,
							'message' => 'Lesson cannot be edited right now. Please try again.',
						);
					}
				}
				else
				{
					$lesson = $this->Lessons->patchEntity($lessonsObj, $user_data);

					$errors = $lesson->errors();

					if(!empty($errors)) {
						foreach ($errors as $key => $value) {
							$error .= $value[array_keys($value)[0]].",  ";
						}
					}   
					 
					if(!empty($error)) {
						$this->response = array(
								'status' => 400,
								'message' => rtrim($error, ', '),
							);
					}
					else {

						if($this->Lessons->save($lesson))
						{
							
							$reponselessons['Lesson']['id'] 				= $lesson['id'];
							$reponselessons['Lesson']['LessonsHeading'] 	= $lesson['title'];
							$reponselessons['Lesson']['CreatedDate'] 		= $lesson['created'];
							$reponselessons['Lesson']['ModifiedDate'] 		= $lesson['modified'];
							
							$this->response = array(
								'status' => 200,
								'message' => 'Lesson edited.',
								'data' => $reponselessons
							);
						} else
						{
							$this->response = array(
								'status' => 500,
								'message' => 'Lesson cannot be edited right now. Please try again.',
							);
						}		
					}
				}
				
				$this->__send_response();
			}
			else{
				$this->response = array(
							'status' => 400,
							'message' => 'Invalid Lesson. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}
		
		$this->__send_response();
	}
	
	/**
	 * @name delete Lessons
	 * Purpose : This method is used to Delete Lessons 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if chapter edited else returns error
	 */
	public function DeleteLessons()
	{ 
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
				'status' => 400,
				'message' => 'Method not allowed',
			);
		}
		
		$error = '';
		$this->loadModel('Lessons');

		$user_data = $this->request->data;
		
		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';

		if(!isset($user_data['lesson_id']) || empty($user_data['lesson_id']))
			$error .= 'Lesson Id is required.';
		
		if(empty($error)){ 
			$authId = $this->getAuthUser($user_data['sessionId']);

			$lessonsObj = $this->Lessons->find('all',[
					'conditions' => [
						'id' => $user_data['lesson_id'],
						'user_id' => $user_data['user_id']
					],
					'contain' => [
						'UserLessons' => [
							'joinType' => 'inner',
							'queryBuilder' =>
								function ($q) use ($authId) {
									return $q
									->where([
										'UserLessons.user_id' => $authId,
									]);
						}]
					]])->first();
						
			if($lessonsObj){
				$lessons = $lessonsObj->toArray();
				
				if($authId != $user_data['user_id'])
				{
					$this->loadModel('UserLessons');
					$userNewData = [
						'lesson_id'	=> $lessons['id'], 
						'chapter_id'=> $lessons['chapter_id'], 
						'area_id'	=> $lessons['area_id'],
						'user_id'	=> $authId,
						'action'	=> 'delete',
						'title'		=> $lessons['title'],
					];

					if(empty($lessons['user_lessons']))
					{
						$userNewData	= $this->UserLessons->newEntity($userNewData);
					}
					else
					{
						$userLessonDb	= $this->UserLessons->get($lessons['user_lessons'][0]['id']);
						$userNewData	= $this->UserLessons->patchEntity($userLessonDb, $userNewData);
					}
					
					if($this->UserLessons->save($userNewData))
					{
						$this->response = array(
							'status' => 200,
							'message' => 'Lesson deleted.'
						);
					} else
					{
						$this->response = array(
							'status' => 500,
							'message' => 'Lesson cannot be deleted right now. Please try again.',
						);
					}
				}
				else
				{
					if($this->Lessons->delete($lessonsObj))
					{
						$this->response = array(
							'status' => 200,
							'message' => 'Lesson deleted.'
						);
					} else
					{
						$this->response = array(
							'status' => 500,
							'message' => 'Lesson cannot be deleted right now. Please try again.',
						);
					}		
				}
				$this->__send_response();
			}
			else{
				$this->response = array(
							'status' => 400,
							'message' => 'Invalid Lesson. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}
		
		$this->__send_response();
	}
	
	/**
	 * @name Get Lessons List
	 * Purpose : This method is used to get Lessons data
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if areas found else returns error
	 */
			
	function GetLessonsList()
	{
		header('Content-Type: application/json');
		if(!$this->request->is('GET'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
		}
		
		$error = '';
		$user_data = $this->request->data;

		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';
			
		if(!isset($user_data['area_id']) || empty($user_data['area_id']))
			$error .= 'Area Id is required.';
		
		if(!isset($user_data['chapter_id']) || empty($user_data['chapter_id']))
			$error .= 'Chapter Id is required.';
			
		if(empty($error)){ 

			$this->loadModel('Users');
						
			$userObj = $this->Users->find('all', [
						'conditions'=> [
							'id' 				=> $user_data['user_id'], 
							'sessionId' 		=> $user_data['sessionId'],
							]
						])->contain([
								'Lessons.Chapters.Areas' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($user_data) {
												return $q
												->where([
												'AND' =>[
														'Lessons.area_id ' => $user_data['area_id'],
														'Lessons.chapter_id ' => $user_data['chapter_id'],
														'Lessons.status ' => 1
													]
												])->order(['Lessons.order_no'=>'ASC']);
								}]
						])->first();
							
			if($userObj){
				$user = $userObj->toArray();
				$areasData = array();

				$defaultLessonsList = $this->getDefaultLessons($user_data['area_id'], $user_data['chapter_id']);
				$user = array_merge($user, $defaultLessonsList);

				if(isset($user['lessons']) && !empty($user['lessons'])){
					
					foreach ($user['lessons'] as $key => $lesson) {
						
						$user_data['lesson_id'] = $lesson['id'];

						$isExercises = $this->getExercisesCheck($user_data);
						
						$hasExercises = 0;
						if(!empty($isExercises)){
							$hasExercises = count($isExercises);
						}

						$reponseLessons['chapternamePointer']['__type'] 		= "Pointer";
						$reponseLessons['chapternamePointer']['className'] 		= "Chapter";
						$reponseLessons['chapternamePointer']['ChapterId'] 		= $lesson['chapter']['id'];
						$reponseLessons['chapternamePointer']['objectId'] 		= $lesson['chapter']['object_id'];
						$reponseLessons['lessonName'] 							= $lesson['title'];
						$reponseLessons['createdAt'] 							= $lesson['created'];
						$reponseLessons['LessonId'] 							= $lesson['id'];
						$reponseLessons['hasExercise'] 							= $hasExercises;
						$reponseLessons['objectId'] 							= $lesson['object_id'];
						$reponseLessons['updatedAt'] 							= $lesson['modified'];

						$lessonsData[] = $reponseLessons;
					}
					
					$this->response = array(
							'status' => 200,
							'message' => 'Lessons found.',
							'value' => $lessonsData
						 );

				}
				else{
					$this->response = array(
							'status' => 404,
							'message' => 'Lessons not found for this user.',
						);
				}
			}
			else
			{
				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}

		$this->__send_response();
	} 
	
	/**
	 * @name Add Exercises
	 * Purpose : This method is used to add exercises under area -> chapter -> Lessons
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if areas added else returns error
	 */
	public function AddExercises()
	{ 
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
				'status' => 400,
				'message' => 'Method not allowed',
			);
		}
		
		$error = '';
		$this->loadModel('Users');

		$user_data = $this->request->data;
		
		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';
			
		if(!isset($user_data['area_id']) || empty($user_data['area_id']))
			$error .= 'Area Id is required.';
		
		if(!isset($user_data['chapter_id']) || empty($user_data['chapter_id']))
			$error .= 'Chapter Id is required.';
			
		if(!isset($user_data['lesson_id']) || empty($user_data['lesson_id']))
			$error .= 'Lesson Id is required.';	
		
		if(empty($error)){ 
			$userObj = $this->Users->find('all',['conditions' => ['id' => $user_data['user_id'], 'sessionId' => $user_data['sessionId']]])->first();
			
			if($userObj){
				$user = $userObj->toArray();
				
				$this->loadComponent('Common');
				$user_data['object_id'] = $this->Common->generateRandomString(10);
				
				$this->loadModel('Exercises');
				$exercise = $this->Exercises->newEntity($user_data);
				
				$errors = $exercise->errors();
				
				if(!empty($errors)) {
				    foreach ($errors as $key => $value) {
				    	$error .= $value[array_keys($value)[0]].",  ";
				    }
				}   
				
				if(!empty($error)) {
				    $this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
				}
				else {
					
					$exercise->order_no = $this->generateAutoOrder('exercise');

					if($this->Exercises->save($exercise))
					{
						
						$reponseExercises['Exercise']['id'] 				= $exercise['id'];
						$reponseExercises['Exercise']['objectId'] 			= $exercise['object_id'];
						$reponseExercises['Exercise']['ExerciseHeading'] 	= $exercise['title'];
						$reponseExercises['Exercise']['CreatedDate'] 		= $exercise['created'];
						$reponseExercises['Exercise']['ModifiedDate'] 		= $exercise['modified'];
						
						$this->response = array(
							'status' => 200,
							'message' => 'Exercise created successfully.',
							'data' => $reponseExercises
						);
					} else
					{
						$this->response = array(
							'status' => 500,
							'message' => 'Exercise cannot be added right now. Please try again.',
						);
					}		
				}
				$this->__send_response();
			}
			else{
				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}
		
		$this->__send_response();
	}
	
	/**
	 * @name Edit Exercise
	 * Purpose : This method is used to edit Exercise 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if Exercise edited else returns error
	 */
	public function EditExercises()
	{ 
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
				'status' => 400,
				'message' => 'Method not allowed',
			);
		}
		
		$error = '';
		$this->loadModel('Exercises');

		$user_data = $this->request->data;
		
		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';

		if(!isset($user_data['exercise_id']) || empty($user_data['exercise_id']))
			$error .= 'Exercise Id is required.';
		
		if(empty($error)){ 
			$authId = $this->getAuthUser($user_data['sessionId']);

			$exercisesObj = $this->Exercises->find('all',[
						'conditions' => [
							'id' => $user_data['exercise_id'], 
							'user_id' => $user_data['user_id']
						],
						'contain' => [
							'UserExercises' => [
								'joinType' => 'inner',
								'queryBuilder' =>
									function ($q) use ($authId) {
										return $q
										->where([
											'UserExercises.user_id' => $authId,
										]);
							}]
						]])->first();
			
			if($exercisesObj){
				$exercises = $exercisesObj->toArray();
				
				if($authId != $user_data['user_id'])
				{
					$this->loadModel('UserExercises');
					$userNewData = [
						'exercise_id'	=> $exercises['id'], 
						'lesson_id'		=> $exercises['lesson_id'], 
						'chapter_id'	=> $exercises['chapter_id'], 
						'area_id'		=> $exercises['area_id'],
						'user_id'		=> $authId,
						'action'		=> 'edit',
						'title'			=> $user_data['title'],
					];

					if(empty($exercises['user_exercises']))
					{
						$userNewData	= $this->UserExercises->newEntity($userNewData);
					}
					else
					{
						$userExerciseDb	= $this->UserExercises->get($exercises['user_exercises'][0]['id']);
						$userNewData	= $this->UserExercises->patchEntity($userExerciseDb, $userNewData);
					}
					
					if($this->UserExercises->save($userNewData))
					{
						
						$reponseChapters['Exercise']['id'] 					= $exercises['id'];
						$reponseChapters['Exercise']['ExerciseHeading'] 	= $userNewData['title'];
						$reponseChapters['Exercise']['CreatedDate'] 		= $userNewData['created'];
						$reponseChapters['Exercise']['ModifiedDate'] 		= $userNewData['modified'];
						
						$this->response = array(
							'status' => 200,
							'message' => 'Exercise edited.',
							'data' => $reponseChapters
						);
					} else
					{
						$this->response = array(
							'status' => 500,
							'message' => 'Exercise cannot be edited right now. Please try again.',
						);
					}
				}
				else
				{
					$exercise = $this->Exercises->patchEntity($exercisesObj, $user_data);

					$errors = $exercise->errors();

					if(!empty($errors)) {
						foreach ($errors as $key => $value) {
							$error .= $value[array_keys($value)[0]].",  ";
						}
					}   
					 
					if(!empty($error)) {
						$this->response = array(
								'status' => 400,
								'message' => rtrim($error, ', '),
							);
					}
					else {

						if($this->Exercises->save($exercise))
						{
							
							$reponseExercises['Exercise']['id'] 				= $exercise['id'];
							$reponseExercises['Exercise']['ExerciseHeading'] 	= $exercise['title'];
							$reponseExercises['Exercise']['CreatedDate'] 		= $exercise['created'];
							$reponseExercises['Exercise']['ModifiedDate'] 		= $exercise['modified'];
							
							$this->response = array(
								'status' => 200,
								'message' => 'Exercise edited.',
								'data' => $reponseExercises
							);
						} else
						{
							$this->response = array(
								'status' => 500,
								'message' => 'Exercise cannot be edited right now. Please try again.',
							);
						}		
					}
				}
				$this->__send_response();
			}
			else{
				$this->response = array(
							'status' => 400,
							'message' => 'Invalid exercise. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}
		
		$this->__send_response();
	}
	
	/**
	 * @name deleteExercises
	 * Purpose : This method is used to Delete Exercise 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if Exercise edited else returns error
	 */
	public function DeleteExercises()
	{ 
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
				'status' => 400,
				'message' => 'Method not allowed',
			);
		}
		
		$error = '';
		$this->loadModel('Exercises');

		$user_data = $this->request->data;
		
		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';

		if(!isset($user_data['exercise_id']) || empty($user_data['exercise_id']))
			$error .= 'Exercise Id is required.';
		
		if(empty($error)){ 
			$authId = $this->getAuthUser($user_data['sessionId']);

			$exercisesObj = $this->Exercises->find('all',[
						'conditions' => [
							'id' => $user_data['exercise_id'], 
							'user_id' => $user_data['user_id']
						],
						'contain' => [
							'UserExercises' => [
								'joinType' => 'inner',
								'queryBuilder' =>
									function ($q) use ($authId) {
										return $q
										->where([
											'UserExercises.user_id' => $authId,
										]);
							}]
						]])->first();
			
			if($exercisesObj){

				$exercises = $exercisesObj->toArray();
				
				if($authId != $user_data['user_id'])
				{
					$this->loadModel('UserExercises');
					$userNewData = [
						'exercise_id'	=> $exercises['id'], 
						'lesson_id'		=> $exercises['lesson_id'], 
						'chapter_id'	=> $exercises['chapter_id'], 
						'area_id'		=> $exercises['area_id'],
						'user_id'		=> $authId,
						'action'		=> 'delete',
						'title'			=> $exercises['title'],
					];

					if(empty($exercises['user_exercises']))
					{
						$userNewData	= $this->UserExercises->newEntity($userNewData);
					}
					else
					{
						$userExerciseDb	= $this->UserExercises->get($exercises['user_exercises'][0]['id']);
						$userNewData	= $this->UserExercises->patchEntity($userExerciseDb, $userNewData);
					}
					
					if($this->UserExercises->save($userNewData))
					{
						$this->response = array(
							'status' => 200,
							'message' => 'Exercise deleted.'
						);
					} else
					{
						$this->response = array(
							'status' => 500,
							'message' => 'Exercise cannot be deleted right now. Please try again.',
						);
					}
				}
				else
				{
					if($this->Exercises->delete($exercisesObj))
					{
						$this->response = array(
							'status' => 200,
							'message' => 'Exercise deleted.'
						);
					} else
					{
						$this->response = array(
							'status' => 500,
							'message' => 'Exercise cannot be deleted right now. Please try again.',
						);
					}
				}
				$this->__send_response();
			}
			else{
				$this->response = array(
							'status' => 400,
							'message' => 'Invalid exercise. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}
		
		$this->__send_response();
	}
	
	/**
	 * @name GetExercisesList
	 * Purpose : This method is used to get Exercises data
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if areas found else returns error
	 */
			
	public function GetExercisesList()
	{
		header('Content-Type: application/json');
		if(!$this->request->is('GET'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
		}
		
		$error = '';
		$user_data = $this->request->data;

		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';
			
		if(!isset($user_data['area_id']) || empty($user_data['area_id']))
			$error .= 'Area Id is required.';
		
		if(!isset($user_data['chapter_id']) || empty($user_data['chapter_id']))
			$error .= 'Chapter Id is required.';
			
		if(!isset($user_data['lesson_id']) || empty($user_data['lesson_id']))
			$error .= 'Lessson Id is required.';
			
		if(empty($error)){ 

			$this->loadModel('Users');
						
			$userObj = $this->Users->find('all', [
						'conditions'=> [
							'id' 				=> $user_data['user_id'], 
							'sessionId' 		=> $user_data['sessionId'],
							]
						])->contain([
								'Exercises.Lessons.Chapters.Areas' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($user_data) {
												return $q->where([
												'AND' =>[
														'Exercises.area_id ' => $user_data['area_id'],
														'Exercises.chapter_id ' => $user_data['chapter_id'],
														'Exercises.lesson_id ' => $user_data['lesson_id'],
														'Exercises.status ' => 1
													]
												])->order(['Exercises.order_no'=>'ASC']);
								}]
						])->first();
							
			if($userObj){
				$user = $userObj->toArray();
				
				$areasData = array();

				$defaultExercisesList = $this->getDefaultExercises($user_data['area_id'], $user_data['chapter_id'], $user_data['lesson_id']);
				$user = array_merge($user, $defaultExercisesList);

				if(isset($user['exercises']) && !empty($user['exercises'])){

					foreach ($user['exercises'] as $key => $exercise) {
						
						$reponseLessons['lessonnamePointer']['__type'] 		= "Pointer";
						$reponseLessons['lessonnamePointer']['className'] 	= "Lesson";
						$reponseLessons['lessonnamePointer']['LessonId'] 	= $exercise['lesson']['id'];
						$reponseLessons['lessonnamePointer']['objectId'] 	= $exercise['lesson']['object_id'];
						$reponseLessons['exerciseName'] 					= $exercise['title'];
						$reponseLessons['createdAt'] 						= $exercise['created'];
						$reponseLessons['objectId'] 						= $exercise['object_id'];
						$reponseLessons['ExerciseId'] 						= $exercise['id'];
						$reponseLessons['updatedAt'] 						= $exercise['modified'];

						$lessonsData[] = $reponseLessons;
					}
					
					$this->response = array(
							'status' => 200,
							'message' => 'Exercises found.',
							'value' => $lessonsData
						 );

				}
				else{
					$this->response = array(
							'status' => 404,
							'message' => 'Exercises not found for this user.',
						);
				}
			}
			else
			{
				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}

		$this->__send_response();
	}

	/**
	 * @name StudentView
	 * Purpose : This method is used to save/update Student view plan
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if areas found else returns error
	 */
	//$this->log(print_r($user_data, true),'debug');
	public function StudentView()
	{
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
		}
		
		$error = '';
		$user_data = $this->request->data;

		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required. ';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required. ';
		
		if(!isset($user_data['view']) || empty($user_data['view']))
				$error .= 'Undefined View. ';

		if(!isset($user_data['planId']) || empty($user_data['planId'])){
			
			if(!isset($user_data['start_date']) || empty($user_data['start_date']))
			$error .= 'Start Date is required. ';
			
			if(!isset($user_data['end_date']) || empty($user_data['end_date']))
				$error .= 'End Date is required. ';
			
			if(!isset($user_data['record']) || empty($user_data['record']))
				$error .= 'Record is required. ';
				
			
				
				
		}

		//$this->log(print_r("=============================New Plan==========================", true),'debug');
		$this->log(print_r($user_data, true),'debug');

		if(empty($error)){ 
			
			$this->loadModel('Users');
			$userObj = $this->Users->find('all',['conditions' => ['id' => $user_data['user_id'], 'sessionId' => $user_data['sessionId']]])->first();
			
			if($userObj){
				$this->loadModel('UserPlans');
				$this->loadModel('Students');
				$this->loadModel('StudentViews');
				
				$userObj = $userObj->toArray();
				

				$planData = [];
				if(isset($user_data['record']) && !empty($user_data['record']))
				{
					
					$records = json_decode($user_data['record']);
					
					$makePlanObj['user_id'] 	= $user_data['user_id'];
					$makePlanObj['user_type'] 	= $userObj['user_type'];
					$makePlanObj['status_id'] 	= '1';
					
					if(isset($user_data['start_date']) && !empty($user_data['start_date'])){
						$makePlanObj['start_date'] = $user_data['start_date'];
					}
					
					if(isset($user_data['end_date']) && !empty($user_data['end_date'])){
						$makePlanObj['end_date'] = $user_data['end_date'];
					}
					
					if(isset($user_data['view']) && !empty($user_data['view'])){
						$makePlanObj['plan_type'] = $user_data['view'];
					}
					
					if(isset($user_data['title']) && !empty($user_data['title'])){
						$makePlanObj['title'] = $user_data['title'];
					}
					
								
					$userPlanId = '';
					$planObj = $this->UserPlans->newEntity($makePlanObj);
					$updatePlan = false;
					if(isset($user_data['planId']) && !empty($user_data['planId']))
					{
						$userPlanId = $user_data['planId'];
						$planObj = $this->UserPlans->get($userPlanId);
						$planObj = $this->UserPlans->patchEntity($planObj, $makePlanObj);
						$updatePlan = true;
					}

					if($planObj = $this->UserPlans->save($planObj)){
						
						$userPlanId = $planObj->id;

						foreach($records as $record){
							$statusFor = 'lesson';
							if(!empty($record->exerciseId)){
								$statusFor = 'exercise';
							}
							
							$statusId = 7;
							if($updatePlan){
								$statusId = isset($record->status_id) ? $record->status_id : '7';
							}

							if($user_data['view'] == 2){
								$studentIds = $record->student_id;
								$studentIds = explode(',', $studentIds);
								
								foreach($studentIds as $sId){
									
									$planData[] = [
										'user_plan_id'	=> $userPlanId,
										'student_id' 	=> $sId,
										'area_id' 		=> $record->areaId,
										'chapter_id' 	=> $record->chapterId,
										'lesson_id' 	=> $record->lessId,
										'exercise_id' 	=> $record->exerciseId,
										'status_for' 	=> $statusFor,
										'status_id' 	=> $statusId,
										'state_date'	=> '',
										'end_date'		=> '',
									];
								}
							}else{
								$planData[] = [
									'user_plan_id'	=> $userPlanId,
									'student_id' 	=> $record->student_id,
									'area_id' 		=> $record->areaId,
									'chapter_id' 	=> $record->chapterId,
									'lesson_id' 	=> $record->lessId,
									'exercise_id' 	=> $record->exerciseId,
									'status_for' 	=> $statusFor,
									'status_id' 	=> $statusId,
									'state_date'	=> '',
									'end_date'		=> '',
								];
							}
						}
					}
				}

				if(!empty($planData))
				{
					// If update delete all views from table
					if($updatePlan)
					{
						$this->StudentViews->deleteAll(['StudentViews.user_plan_id' => $userPlanId]);
						//$this->log(print_r("======================= Update Plan ======================", true),'debug');
						//$this->log(print_r($planData, true),'debug');
					}
					
					$studentViews = $this->StudentViews->newEntities($planData);
					
					$studentViewRecord = [];
					$recordViewData = [];
					$studentViewData = [];
					
					foreach($studentViews as $studentView){
						if($savedStudentViews = $this->StudentViews->save($studentView))
						{
							
							$status = 'Null';
							if($studentView->status_id == 4){
								$status = 'Presented';
							}elseif ($studentView->status_id == 5) {
								$status = 'Further refinement';
							}elseif ($studentView->status_id == 6) {
								$status = 'Working';
							}elseif ($studentView->status_id == 7) {
								$status = 'None';
							}
							
							$studentViewDb = $this->StudentViews->get($savedStudentViews->id, [
																		'contain'=>[
																			'UserPlans.Users', 
																			'Students', 
																			'Areas', 
																			'Chapters', 
																			'Lessons', 
																			'Exercises'
																		]]);
							
							
							$studentViewId 		= $studentViewDb->id;
							
							$teacherId 			= isset($studentViewDb->user_plan->user->id) ? $studentViewDb->user_plan->user->id : '';
							$teacherEmail 		= isset($studentViewDb->user_plan->user->email) ? $studentViewDb->user_plan->user->email : '';
							$t_firstname 		= isset($studentViewDb->user_plan->user->first_name) ? $studentViewDb->user_plan->user->first_name : 'Null';
							$t_lastname 		= isset($studentViewDb->user_plan->user->last_name) ? $studentViewDb->user_plan->user->last_name : 'Null';
							$teacherName 		= $t_firstname.' '.$t_lastname;
							
							$studentId 			= isset($studentViewDb->student->id) ? $studentViewDb->student->id : '';
							$studentAge 		= isset($studentViewDb->student->birthday) ? $studentViewDb->student->birthday : '';
							$s_firstname 		= isset($studentViewDb->student->first_name) ? $studentViewDb->student->first_name : 'Null';
							$s_lastname 		= isset($studentViewDb->student->last_name) ? $studentViewDb->student->last_name : 'Null';

							$s_firstname		= $this->getStudentShortName($s_firstname, 20); 
							$s_lastname			= $this->getStudentShortName($s_lastname, 1);
							$studentName 		= $s_firstname.' '.$s_lastname;
							
							
							$areaHeading 		= isset($studentViewDb->area->title) ? $studentViewDb->area->title : 'Null';
							$chapterHeading 	= isset($studentViewDb->chapter->title) ? $studentViewDb->chapter->title : 'Null';
							$lessonHeading 		= isset($studentViewDb->lesson->title) ? $studentViewDb->lesson->title : 'Null';
							$exerciseHeading	= isset($studentViewDb->exercise->title) ? $studentViewDb->exercise->title : 'Null';
							
							$stuLessonName 		= isset($studentViewDb->lesson->title) ? $studentViewDb->lesson->title : '';
							$stuExerciseName 	= isset($studentViewDb->exercise->title) ? $studentViewDb->exercise->title : '';
							
							
							if($user_data['view'] == 1){
								if(!empty($studentId)){
									$lessonExercise = rtrim($stuLessonName. '/'. $stuExerciseName, '/');
									$studentViewArray['Student Name'] 		= $studentName;
									$studentViewArray['Age'] 				= $this->age_from_dob(date('Y-m-d', strtotime($studentAge)));
									$studentViewArray['Lesson/Exercise'] 	= $lessonExercise;
									$studentViewData[$studentId][] 			= $studentViewArray;
								}
							}else{
								if(!empty($studentId)){
									$lessonExercise = rtrim($stuLessonName. '/'. $stuExerciseName, '/');
									$recordView['Student Name'] 		= $studentName;
									$recordView['Age'] 					= $this->age_from_dob(date('Y-m-d', strtotime($studentAge)));
									$recordViewData[$lessonExercise][] 	= $recordView;
								}
							}
						}
					}
					//pr($studentViewData);
					if($user_data['view'] == 1)
					{
						$line = [];
						foreach($studentViewData as $key=>$sv){
							$line[$key][] = $sv[0]['Student Name'].' '.$sv[0]['Age'];
							foreach($sv as $v){
								$line[$key][] = $v['Lesson/Exercise'];
							}
						}
					}
					else
					{
						$line = [];
						foreach($recordViewData as $key=>$rv){
							$line[$key][] = $key;
							foreach($rv as $v){
								$line[$key][] = $v['Student Name'].' '.$v['Age'];
							}
						}
					}
					//pr($line);
					if($user_data['view'] == 1){
						$viewType = 'Student View';
					}else{
						$viewType = 'Record View';
					}
					
					$responsePlan['plan']['id'] 						= $planObj->id;
					$responsePlan['plan']['title'] 						= $planObj->title;
					$responsePlan['plan']['start_date'] 				= date('m-d-Y', strtotime($planObj->start_date));
					$responsePlan['plan']['end_date'] 					= date('m-d-Y', strtotime($planObj->end_date));
					$responsePlan['plan']['created'] 					= date('m-d-Y', strtotime($planObj->created));
					$responsePlan['plan']['plan_type'] 					= $user_data['view'];
					$responsePlan['plan']['planType'] 					= $viewType;
					
					$planTitle = ($responsePlan['plan']['title']!= "") ? '/'.$responsePlan['plan']['title'] : '';
					$viewPlanOutput[] = $responsePlan['plan']['start_date'].' to '.$responsePlan['plan']['end_date'].$planTitle;
					
					// Send Email 
					if($user_data['sendmail'] == 1){
						if(!empty($teacherEmail)){
							$this->loadComponent('Common');
							$this->loadComponent('Export');
									
							$template = 'plan-email';

							$this->Export->addRow($viewPlanOutput);
							
							if(!empty($responsePlan['plan']['title'])){
								$plan = $responsePlan['plan']['title']. ' <br/>'. $responsePlan['plan']['end_date']. ' to ' .$responsePlan['plan']['start_date'];
							}else{
								$plan = $responsePlan['plan']['end_date']. ' to ' .$responsePlan['plan']['start_date'];
							}
							$token = [
								'{{teacher_name}}',
								'{{plan_type}}',
								'{{plan_title}}',
							];
							
							$token_value = [
								$teacherName,
								$responsePlan['plan']['planType'],
								$plan,
							];
							
							foreach($line as $l){
								//pr($l);
								$this->Export->addRow($l);
							}
							
							$filename = $planObj->id.'_Export.csv';

							$targetFolder = WWW_ROOT. 'uploads' .DS . 'user' . DS . $teacherId. DS;
								

							if (!file_exists($targetFolder)) {
								umask(0000);
								mkdir($targetFolder, 0777, true);
							}
							
							$targetFile = rtrim($targetFolder,'/') . DS . $filename;

							// Rename if file exists
							$counter = 0;
							$fileParts = pathinfo($filename);
							while(file_exists($targetFile)) {
								$filename = $fileParts['filename'] . $counter . '.' . $fileParts['extension'];
								$targetFile = rtrim($targetFolder,'/') . DS . $filename;
								$counter++;
							};
							
							$file = $this->Export->render($filename);
							
							if(file_put_contents($targetFile, $file)){
								
								$attachment['fileName'] = $filename;
								$attachment['filePath'] = $targetFile;
								$attachment['fileType'] = $fileParts['extension'];
								//$teacherEmail = 'pawan.xicom@gmail.com';
								if($this->Common->_send_email($teacherEmail, $token, $token_value, $template, '', $attachment)){
									$this->log(print_r(['email sent to '.$teacherEmail], true),'debug');
								}
							}
						}
					}
					
					if($user_data['view'] == 1){
						$viewType = 'Student View ';
					}else{
						$viewType = 'Record View ';
					}
					
					$created = 'created ';
					if($updatePlan){
						$created = 'updated ';
					}
					
					$this->response = array(
							'status' => 200,
							'message' => 'Plan created successfully!',
							'data' => $responsePlan
						);
				
					$this->__send_response();
				}else{
					$this->response = array(
							'status' => 400,
							'message' => 'Plan is empty. You can not create a plan with empty values.',
						);
				}
			}
			else{

				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}

		$this->__send_response();
	}
	
	
	/**
	 * @name getPlans
	 * Purpose : This method is used to fetch all user plans
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if areas found else returns error
	 */
			
	public function getPlans(){
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
						
			$this->__send_response();
		}
		
		$error = '';
		$user_data = $this->request->data;

		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required. ';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required. ';
			

		if(empty($error)){ 

			$this->loadModel('Users');
			
			$userObj = $this->Users->find('all',['conditions' => ['id' => $user_data['user_id'], 'sessionId' => $user_data['sessionId']]])->first();

			if($userObj){
				
				$this->loadModel('UserPlans');
				$this->loadModel('StudentViews');
				
				$conditions = [];
				$conditions['conditions'][] = ['UserPlans.status'			=> 1];
				if(isset($user_data['user_id']) && !empty($user_data['user_id']))
					$conditions['conditions'][] = ['UserPlans.user_id'			=> $user_data['user_id']];
		
				
				$conditions['order'] = [
							'UserPlans.start_date' => 'desc'
						];
				
				$conditions['group'] = [
							'UserPlans.id'
						];
					
				$plans = $this->UserPlans->find('all', $conditions)
															->contain([
																'Users',
																'StudentViews.Students'
															])
															->hydrate(false);

				$this->paginate = [
						'limit'	=> isset($user_data['limit']) ? $user_data['limit'] : 10,
						'page' => isset($user_data['page']) ? $user_data['page'] : '1',
					];
					
				if($this->paginate['page'] <= 0){
					$this->paginate = [
						'limit'	=> 1000,
						'page' => 0,
					];
				}
				
				$getStudentView = $this->paginate($plans);
				
				if(!empty($getStudentView)){
					$getStudentView = $getStudentView->toArray();

					if(isset($getStudentView) && !empty($getStudentView)){
						$areasData = array();
						foreach ($getStudentView as $key => $studentView) {
							
							$teacherName = $studentView['user']['first_name']. ' ' .$studentView['user']['last_name'];
							
							$reponseLessons['PlanId'] 			= $studentView['id'];
							$reponseLessons['PlanViewType'] 	= $studentView['plan_type'];
							$reponseLessons['PlanStartDate'] 	= date('m-d-Y', strtotime($studentView['start_date']));
							$reponseLessons['PlanEndDate'] 		= date('m-d-Y', strtotime($studentView['end_date']));
							$reponseLessons['CreatedAt'] 		= date('m-d-Y', strtotime($studentView['created']));

							$lessonsData[] = $reponseLessons;
						}
						
						
						$pageResponse = isset($this->request->params['paging']['UserPlans']) ? $this->request->params['paging']['UserPlans'] : '';
			
						$page = [];
						if(!empty($pageResponse)){
							$page['Page'] 			= $pageResponse['page'];
							$page['Limit'] 			= $pageResponse['perPage'];
							$page['HasPrevPage'] 	= ($pageResponse['prevPage'] != "") ? TRUE : FALSE;
							$page['HasNextPage'] 	= ($pageResponse['nextPage'] != "") ? TRUE : FALSE;;
							$page['TotalCount'] 	= $pageResponse['count'];
							$page['TotalPage'] 		= $pageResponse['pageCount'];
						}
						
						$this->response = array(
							'status' 		=> 200,
							'message' 		=> 'Plan found.',
							'pagination' 	=> $page,
							'value' 		=> $lessonsData
						 );
						 
					}else{
						$this->response = array(
							'status' => 400,
							'message' => 'Plan not found for this user.',
						);
					}
				}
				else{
					$this->response = array(
						'status' => 400,
						'message' => 'Plan not found for this user.',
					);
				}
				$this->__send_response();
			}
			else{

				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}

		$this->__send_response();
	}
	
    /**
	 * @name getPlanDetail
	 * Purpose : This method is used to get detail about plan
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if areas found else returns error
	 */
	 
    public function getPlanDetail(){
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
						
			$this->__send_response();
		}
		
		$error = '';
		$user_data = $this->request->data;

		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required. ';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required. ';
			
		if(!isset($user_data['planId']) || empty($user_data['planId']))
			$error .= 'Plan Id is required. ';
			

		if(empty($error)){ 

			$this->loadModel('Users');
			
			$userObj = $this->Users->find('all',['conditions' => ['id' => $user_data['user_id'], 'sessionId' => $user_data['sessionId']]])->first();

			if($userObj){
				
				$this->loadModel('UserPlans');
				$this->loadModel('StudentViews');
				
				$conditions = [];
				
				if(isset($user_data['planId']) && !empty($user_data['planId']))
					$conditions['conditions'][] = ['StudentViews.user_plan_id'			=> $user_data['planId']];
					
				if(isset($user_data['student_id']) && !empty($user_data['student_id']))
					$conditions['conditions'][] = ['StudentViews.student_id'	=> $user_data['student_id']];

				if(isset($user_data['area_id']) && !empty($user_data['area_id']))
					$conditions['conditions'][] = ['StudentViews.area_id'		=> $user_data['area_id']];
				
				if(isset($user_data['chapter_id']) && !empty($user_data['chapter_id']))
					$conditions['conditions'][] = ['StudentViews.chapter_id'	=> $user_data['chapter_id']];
					
				if(isset($user_data['lesson_id']) && !empty($user_data['lesson_id']))
				 	$conditions['conditions'][] = ['StudentViews.lesson_id'	=> $user_data['lesson_id']];

				if(isset($user_data['exercise_id']) && !empty($user_data['exercise_id']))
				 	$conditions['conditions'][] = ['StudentViews.exercise_id'	=> $user_data['exercise_id']];

				if(isset($user_data['status_for']) && !empty($user_data['status_for']))
				 	$conditions['conditions'][] = ['StudentViews.status_for'	=> $user_data['status_for']];
					
				
				$conditions['order'] = [
							'Students.birthday' => 'desc'
						];
						
				$getStudentView = $this->StudentViews->find('all', $conditions)
																		->contain([
																			'UserPlans.Users', 
																			'Students', 
																			'Areas', 
																			'Chapters', 
																			'Lessons', 
																			'Exercises', 
																			'Statuses'
																		])
																		->hydrate(false);
				
				//$getStudentView = $this->paginate($getStudentView);
				
				if(!empty($getStudentView)){
					$getStudentView = $getStudentView->toArray();
					if(isset($getStudentView) && !empty($getStudentView)){
						
						$areasData = array();
						$reponseLessons['PlanId'] 			= $getStudentView[0]['user_plan']['id'];
						$reponseLessons['PlanStartDate'] 	= date('m-d-Y', strtotime($getStudentView[0]['user_plan']['start_date']));
						$reponseLessons['PlanEndDate'] 		= date('m-d-Y', strtotime($getStudentView[0]['user_plan']['end_date']));
						$reponseLessons['TeacherName'] 		= $getStudentView[0]['user_plan']['user']['first_name']. ' ' .$getStudentView[0]['user_plan']['user']['last_name'];
						
						$reponseLessons['viewType']		= $getStudentView[0]['user_plan']['plan_type'];
						
						foreach($getStudentView as $plan){
							
							$studentAge = $this->age_from_dob(date('Y-m-d', strtotime($plan['student']['birthday'])));
							
							$s_firstname = $this->getStudentShortName($plan['student']['first_name'], 20);
							$s_lastname = $this->getStudentShortName($plan['student']['last_name'], 1);

							$reponseLessons['StudentView']['StudentViewId'] 	= $plan['id'];
							$reponseLessons['StudentView']['StudentId'] 		= $plan['student']['id'];
							$reponseLessons['StudentView']['StudentName'] 		= $s_firstname. ' ' .$s_lastname;
							$reponseLessons['StudentView']['StudentAge'] 		= $studentAge;
							$reponseLessons['StudentView']['AreaId']			= $plan['area']['id'];
							$reponseLessons['StudentView']['AreaName']			= $plan['area']['title'];
							$reponseLessons['StudentView']['AreaColor']			= $plan['area']['area_color'];
							$reponseLessons['StudentView']['ChapterId']			= $plan['chapter']['id'];
							$reponseLessons['StudentView']['ChapterName'] 		= $plan['chapter']['title'];
							$reponseLessons['StudentView']['LessonId']			= $plan['lesson']['id'];
							$reponseLessons['StudentView']['LessonName'] 		= $plan['lesson']['title'];
							$reponseLessons['StudentView']['ExerciseId']		= $plan['exercise']['id'];
							$reponseLessons['StudentView']['ExerciseName'] 		= $plan['exercise']['title'];
							$reponseLessons['StudentView']['StatusFor'] 		= $plan['status_for'];
							$reponseLessons['StudentView']['StatusId'] 			= $plan['status_id'];
							$reponseLessons['StudentView']['StatusName'] 		= $plan['status']['name'];
							$reponseLessons['StudentView']['CreatedAt'] 		= date('m-d-Y', strtotime($plan['created']));
							
							$resultResponse[] = $reponseLessons;
						}
						

						
						$pageResponse = ''; //isset($this->request->params['paging']['StudentViews']) ? $this->request->params['paging']['StudentViews'] : '';
						
						$page = [];
						if(!empty($pageResponse)){
							$page['Page'] 			= $pageResponse['page'];
							$page['Limit'] 			= $pageResponse['perPage'];
							$page['HasPrevPage'] 	= ($pageResponse['prevPage'] != "") ? TRUE : FALSE;
							$page['HasNextPage'] 	= ($pageResponse['nextPage'] != "") ? TRUE : FALSE;
							$page['TotalCount'] 	= $pageResponse['count'];
							$page['TotalPage'] 		= $pageResponse['pageCount'];
						}
						
						$this->response = array(
							'status' 		=> 200,
							'message' 		=> 'Plan found.',
							'pagination' 	=> $page,
							'value' 		=> $resultResponse
						 );
						 
					}else{
						$this->response = array(
							'status' => 400,
							'message' => 'Plan not found for this user.',
						);
					}
				}
				else{
					$this->response = array(
						'status' => 400,
						'message' => 'Plan not found for this user.',
					);
				}
				$this->__send_response();
			}
			else{

				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}

		$this->__send_response();
	}
	
	/**
	 * @name getPlanDetail
	 * Purpose : This method is used to get detail about plan
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if areas found else returns error
	 */
	 
    public function getPlanDetailIOS(){
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
						
			$this->__send_response();
		}
		
		$error = '';
		$user_data = $this->request->data;

		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required. ';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required. ';
			
		if(!isset($user_data['planId']) || empty($user_data['planId']))
			$error .= 'Plan Id is required. ';
			

		if(empty($error)){ 

			$this->loadModel('Users');
			
			$userObj = $this->Users->find('all',['conditions' => ['id' => $user_data['user_id'], 'sessionId' => $user_data['sessionId']]])->first();

			if($userObj){
				
				$this->loadModel('UserPlans');
				$this->loadModel('StudentViews');
				
				$conditions = [];
				
				if(isset($user_data['planId']) && !empty($user_data['planId']))
					$conditions['conditions'] = ['StudentViews.user_plan_id'			=> $user_data['planId']];
					
				/*
				if(isset($user_data['student_id']) && !empty($user_data['student_id']))
					$conditions['conditions'][] = ['StudentViews.student_id'	=> $user_data['student_id']];

				if(isset($user_data['area_id']) && !empty($user_data['area_id']))
					$conditions['conditions'][] = ['StudentViews.area_id'		=> $user_data['area_id']];
				
				if(isset($user_data['chapter_id']) && !empty($user_data['chapter_id']))
					$conditions['conditions'][] = ['StudentViews.chapter_id'	=> $user_data['chapter_id']];
					
				if(isset($user_data['lesson_id']) && !empty($user_data['lesson_id']))
				 	$conditions['conditions'][] = ['StudentViews.lesson_id'	=> $user_data['lesson_id']];

				if(isset($user_data['exercise_id']) && !empty($user_data['exercise_id']))
				 	$conditions['conditions'][] = ['StudentViews.exercise_id'	=> $user_data['exercise_id']];

				if(isset($user_data['status_for']) && !empty($user_data['status_for']))
				 	$conditions['conditions'][] = ['StudentViews.status_for'	=> $user_data['status_for']];
				*/	
				
				$conditions['order'] = [
							'Students.birthday' => 'desc'
						];
				

				$getStudentView = $this->StudentViews->find('all', $conditions)
																		->contain([
																			'UserPlans.Users', 
																			'Students', 
																			'Areas', 
																			'Chapters', 
																			'Lessons', 
																			'Exercises', 
																			'Statuses'
																		])
																		->hydrate(false);
				
				if(!empty($getStudentView)){
					$getStudentView = $getStudentView->toArray();
					
					//pr($getStudentView);

					if(isset($getStudentView) && !empty($getStudentView)){
						
						$areasData = array();
						$reponsePlan['PlanId'] 				= $getStudentView[0]['user_plan']['id'];
						$reponsePlan['PlanTitle'] 			= $getStudentView[0]['user_plan']['title'];
						$reponsePlan['PlanStartDate'] 		= date('m-d-Y', strtotime($getStudentView[0]['user_plan']['start_date']));
						$reponsePlan['PlanEndDate'] 		= date('m-d-Y', strtotime($getStudentView[0]['user_plan']['end_date']));
						$reponsePlan['TeacherName'] 		= $getStudentView[0]['user_plan']['user']['first_name']. ' ' .$getStudentView[0]['user_plan']['user']['last_name'];
						$reponsePlan['viewType']			= $getStudentView[0]['user_plan']['plan_type'];
						
						if($reponsePlan['viewType'] == 2){
							foreach($getStudentView as $plan)
							{
								$studentAge		= $this->age_from_dob(date('Y-m-d', strtotime($plan['student']['birthday'])));
								$s_firstname	= $this->getStudentShortName($plan['student']['first_name'], 20);
								$s_lastname		= $this->getStudentShortName($plan['student']['last_name'], 1);
								
								$lessonExercise = $plan['lesson']['title'].$plan['exercise']['title'];
								
								$reponseLessons['RecordView']['LessonId']		= $plan['lesson']['id'];
								$reponseLessons['RecordView']['LessonName'] 	= $plan['lesson']['title'];
								$reponseLessons['RecordView']['ExerciseId']		= $plan['exercise']['id'];
								$reponseLessons['RecordView']['ExerciseName'] 	= $plan['exercise']['title'];
								$reponseLessons['RecordView']['StatusFor'] 		= $plan['status_for'];
								$reponseLessons['RecordView']['StatusName'] 	= $plan['status']['name'];
								$reponseLessons['RecordView']['CreatedAt'] 		= date('m-d-Y', strtotime($plan['created']));
								$reponseLessons['RecordView']['AreaId']			= $plan['area']['id'];
								$reponseLessons['RecordView']['AreaName']		= $plan['area']['title'];
								$reponseLessons['RecordView']['AreaColor']		= $plan['area']['area_color'];
								$reponseLessons['RecordView']['ChapterId']		= $plan['chapter']['id'];
								$reponseLessons['RecordView']['ChapterName'] 	= $plan['chapter']['title'];

								$reponseLessons['Students']['StudentViewId'] 	= $plan['id'];
								$reponseLessons['Students']['StatusId'] 		= $plan['status_id'];
								$reponseLessons['Students']['StudentId'] 		= $plan['student']['id'];
								$reponseLessons['Students']['StudentAge'] 		= $studentAge;
								$reponseLessons['Students']['StudentName'] 		= $s_firstname. ' ' .$s_lastname;
								
								
								$exeView[$lessonExercise] = $reponseLessons['RecordView'];
								$resultResponse[$lessonExercise]['Students'][$plan['student']['id']] = $reponseLessons['Students'];
								//$exeView[$lessonExercise]['Students'] = $resultResponse;
							}
							$finalPlan = array_merge_recursive($exeView, $resultResponse);

							foreach($finalPlan as $k => $exeValue)
							{
								$makeStudents = [];
								foreach($exeValue['Students'] as $j => $stu)
								{
									$makeStudents[] = $stu;
								}
								unset($exeValue['Students']);
								$exeValue['Students'] = $makeStudents;
								$finalData[] = $exeValue;
							}
						}else{
							
							foreach($getStudentView as $plan)
							{
								$studentAge = $this->age_from_dob(date('Y-m-d', strtotime($plan['student']['birthday'])));
								
								$s_firstname	= $this->getStudentShortName($plan['student']['first_name'], 20);
								$s_lastname		= $this->getStudentShortName($plan['student']['last_name'], 1);

								$studentId = $plan['student']['id'];
								$lessonExercise = $plan['lesson']['id'].$plan['exercise']['id'];
								
								$reponseLessons['Students']['StudentId'] 			= $plan['student']['id'];
								$reponseLessons['Students']['StudentAge'] 			= $studentAge;
								$reponseLessons['Students']['StudentName'] 			= $s_firstname. ' ' .$s_lastname;
								
								$reponseLessons['StudentView']['StudentViewId'] 	= $plan['id'];
								$reponseLessons['StudentView']['LessonId']			= $plan['lesson']['id'];
								$reponseLessons['StudentView']['LessonName'] 		= $plan['lesson']['title'];
								$reponseLessons['StudentView']['ExerciseId']		= $plan['exercise']['id'];
								$reponseLessons['StudentView']['ExerciseName'] 		= $plan['exercise']['title'];
								$reponseLessons['StudentView']['StatusFor'] 		= $plan['status_for'];
								$reponseLessons['StudentView']['StatusId'] 			= $plan['status_id'];
								$reponseLessons['StudentView']['StatusName'] 		= $plan['status']['name'];
								$reponseLessons['StudentView']['CreatedAt'] 		= date('m-d-Y', strtotime($plan['created']));
								$reponseLessons['StudentView']['AreaId']			= $plan['area']['id'];
								$reponseLessons['StudentView']['AreaName']			= $plan['area']['title'];
								$reponseLessons['StudentView']['AreaColor']			= $plan['area']['area_color'];
								$reponseLessons['StudentView']['ChapterId']			= $plan['chapter']['id'];
								$reponseLessons['StudentView']['ChapterName'] 		= $plan['chapter']['title'];
								
								$exeView[$studentId][$studentId] = $reponseLessons['Students'];
								$exeView[$studentId]['StudentView'][] = isset($reponseLessons['StudentView']) ? $reponseLessons['StudentView'] : '';
							}
							
							foreach($exeView as $k => $exeValue)
							{
								$makeStudents = [];
								foreach($exeValue['StudentView'] as $j => $stu)
								{
									$makeStudents[] = $stu;
									foreach($stu as $s){
										
									}
								}
								
								if(isset($exeValue[$k])){
									$exeValue['Student'] = $exeValue[$k];
								}
								unset($exeValue[$k]);
								unset($exeValue['StudentView']);
								
								$exeValue['Student']['StudentView'] = $makeStudents;
								$finalData[] = $exeValue;
							}
						}
						
						
						$reponsePlan['data'] = $finalData;
						
						$pageResponse = '';
						
						$page = [];
						if(!empty($pageResponse)){
							$page['Page'] 			= $pageResponse['page'];
							$page['Limit'] 			= $pageResponse['perPage'];
							$page['HasPrevPage'] 	= ($pageResponse['prevPage'] != "") ? TRUE : FALSE;
							$page['HasNextPage'] 	= ($pageResponse['nextPage'] != "") ? TRUE : FALSE;
							$page['TotalCount'] 	= $pageResponse['count'];
							$page['TotalPage'] 		= $pageResponse['pageCount'];
						}
						
						if($reponsePlan['viewType'] == 1){
							$viewType = 'Student View';
						}else{
							$viewType = 'Record View';
						}
						
						$this->response = array(
							'status' 		=> 200,
							'message' 		=> $viewType. ' found',
							'pagination' 	=> $page,
							'value' 		=> $reponsePlan
						 );
						 
					}else{
						$this->response = array(
							'status' => 400,
							'message' => 'Plan not found for this user.',
						);
					}
				}
				else{
					$this->response = array(
						'status' => 400,
						'message' => 'Plan not found for this user.',
					);
				}
				$this->__send_response();
			}
			else{

				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}

		$this->__send_response();
	}
	

	/**
	 * @name SendPlanEmail
	 * Purpose : This method is used to save/update Student view plan
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if areas found else returns error
	 */
	public function SendPlanEmail()
	{
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
		}
		
		$error = '';
		$user_data = $this->request->data;

		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required. ';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required. ';
			
		if(!isset($user_data['planId']) || empty($user_data['planId']))
			$error .= 'Plan Id is required. ';
		
		
		if(empty($error)){ 
			
			$this->loadModel('Users');
			$userObj = $this->Users->find('all',['conditions' => ['id' => $user_data['user_id'], 'sessionId' => $user_data['sessionId']]])->first();

			if($userObj){
				$this->loadModel('UserPlans');
				$this->loadModel('Students');
				$this->loadModel('StudentViews');
				
				$planData = [];
				if(isset($user_data['planId']) && !empty($user_data['planId']))
				{
					$planObj = $this->UserPlans->find('all', [
						'conditions' => ['UserPlans.id'=>$user_data['planId']],
						'contain' => ['StudentViews']
						])->first();
						
					if($planObj){
						$planObj = $planObj->toArray();
						
						$userPlanId = $planObj['id'];
						$records = $planObj['student_views'];
						foreach($records as $record){
							
							$statusFor = 'lesson';
							if(!empty($record['exercise_id'])){
								$statusFor = 'exercise';
							}
							
							if($planObj['plan_type'] == 2){
								$studentIds = $record['student_id'];
								$studentIds = explode(',', $studentIds);
								
								foreach($studentIds as $sId){
									$planData[] = [
										'view_id'		=> $record['id'],
										'user_plan_id'	=> $userPlanId,
										'student_id' 	=> $sId,
										'area_id' 		=> $record['area_id'],
										'chapter_id' 	=> $record['chapter_id'],
										'lesson_id' 	=> $record['lesson_id'],
										'exercise_id' 	=> $record['exercise_id'],
										'status_for' 	=> $statusFor,
										'status_id' 	=> 7,
										'state_date'	=> '',
										'end_date'		=> '',
									];
								}
							}else{
								$planData[] = [
									'view_id'		=> $record['id'],
									'user_plan_id'	=> $userPlanId,
									'student_id' 	=> $record['student_id'],
									'area_id' 		=> $record['area_id'],
									'chapter_id' 	=> $record['chapter_id'],
									'lesson_id' 	=> $record['lesson_id'],
									'exercise_id' 	=> $record['exercise_id'],
									'status_for' 	=> $statusFor,
									'status_id' 	=> 7,
									'state_date'	=> '',
									'end_date'		=> '',
								];
							}
						}
					}
				}
				
				if(!empty($planData))
				{
					$studentViewRecord = [];
					$recordViewData = [];
					$studentViewData = [];
					
					foreach($planData as $studentView){
						$status = 'Null';
						if($studentView['status_id'] == 4){
							$status = 'Presented';
						}elseif ($studentView['status_id'] == 5) {
							$status = 'Further refinement';
						}elseif ($studentView['status_id'] == 6) {
							$status = 'Working';
						}elseif ($studentView['status_id'] == 7) {
							$status = 'None';
						}
						
						$studentViewDb = $this->StudentViews->get($studentView['view_id'], [
																	'contain'=>[
																		'UserPlans.Users', 
																		'Students', 
																		'Areas', 
																		'Chapters', 
																		'Lessons', 
																		'Exercises'
																	]]);
						
						
						$studentViewId 		= $studentViewDb->id;
						
						$teacherId 			= isset($studentViewDb->user_plan->user->id) ? $studentViewDb->user_plan->user->id : '';
						$teacherEmail 		= isset($studentViewDb->user_plan->user->email) ? $studentViewDb->user_plan->user->email : '';
						$t_firstname 		= isset($studentViewDb->user_plan->user->first_name) ? $studentViewDb->user_plan->user->first_name : 'Null';
						$t_lastname 		= isset($studentViewDb->user_plan->user->last_name) ? $studentViewDb->user_plan->user->last_name : 'Null';
						$teacherName 		= $t_firstname.' '.$t_lastname;
						
						$studentId 			= isset($studentViewDb->student->id) ? $studentViewDb->student->id : '';
						$studentAge 		= isset($studentViewDb->student->birthday) ? $studentViewDb->student->birthday : '';
						$s_firstname 		= isset($studentViewDb->student->first_name) ? $studentViewDb->student->first_name : 'Null';
						$s_lastname 		= isset($studentViewDb->student->last_name) ? $studentViewDb->student->last_name : 'Null';

						$s_firstname		= $this->getStudentShortName($s_firstname, 20);
						$s_lastname			= $this->getStudentShortName($s_lastname, 1);

						$studentName 		= $s_firstname.' '.$s_lastname;
						
						
						$areaHeading 		= isset($studentViewDb->area->title) ? $studentViewDb->area->title : 'Null';
						$chapterHeading 	= isset($studentViewDb->chapter->title) ? $studentViewDb->chapter->title : 'Null';
						$lessonHeading 		= isset($studentViewDb->lesson->title) ? $studentViewDb->lesson->title : 'Null';
						$exerciseHeading	= isset($studentViewDb->exercise->title) ? $studentViewDb->exercise->title : 'Null';
						
						$stuLessonName 		= isset($studentViewDb->lesson->title) ? $studentViewDb->lesson->title : '';
						$stuExerciseName 	= isset($studentViewDb->exercise->title) ? $studentViewDb->exercise->title : '';
						
						
						if($planObj['plan_type'] == 1){
							if(!empty($studentId)){
								$lessonExercise = rtrim($stuLessonName. '/'. $stuExerciseName, '/');
								$studentViewArray['Student Name'] 		= $studentName;
								$studentViewArray['Age'] 				= $this->age_from_dob(date('Y-m-d', strtotime($studentAge)));
								$studentViewArray['Lesson/Exercise'] 	= $lessonExercise;
								$studentViewData[$studentId][] 			= $studentViewArray;
							}
						}else{
							if(!empty($studentId)){
								$lessonExercise = rtrim($stuLessonName. '/'. $stuExerciseName, '/');
								$recordView['Student Name'] 		= $studentName;
								$recordView['Age'] 					= $this->age_from_dob(date('Y-m-d', strtotime($studentAge)));
								$recordViewData[$lessonExercise][] 	= $recordView;
							}
						}
					}
					
					if($planObj['plan_type'] == 1)
					{
						$line = [];
						foreach($studentViewData as $key=>$sv){
							$line[$key][] = $sv[0]['Student Name'];
							$line[$key][] = $sv[0]['Age'];
							foreach($sv as $v){
								$line[$key][] = $v['Lesson/Exercise'];
							}
						}
					}
					else
					{
						$line = [];
						foreach($recordViewData as $key=>$rv){
							$line[$key][] = $key;
							foreach($rv as $v){
								$line[$key][] = $v['Student Name'];
								$line[$key][] = $v['Age'];
							}
						}
					}
					
					if($planObj['plan_type'] == 1){
						$viewType = 'Student View';
					}else{
						$viewType = 'Record View';
					}
					
					$responsePlan['plan']['id'] 						= $planObj['id'];
					$responsePlan['plan']['title'] 						= $planObj['title'];
					$responsePlan['plan']['start_date'] 				= date('m-d-Y', strtotime($planObj['start_date']));
					$responsePlan['plan']['end_date'] 					= date('m-d-Y', strtotime($planObj['end_date']));
					$responsePlan['plan']['created'] 					= date('m-d-Y', strtotime($planObj['created']));
					$responsePlan['plan']['plan_type'] 					= $planObj['plan_type'];
					$responsePlan['plan']['planType'] 					= $viewType;
					
					$planTitle = ($responsePlan['plan']['title']!= "") ? '/'.$responsePlan['plan']['title'] : '';
					$viewPlanOutput[] = $responsePlan['plan']['start_date'].' to '.$responsePlan['plan']['end_date'].$planTitle;
					
					// Send Email 
					if(!empty($teacherEmail)){
						$this->loadComponent('Common');
						$this->loadComponent('Export');
								
						$template = 'plan-email';

						$this->Export->addRow($viewPlanOutput);
						
						if(!empty($responsePlan['plan']['title'])){
							$plan = $responsePlan['plan']['title']. ' <br/>'. $responsePlan['plan']['end_date']. ' to ' .$responsePlan['plan']['start_date'];
						}else{
							$plan = $responsePlan['plan']['end_date']. ' to ' .$responsePlan['plan']['start_date'];
						}
						$token = [
							'{{teacher_name}}',
							'{{plan_type}}',
							'{{plan_title}}',
						];
						
						$token_value = [
							$teacherName,
							$responsePlan['plan']['planType'],
							$plan,
						];
						
						foreach($line as $l){
							$this->Export->addRow($l);
						}
						
						$filename = $planObj['id'].'_Export.csv';

						$targetFolder = WWW_ROOT. 'uploads' .DS . 'user' . DS . $teacherId. DS;
							

						if (!file_exists($targetFolder)) {
							umask(0000);
							mkdir($targetFolder, 0777, true);
						}
						
						$targetFile = rtrim($targetFolder,'/') . DS . $filename;

						// Rename if file exists
						$counter = 0;
						$fileParts = pathinfo($filename);
						while(file_exists($targetFile)) {
							$filename = $fileParts['filename'] . $counter . '.' . $fileParts['extension'];
							$targetFile = rtrim($targetFolder,'/') . DS . $filename;
							$counter++;
						};
						
						$file = $this->Export->render($filename);
						
						if(file_put_contents($targetFile, $file)){
							
							$attachment['fileName'] = $filename;
							$attachment['filePath'] = $targetFile;
							$attachment['fileType'] = $fileParts['extension'];
							
							if($this->Common->_send_email($teacherEmail, $token, $token_value, $template, '', $attachment)){
								$this->log(print_r(['email sent to '.$teacherEmail], true),'debug');
							}
						}
					}
					
					
					if($planObj['plan_type'] == 1){
						$viewType = 'Student View';
					}else{
						$viewType = 'Record View';
					}
					
					$this->response = array(
							'status' => 200,
							'message' => 'Plan emailed successfully.',
							'data' => $responsePlan
						);
				
					$this->__send_response();
					
				}else{
					$this->response = array(
							'status' => 400,
							'message' => 'This plan is empty.  You can not create plan with empty values.',
						);
				}
			}
			else{

				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}

		$this->__send_response();
	}
	
    /**
	 * @name updatePlanStatus
	 * Purpose : This method is used to save Student view plan
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if areas found else returns error
	 */
			
	public function updatePlanStatus(){
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
		}
		
		$error = '';
		$user_data = $this->request->data;

		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required. ';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required. ';
			
		if(!isset($user_data['status_id']) || empty($user_data['status_id']))
			$error .= 'Status Id is required. ';
			
		if(empty($error)){ 
			
			$createNewPlan = true;
			if(isset($user_data['studentViewId']) && !empty($user_data['studentViewId']))
				$createNewPlan = false;

			$this->loadModel('Users');
			
			$userObj = $this->Users->find('all',['conditions' => ['id' => $user_data['user_id'], 'sessionId' => $user_data['sessionId']]])->first();

			if($userObj){
				
				$this->loadModel('UserPlans');
				$this->loadModel('StudentViews');
				
				
				if($createNewPlan)
				{
					$user = $userObj->toArray();
					$planData = [
						'user_id'	=> $user_data['user_id'],	
						'user_type' => $user['user_type'],
						'start_date'=> date('Y-m-d'),
						'end_date'	=> date('Y-m-d'),
						'plan_type' => '1',
						'status'	=> '0',
					];
					
					$planEntity = $this->UserPlans->newEntity($planData);

					$dbPlan = $this->UserPlans->find('all', ['conditions' => [
							'user_id'	=> $user_data['user_id'],	
							'user_type' => $user['user_type'],
							'plan_type' => '1',
							'status'	=> '0',
						]])->first();

					if(!empty($dbPlan))
					{
						$dbPlan = $dbPlan->toArray();
						$planEntity = $this->UserPlans->get($dbPlan['id']);
					}

					$planEntity = $this->UserPlans->patchEntity($planEntity, $planData);
					if($planEntity = $this->UserPlans->save($planEntity))
					{
						$viewExerciseId = isset($user_data['exercise_id']) ? $user_data['exercise_id'] : '0';
						
						$user_data['user_plan_id']	= $planEntity['id'];
						$user_data['status_for']	= ($viewExerciseId == "0") ? 'lesson' : 'exercise';
						$user_data['creation_type'] = 'new';

						$entity = $this->StudentViews->newEntity($user_data);
						$entity = $this->StudentViews->patchEntity($entity, $user_data);
						if($entity = $this->StudentViews->save($entity)){

							$studentV = $this->StudentViews->get($entity['id'], ['contain' => ['Statuses']]);
							$studentView = [];
							if($studentV)
							{
								$studentView = [
									'StudentViewId'	=> $studentV['id'],
									'statusId'		=> $studentV['status_id'],
									'status'		=> $studentV['status']['name'],
									'statusFor'		=> $studentV['status_for'],
								];
							}

							$this->response = array(
								'status' 		=> 200,
								'message' 		=> 'Status updated.',
								'studentView'	=> $studentView,
							);
						}else{
							$this->response = array(
									'status' => 400,
									'message' => 'Unable to update status, try again later.',
								);
						}
					}
				}
				else
				{
					$conditions = [];
				
					if(isset($user_data['studentViewId']) && !empty($user_data['studentViewId']))
						$conditions['conditions'][] = ['StudentViews.id' => $user_data['studentViewId']];

					$conditions['order'] = [
								'UserPlans.start_date' => 'desc'
							];
					
					
					$getStudentView = $this->StudentViews->find('all', $conditions)->contain([
																					'UserPlans.Users', 
																					'Students', 
																					'Areas', 
																					'Chapters', 
																					'Lessons', 
																					'Exercises', 
																					'Statuses'
																				])->hydrate(false);
																			
																			
					$getStudentView = $getStudentView->first();

					if(!empty($getStudentView)){
						
						$viewPlanId		= $getStudentView['user_plan']['id'];
						$viewStudentId	= $getStudentView['student_id'];
						$viewAreaId		= $getStudentView['area_id'];
						$viewChapterId	= $getStudentView['chapter_id'];
						$viewLessonId	= $getStudentView['lesson_id'];
						$viewExerciseId = $getStudentView['exercise_id'];
						
						$conditionsAll['conditions'] = [];
						if(($viewStudentId))
							$conditionsAll['conditions'][] = ['StudentViews.student_id'		=> $viewStudentId];
						else
							$conditionsAll['conditions'][] = ['StudentViews.student_id IS'	=> null];

						if(($viewAreaId))
							$conditionsAll['conditions'][] = ['StudentViews.area_id'		=> $viewAreaId];
						else
							$conditionsAll['conditions'][] = ['StudentViews.area_id IS'		=> null];

						if(($viewChapterId))
							$conditionsAll['conditions'][] = ['StudentViews.chapter_id'		=> $viewChapterId];
						else
							$conditionsAll['conditions'][] = ['StudentViews.chapter_id IS'	=> null];

						if(($viewLessonId))
							$conditionsAll['conditions'][] = ['StudentViews.lesson_id'		=> $viewLessonId];
						else
							$conditionsAll['conditions'][] = ['StudentViews.lesson_id IS'	=> null];

						if(($viewExerciseId))
							$conditionsAll['conditions'][] = ['StudentViews.exercise_id'	=> $viewExerciseId];
						else
							$conditionsAll['conditions'][] = ['StudentViews.exercise_id IS'	=> null];


						$dbStudentViews = $this->StudentViews->find('all', $conditionsAll)->contain([
																		'UserPlans.Users', 
																		'Students', 
																	])->hydrate(false);
						
						
						
						
						$svId = [];
						$svId[] = $user_data['studentViewId'];
						if(!empty($dbStudentViews))
						{
							$dbStudentViews = $dbStudentViews->toArray();
							foreach($dbStudentViews as $svIds)
							{
								$svId[] = $svIds['id'];
							}
						}
						
						$studentView = [];
						
						if(!empty($svId))
						{
							$updateStatus = true;
							foreach($svId as $Vid)
							{
								$user_data['studentViewId'] = $Vid;
								
								$entity = $this->StudentViews->get($user_data['studentViewId']);
								$entity = $this->StudentViews->patchEntity($entity, $user_data);
								
								if($entity = $this->StudentViews->save($entity)){
									$studentV = $this->StudentViews->get($entity['id'], ['contain' => ['Statuses']]);
									if($studentV)
									{
										$studentView = [
											'StudentViewId'	=> $studentV['id'],
											'statusId'		=> $studentV['status_id'],
											'status'		=> $studentV['status']['name'],
											'statusFor'		=> $studentV['status_for'],
										];
									}
								}else{
									$updateStatus = false;
								}
							}

							if($updateStatus)
							{

								$this->response = array(
									'status' 		=> 200,
									'message' 		=> 'Status updated.',
									'studentView'	=> $studentView,
								);
							}
							else
							{
								$this->response = array(
									'status' => 400,
									'message' => 'Unable to update status, try again later.',
								);
							}
						}
						else
						{
							$this->response = array(
									'status' => 400,
									'message' => 'This plan is not found. ',
								);
						}
					}
					else{
						$this->response = array(
							'status' => 400,
							'message' => 'Plans are not found.',
						);
					}
				}
				
				$this->__send_response();
			}
			else{

				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}

		$this->__send_response();
	}
	
	/**
	 * @name getAllUserData
	 * Purpose : This method is used to get all user data with keywords
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if areas found else returns error
	 */
	 
	public function getAllUserData(){
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
			$this->__send_response();
		}
		
		$error = '';
		$user_data = $this->request->data;

		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';
		
		if(!isset($user_data['area_type']) || empty($user_data['area_type']))
			$error .= 'Area type is required.';
		
		if(empty($error)){ 
			
			$chapterRequired = true;
			if(isset($user_data['chapterRequired'])){
				$chapterRequired = true;
			}
			$lessonRequired = true;
			if(isset($user_data['lessonRequired'])){
				$lessonRequired = true;
			}
			$exerciseRequired = true;
			if(isset($user_data['exerciseRequired'])){
				$exerciseRequired = true;
			}
			
			$this->loadModel('Users');
						
			$userObj = $this->Users->find('all', [
						'conditions'=> [
							'id' 				=> $user_data['user_id'], 
							'sessionId' 		=> $user_data['sessionId'],
						]
						])->first();
			
			
			if(!empty($userObj)){
				$user = $userObj->toArray();
				
				
				$userDataObj = $this->Users->find('all', [
						'conditions'=> [
							'id' 				=> $user['id']
						]
						])->contain([
								'Areas' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($user) {
												return $q->where([
													'AND' =>[
														'Areas.status' => 1,
														'Areas.area_type' => $user['user_type'],
													]
												])->order(['Areas.order_no'=>'ASC']);
								}], 
								'Areas.Chapters' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($user) {
												return $q->where([
													'AND' =>[
														'Chapters.status' => 1,
													]
												])->order(['Chapters.order_no'=>'ASC']);
								}],
								'Areas.Chapters.Lessons' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($user) {
												return $q->where([
													'AND' =>[
														'Lessons.status' => 1,
													]
												])->order(['Lessons.order_no'=>'ASC']);
								}],
								'Areas.Chapters.Lessons.Exercises' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($user) {
												return $q->where([
													'AND' =>[
														'Exercises.status' => 1,
													]
												])->order(['Exercises.order_no'=>'ASC']);
								}]
						])->first();
				
				$userData 			= $userDataObj->toArray();		
				
				$userDataList 		= $userData['areas'];

				$defaultDataList 	= $this->getDefaultDataList($user['user_type'], $user_data['sessionId']);
			
				$areasData = array();
				$reponseAreas = [];
				if((isset($userData['areas']) && !empty($userData['areas'])) || !empty($defaultDataList)){

					foreach ($userData['areas'] as $key => $area) {

						if($area['area_type'] == 1)
							$area['area_type'] = 'Primary';
						else
							$area['area_type'] = 'Elementry';
						
						$reponseAreas['Area'][$area['title']] = [
													'AreaId'		=> $area['id'],
													'OrderNo'		=> $area['order_no'],
													'objectId'		=> $area['object_id'],
													'userId'		=> $area['user_id'],
													'AreaType'		=> $area['area_type'],
													'areaName'		=> $area['title'],
													'areaColor'		=> $area['area_color'],
													'createdAt'		=> $area['created'],
													'updatedAt'		=> $area['modified'],
												];
						if($chapterRequired){
							if(isset($area['chapters']) && !empty($area['chapters'])){
								foreach($area['chapters'] as $ch=>$chapter){
									
									$reponseAreas['Area'][$area['title']]['Chapter'][$chapter['object_id']] = [
																			'ChatperId'		=> $chapter['id'],
																			'objectId'		=> $chapter['object_id'],
																			'areaId'		=> $chapter['area_id'],
																			'orderNo'		=> $chapter['order_no'],
																			'chapterName'	=> $chapter['title'],
																			'userId'		=> $chapter['user_id'],
																			'updatedAt'		=> $chapter['modified'],
																			'createdAt'		=> $chapter['created']
																		];
									
									if($lessonRequired){
										if(isset($chapter['lessons']) && !empty($chapter['lessons'])){
											
											$reponseAreas['Area'][$area['title']]['Chapter'][$chapter['object_id']]['hasLessons'] = TRUE;
											
											foreach($chapter['lessons'] as $less=>$lesson){
												$reponseAreas['Area'][$area['title']]['Chapter'][$chapter['object_id']]['Lesson'][$lesson['object_id']] = [
																				'LessonId'		=> $lesson['id'],
																				'objectId'		=> $lesson['object_id'],
																				'areaId'		=> $lesson['area_id'],
																				'chapterId'		=> $lesson['chapter_id'],
																				'orderNo'		=> $lesson['order_no'],
																				'lessonName'	=> $lesson['title'],
																				'userId'		=> $lesson['user_id'],
																				'createdAt'		=> $lesson['created'],
																				'updatedAt'		=> $lesson['modified']
																			];
																			
												if($exerciseRequired){
													if(isset($lesson['exercises']) && !empty($lesson['exercises'])){
														
														$reponseAreas['Area'][$area['title']]['Chapter'][$chapter['object_id']]['Lesson'][$lesson['object_id']]['hasExercise'] = TRUE;
														
														foreach($lesson['exercises'] as $exe=>$exercise){
															$reponseAreas['Area'][$area['title']]['Chapter'][$chapter['object_id']]['Lesson'][$lesson['object_id']]['Exercise'][$exercise['object_id']] = [
																							'ExerciseId'	=> $exercise['id'],
																							'objectId'		=> $exercise['object_id'],
																							'areaId'		=> $exercise['area_id'],
																							'chapterId'		=> $exercise['chapter_id'],
																							'lessonId'		=> $exercise['lesson_id'],
																							'orderNo'		=> $exercise['order_no'],
																							'exerciseName'	=> $exercise['title'],
																							'userId'		=> $exercise['user_id'],
																							'createdAt'		=> $exercise['created'],
																							'updatedAt'		=> $exercise['modified']
																						];
																						
														}
													}else{
														$reponseAreas['Area'][$area['title']]['Chapter'][$chapter['object_id']]['Lesson'][$lesson['object_id']]['hasExercise'] = FALSE;
													}
												}
											}
										}else{
											$reponseAreas['Area'][$area['title']]['Chapter'][$chapter['object_id']]['hasLessons'] = FALSE;
										}
									}
								}
							}
						}
					}
					
					if(!empty($reponseAreas)){
						$mergeData = array_merge_recursive($defaultDataList, $reponseAreas);
					}else{
						$mergeData = $defaultDataList;
					}
					
					
					
					$json = json_encode($mergeData);
					$fileName = 'db.txt';
					$filePath = $this->webroot.'uploads/user'. DS .$user_data['user_id']. DS;
					

					if (!is_dir($filePath)) {
						umask(0000);
						mkdir($filePath, 0777, true);
						chmod($filePath, 0777);
					}
					
					$targetFile = $filePath.$fileName;

					$fileParts = pathinfo($fileName);
					
					chmod($targetFile, 0777);
					$fp = fopen($targetFile, 'w+');
					fwrite($fp, $json);
					fclose($fp);
					
					$url = Router::url('/' . 'uploads' . DS . 'user' . DS . $user_data['user_id'] . DS . $fileName, true);
					
					$this->response = array(
							'status' 	=> 200,
							'message' 	=> 'Data found',
							'value' 	=> $url,
							'data'		=> $mergeData
						 );

				}
				else{
						$this->response = array(
							'status' => 404,
							'message' => 'Areas not found for this user.',
						);	
				}
			}else{
				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}else{
			$this->response = array(
						'status' => 400,
						'message' => rtrim($error, ', '),
					);
		}
		$this->__send_response();
	}
	
	public function getDefaultDataList($user_type = null, $sessionId = null){
		
		$reponseAreas = [];
		$chapterRequired = true;
		if(isset($user_data['chapterRequired'])){
			$chapterRequired = true;
		}
		$lessonRequired = true;
		if(isset($user_data['lessonRequired'])){
			$lessonRequired = true;
		}
		$exerciseRequired = true;
		if(isset($user_data['exerciseRequired'])){
			$exerciseRequired = true;
		}
		
		$this->autoRender = false;
		
		$this->loadModel('Users');
		
		$authId = $this->getAuthUser($sessionId);

		$userDataObj = $this->Users->find('all', [
						'conditions'=> [
							'id' 				=> 1
						]
						])->contain([
								'Areas' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($user_type) {
												return $q->where([
													'AND' =>[
														'Areas.status' => 1,
														'Areas.area_type' => $user_type,
													]
												])->order(['Areas.order_no'=>'ASC']);
								}],
								'Areas.UserAreas' => [
									'joinType' => 'inner',
									'queryBuilder' =>
										function ($q) use ($authId) {
											return $q
											->where([
												'UserAreas.user_id' => $authId,
											]);
								}],
								'Areas.Chapters' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($user_type) {
												return $q->where([
													'AND' =>[
														'Chapters.status' => 1,
													]
												])->order(['Chapters.order_no'=>'ASC']);
								}],
								'Areas.Chapters.UserChapters' => [
									'joinType' => 'inner',
									'queryBuilder' =>
										function ($q) use ($authId) {
											return $q
											->where([
												'UserChapters.user_id' => $authId,
											]);
								}],
								'Areas.Chapters.Lessons' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($user_type) {
												return $q->where([
													'AND' =>[
														'Lessons.status' => 1,
													]
												])->order(['Lessons.order_no'=>'ASC']);
								}],
								'Areas.Chapters.Lessons.UserLessons' => [
									'joinType' => 'inner',
									'queryBuilder' =>
										function ($q) use ($authId) {
											return $q
											->where([
												'UserLessons.user_id' => $authId,
											]);
								}],
								'Areas.Chapters.Lessons.Exercises' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($user_type) {
												return $q->where([
													'AND' =>[
														'Exercises.status' => 1,
													]
												])->order(['Exercises.order_no'=>'ASC']);
								}],
								'Areas.Chapters.Lessons.Exercises.UserExercises' => [
									'joinType' => 'inner',
									'queryBuilder' =>
										function ($q) use ($authId) {
											return $q
											->where([
												'UserExercises.user_id' => $authId,
											]);
								}]
						])->first();
				
		$user = $userDataObj->toArray();

		$areasData = array();

		if(isset($user['areas']) && !empty($user['areas'])){
			foreach ($user['areas'] as $key => $area) {

				

				if($area['area_type'] == 1)
					$area['area_type'] = 'Primary';
				else
					$area['area_type'] = 'Elementry';
					
				
				if(!empty($area['user_areas']))
				{
					if($area['user_areas'][0]['action'] == "edit")
					{
						$area['title']		= $area['user_areas'][0]['title'];
						$area['area_color'] = $area['user_areas'][0]['area_color'];

						$reponseAreas['Area'][$area['title']] = [
											'AreaId'		=> $area['id'],
											'OrderNo'		=> $area['order_no'],
											'objectId'		=> $area['object_id'],
											'userId'		=> $area['user_id'],
											'AreaType'		=> $area['area_type'],
											'areaName'		=> $area['title'],
											'areaColor'		=> $area['area_color'],
											'createdAt'		=> $area['created'],
											'updatedAt'		=> $area['modified'],
										];
					}
					elseif($area['user_areas'][0]['action'] == "delete")
					{
						unset($area);
					}
				}
				else
				{
					$reponseAreas['Area'][$area['title']] = [
											'AreaId'		=> $area['id'],
											'OrderNo'		=> $area['order_no'],
											'objectId'		=> $area['object_id'],
											'userId'		=> $area['user_id'],
											'AreaType'		=> $area['area_type'],
											'areaName'		=> $area['title'],
											'areaColor'		=> $area['area_color'],
											'createdAt'		=> $area['created'],
											'updatedAt'		=> $area['modified'],
										];
				}
				
				
				if($chapterRequired){
					if(isset($area['chapters']) && !empty($area['chapters'])){
						
						foreach($area['chapters'] as $ch=>$chapter){
							
							if(!empty($chapter['user_chapters']))
							{
								if($chapter['user_chapters'][0]['action'] == "edit")
								{
									$chapter['title'] = $chapter['user_chapters'][0]['title'];
									
									$reponseAreas['Area'][$area['title']]['Chapter'][$chapter['object_id']] = [
																	'ChatperId'		=> $chapter['id'],
																	'objectId'		=> $chapter['object_id'],
																	'areaId'		=> $chapter['area_id'],
																	'orderNo'		=> $chapter['order_no'],
																	'chapterName'	=> $chapter['title'],
																	'userId'		=> $chapter['user_id'],
																	'updatedAt'		=> $chapter['modified'],
																	'createdAt'		=> $chapter['created']
																];
								}
								elseif($chapter['user_chapters'][0]['action'] == "delete")
								{
									unset($chapter);
								}
							}
							else
							{
								$reponseAreas['Area'][$area['title']]['Chapter'][$chapter['object_id']] = [
																	'ChatperId'		=> $chapter['id'],
																	'objectId'		=> $chapter['object_id'],
																	'areaId'		=> $chapter['area_id'],
																	'orderNo'		=> $chapter['order_no'],
																	'chapterName'	=> $chapter['title'],
																	'userId'		=> $chapter['user_id'],
																	'updatedAt'		=> $chapter['modified'],
																	'createdAt'		=> $chapter['created']
																];
							}

							
							
							if($lessonRequired){
								if(isset($chapter['lessons']) && !empty($chapter['lessons'])){
									
									$reponseAreas['Area'][$area['title']]['Chapter'][$chapter['object_id']]['hasLessons'] = TRUE;
									
									foreach($chapter['lessons'] as $less=>$lesson){

										if(!empty($lesson['user_lessons']))
										{
											$lesson['title'] = $lesson['user_lessons'][0]['title'];

											if($lesson['user_lessons'][0]['action'] == "edit")
											{
												$reponseAreas['Area'][$area['title']]['Chapter'][$chapter['object_id']]['Lesson'][$lesson['object_id']] = [
																		'LessonId'		=> $lesson['id'],
																		'objectId'		=> $lesson['object_id'],
																		'areaId'		=> $lesson['area_id'],
																		'chapterId'		=> $lesson['chapter_id'],
																		'orderNo'		=> $lesson['order_no'],
																		'lessonName'	=> $lesson['title'],
																		'userId'		=> $lesson['user_id'],
																		'createdAt'		=> $lesson['created'],
																		'updatedAt'		=> $lesson['modified']
																	];
											}
											elseif($lesson['user_lessons'][0]['action'] == "delete")
											{
												unset($lesson);
											}
										}
										else
										{
										$reponseAreas['Area'][$area['title']]['Chapter'][$chapter['object_id']]['Lesson'][$lesson['object_id']] = [
																		'LessonId'		=> $lesson['id'],
																		'objectId'		=> $lesson['object_id'],
																		'areaId'		=> $lesson['area_id'],
																		'chapterId'		=> $lesson['chapter_id'],
																		'orderNo'		=> $lesson['order_no'],
																		'lessonName'	=> $lesson['title'],
																		'userId'		=> $lesson['user_id'],
																		'createdAt'		=> $lesson['created'],
																		'updatedAt'		=> $lesson['modified']
																	];
										}
																	
										if($exerciseRequired){
											if(isset($lesson['exercises']) && !empty($lesson['exercises'])){
												
												$reponseAreas['Area'][$area['title']]['Chapter'][$chapter['object_id']]['Lesson'][$lesson['object_id']]['hasExercise'] = TRUE;
												
												foreach($lesson['exercises'] as $exe=>$exercise){
													if(!empty($exercise['user_exercises']))
													{
														$exercise['title'] = $exercise['user_exercises'][0]['title'];
														if($exercise['user_exercises'][0]['action'] == "edit")
														{
															$reponseAreas['Area'][$area['title']]['Chapter'][$chapter['object_id']]['Lesson'][$lesson['object_id']]['Exercise'][$exercise['object_id']] = [
																					'ExerciseId'	=> $exercise['id'],
																					'objectId'		=> $exercise['object_id'],
																					'areaId'		=> $exercise['area_id'],
																					'chapterId'		=> $exercise['chapter_id'],
																					'lessonId'		=> $exercise['lesson_id'],
																					'orderNo'		=> $exercise['order_no'],
																					'exerciseName'	=> $exercise['title'],
																					'userId'		=> $exercise['user_id'],
																					'createdAt'		=> $exercise['created'],
																					'updatedAt'		=> $exercise['modified']
																				];
														}
														elseif($exercise['user_exercises'][0]['action'] == "delete")
														{
															unset($exercise);
														}
													}
													else
													{
														$reponseAreas['Area'][$area['title']]['Chapter'][$chapter['object_id']]['Lesson'][$lesson['object_id']]['Exercise'][$exercise['object_id']] = [
																					'ExerciseId'	=> $exercise['id'],
																					'objectId'		=> $exercise['object_id'],
																					'areaId'		=> $exercise['area_id'],
																					'chapterId'		=> $exercise['chapter_id'],
																					'lessonId'		=> $exercise['lesson_id'],
																					'orderNo'		=> $exercise['order_no'],
																					'exerciseName'	=> $exercise['title'],
																					'userId'		=> $exercise['user_id'],
																					'createdAt'		=> $exercise['created'],
																					'updatedAt'		=> $exercise['modified']
																				];
													}
												}
											}else{
												if(isset($lesson['object_id']))
												{
													$reponseAreas['Area'][$area['title']]['Chapter'][$chapter['object_id']]['Lesson'][$lesson['object_id']]['hasExercise'] = FALSE;
												}
											}
										}
									}
								}else{
									if(isset($chapter['object_id']))
									{
										$reponseAreas['Area'][$area['title']]['Chapter'][$chapter['object_id']]['hasLessons'] = FALSE;
									}
								}
							}
						}
					}
				}
			}
			
			return $reponseAreas;
			
		}else{
			return true;
		}
	}
	
	
	/**
	 * @name getAllUserDataTest 
	 * Purpose : This method is used to get all user data without keywords
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if areas found else returns error
	 */
	 
	public function getAllUserDataTest(){
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
			$this->__send_response();
		}
		
		$error = '';
		$user_data = $this->request->data;

		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';
		
		if(!isset($user_data['area_type']) || empty($user_data['area_type']))
			$error .= 'Area type is required.';
		
		if(empty($error)){ 
			
			$chapterRequired = true;
			if(isset($user_data['chapterRequired'])){
				$chapterRequired = true;
			}
			$lessonRequired = true;
			if(isset($user_data['lessonRequired'])){
				$lessonRequired = true;
			}
			$exerciseRequired = true;
			if(isset($user_data['exerciseRequired'])){
				$exerciseRequired = true;
			}
			
			$this->loadModel('Users');
						
			$userObj = $this->Users->find('all', [
						'conditions'=> [
							'id' 				=> $user_data['user_id'], 
							'sessionId' 		=> $user_data['sessionId'],
						]
						])->first();
			
			
			if(!empty($userObj)){
				$user = $userObj->toArray();
				
				$userDataObj = $this->Users->find('all', [
						'conditions'=> [
							'id' 				=> $user['id']
						]
						])->contain([
								'Areas' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($user) {
												return $q->where([
													'AND' =>[
														'Areas.status' => 1,
														'Areas.area_type' => $user['user_type'],
													]
												])->order(['Areas.order_no'=>'ASC']);
								}], 
								'Areas.Chapters' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($user) {
												return $q->where([
													'AND' =>[
														'Chapters.status' => 1,
													]
												])->order(['Chapters.order_no'=>'ASC']);
								}],
								'Areas.Chapters.Lessons' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($user) {
												return $q->where([
													'AND' =>[
														'Lessons.status' => 1,
													]
												])->order(['Lessons.order_no'=>'ASC']);
								}],
								'Areas.Chapters.Lessons.Exercises' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($user) {
												return $q->where([
													'AND' =>[
														'Exercises.status' => 1,
													]
												])->order(['Exercises.order_no'=>'ASC']);
								}]
						])->first();
				
				$userData 			= $userDataObj->toArray();		
				$userDataList 		= $userData['areas'];

				$defaultDataList 	= $this->getDefaultDataListTest($user['user_type'], $user_data['sessionId']);

				$areasData = array();
				$reponseAreas = [];
				if((isset($userData['areas']) && !empty($userData['areas'])) || !empty($defaultDataList)){

					foreach ($userData['areas'] as $key => $area) {

						if($area['area_type'] == 1)
							$area['area_type'] = 'Primary';
						else
							$area['area_type'] = 'Elementry';
						
						$reponseAreas['Area'][$key] = [
													'AreaId'		=> $area['id'],
													'OrderNo'		=> $area['order_no'],
													'objectId'		=> $area['object_id'],
													'userId'		=> $area['user_id'],
													'AreaType'		=> $area['area_type'],
													'areaName'		=> $area['title'],
													'areaColor'		=> $area['area_color'],
													'createdAt'		=> $area['created'],
													'updatedAt'		=> $area['modified'],
												];
						if($chapterRequired){
							if(isset($area['chapters']) && !empty($area['chapters'])){
								foreach($area['chapters'] as $ch=>$chapter){
									
									$reponseAreas['Area'][$key]['Chapter'][$ch] = [
																			'ChatperId'		=> $chapter['id'],
																			'objectId'		=> $chapter['object_id'],
																			'areaId'		=> $chapter['area_id'],
																			'orderNo'		=> $chapter['order_no'],
																			'chapterName'	=> $chapter['title'],
																			'userId'		=> $chapter['user_id'],
																			'updatedAt'		=> $chapter['modified'],
																			'createdAt'		=> $chapter['created']
																		];
									
									if($lessonRequired){
										if(isset($chapter['lessons']) && !empty($chapter['lessons'])){
											
											$reponseAreas['Area'][$key]['Chapter'][$ch]['hasLessons'] = TRUE;
											
											foreach($chapter['lessons'] as $less=>$lesson){
												$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less] = [
																				'LessonId'		=> $lesson['id'],
																				'objectId'		=> $lesson['object_id'],
																				'areaId'		=> $lesson['area_id'],
																				'chapterId'		=> $lesson['chapter_id'],
																				'orderNo'		=> $lesson['order_no'],
																				'lessonName'	=> $lesson['title'],
																				'userId'		=> $lesson['user_id'],
																				'createdAt'		=> $lesson['created'],
																				'updatedAt'		=> $lesson['modified']
																			];
																			
												if($exerciseRequired){
													if(isset($lesson['exercises']) && !empty($lesson['exercises'])){
														
														$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less]['hasExercise'] = TRUE;
														
														foreach($lesson['exercises'] as $exe=>$exercise){
															$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less]['Exercise'][] = [
																							'ExerciseId'	=> $exercise['id'],
																							'objectId'		=> $exercise['object_id'],
																							'areaId'		=> $exercise['area_id'],
																							'chapterId'		=> $exercise['chapter_id'],
																							'lessonId'		=> $exercise['lesson_id'],
																							'orderNo'		=> $exercise['order_no'],
																							'exerciseName'	=> $exercise['title'],
																							'userId'		=> $exercise['user_id'],
																							'createdAt'		=> $exercise['created'],
																							'updatedAt'		=> $exercise['modified']
																						];
																						
														}
													}else{
														$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less]['hasExercise'] = FALSE;
													}
												}
											}
										}else{
											$reponseAreas['Area'][$key]['Chapter'][$ch]['hasLessons'] = FALSE;
										}
									}
								}
							}
						}
					}
					

					if(!empty($reponseAreas)){
						$mergeData = array_merge_recursive($defaultDataList, $reponseAreas);
					}else{
						$mergeData = $defaultDataList;
					}
				
				
					$finalOutput = [];
					$mergeData['Area'] = array_values($mergeData['Area']);
					foreach($mergeData['Area'] as $a=>$aChap)
					{
						if(isset($aChap['Chapter']))
						{
							$chatDatas = $aChap['Chapter'];
							unset($aChap['Chapter']);
							$finalOutput['Area'][$a] = $aChap;
							$chatData = array_values($chatDatas);

							foreach($chatData as $c=>$cLess)
							{
								if($cLess['hasLessons'] == 1 || $cLess['hasLessons'] == true)
								{
									$lessonData = $cLess['Lesson'];
									unset($cLess['Lesson']);
									$finalOutput['Area'][$a]['Chapter'][$c] = $cLess;
									
									$lessonData = array_values($lessonData);
									foreach($lessonData as $l => $lExe)
									{
										if($lExe['hasExercise'] == 1)
										{
											$exeData = $lExe['Exercise'];
											unset($lExe['Exercise']);
											$finalOutput['Area'][$a]['Chapter'][$c]['Lesson'][$l] = $lExe;

											foreach($exeData as $e => $exe)
											{
												$finalOutput['Area'][$a]['Chapter'][$c]['Lesson'][$l]['Exercise'][] = $exe;
											}	
										}
										else
										{
											$finalOutput['Area'][$a]['Chapter'][$c]['Lesson'][$l] = $lExe;
										}
									}
								}
								else
								{
									$finalOutput['Area'][$a]['Chapter'][$c] = $cLess;
								}
							}	
						}else
						{
							$finalOutput['Area'][$a] = $aChap;
						}
					}

					$json = json_encode($finalOutput);
					
					$fileName = 'db2.txt';
					$filePath = $this->webroot.'uploads/user'. DS .$user_data['user_id']. DS;
					
					if (!is_dir($filePath)) {
						umask(0000);
						@mkdir($filePath, 0777, true);
						@chmod($filePath, 0777);
					}
					
					$targetFile = $filePath.$fileName;

					$fileParts = pathinfo($fileName);

					@chmod($targetFile, 0777);
					$fp = @fopen($targetFile, 'w+');
					fwrite($fp, $json);
					fclose($fp);
					
					$url = Router::url('/' . 'uploads' . DS . 'user' . DS . $user_data['user_id'] . DS . $fileName, true);
					
					$this->response = array(
							'status' 	=> 200,
							'message' 	=> 'Data found',
							'value' 	=> $url,
							'data'		=> $finalOutput
						 );

				}
				else{
						$this->response = array(
							'status' => 404,
							'message' => 'Areas not found for this user.',
						);	
				}
			}else{
				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}else{
			$this->response = array(
						'status' => 400,
						'message' => rtrim($error, ', '),
					);
		}
		$this->__send_response();
	}
	
	public function getDefaultDataListTest($user_type = null, $sessionId = null){
		
		$reponseAreas = [];
		$chapterRequired = true;
		if(isset($user_data['chapterRequired'])){
			$chapterRequired = true;
		}
		$lessonRequired = true;
		if(isset($user_data['lessonRequired'])){
			$lessonRequired = true;
		}
		$exerciseRequired = true;
		if(isset($user_data['exerciseRequired'])){
			$exerciseRequired = true;
		}
		
		$this->autoRender = false;
		
		$this->loadModel('Users');
		
		$authId = $this->getAuthUser($sessionId);

		$userDataObj = $this->Users->find('all', [
						'conditions'=> [
							'id' 				=> 1
						]
						])->contain([
								'Areas' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($user_type) {
												return $q->where([
													'AND' =>[
														'Areas.status' => 1,
														'Areas.area_type' => $user_type,
													]
												])->order(['Areas.order_no'=>'ASC']);
								}],
								'Areas.UserAreas' => [
									'joinType' => 'inner',
									'queryBuilder' =>
										function ($q) use ($authId) {
											return $q
											->where([
												'UserAreas.user_id' => $authId,
											]);
								}],
								'Areas.Chapters' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($user_type) {
												return $q->where([
													'AND' =>[
														'Chapters.status' => 1,
													]
												])->order(['Chapters.order_no'=>'ASC']);
								}],
								'Areas.Chapters.UserChapters' => [
									'joinType' => 'inner',
									'queryBuilder' =>
										function ($q) use ($authId) {
											return $q
											->where([
												'UserChapters.user_id' => $authId,
											]);
								}],
								'Areas.Chapters.Lessons' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($user_type) {
												return $q->where([
													'AND' =>[
														'Lessons.status' => 1,
													]
												])->order(['Lessons.order_no'=>'ASC']);
								}],
								'Areas.Chapters.Lessons.UserLessons' => [
									'joinType' => 'inner',
									'queryBuilder' =>
										function ($q) use ($authId) {
											return $q
											->where([
												'UserLessons.user_id' => $authId,
											]);
								}],
								'Areas.Chapters.Lessons.Exercises' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($user_type) {
												return $q->where([
													'AND' =>[
														'Exercises.status' => 1,
													]
												])->order(['Exercises.order_no'=>'ASC']);
								}],
								'Areas.Chapters.Lessons.Exercises.UserExercises' => [
									'joinType' => 'inner',
									'queryBuilder' =>
										function ($q) use ($authId) {
											return $q
											->where([
												'UserExercises.user_id' => $authId,
											]);
								}]
						])->first();
				
		$user		= $userDataObj->toArray();

		$areasData = array();
		//pr($user);
		if(isset($user['areas']) && !empty($user['areas'])){

			foreach ($user['areas'] as $key => $area) {

				if($area['area_type'] == 1)
					$area['area_type'] = 'Primary';
				else
					$area['area_type'] = 'Elementry';
				
				
							
				if(!empty($area['user_areas']))
				{
					if($area['user_areas'][0]['action'] == "edit")
					{
						$area['title']		= $area['user_areas'][0]['title'];
						$area['area_color'] = $area['user_areas'][0]['area_color'];

						$reponseAreas['Area'][$key] = [
											'AreaId'		=> $area['id'],
											'OrderNo'		=> $area['order_no'],
											'objectId'		=> $area['object_id'],
											'userId'		=> $area['user_id'],
											'AreaType'		=> $area['area_type'],
											'areaName'		=> $area['title'],
											'areaColor'		=> $area['area_color'],
											'createdAt'		=> $area['created'],
											'updatedAt'		=> $area['modified'],
										];
					}
					elseif($area['user_areas'][0]['action'] == "delete")
					{
						unset($area);
					}
				}
				else
				{
					$reponseAreas['Area'][$key] = [
											'AreaId'		=> $area['id'],
											'OrderNo'		=> $area['order_no'],
											'objectId'		=> $area['object_id'],
											'userId'		=> $area['user_id'],
											'AreaType'		=> $area['area_type'],
											'areaName'		=> $area['title'],
											'areaColor'		=> $area['area_color'],
											'createdAt'		=> $area['created'],
											'updatedAt'		=> $area['modified'],
										];
				}
				
				if($chapterRequired){
					if(isset($area['chapters']) && !empty($area['chapters'])){
						foreach($area['chapters'] as $ch=>$chapter){
							
							if(!empty($chapter['user_chapters']))
							{
								if($chapter['user_chapters'][0]['action'] == "edit")
								{
									$chapter['title'] = $chapter['user_chapters'][0]['title'];
									
									$reponseAreas['Area'][$key]['Chapter'][$ch] = [
																	'ChatperId'		=> $chapter['id'],
																	'objectId'		=> $chapter['object_id'],
																	'areaId'		=> $chapter['area_id'],
																	'orderNo'		=> $chapter['order_no'],
																	'chapterName'	=> $chapter['title'],
																	'userId'		=> $chapter['user_id'],
																	'updatedAt'		=> $chapter['modified'],
																	'createdAt'		=> $chapter['created']
																];
								}
								elseif($chapter['user_chapters'][0]['action'] == "delete")
								{
									unset($chapter);
								}
							}
							else
							{
								$reponseAreas['Area'][$key]['Chapter'][$ch] = [
																	'ChatperId'		=> $chapter['id'],
																	'objectId'		=> $chapter['object_id'],
																	'areaId'		=> $chapter['area_id'],
																	'orderNo'		=> $chapter['order_no'],
																	'chapterName'	=> $chapter['title'],
																	'userId'		=> $chapter['user_id'],
																	'updatedAt'		=> $chapter['modified'],
																	'createdAt'		=> $chapter['created']
																];
							}
							
							if($lessonRequired){
								if(isset($chapter['lessons']) && !empty($chapter['lessons'])){
									
									$reponseAreas['Area'][$key]['Chapter'][$ch]['hasLessons'] = TRUE;
									
									foreach($chapter['lessons'] as $less=>$lesson){

										if(!empty($lesson['user_lessons']))
										{
											$lesson['title'] = $lesson['user_lessons'][0]['title'];

											if($lesson['user_lessons'][0]['action'] == "edit")
											{
												$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less] = [
																		'LessonId'		=> $lesson['id'],
																		'objectId'		=> $lesson['object_id'],
																		'areaId'		=> $lesson['area_id'],
																		'chapterId'		=> $lesson['chapter_id'],
																		'orderNo'		=> $lesson['order_no'],
																		'lessonName'	=> $lesson['title'],
																		'userId'		=> $lesson['user_id'],
																		'createdAt'		=> $lesson['created'],
																		'updatedAt'		=> $lesson['modified']
																	];
											}
											elseif($lesson['user_lessons'][0]['action'] == "delete")
											{
												unset($lesson);
											}
										}
										else
										{
											$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less] = [
																		'LessonId'		=> $lesson['id'],
																		'objectId'		=> $lesson['object_id'],
																		'areaId'		=> $lesson['area_id'],
																		'chapterId'		=> $lesson['chapter_id'],
																		'orderNo'		=> $lesson['order_no'],
																		'lessonName'	=> $lesson['title'],
																		'userId'		=> $lesson['user_id'],
																		'createdAt'		=> $lesson['created'],
																		'updatedAt'		=> $lesson['modified']
																	];
										}
										
										
																	
										if($exerciseRequired){
											if(isset($lesson['exercises']) && !empty($lesson['exercises'])){
												
												$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less]['hasExercise'] = TRUE;
												
												foreach($lesson['exercises'] as $exe=>$exercise){
													
													
													if(!empty($exercise['user_exercises']))
													{
														$exercise['title'] = $exercise['user_exercises'][0]['title'];
														if($exercise['user_exercises'][0]['action'] == "edit")
														{
															$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less]['Exercise'][$exe] = [
																					'ExerciseId'	=> $exercise['id'],
																					'objectId'		=> $exercise['object_id'],
																					'areaId'		=> $exercise['area_id'],
																					'chapterId'		=> $exercise['chapter_id'],
																					'lessonId'		=> $exercise['lesson_id'],
																					'orderNo'		=> $exercise['order_no'],
																					'exerciseName'	=> $exercise['title'],
																					'userId'		=> $exercise['user_id'],
																					'createdAt'		=> $exercise['created'],
																					'updatedAt'		=> $exercise['modified']
																				];
														}
														elseif($exercise['user_exercises'][0]['action'] == "delete")
														{
															unset($exercise);
														}
													}
													else
													{
														$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less]['Exercise'][$exe] = [
																					'ExerciseId'	=> $exercise['id'],
																					'objectId'		=> $exercise['object_id'],
																					'areaId'		=> $exercise['area_id'],
																					'chapterId'		=> $exercise['chapter_id'],
																					'lessonId'		=> $exercise['lesson_id'],
																					'orderNo'		=> $exercise['order_no'],
																					'exerciseName'	=> $exercise['title'],
																					'userId'		=> $exercise['user_id'],
																					'createdAt'		=> $exercise['created'],
																					'updatedAt'		=> $exercise['modified']
																				];
													}
												}
											}else{
												$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less]['hasExercise'] = FALSE;
											}
										}
									}
								}else{
									if(isset($chapter))
									{
										$reponseAreas['Area'][$key]['Chapter'][$ch]['hasLessons'] = FALSE;
									}
								}
							}
						}
					}
				}
			}
			
			return $reponseAreas;
			
		}else{
			return true;
		}
	}
	
	/**
	 * @name saveClassroom
	 * Purpose : This method is used to update classroom information of user
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if areas found else returns error
	 */
			
	public function saveClassroom(){
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
						
			$this->__send_response();
		}
		
		$error = '';
		$user_data = $this->request->data;

		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required. ';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required. ';
			
		if(!isset($user_data['classroom']) || empty($user_data['classroom']))
			$error .= 'class Room is required. ';
		
		if(empty($error)){
			$this->loadModel('Users'); 
			$userObj = $this->Users->find('all',['conditions' => ['id' => $user_data['user_id'], 'sessionId' => $user_data['sessionId']]])->first();
			
			$this->Users->validator()->remove('password');
			$this->Users->validator()->remove('confirm_password');
			
			if($userObj){
				$user = $this->Users->patchEntity($userObj, $user_data);

				$errors = $user->errors();

				if(!empty($errors)) {
					foreach ($errors as $key => $value) {
						$error .= $value[array_keys($value)[0]].",  ";
					}
				}   
				
				if(!empty($error)) {
				$this->response = array(
						'status' => 400,
						'message' => rtrim($error, ', '),
					);
				}
				else {

					if($this->Users->save($user))
					{
						$user = $user->toArray();
						
						$reponseUser['userdetails']['userId'] 			= $user['id'];
						$reponseUser['userdetails']['classroom'] 		= $user['classroom'];

						$this->response = array(
							'status' => 200,
							'message' => 'Successfully updated.',
							'data' => $reponseUser
						);
					} else
					{
						$this->response = array(
							'status' => 500,
							'message' => 'Student cannot be saved right now. Please try again shortly.',
						);
					}		
				}
				$this->__send_response();
			}
			else{
				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}	
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}

		$this->__send_response();
	}
	
	/**
	 * @name updateUserType
	 * Purpose : This method is used to update user type
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if areas found else returns error
	 */
			
	public function updateUserType(){
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
						
			$this->__send_response();
		}
		
		$error = '';
		$user_data = $this->request->data;

		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required. ';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required. ';
			
		if(!isset($user_data['user_type']) || empty($user_data['user_type']))
			$error .= 'User type is required. ';
		
		if(empty($error)){
			$this->loadModel('Users'); 
			$userObj = $this->Users->find('all',['conditions' => ['id' => $user_data['user_id'], 'sessionId' => $user_data['sessionId']]])->first();
			
			$this->Users->validator()->remove('password');
			$this->Users->validator()->remove('confirm_password');
			
			if($userObj){
				$user = $this->Users->patchEntity($userObj, $user_data);

				$errors = $user->errors();

				if(!empty($errors)) {
					foreach ($errors as $key => $value) {
						$error .= $value[array_keys($value)[0]].",  ";
					}
				}   
				
				if(!empty($error)) {
				$this->response = array(
						'status' => 400,
						'message' => rtrim($error, ', '),
					);
				}
				else {

					if($this->Users->save($user))
					{
						$user = $user->toArray();
						
						
						$reponseUser['userdetails']['userId'] 			= $user['id'];
						if($user['user_type'] == 1)
							$reponseUser['userdetails']['user_type'] 	= 'Primary';
						else	
							$reponseUser['userdetails']['user_type'] 	= 'Elementary';
							

						$this->response = array(
							'status' => 200,
							'message' => 'Successfully updated.',
							'data' => $reponseUser
						);
					} else
					{
						$this->response = array(
							'status' => 500,
							'message' => 'User cannot be saved right now. Please try again.',
						);
					}		
				}
				$this->__send_response();
			}
			else{
				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}	
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}

		$this->__send_response();
	}
		
	/**
	 * @name deletePlan
	 * Purpose : This method is used to delete plans created
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if areas found else returns error
	 */
	 
	public function deletePlan()
    {
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
			$this->__send_response();
		}
		
		$error = '';
		$user_data = $this->request->data;

		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';
		
		if(!isset($user_data['planId']) || empty($user_data['planId']))
			$error .= 'Plan Id is required.';
			
		if(empty($error)){
			$this->loadModel('Users'); 
			$userObj = $this->Users->find('all',['conditions' => ['id' => $user_data['user_id'], 'sessionId' => $user_data['sessionId']]])->first();
			
			if($userObj){
				
				$this->loadModel('UserPlans');
				
				$isUserPlan = $this->UserPlans->findById($user_data['planId'])->first();

				if($isUserPlan)
				{
					$planEntity = $this->UserPlans->get($user_data['planId']);
					if($this->UserPlans->delete($planEntity)){
						$this->response = array(
								'status' => 200,
								'message' => 'Plan deleted successfully',
							);
					}else{
						$this->response = array(
								'status' => 400,
								'message' => 'Unable to delete plan. Please try again.',
							);
					}	
				}
				else
				{
					$this->response = array(
							'status' => 400,
							'message' => 'No plan found.',
						);
				}
				
				$this->__send_response();
			}
			else{
				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}	
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}

		$this->__send_response();
    }
    
    
    /**
	 * @name getStudentHistory 
	 * Purpose : This method is used to get all user data without keywords
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if areas found else returns error
	 */
	 
	public function getStudentHistory(){
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
			$this->__send_response();
		}
		
		$error = '';
		$user_data = $this->request->data;

		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';
		
		if(!isset($user_data['studentId']) || empty($user_data['studentId']))
			$error .= 'Student Id is required.';
		
		if(empty($error)){ 
			
			$chapterRequired = true;
			if(isset($user_data['chapterRequired'])){
				$chapterRequired = true;
			}
			$lessonRequired = true;
			if(isset($user_data['lessonRequired'])){
				$lessonRequired = true;
			}
			$exerciseRequired = true;
			if(isset($user_data['exerciseRequired'])){
				$exerciseRequired = true;
			}
			
			$this->loadModel('Users');
						
			$userObj = $this->Users->find('all', [
						'conditions'=> [
							'id' 				=> $user_data['user_id'], 
							'sessionId' 		=> $user_data['sessionId'],
						]
						])->first();
			
			
			if(!empty($userObj)){
				$user = $userObj->toArray();
				
				$this->loadModel('StudentViews');
				
				$getStudentView = $this->StudentViews->find('all', [
															'conditions'=>[
																'StudentViews.student_id' => $user_data['studentId']
															]])->contain([
																'UserPlans'  => ['joinType' => 'inner'], 
																'UserPlans.Users', 
																'Students', 
																'Areas', 
																'Chapters', 
																'Lessons', 
																'Exercises', 
																'Statuses'
															])->hydrate(false);
				
				
				$getStudentView = $getStudentView->toArray();
				//pr($getStudentView);
				if(!empty($getStudentView)){
					$newView = [];
					foreach($getStudentView as $key=>$value){
						$stuId	= $value['student']['id'];
						$areaId = $value['area']['id'];
						$chpId	= $value['chapter']['id'];
						$lessId = $value['lesson']['id'];
						$exeId	= $value['exercise']['id'];
						
						$studentId	 = $value['student']['id'];

						$s_firstname = $this->getStudentShortName($value['student']['first_name'], 20);
						$s_lastname	 = $this->getStudentShortName($value['student']['last_name'], 1);
						
						$studentName = $s_firstname .' '.$s_lastname;
						
						if(!empty($areaId)){
							$newView[$areaId][] = [
													'AreaId'		=> $value['area']['id'], 
													'AreaObjectId'	=> $value['area']['object_id'], 
													'AreaTitle'		=> $value['area']['title'], 
													'AreaColor'		=> $value['area']['area_color']
												];
						}

						if(!empty($chpId)){
							$newView[$areaId]['Chapter'][$chpId][] = [
																	'ChapterId' 		=> $value['chapter']['id'], 
																	'ChapterObjectId'	=> $value['chapter']['object_id'], 
																	'ChapterTitle'		=> $value['chapter']['title']
																];
						}
						
						if(!empty($lessId)){
								$newView[$areaId]['Chapter'][$chpId]['Lesson'][$lessId][] = [
																	'LessonId' 			=> $value['lesson']['id'], 
																	'LessonObjectId'	=> $value['lesson']['object_id'], 
																	'LessonTitle'		=> $value['lesson']['title'],
																	'LessonStatus'		=> $value['status_id'],
																	'StudentViewId'		=> $value['id'],
																];
							}

						if(!empty($exeId)){
								$newView[$areaId]['Chapter'][$chpId]['Lesson'][$lessId]['Exe'][$exeId][] = [
																'ExerciseId' 		=> $value['exercise']['id'], 
																'ExerciseObjectId'	=> $value['exercise']['object_id'], 
																'ExerciseTitle'		=> $value['exercise']['title'],
																'ExerciseStatus'	=> $value['status_id'],
																'StudentViewId'		=> $value['id'],
															];
							}
					}
				}
				
				//pr($newView);

				$reponseAreas	= [];

				if(isset($newView) && !empty($newView)){
					foreach ($newView as $key => $area) {

						$areaCount = 0;

						$areaCount = $areaCount + 1;
						$reponseAreas['Area'][$key] = [
													'areaColor'	=> $area[0]['AreaColor'],
													'areaName'	=> $area[0]['AreaTitle'],
													'areaId'	=> $area[0]['AreaId'],
													'objectId'	=> $area[0]['AreaObjectId'],
													'areaCount' => $areaCount,
												];

						if(isset($area['Chapter']) && !empty($area['Chapter'])){
							$chapCount = 0;
							foreach($area['Chapter'] as $ch=>$chapter){
								$chapCount = $chapCount + 1;
								$reponseAreas['Area'][$key]['Chapter'][$ch] = [
																		'chatperId'		=> $chapter[0]['ChapterId'],
																		'objectId'		=> $chapter[0]['ChapterObjectId'],
																		'chapterName'	=> $chapter[0]['ChapterTitle'],
																		'chapterCount'	=> $chapCount,
																	];
								//pr($chapter);
								if(isset($chapter['Lesson']) && !empty($chapter['Lesson'])){
									$lessCount = 0;
									foreach($chapter['Lesson'] as $less=>$lesson){
										$lessCount = $lessCount + 1;
										if(isset($lesson[0]['LessonId']) && !empty($lesson[0]['LessonId'])){
												$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$lesson[0]['LessonId']] = [
																	'lessonId'		=> $lesson[0]['LessonId'],
																	'objectId'		=> $lesson[0]['LessonObjectId'],
																	'lessonName'	=> $lesson[0]['LessonTitle'],
																	'lessonStatus'	=> $lesson[0]['LessonStatus'],
																	'lessonCount'	=> $lessCount,
																	'StudentViewId'	=> $lesson[0]['StudentViewId'],
																];
											
											if($lesson[0]['LessonStatus'] == 4){
												$reponseAreas['Area'][$key]['Chapter'][$ch]['presented'][] = $lesson[0]['LessonId'];
											}else{
												$reponseAreas['Area'][$key]['Chapter'][$ch]['working'][] = $lesson[0]['LessonId'];
											}
											
											
											if(isset($lesson['Exe']) && !empty($lesson['Exe'])){
												$exeCount = 0;
												foreach($lesson['Exe'] as $exe=>$exercise){
														$exeCount = $exeCount + 1;
														$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$lesson[0]['LessonId']]['Exercise'][$exe] = [
																	'exerciseId'		=> $exercise[0]['ExerciseId'],
																	'objectId'			=> $exercise[0]['ExerciseObjectId'],
																	'exerciseName'		=> $exercise[0]['ExerciseTitle'],
																	'exerciseStatus'	=> $exercise[0]['ExerciseStatus'],
																	'exerciseCount'		=> $exeCount,
																	'StudentViewId'		=> $exercise[0]['StudentViewId'],
																];

													if($exercise[0]['ExerciseStatus'] == 4){
														$reponseAreas['Area'][$key]['Chapter'][$ch]['presented'][] = $exercise[0]['ExerciseId'];


														$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$lesson[0]['LessonId']]['presented'][] = $exercise[0]['ExerciseId'];
													}else{
														$reponseAreas['Area'][$key]['Chapter'][$ch]['working'][] = $exercise[0]['ExerciseId'];

														$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$lesson[0]['LessonId']]['working'][] = $exercise[0]['ExerciseId'];
													}
												}
											}
										}
									}
								}
							}
						}
					}

					//pr($reponseAreas);
					$area = 0;
					foreach($reponseAreas['Area'] as $key => $final){
						
						$chapter = $final['Chapter'];
						unset($final['Chapter']);
						$fArray['Area'][$area] = $final;

							$chapCount = 0;
							foreach($chapter as $ch=> $chap){
								
								$lessons = $chap['Lesson'];
								unset($chap['Lesson']);
								
								// Calculate % 

								$chapWoking = 0;
								$chapPresent = 0;

								if(isset($chap['working'])){
									$chapWoking = count($chap['working']);
									unset($chap['working']);
								}
								if(isset($chap['presented'])){
									$chapPresent = count($chap['presented']);
									unset($chap['presented']);
								}
								
								$chapTotal = $chapWoking + $chapPresent;

								$chapPersents = $chapPresent * 100 / $chapTotal;
								
								$chap['percentage'] = $chapPersents;
								$chap['areaId'] = $final['areaId'];

								$fArray['Area'][$area]['Chapter'][$chapCount] = $chap;

									$lessCount = 0;	
									foreach($lessons as $ls => $less){
										// Calculate % 
										$lessWoking = 0;
										$lessPresent = 0;
										$lessPersents = 0;

										if(isset($less['working'])){
											$lessWoking = count($less['working']);
											unset($less['working']);
										}
										if(isset($less['presented'])){
											$lessPresent = count($less['presented']);
											unset($less['presented']);
										}
										
										$lessTotal = $lessWoking + $lessPresent;
										
										if($lessTotal >= 1){
											$lessPersents = ($lessPresent * 100) / $lessTotal;
										}
										
										
										$less['percentage'] = $lessPersents; 
										$less['chapterId']	= $chap['chatperId'];
										
										$exeCount = 0;	
										if(isset($less['Exercise'])){
											$exercises = $less['Exercise'];
											unset($less['Exercise']);
											$less['hasExercise'] = TRUE;
											$fArray['Area'][$area]['Chapter'][$chapCount]['Lesson'][$lessCount] = $less;
											foreach($exercises as $e => $exe){
												$exe['lessonId']	= $less['lessonId'];
												$fArray['Area'][$area]['Chapter'][$chapCount]['Lesson'][$lessCount]['Exe'][$exeCount] = $exe;
												$exeCount ++;
											}
										}else{
											$less['hasExercise'] = FALSE;
											$fArray['Area'][$area]['Chapter'][$chapCount]['Lesson'][$lessCount] = $less;
										}
										
										$lessCount ++;
									}
									
								$chapCount ++; 
							}
							
						$area ++;		
					}
				}

				if((isset($reponseAreas['Area']) && !empty($reponseAreas['Area']))){

					$this->response = array(
							'status' 	=> 200,
							'message' 	=> 'Data found',
							'data'		=> $fArray
						 );

				}
				else{
						$this->response = array(
							'status' => 404,
							'message' => 'No record found for this user.',
						);	
				}
			}else{
				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}else{
			$this->response = array(
						'status' => 400,
						'message' => rtrim($error, ', '),
					);
		}
		$this->__send_response();
	}

	public function getStudentShortName($name = null, $char = 2){
		return substr(ucfirst($name), 0, $char);
	}
	
	/**
	 * @name getAllUserData
	 * Purpose : This method is used to get all user data with keywords
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if areas found else returns error
	 */
	 
	public function getAllUserStudentData(){
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
			$this->__send_response();
		}
		
		$error = '';
		$user_data = $this->request->data;

		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required.';
		
		if(!isset($user_data['studentId']) || empty($user_data['studentId']))
			$error .= 'Student id is required.';

		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required.';
		
		if(!isset($user_data['area_type']) || empty($user_data['area_type']))
			$error .= 'Area type is required.';
		
		if(empty($error)){ 
			
			$chapterRequired = true;
			if(isset($user_data['chapterRequired'])){
				$chapterRequired = true;
			}
			$lessonRequired = true;
			if(isset($user_data['lessonRequired'])){
				$lessonRequired = true;
			}
			$exerciseRequired = true;
			if(isset($user_data['exerciseRequired'])){
				$exerciseRequired = true;
			}
			
			$studentId = $user_data['studentId'];

			$this->loadModel('Users');
						
			$userObj = $this->Users->find('all', [
						'conditions'=> [
							'id' 				=> $user_data['user_id'], 
							'sessionId' 		=> $user_data['sessionId'],
						],
						'contain' => [
								'Students' => [
									'joinType' => 'left',
									'queryBuilder' =>
											function ($q) use ($studentId) {
												return $q->where([
													'AND' =>[
														'Students.id' => $studentId
													]
												]);
								}]]
						])->first();
			
			if(!empty($userObj)){
				$user = $userObj->toArray();
				
				if(!empty($user['students']))
				{
					$user_type = $user['user_type']; 

					$userDataObj = $this->Users->find('all', [
							'conditions'=> [
								'id' 				=> $user['id']
							]
							])->contain([
									'Areas' => [
										'joinType' => 'inner',
										'queryBuilder' =>
												function ($q) use ($user_type) {
													return $q->where([
														'AND' =>[
															'Areas.status' => 1,
															'Areas.area_type' => $user_type,
														]
													])->order(['Areas.order_no'=>'ASC']);
									}],
									'Areas.StudentViews' => [
										'joinType' => 'inner',
										'queryBuilder' =>
												function ($q) use ($studentId) {
													return $q->where([
														'AND' =>[
															'StudentViews.student_id' => $studentId
														]
													]);
									}],
									'Areas.StudentViews.Statuses',
									'Areas.Chapters' => [
										'joinType' => 'inner',
										'queryBuilder' =>
												function ($q) use ($user_type) {
													return $q->where([
														'AND' =>[
															'Chapters.status' => 1,
														]
													])->order(['Chapters.order_no'=>'ASC']);
									}],
									'Areas.Chapters.StudentViews' => [
										'joinType' => 'inner',
										'queryBuilder' =>
												function ($q) use ($studentId) {
													return $q->where([
														'AND' =>[
															'StudentViews.student_id' => $studentId
														]
													]);
									}],
									'Areas.Chapters.StudentViews.Statuses',
									'Areas.Chapters.Lessons' => [
										'joinType' => 'inner',
										'queryBuilder' =>
												function ($q) use ($user_type) {
													return $q->where([
														'AND' =>[
															'Lessons.status' => 1,
														]
													])->order(['Lessons.order_no'=>'ASC']);
									}],
									'Areas.Chapters.Lessons.StudentViews' => [
										'joinType' => 'inner',
										'queryBuilder' =>
												function ($q) use ($studentId) {
													return $q->where([
														'AND' =>[
															'StudentViews.student_id' => $studentId
														]
													]);
									}],
									'Areas.Chapters.Lessons.StudentViews.Statuses',
									'Areas.Chapters.Lessons.Exercises' => [
										'joinType' => 'inner',
										'queryBuilder' =>
												function ($q) use ($user_type) {
													return $q->where([
														'AND' =>[
															'Exercises.status' => 1,
														]
													])->order(['Exercises.order_no'=>'ASC']);
									}],
									'Areas.Chapters.Lessons.Exercises.StudentViews' => [
										'joinType' => 'inner',
										'queryBuilder' =>
												function ($q) use ($studentId) {
													return $q->where([
														'AND' =>[
															'StudentViews.student_id' => $studentId
														]
													]);
									}],
									'Areas.Chapters.Lessons.Exercises.StudentViews.Statuses',
							])->first();
					
					$userData 			= $userDataObj->toArray();		
					$userDataList 		= $userData['areas'];
					$defaultDataList 	= $this->getDefaultStudentDataList($user['user_type'], $user_data['sessionId'], $user_data['studentId']);

					$areasData = array();
					$reponseAreas = [];
					if((isset($userData['areas']) && !empty($userData['areas'])) || !empty($defaultDataList)){

						foreach ($userData['areas'] as $key => $area) {

							if($area['area_type'] == 1)
								$area['area_type'] = 'Primary';
							else
								$area['area_type'] = 'Elementry';
							
							$isAreaAssigned = FALSE;
							$studentViewArea = [];
							if(!empty($area['student_views']))
							{
								foreach($area['student_views'] as $studentVarea)
								{
									$studentViewArea[] = [
										'StudentViewId'	=> $studentVarea['id'],
										'statusId'		=> $studentVarea['status_id'],
										'status'		=> $studentVarea['status']['name']
									];
								}
								if(!empty($studentViewArea))
								{
									$isAreaAssigned = TRUE;
								}
							}

							$reponseAreas['Area'][$key] = [
														'areaId'		=> $area['id'],
														'OrderNo'		=> $area['order_no'],
														'objectId'		=> $area['object_id'],
														'userId'		=> $area['user_id'],
														'AreaType'		=> $area['area_type'],
														'areaName'		=> $area['title'],
														'areaColor'		=> $area['area_color'],
														'createdAt'		=> $area['created'],
														'updatedAt'		=> $area['modified'],
														'isAssigned'	=> $isAreaAssigned,
													];
							if(isset($area['chapters']) && !empty($area['chapters'])){
								foreach($area['chapters'] as $ch=>$chapter){
									
									$isChapterAssigned = FALSE;
									$studentViewChp = [];
									if(!empty($chapter['student_views']))
									{
										foreach($chapter['student_views'] as $studentVchp)
										{
											$studentViewChp[] = [
												'StudentViewId'	=> $studentVchp['id'],
												'statusId'		=> $studentVchp['status_id'],
												'status'		=> $studentVchp['status']['name']
											];
										}
										if(!empty($studentViewChp))
										{
											$isChapterAssigned = TRUE;										
										}
									}

									$reponseAreas['Area'][$key]['Chapter'][$ch] = [
																			'chatperId'		=> $chapter['id'],
																			'objectId'		=> $chapter['object_id'],
																			'areaId'		=> $chapter['area_id'],
																			'orderNo'		=> $chapter['order_no'],
																			'chapterName'	=> $chapter['title'],
																			'userId'		=> $chapter['user_id'],
																			'updatedAt'		=> $chapter['modified'],
																			'createdAt'		=> $chapter['created'],
																			'isAssigned'	=> $isChapterAssigned
																		];
									// Calculate percentage
									$percentage			= 0;
									$percentageRefine	= 0;
									$percentageNone		= 0;
									$totalAssigned		= 0;
									$totalPresented		= 0;
									$totalWorking		= 0;
									$totalRefinement	= 0;
									$totalNone			= 0;
									$totalLeft			= 0;

									if(isset($chapter['lessons']) && !empty($chapter['lessons'])){
										
										$reponseAreas['Area'][$key]['Chapter'][$ch]['hasLessons'] = TRUE;
										
										foreach($chapter['lessons'] as $less=>$lesson){
											
											$isLessonAssigned	= FALSE;
											$studentView		= [];
											if(!empty($chapter['student_views']))
											{
												foreach($lesson['student_views'] as $studentV)
												{
													if($studentV['status_for'] == 'lesson')
													{
														$studentView[] = [
															'StudentViewId'	=> $studentV['id'],
															'statusId'		=> $studentV['status_id'],
															'status'		=> $studentV['status']['name'],
															'statusFor'		=> $studentV['status_for'],
														];
													}
												}

												if(!empty($studentView))
												{
													$isLessonAssigned = TRUE;													
												}
											}

											$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less] = [
																			'lessonId'		=> $lesson['id'],
																			'objectId'		=> $lesson['object_id'],
																			'areaId'		=> $lesson['area_id'],
																			'chapterId'		=> $lesson['chapter_id'],
																			'orderNo'		=> $lesson['order_no'],
																			'lessonName'	=> $lesson['title'],
																			'userId'		=> $lesson['user_id'],
																			'createdAt'		=> $lesson['created'],
																			'updatedAt'		=> $lesson['modified'],
																			'isAssigned'	=> $isLessonAssigned,
																			'studentView'	=> $studentView,
																		];
											
											// Calculate percentage Lessons
											
											if($reponseAreas['Area'][$key]['Chapter'][$ch]['hasLessons'])
											{
												$lessonView = isset($reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less]['studentView']) ? $reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less]['studentView'] : '';
												if(!empty($lessonView))
												{
													if($lessonView[0]['statusId'] == 4)
													{
														$totalPresented++;
													}
													elseif($lessonView[0]['statusId'] == 5)
													{
														$totalRefinement++;
													}
													elseif($lessonView[0]['statusId'] == 6)
													{
														$totalPresented++;
													}
													elseif($lessonView[0]['statusId'] == 7)
													{
														$totalNone++;
													}
													elseif($lessonView[0]['statusId'] == 1)
													{
														$totalNone++;
													}
												}
												else
												{
													$totalLeft++;
												}
											}
											
											if(isset($lesson['exercises']) && !empty($lesson['exercises'])){
												
												$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less]['hasExercise'] = TRUE;
												
												foreach($lesson['exercises'] as $exe=>$exercise){
													$isExerciseAssigned = FALSE;
													$studentViewExe		= [];
													if(!empty($chapter['student_views']))
													{
														foreach($exercise['student_views'] as $studentVexe)
														{
															if($studentVexe['status_for'] == 'exercise')
															{
																$studentViewExe[] = [
																	'StudentViewId'	=> $studentVexe['id'],
																	'statusId'		=> $studentVexe['status_id'],
																	'status'		=> $studentVexe['status']['name'],
																	'statusFor'		=> $studentVexe['status_for'],
																];
															}
														}
														if(!empty($studentViewExe))
														{
															$isExerciseAssigned = TRUE;
														}
													}
													$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less]['Exercise'][] = [
																					'exerciseId'	=> $exercise['id'],
																					'objectId'		=> $exercise['object_id'],
																					'areaId'		=> $exercise['area_id'],
																					'chapterId'		=> $exercise['chapter_id'],
																					'lessonId'		=> $exercise['lesson_id'],
																					'orderNo'		=> $exercise['order_no'],
																					'exerciseName'	=> $exercise['title'],
																					'userId'		=> $exercise['user_id'],
																					'createdAt'		=> $exercise['created'],
																					'updatedAt'		=> $exercise['modified'],
																					'isAssigned'	=> $isExerciseAssigned,
																					'studentView'	=> $studentViewExe,
																				];
													if($reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less]['hasExercise'])
													{
														$exeView = isset($reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less]['Exercise'][$exe]['studentView']) ? $reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less]['Exercise'][$exe]['studentView'] : '';
														
														if(!empty($exeView))
														{
															if($exeView[0]['statusId'] == 4)
															{
																$totalPresented++;
															}
															elseif($exeView[0]['statusId'] == 5)
															{
																$totalRefinement++;
															}
															elseif($exeView[0]['statusId'] == 6)
															{
																$totalPresented++;
															}
															elseif($exeView[0]['statusId'] == 7)
															{
																$totalNone++;
															}
															elseif($exeView[0]['statusId'] == 1)
															{
																$totalNone++;
															}
														}
														else
														{
															$totalLeft++;
														}
													}
																				
												}
											}else{
												$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less]['hasExercise'] = FALSE;
											}
											
											$totalAssigned = $totalPresented + $totalRefinement + $totalNone + $totalLeft; 
											
											if($totalAssigned > 0)
											{
												$percentage			= $this->convertDecimal(($totalPresented * 100 / $totalAssigned), 2);
												$percentageRefine	= $this->convertDecimal(($totalRefinement * 100 / $totalAssigned), 2);
												$percentageNone		= $this->convertDecimal(($totalNone * 100 / $totalAssigned), 2);
											}

											$reponseAreas['Area'][$key]['Chapter'][$ch]['percentage']			= $percentage;
											$reponseAreas['Area'][$key]['Chapter'][$ch]['percentageRefine']		= $percentageRefine;
											$reponseAreas['Area'][$key]['Chapter'][$ch]['percentageNone']		= $percentageNone;
											$reponseAreas['Area'][$key]['Chapter'][$ch]['totalRecords']			= $totalAssigned;
											$reponseAreas['Area'][$key]['Chapter'][$ch]['totalPresented']		= $totalPresented;
											$reponseAreas['Area'][$key]['Chapter'][$ch]['totalRefinement']		= $totalRefinement;
											$reponseAreas['Area'][$key]['Chapter'][$ch]['totalNone']			= $totalNone;
										}
									}else{
										$reponseAreas['Area'][$key]['Chapter'][$ch]['hasLessons'] = FALSE;
									}
								}
							}
						}

						if(!empty($reponseAreas)){
							$mergeData = array_merge_recursive($defaultDataList, $reponseAreas);
						}else{
							$mergeData = $defaultDataList;
						}
						
						$finalOutput = [];
						$mergeData['Area'] = array_values($mergeData['Area']);
						foreach($mergeData['Area'] as $a=>$aChap)
						{
							if(isset($aChap['Chapter']))
							{
								$chatDatas = $aChap['Chapter'];
								unset($aChap['Chapter']);
								$finalOutput['Area'][$a] = $aChap;
								$chatData = array_values($chatDatas);

								foreach($chatData as $c=>$cLess)
								{
									if($cLess['hasLessons'] == 1 || $cLess['hasLessons'] == true)
									{
										$lessonData = $cLess['Lesson'];
										unset($cLess['Lesson']);
										$finalOutput['Area'][$a]['Chapter'][$c] = $cLess;
										
										$lessonData = array_values($lessonData);
										foreach($lessonData as $l => $lExe)
										{
											if($lExe['hasExercise'] == 1)
											{
												$exeData = $lExe['Exercise'];
												unset($lExe['Exercise']);
												$finalOutput['Area'][$a]['Chapter'][$c]['Lesson'][$l] = $lExe;

												foreach($exeData as $e => $exe)
												{
													$finalOutput['Area'][$a]['Chapter'][$c]['Lesson'][$l]['Exercise'][] = $exe;
												}	
											}
											else
											{
												$finalOutput['Area'][$a]['Chapter'][$c]['Lesson'][$l] = $lExe;
											}
										}
									}
									else
									{
										$finalOutput['Area'][$a]['Chapter'][$c] = $cLess;
									}
								}
							}
							else
							{
								$finalOutput['Area'][$a] = $aChap;
								$chatData = array_values($chatDatas);
							}
						}
						//pr($finalOutput);
						$json = json_encode($finalOutput);
						
						$fileName = 'db2.txt';
						$filePath = $this->webroot.'uploads/user'. DS .$user_data['user_id']. DS .'student'.DS. $user_data['studentId'] . DS;

						if (!file_exists($filePath)) {
							umask(0000);
							mkdir($filePath, 0777, true);
						}
						
						$targetFile = $filePath.$fileName;

						$fileParts = pathinfo($fileName);


						$fp = fopen($targetFile, 'w+');
						fwrite($fp, $json);
						fclose($fp);
						
						$url = Router::url('/' . 'uploads/user'. DS .$user_data['user_id']. DS .'student'.DS. $user_data['studentId'] . DS. 'db2.txt', true);
						
						$this->response = array(
								'status' 	=> 200,
								'message' 	=> 'Data found',
								'value' 	=> $url,
								'data'		=> $finalOutput
							 );

					}
					else{
							$this->response = array(
								'status' => 404,
								'message' => 'Areas not found for this user.',
							);	
					}
				}
				else
				{
					$this->response = array(
								'status' => 404,
								'message' => 'Invalid student.',
							);	
				}
			}else{
				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}else{
			$this->response = array(
						'status' => 400,
						'message' => rtrim($error, ', '),
					);
		}
		$this->__send_response();
	}

	public function getDefaultStudentDataList($user_type = null, $sessionId = null, $studentId = null){
		
		$reponseAreas = [];
		$chapterRequired = true;
		if(isset($user_data['chapterRequired'])){
			$chapterRequired = true;
		}
		$lessonRequired = true;
		if(isset($user_data['lessonRequired'])){
			$lessonRequired = true;
		}
		$exerciseRequired = true;
		if(isset($user_data['exerciseRequired'])){
			$exerciseRequired = true;
		}
		
		$this->autoRender = false;
		
		$this->loadModel('Users');
		
		$authId = $this->getAuthUser($sessionId);

		$userDataObj = $this->Users->find('all', [
						'conditions'=> [
							'id' 				=> 1
						]
						])->contain([
								'Areas' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($user_type) {
												return $q->where([
													'AND' =>[
														'Areas.status' => 1,
														'Areas.area_type' => $user_type,
													]
												])->order(['Areas.order_no'=>'ASC']);
								}],
								'Areas.StudentViews' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($studentId) {
												return $q->where([
													'AND' =>[
														'StudentViews.student_id' => $studentId
													]
												]);
								}],
								'Areas.StudentViews.Statuses',
								'Areas.UserAreas' => [
									'joinType' => 'inner',
									'queryBuilder' =>
										function ($q) use ($authId) {
											return $q
											->where([
												'UserAreas.user_id' => $authId,
											]);
								}],
								'Areas.Chapters' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($user_type) {
												return $q->where([
														'AND' =>[
															'Chapters.status' => 1,
														]
													])->order(['Chapters.order_no'=>'ASC']);
								}],
								'Areas.Chapters.StudentViews' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($studentId) {
												return $q->where([
													'AND' =>[
														'StudentViews.student_id' => $studentId
													]
												]);
								}],
								'Areas.Chapters.StudentViews.Statuses',
								'Areas.Chapters.UserChapters' => [
									'joinType' => 'inner',
									'queryBuilder' =>
										function ($q) use ($authId) {
											return $q
											->where([
												'UserChapters.user_id' => $authId,
											]);
								}],
								'Areas.Chapters.Lessons' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($user_type) {
												return $q->where([
														'AND' =>[
															'Lessons.status' => 1,
														]
													])->order(['Lessons.order_no'=>'ASC']);
								}],
								'Areas.Chapters.Lessons.StudentViews' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($studentId) {
												return $q->where([
													'AND' =>[
														'StudentViews.student_id' => $studentId
													]
												]);
								}],
								'Areas.Chapters.Lessons.StudentViews.Statuses',
								'Areas.Chapters.Lessons.UserLessons' => [
									'joinType' => 'inner',
									'queryBuilder' =>
										function ($q) use ($authId) {
											return $q
											->where([
												'UserLessons.user_id' => $authId,
											]);
								}],
								'Areas.Chapters.Lessons.Exercises' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($user_type) {
												return $q->where([
														'AND' =>[
															'Exercises.status' => 1,
														]
													])->order(['Exercises.order_no'=>'ASC']);
								}],
								'Areas.Chapters.Lessons.Exercises.StudentViews' => [
									'joinType' => 'inner',
									'queryBuilder' =>
											function ($q) use ($studentId) {
												return $q->where([
													'AND' =>[
														'StudentViews.student_id' => $studentId
													]
												]);
								}],
								'Areas.Chapters.Lessons.Exercises.StudentViews.Statuses',
								'Areas.Chapters.Lessons.Exercises.UserExercises' => [
									'joinType' => 'inner',
									'queryBuilder' =>
										function ($q) use ($authId) {
											return $q
											->where([
												'UserExercises.user_id' => $authId,
											]);
								}]
						])->first();
				
		$user		= $userDataObj->toArray();

		$areasData = array();

		if(isset($user['areas']) && !empty($user['areas'])){

			foreach ($user['areas'] as $key => $area) {

				if($area['area_type'] == 1)
					$area['area_type'] = 'Primary';
				else
					$area['area_type'] = 'Elementry';
				
				$isAreaAssigned = FALSE;
				$studentViewArea = [];
				if(!empty($area['student_views']))
				{
					$isAreaAssigned = TRUE;
					foreach($area['student_views'] as $studentVarea)
					{
						$studentViewArea[] = [
							'StudentViewId'	=> $studentVarea['id'],
							'statusId'		=> $studentVarea['status_id'],
							'status'		=> $studentVarea['status']['name']
						];
					}
				}
							
				if(!empty($area['user_areas']))
				{
					if($area['user_areas'][0]['action'] == "edit")
					{
						$area['title']		= $area['user_areas'][0]['title'];
						$area['area_color'] = $area['user_areas'][0]['area_color'];

						$reponseAreas['Area'][$key] = [
											'areaId'		=> $area['id'],
											'OrderNo'		=> $area['order_no'],
											'objectId'		=> $area['object_id'],
											'userId'		=> $area['user_id'],
											'AreaType'		=> $area['area_type'],
											'areaName'		=> $area['title'],
											'areaColor'		=> $area['area_color'],
											'createdAt'		=> $area['created'],
											'updatedAt'		=> $area['modified'],
											'isAssigned'	=> $isAreaAssigned,
										];
					}
					elseif($area['user_areas'][0]['action'] == "delete")
					{
						unset($area);
					}
				}
				else
				{
					$reponseAreas['Area'][$key] = [
											'areaId'		=> $area['id'],
											'OrderNo'		=> $area['order_no'],
											'objectId'		=> $area['object_id'],
											'userId'		=> $area['user_id'],
											'AreaType'		=> $area['area_type'],
											'areaName'		=> $area['title'],
											'areaColor'		=> $area['area_color'],
											'createdAt'		=> $area['created'],
											'updatedAt'		=> $area['modified'],
											'isAssigned'	=> $isAreaAssigned,
										];
				}
				
				if(isset($area['chapters']) && !empty($area['chapters'])){
					foreach($area['chapters'] as $ch=>$chapter){
						
						$isChapterAssigned = FALSE;
						$studentViewChp		= [];
						if(!empty($chapter['student_views']))
						{
							foreach($chapter['student_views'] as $studentVchp)
							{
								$studentViewChp[] = [
									'StudentViewId'	=> $studentVchp['id'],
									'statusId'		=> $studentVchp['status_id'],
									'status'		=> $studentVchp['status']['name'],
								];
							}
							if(!empty($studentViewChp))
							{
								$isChapterAssigned	= TRUE;
							}
						}

						if(!empty($chapter['user_chapters']))
						{
							if($chapter['user_chapters'][0]['action'] == "edit")
							{
								$chapter['title'] = $chapter['user_chapters'][0]['title'];
								
								$reponseAreas['Area'][$key]['Chapter'][$ch] = [
																'chatperId'		=> $chapter['id'],
																'objectId'		=> $chapter['object_id'],
																'areaId'		=> $chapter['area_id'],
																'orderNo'		=> $chapter['order_no'],
																'chapterName'	=> $chapter['title'],
																'userId'		=> $chapter['user_id'],
																'updatedAt'		=> $chapter['modified'],
																'createdAt'		=> $chapter['created'],
																'isAssigned'	=> $isChapterAssigned,
															];
							}
							elseif($chapter['user_chapters'][0]['action'] == "delete")
							{
								unset($chapter);
							}
						}
						else
						{
							$reponseAreas['Area'][$key]['Chapter'][$ch] = [
																'chatperId'		=> $chapter['id'],
																'objectId'		=> $chapter['object_id'],
																'areaId'		=> $chapter['area_id'],
																'orderNo'		=> $chapter['order_no'],
																'chapterName'	=> $chapter['title'],
																'userId'		=> $chapter['user_id'],
																'updatedAt'		=> $chapter['modified'],
																'createdAt'		=> $chapter['created'],
																'isAssigned'	=> $isChapterAssigned,
															];
						}
						
						// Calculate percentage
						$percentage			= 0;
						$percentageRefine	= 0;
						$percentageNone		= 0;
						$totalAssigned		= 0;
						$totalPresented		= 0;
						$totalRefinement	= 0;
						$totalNone			= 0;
						$totalLeft			= 0;

						if(isset($chapter['lessons']) && !empty($chapter['lessons'])){
							
							$reponseAreas['Area'][$key]['Chapter'][$ch]['hasLessons'] = TRUE;
							
							foreach($chapter['lessons'] as $less=>$lesson){
								
								$studentView		= [];
								$isLessonAssigned	= FALSE;
								if(!empty($lesson['student_views']))
								{
									foreach($lesson['student_views'] as $studentV)
									{
										
										if($studentV['status_for'] == 'lesson')
										{
											$studentView[] = [
												'StudentViewId'	=> $studentV['id'],
												'statusId'		=> $studentV['status_id'],
												'status'		=> $studentV['status']['name'],
												'statusFor'		=> $studentV['status_for'],
											];
										}
									}

									if(!empty($studentView))
									{
										$isLessonAssigned = TRUE;
									}
								}

								if(!empty($lesson['user_lessons']))
								{
									$lesson['title'] = $lesson['user_lessons'][0]['title'];

									if($lesson['user_lessons'][0]['action'] == "edit")
									{
										$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less] = [
																'lessonId'		=> $lesson['id'],
																'objectId'		=> $lesson['object_id'],
																'areaId'		=> $lesson['area_id'],
																'chapterId'		=> $lesson['chapter_id'],
																'orderNo'		=> $lesson['order_no'],
																'lessonName'	=> $lesson['title'],
																'userId'		=> $lesson['user_id'],
																'createdAt'		=> $lesson['created'],
																'updatedAt'		=> $lesson['modified'],
																'isAssigned'	=> $isLessonAssigned,
																'studentView'	=> $studentView,
															];
									}
									elseif($lesson['user_lessons'][0]['action'] == "delete")
									{
										unset($lesson);
									}
								}
								else
								{
									$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less] = [
																'lessonId'		=> $lesson['id'],
																'objectId'		=> $lesson['object_id'],
																'areaId'		=> $lesson['area_id'],
																'chapterId'		=> $lesson['chapter_id'],
																'orderNo'		=> $lesson['order_no'],
																'lessonName'	=> $lesson['title'],
																'userId'		=> $lesson['user_id'],
																'createdAt'		=> $lesson['created'],
																'updatedAt'		=> $lesson['modified'],
																'isAssigned'	=> $isLessonAssigned,
																'studentView'	=> $studentView,
															];
								}

								if($reponseAreas['Area'][$key]['Chapter'][$ch]['hasLessons'])
								{

									$lessonView = isset($reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less]['studentView']) ? $reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less]['studentView'] : '';
												
									if(!empty($lessonView))
									{
										if($lessonView[0]['statusId'] == 4)
										{
											$totalPresented++;
										}
										elseif($lessonView[0]['statusId'] == 5)
										{
											$totalRefinement++;
										}
										elseif($lessonView[0]['statusId'] == 6)
										{
											$totalPresented++;
										}
										elseif($lessonView[0]['statusId'] == 7)
										{
											$totalNone++;
										}
										elseif($lessonView[0]['statusId'] == 1)
										{
											$totalNone++;
										}
									}
									else
									{
										$totalLeft++;
									}
								}
															
								if(isset($lesson['exercises']) && !empty($lesson['exercises'])){
									$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less]['hasExercise'] = TRUE;
									
									foreach($lesson['exercises'] as $exe=>$exercise){
										
										$isExerciseAssigned = FALSE;
										$studentViewExe		= [];
										if(!empty($exercise['student_views']))
										{
											foreach($exercise['student_views'] as $studentVexe)
											{
												if($studentVexe['status_for'] == 'exercise')
												{
													$studentViewExe[] = [
														'StudentViewId'	=> $studentVexe['id'],
														'statusId'		=> $studentVexe['status_id'],
														'status'		=> $studentVexe['status']['name'],
														'statusFor'		=> $studentVexe['status_for'],
													];
												}
											}
											if(!empty($studentViewExe))
											{
												$isExerciseAssigned = TRUE;
											}
										}

										if(!empty($exercise['user_exercises']))
										{
											$exercise['title'] = $exercise['user_exercises'][0]['title'];
											if($exercise['user_exercises'][0]['action'] == "edit")
											{
												$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less]['Exercise'][$exe] = [
																		'exerciseId'	=> $exercise['id'],
																		'objectId'		=> $exercise['object_id'],
																		'areaId'		=> $exercise['area_id'],
																		'chapterId'		=> $exercise['chapter_id'],
																		'lessonId'		=> $exercise['lesson_id'],
																		'orderNo'		=> $exercise['order_no'],
																		'exerciseName'	=> $exercise['title'],
																		'userId'		=> $exercise['user_id'],
																		'createdAt'		=> $exercise['created'],
																		'updatedAt'		=> $exercise['modified'],
																		'isAssigned'	=> $isExerciseAssigned,
																		'studentView'	=> $studentViewExe,
																	];
											}
											elseif($exercise['user_exercises'][0]['action'] == "delete")
											{
												unset($exercise);
											}
										}
										else
										{
											$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less]['Exercise'][$exe] = [
																		'exerciseId'	=> $exercise['id'],
																		'objectId'		=> $exercise['object_id'],
																		'areaId'		=> $exercise['area_id'],
																		'chapterId'		=> $exercise['chapter_id'],
																		'lessonId'		=> $exercise['lesson_id'],
																		'orderNo'		=> $exercise['order_no'],
																		'exerciseName'	=> $exercise['title'],
																		'userId'		=> $exercise['user_id'],
																		'createdAt'		=> $exercise['created'],
																		'updatedAt'		=> $exercise['modified'],
																		'isAssigned'	=> $isExerciseAssigned,
																		'studentView'	=> $studentViewExe,
																	];
										}

										if($reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less]['hasExercise'])
										{
											$exeView = isset($reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less]['Exercise'][$exe]['studentView']) ? $reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less]['Exercise'][$exe]['studentView'] : '';
												
											if(!empty($exeView))
											{
												if($exeView[0]['statusId'] == 4)
												{
													$totalPresented++;
												}
												elseif($exeView[0]['statusId'] == 5)
												{
													$totalRefinement++;
												}
												elseif($exeView[0]['statusId'] == 6)
												{
													$totalPresented++;
												}
												elseif($exeView[0]['statusId'] == 7)
												{
													$totalNone++;
												}
												elseif($exeView[0]['statusId'] == 1)
												{
													$totalNone++;
												}
											}
											else
											{
												$totalLeft++;
											}
										}
									}

								}else{
									$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$less]['hasExercise'] = FALSE;
								}

								$totalAssigned = $totalPresented + $totalRefinement + $totalNone + $totalLeft; 
								
								if($totalAssigned > 0)
								{
									$percentage			= $this->convertDecimal(($totalPresented * 100 / $totalAssigned), 2);
									$percentageRefine	= $this->convertDecimal(($totalRefinement * 100 / $totalAssigned), 2);
									$percentageNone		= $this->convertDecimal(($totalNone * 100 / $totalAssigned), 2);
								}

								$reponseAreas['Area'][$key]['Chapter'][$ch]['percentage']			= $percentage;
								$reponseAreas['Area'][$key]['Chapter'][$ch]['percentageRefine']		= $percentageRefine;
								$reponseAreas['Area'][$key]['Chapter'][$ch]['percentageNone']		= $percentageNone;
								$reponseAreas['Area'][$key]['Chapter'][$ch]['totalRecords']			= $totalAssigned;
								$reponseAreas['Area'][$key]['Chapter'][$ch]['totalPresented']		= $totalPresented;
								$reponseAreas['Area'][$key]['Chapter'][$ch]['totalRefinement']		= $totalRefinement;
								$reponseAreas['Area'][$key]['Chapter'][$ch]['totalNone']			= $totalNone;
							}
						}else{
							if(isset($chapter))
							{
								$reponseAreas['Area'][$key]['Chapter'][$ch]['hasLessons'] = FALSE;
							}
						}
					}
				}
			}
			
			return $reponseAreas;
			
		}else{
			return true;
		}
	}
	
	public function convertDecimal($number = null, $upto = 2)
	{
		return number_format($number, $upto, '.', '');
	}

	public function getStudentView($getStudentView = null){
		$this->autoRender = false;
		if(empty($getStudentView)){
			return true;
		}
		$getStudentView = [$getStudentView];
		//pr($getStudentView);
		if(!empty($getStudentView)){
			$newView = [];
			foreach($getStudentView as $key=>$value){
				
				$stuId	= $value['student_id'];
				$areaId = $value['area']['id'];
				$chpId	= $value['chapter']['id'];
				$lessId = $value['lesson']['id'];
				$exeId	= $value['exercise']['id'];
				
				$studentId	 = $value['student']['id'];

				$s_firstname = $this->getStudentShortName($value['student']['first_name'], 20);
				$s_lastname	 = $this->getStudentShortName($value['student']['last_name'], 1);
				
				$studentName = $s_firstname .' '.$s_lastname;
				
				if(!empty($areaId)){
					$newView[$areaId][] = [
											'AreaId'		=> $value['area']['id'], 
											'AreaObjectId'	=> $value['area']['object_id'], 
											'AreaTitle'		=> $value['area']['title'], 
											'AreaColor'		=> $value['area']['area_color']
										];
				}

				if(!empty($chpId)){
					$newView[$areaId]['Chapter'][$chpId][] = [
															'ChapterId' 		=> $value['chapter']['id'], 
															'ChapterObjectId'	=> $value['chapter']['object_id'], 
															'ChapterTitle'		=> $value['chapter']['title']
														];
				}
				
				if(!empty($lessId)){
						$newView[$areaId]['Chapter'][$chpId]['Lesson'][$lessId][] = [
															'LessonId' 			=> $value['lesson']['id'], 
															'LessonObjectId'	=> $value['lesson']['object_id'], 
															'LessonTitle'		=> $value['lesson']['title'],
															'LessonStatus'		=> $value['status_id'],
															'StudentViewId'		=> $value['id'],
														];
					}

				if(!empty($exeId)){
						$newView[$areaId]['Chapter'][$chpId]['Lesson'][$lessId]['Exe'][$exeId][] = [
														'ExerciseId' 		=> $value['exercise']['id'], 
														'ExerciseObjectId'	=> $value['exercise']['object_id'], 
														'ExerciseTitle'		=> $value['exercise']['title'],
														'ExerciseStatus'	=> $value['status_id'],
														'StudentViewId'		=> $value['id'],
													];
					}
			}
		}
		
		//pr($newView);

		$reponseAreas	= [];

		if(isset($newView) && !empty($newView)){
			foreach ($newView as $key => $area) {

				$areaCount = 0;

				$areaCount = $areaCount + 1;
				$reponseAreas['Area'][$key] = [
											'areaColor'	=> $area[0]['AreaColor'],
											'areaName'	=> $area[0]['AreaTitle'],
											'areaId'	=> $area[0]['AreaId'],
											'objectId'	=> $area[0]['AreaObjectId'],
											'areaCount' => $areaCount,
										];

				if(isset($area['Chapter']) && !empty($area['Chapter'])){
					$chapCount = 0;
					foreach($area['Chapter'] as $ch=>$chapter){
						$chapCount = $chapCount + 1;
						$reponseAreas['Area'][$key]['Chapter'][$ch] = [
																'chatperId'		=> $chapter[0]['ChapterId'],
																'objectId'		=> $chapter[0]['ChapterObjectId'],
																'chapterName'	=> $chapter[0]['ChapterTitle'],
																'chapterCount'	=> $chapCount,
															];
						//pr($chapter);
						if(isset($chapter['Lesson']) && !empty($chapter['Lesson'])){
							$lessCount = 0;
							foreach($chapter['Lesson'] as $less=>$lesson){
								$lessCount = $lessCount + 1;
								if(isset($lesson[0]['LessonId']) && !empty($lesson[0]['LessonId'])){
										$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$lesson[0]['LessonId']] = [
															'lessonId'		=> $lesson[0]['LessonId'],
															'objectId'		=> $lesson[0]['LessonObjectId'],
															'lessonName'	=> $lesson[0]['LessonTitle'],
															'lessonStatus'	=> $lesson[0]['LessonStatus'],
															'lessonCount'	=> $lessCount,
															'StudentViewId'	=> $lesson[0]['StudentViewId'],
														];
									
									if($lesson[0]['LessonStatus'] == 4){
										$reponseAreas['Area'][$key]['Chapter'][$ch]['presented'][] = $lesson[0]['LessonId'];
									}else{
										$reponseAreas['Area'][$key]['Chapter'][$ch]['working'][] = $lesson[0]['LessonId'];
									}
									
									
									if(isset($lesson['Exe']) && !empty($lesson['Exe'])){
										$exeCount = 0;
										foreach($lesson['Exe'] as $exe=>$exercise){
												$exeCount = $exeCount + 1;
												$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$lesson[0]['LessonId']]['Exercise'][$exe] = [
															'exerciseId'		=> $exercise[0]['ExerciseId'],
															'objectId'			=> $exercise[0]['ExerciseObjectId'],
															'exerciseName'		=> $exercise[0]['ExerciseTitle'],
															'exerciseStatus'	=> $exercise[0]['ExerciseStatus'],
															'exerciseCount'		=> $exeCount,
															'StudentViewId'		=> $exercise[0]['StudentViewId'],
														];

											if($exercise[0]['ExerciseStatus'] == 4){
												$reponseAreas['Area'][$key]['Chapter'][$ch]['presented'][] = $exercise[0]['ExerciseId'];


												$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$lesson[0]['LessonId']]['presented'][] = $exercise[0]['ExerciseId'];
											}else{
												$reponseAreas['Area'][$key]['Chapter'][$ch]['working'][] = $exercise[0]['ExerciseId'];

												$reponseAreas['Area'][$key]['Chapter'][$ch]['Lesson'][$lesson[0]['LessonId']]['working'][] = $exercise[0]['ExerciseId'];
											}
										}
									}
								}
							}
						}
					}
				}
			}

			//pr($reponseAreas);
			$area = 0;
			foreach($reponseAreas['Area'] as $key => $final){
				
				$chapter = $final['Chapter'];
				unset($final['Chapter']);
				$fArray['Area'][$area] = $final;

					$chapCount = 0;
					foreach($chapter as $ch=> $chap){
						
						$lessons = $chap['Lesson'];
						unset($chap['Lesson']);
						
						// Calculate % 

						$chapWoking = 0;
						$chapPresent = 0;

						if(isset($chap['working'])){
							$chapWoking = count($chap['working']);
							unset($chap['working']);
						}
						if(isset($chap['presented'])){
							$chapPresent = count($chap['presented']);
							unset($chap['presented']);
						}
						
						$chapTotal = $chapWoking + $chapPresent;

						$chapPersents = $chapPresent * 100 / $chapTotal;
						
						$chap['percentage'] = $chapPersents;
						$chap['areaId'] = $final['areaId'];

						$fArray['Area'][$area]['Chapter'][$chapCount] = $chap;

							$lessCount = 0;	
							foreach($lessons as $ls => $less){
								// Calculate % 
								$lessWoking = 0;
								$lessPresent = 0;
								$lessPersents = 0;

								if(isset($less['working'])){
									$lessWoking = count($less['working']);
									unset($less['working']);
								}
								if(isset($less['presented'])){
									$lessPresent = count($less['presented']);
									unset($less['presented']);
								}
								
								$lessTotal = $lessWoking + $lessPresent;
								
								if($lessTotal >= 1){
									$lessPersents = ($lessPresent * 100) / $lessTotal;
								}
								
								
								$less['percentage'] = $lessPersents; 
								$less['chapterId']	= $chap['chatperId'];
								
								$exeCount = 0;	
								if(isset($less['Exercise'])){
									$exercises = $less['Exercise'];
									unset($less['Exercise']);
									$less['hasExercise'] = TRUE;
									$fArray['Area'][$area]['Chapter'][$chapCount]['Lesson'][$lessCount] = $less;
									foreach($exercises as $e => $exe){
										$exe['lessonId']	= $less['lessonId'];
										$fArray['Area'][$area]['Chapter'][$chapCount]['Lesson'][$lessCount]['Exe'][$exeCount] = $exe;
										$exeCount ++;
									}
								}else{
									$less['hasExercise'] = FALSE;
									$fArray['Area'][$area]['Chapter'][$chapCount]['Lesson'][$lessCount] = $less;
								}
								
								$lessCount ++;
							}
							
						$chapCount ++; 
					}
					
				$area ++;		
			}

			return $fArray;
		}
	}

	public function paymentSuccess()
	{
		header('Content-Type: application/json');
		if(!$this->request->is('POST'))
		{
			$this->response = array(
							'status' => 400,
							'message' => 'Method not allowed',
						);
						
			$this->__send_response();
		}
		
		$error = '';
		$user_data = $this->request->data;

		if(!isset($user_data['user_id']) || empty($user_data['user_id']))
			$error .= 'User id is required. ';
		
		if(!isset($user_data['sessionId']) || empty($user_data['sessionId']))
			$error .= 'Session Id is required. ';
			
		if(!isset($user_data['txn_id']) || empty($user_data['txn_id']))
			$error .= 'txn_id is required. ';

		if(!isset($user_data['product_id']) || empty($user_data['product_id']))
			$error .= 'product_id is required. ';

		if(!isset($user_data['payment_status']) || empty($user_data['payment_status']))
			$error .= 'payment_status is required. ';

		if(!isset($user_data['platform']) || empty($user_data['platform']))
			$error .= 'platform is required. ';


		if(empty($error)){ 

			$this->loadModel('Users');
			
			$userObj = $this->Users->find('all',[
									'conditions' => [
										'Users.id'	=> $user_data['user_id'],
										'sessionId' => $user_data['sessionId']
									],
									'contain'	=> ['Products', 'UserProducts.Products']
									])->first();

			if($userObj)
			{
				
				$this->loadModel('Products');

				$productObj = $this->Products->findById($user_data['product_id'])->first()->toArray();


				$paymentData = [
					'user_id'			=> $user_data['user_id'],
					'txn_id'			=> $user_data['txn_id'],	
					'product_id'		=> $user_data['product_id'],
					'payment_gross'		=> $productObj['price'],
					'currency_code'		=> $productObj['currency_code'],
					'payment_status'	=> $user_data['payment_status'],
					'payment_data'		=> base64_encode(serialize($user_data)),
				];

				$this->loadModel('Payments');
				$paymentObj = $this->Payments->newEntity($paymentData);
				
				//ALTER TABLE  `payments` ADD  `platform` VARCHAR( 50 ) NULL AFTER  `payment_data` ;

				/*
				$ifPayment = $this->Payments->find('all', [
						'conditions' => [
							'Payments.user_id'		=> $userObj['id'], 
							'Payments.product_id'	=> $userObj['user_product']['product_id']
						]])->first();

				
				if(!empty($ifPayment))
				{
					$ifPayment			= $ifPayment->toArray();
					$paymentData['id']	= $ifPayment['id'];
					$paymentObj			= $this->Payments->patchEntity($paymentObj, $paymentData);
				}
				*/
				
				$paymentObj	= $this->Payments->patchEntity($paymentObj, $paymentData);

				if($paymentSaved = $this->Payments->save($paymentObj))
				{
					$userObjData = $this->Users->get($userObj['id']);
					$userObjData->is_trial		= 0;
					$userObjData->is_paid		= 1;
					$userObjData->product_id	= $user_data['product_id'];
					$this->Users->save($userObjData);
					
					$user_data['payment_status'] = ($user_data['payment_status'] == 1) ? "Success" : 'Failed';
					
					$template	= "payment-success";
					$token		= array('{{name}}','{{txn_id}}','{{product_name}}','{{payment_status}}');
					$token_value = array($userObj['first_name'] . " " . $userObj['last_name'], $user_data['txn_id'], $productObj['title'], $user_data['payment_status']);

          			$this->loadComponent('Common');
					$this->Common->_send_email($userObj['email'], $token, $token_value, $template, '');


					$this->response = array(
							'status' => 200,
							'message' => 'Payment status updated successfully.',
						);
					$this->__send_response();
				}
				else
				{	
					$this->response = array(
							'status' => 400,
							'message' => 'Unable to update payment status, try again later.',
						);
				}
			}
			else{

				$this->response = array(
							'status' => 500,
							'message' => 'Your session expired. Please try again.',
						);
			}
		}
		else{
			$this->response = array(
							'status' => 400,
							'message' => rtrim($error, ', '),
						);
		}

		$this->__send_response();
	}
}
?>
