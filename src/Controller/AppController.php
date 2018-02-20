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
namespace App\Controller;

use Cake\Controller\Controller;
use Cake\Event\Event;
use Cake\Controller\Component\CookieComponent;
use Cake\Core\Configure;
use Cake\Filesystem\Folder;
use Cake\Routing\Router;
use Cake\Filesystem\File;
/**
 * Application Controller
 *
 * Add your application-wide methods in the class below, your controllers
 * will inherit them.
 *
 * @link http://book.cakephp.org/3.0/en/controllers.html#the-app-controller
 */
class AppController extends Controller
{

    /**
     * Initialization hook method.
     *
     * Use this method to add common initialization code like loading components.
     *
     * e.g. `$this->loadComponent('Security');`
     *
     * @return void
     */
    public function initialize()
    {
        parent::initialize();
		$this->loadComponent('RequestHandler');
        $this->loadComponent('Cookie');
        $this->loadComponent('Flash');
        
        $this->loadComponent('Auth', [
            'authorize' => 'Controller',
            'authenticate' => ['Form' => [
                            'fields' => [
                                'username' => 'username', 
                                'password' => 'password'
                            ]
                        ]],
            'userModel' => 'Users',
            'loginRedirect' => [
                'controller' => 'Dashboard',
                'action' => 'index'
            ],
            'loginAction' => [
                'controller' => 'Users',
                'action' => 'login',
                'prefix' => 'admin', 'home'
            ],
            'logoutRedirect' => [
                'controller' => 'Users',
                'action' => 'login', 'home', 
                'prefix' => 'admin', 
            ],
            'authError' => __('Please login to visit that page'),
            'unauthorizedRedirect' => $this->referer()
        ]);
		


		$this->loadModel('AddLimits');
		$dbLimitObj = $this->AddLimits->find('All')->hydrate(false);
		if(!empty($dbLimitObj))
		{
			$dbLimitObj = $dbLimitObj->toArray();
			foreach($dbLimitObj as $obj){
				if($obj['type'] == "area"){
					define('ADD_AREA_LIMIT', $obj['upto_limit']);
				}
				
				if($obj['type'] == "student"){
					define('ADD_STUDENT_LIMIT', $obj['upto_limit']);
				}
				
				if($obj['type'] == "subscription"){
					define('ADD_SUBSCRIPTION_LIMIT', $obj['upto_limit']);
				}
			}
		}

		if(!defined('ADD_AREA_LIMIT'))
			define('ADD_AREA_LIMIT', 2);

		if(!defined('ADD_STUDENT_LIMIT'))
			define('ADD_STUDENT_LIMIT', 40);

		if(!defined('ADD_SUBSCRIPTION_LIMIT'))
			define('ADD_SUBSCRIPTION_LIMIT', 30);

    
	}

    /**
     * Before render callback.
     *
     * @param \Cake\Event\Event $event The beforeRender event.
     * @return void
     */

    public function beforeRender(Event $event)
    {
        if (!array_key_exists('_serialize', $this->viewVars) &&
            in_array($this->response->type(), ['application/json', 'application/xml'])
        ) {
            $this->set('_serialize', true);
        }
    }
    
    public function isAuthorized($user)
    {
        $controller = $this->request->params['controller'];
        $action = $this->request->params['action'];
        $prefix = false;

        // Any registered user can access public functions
        if (empty($this->request->params['prefix'])) {
            return $this->redirect(['controller'=>$controller, 'action'=>$action, 'prefix' => 'admin']);
        }else{
            if($user['group_id'] == 1){
                return true;
            }
        }
        
        // Default deny
        return false;
    }

	public function getError($table = null){
		
		$errors = $table->errors();
		$err = '';
		foreach($errors as $key=>$value)
		{
			$err .= $value[array_keys($value)[0]].",  ";
		}
		
		return rtrim($err, ', ');
	}

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

	public function encode($data = null, $salt = 'tltamonty')
	{
		return base64_encode($data.$salt);
	}
	public function decode($data = null, $salt = 'tltamonty')
	{
		$data = base64_decode($data);	
		return str_replace($salt,"",$data);
	}
}
