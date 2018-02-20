<?php
namespace App\Controller;

use App\Controller\AppController;
use Cake\Event\Event;
use Cake\Network\Exception\NotFoundException;
use Cake\Routing\Router;
use Cake\Core\Configure;
use Cake\Database\Expression\QueryExpression;

/**
 * Users Controller
 *
 * @property \App\Model\Table\UsersTable $Users
 */
class UsersController extends AppController
{

	public function beforeFilter(Event $event)
	{
		parent::beforeFilter($event);
		$this->viewBuilder()->layout('frontend');
		$this->Auth->allow(['verifyUser', 'resetPassword']);
	}

	public function verifyUser()
	{
		$message = array('status' => false, 'message' => 'Unknown Error');
		if(isset($this->request->params['pass'][0]) && isset($this->request->params['pass'][1]))
		{
			$email = $this->request->params['pass'][0];
			$verification_token = $this->request->params['pass'][1];
			$user = $this->Users->find('all', array(
				'conditions' => array('Users.email' => $email, 'Users.verification_token' => $verification_token), 'recursive' => -1
			))->first();
			if(!empty($user))
			{
				$this->Users->updateAll(
					array('status_id' => 1, 'is_verified' => 1),
					array('id' => $user->id)
				);
				$message = array('status' => true, 'message' => 'User has been verified. You can now login via app.');
			} else
			{
				$message = array('status' => false, 'message' => 'Request is invalid.');
			}
		} else
		{
			$message = array('status' => false, 'message' => 'Request is invalid.');
		}
		$this->set(compact('message'));
	}
	
	
	/**
	 * @name forgot_password
	 * Purpose : This method is used to reset the password 
	 * @author Bharat Borana
	 * @access public
	 * @return returns true if password sent else returns error
	 */
	public function resetPassword()
	{
		header('Content-Type: application/json');
		$this->loadModel('Users');
		$this->Users->validator()->remove('password', 'compare');
		$id = $this->request->query('id');
		$new_token = $this->request->query('token');
 		$user_data = $this->Users->find('all', ['conditions' => ['Users.id' => $id]])->first();
		$forgot_token = sha1(md5($user_data->password));
		$message = array('status' => false, 'message' => 'Unknown Error');
		if($user_data && $forgot_token == $new_token)
		{
			// In a controller action
			$this->loadComponent('Common');
			$randString = $this->Common->generateRandomString(8);
			$template = "reset-password-link";
			$forgot_token = md5(uniqid(mt_rand(), true));
			$this->Users->recursive = -1;
			$user_data = $this->Users->get($user_data['id']);
			$user_data->password = $randString;
			if($this->Users->save($user_data))
			{
				$user_data = $user_data->toArray();
				$token = array('{{name}}','{{email}}','{{password}}');
				//$reset_link = Router::url(array('controller'=>'users','action'=>'reset_password',$user_data['id'],$forgot_token),true);
				$token_value = array($user_data['first_name']." ".$user_data['last_name'],$user_data['email'],$randString);
                $this->loadComponent('Common');
				$this->Common->_send_email($user_data['email'], $token, $token_value, $template, '');
				$this->Flash->success('Password sent on provided email address');
				$message['status'] = true;
				$message['message'] = 'We have sent password on your email address. Please visit your provided email account.';
			} else
			{
				$message['status'] = false;
				$message['message'] = 'Sorry! Forgot password update failed. Please try again.';
			}
		} else
		{
			$message['status'] = false;
			$message['message'] = 'Sorry! Email address not Found in our database. Please check again.';
		}
		$this->set(compact('message'));
	}
}
