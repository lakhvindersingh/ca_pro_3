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

class ChaptersController extends AppController
{
   
    public $paginate = [
        'limit' => ADMINPAGINATIONLIMIT,
		'sortWhitelist' => [
			'Chapters.id', 'Chapters.title', 'Chapters.object_id', 'Chapters.created', 'Chapters.status', 'Areas.title', 'Users.first_name', 'Areas.area_type'
		],
        'order' => [
            'Chapters.area_id', 
			'Chapters.order_no'
        ]
    ];
    
    public function initialize(){
		parent::initialize();
		$this->viewBuilder()->layout('admin/admin');
		$this->loadComponent('Paginator');
	}
	
	/**
	 * @name index
	 * Purpose : This method is used to display chapters list 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if successful login
	 */
	public function index(){
		
		$chapters = $this->Chapters->find('all', ['contain'=>['Users', 'Areas']]);
		//->order(['Chapters.area_id' => 'ASC', 'Chapters.order_no' => 'ASC'])
		if($this->request->is(['post', 'put'])){
    		
    		$action = isset($this->request->data['option']) ? $this->request->data['option'] : '';
			$ids = isset($this->request->data['ids']) ? $this->request->data['ids'] : '';
			
			$attr = isset($this->request->data['attr']) ? $this->request->data['attr'] : '';
			
			if(!empty($attr)){
				$ids = unserialize($ids);
			}
			
    		if(!empty($action))
    		{
				if(!empty($ids))
				{
					switch($action)
					{
						case 'delete':
								
								$deletedIds = [];
								foreach($ids as $id){
									$entity = $this->Chapters->get($id);
									$result = $this->Chapters->delete($entity);
									if($result){
										$deletedIds[] = $id;
									}
								}

								$deletedCount = count($deletedIds);
								$userC = "Chapter";
								if($deletedCount > 1)
									$userC = "Chapters";

								$this->Flash->set('Selected '.$userC.' deleted', [
									'element' => 'success'
								]);
								return $this->redirect(['controller'=>'Chapters', 'action'=>'index', 'prefix' => 'admin']);
							
						break;
						case 'active':
								$deletedIds = [];
								foreach($ids as $id){
									$entity = $this->Chapters->get($id);
									$entity->status = 1;
									$result = $this->Chapters->save($entity);
									if($result){
										$deletedIds[] = $id;
									}
								}

								$deletedCount = count($deletedIds);
								$userC = "Chapter";
								if($deletedCount > 1)
									$userC = "Chapters";

								$this->Flash->set('Selected '.$userC.' Activated', [
									'element' => 'success'
								]);
								return $this->redirect(['controller'=>'Chapters', 'action'=>'index', 'prefix' => 'admin']);
						break;
						case 'deactive':
								$deletedIds = [];
								foreach($ids as $id){
									$entity = $this->Chapters->get($id);
									$entity->status = 2;
									$result = $this->Chapters->save($entity);
									if($result){
										$deletedIds[] = $id;
									}
								}

								$deletedCount = count($deletedIds);
								$userC = "Chapter";
								if($deletedCount > 1)
									$userC = "Chapters";

								$this->Flash->set('Selected '.$userC.' De-activated', [
									'element' => 'success'
								]);
								return $this->redirect(['controller'=>'Chapters', 'action'=>'index', 'prefix' => 'admin']);
						break;
					}	
				}else
				{
					$this->Flash->error('Select Chapters to complete process!', [
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
			
			if($keyword == "Primary")
			{
				$keyword = 1;
				$options['conditions'][] 	= 	['Areas.area_type LIKE'		=> '%'.$keyword.'%'];
			}
			elseif($keyword == "Elementary")
			{
				$keyword = 2; 
				$options['conditions'][] 	= 	['Areas.area_type LIKE'		=> '%'.$keyword.'%'];
			}

			if(!isset($this->request->query['sort']) && empty($this->request->query['sort']))
			{
				$options['order'] 		= 	['Chapters.order_no'];
			}
			$options['fields'] 			= 	[];
			$options['conditions'][] 	= 	['OR' => 
												[
													['Chapters.title LIKE' 		=> '%'.$keyword.'%'],
													['Chapters.object_id LIKE' 	=> '%'.$keyword.'%'],
													['Areas.title LIKE' 		=> '%'.$keyword.'%'],
													['Areas.object_id LIKE' 	=> '%'.$keyword.'%'],
													['Users.first_name LIKE' 	=> '%'.$keyword.'%'],
													['Users.last_name LIKE' 	=> '%'.$keyword.'%']
												]
											];
			
			$chapters = $this->Chapters->find('all', $options)->contain(['Users', 'Areas']);
			//->order(['Chapters.area_id' => 'ASC', 'Chapters.order_no' => 'ASC'])
		}
		
		$chapters = $this->paginate($chapters);

		if($keyword == 1)
		{
			$keyword = "Primary";
		}
		elseif($keyword == 2)
		{
			$keyword = "Elementary"; 
		}

        $this->set(compact(['chapters', 'keyword']));
    }

    	/**
	* @name add
	* Purpose : This method is used to add new Chapter
	* @author Pawan Bhatia
	* @access public
	* @return true
	*/
	public function add() {
		
		if($this->request->is('POST'))
		{
			$error = '';
			$this->loadModel('Chapters');
			$chapterData = $this->request->data;
			
			$this->loadComponent('Common');
			if(isset($chapterData['object_id']) || empty($chapterData['object_id'])){
				$chapterData['object_id'] = $this->Common->generateRandomString(10);	
			}
			
			$chapter = $this->Chapters->newEntity($chapterData);
			$errors = $chapter->errors();

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
				
				$chapter = $this->Chapters->patchEntity($chapter, $chapterData);
				$chapter->order_no = $this->generateAutoOrder('chapter');
				if($this->Chapters->save($chapter))
				{
					$this->Flash->success(
						__('Chapter successfully registered.'),
						'default',
						[],
						''
					);
					return $this->redirect(['action'=>'index', 'prefix'=>'admin']);
				} else
				{
					$this->Flash->error(
						__('Chapters cannot be saved right now. Please try again.'),
						'default',
						[],
						''
					);
				}		
			}
		}
		$usersList = [];
		$areasList = [];
		$this->loadModel('Users');
		$users = $this->Users->find('all', ['conditios'=>['group_id'=>'1']]);
		foreach($users as $user){
			$firstname = isset($user->first_name) ? $user->first_name : '';
			$lastname = isset($user->last_name) ? $user->last_name : '';
			$user_type = isset($user->user_type) ? $user->user_type : '';
			if($user->group_id == 2){
				$user_type = ($user_type == 1) ? 'Primary' : 'Elementry';
			}else{
				$user_type = 'Default';
			}
			$usersList[$user->id] = $firstname. ' ' .$lastname. ' ('.$user_type.')';
		}
		
		$this->loadModel('Areas');
		$areas = $this->Areas->find('all');
		foreach($areas as $area){
			$areaType = 'Elementry';
			if($area->area_type == 1){
				$areaType = 'Primary';
			}

			$areasList[$area->id] = $area->title. ' ( '.$areaType. ' )';
		}
		
		$this->set(compact(['usersList', 'areasList']));
	}
	
	/**
	 * @name AddCsv
	 * Purpose : This method is used to Add multiple Chapter using CSV file 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if successful edit else error
	 */
	public function addCsv()
    {
		if($this->request->is(['post'])){
			$fileData = $this->request->data['csv'];
			$modelName = 'Chapters';
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
	 * @name add bulk import
	 * Purpose : This method is used to Add multiple Chapters using json file 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if successful edit else error
	 */
	public function addBulkImport()
    {
    	if($this->request->is(['post'])){
    		$chapter_type = isset($this->request->data['chapter_type']) ? $this->request->data['chapter_type'] : '1';
			$fileData = $this->request->data['json'];

			$modelName = 'Chapters';
			$error = '';
			if($fileData['type'] == "application/octet-stream"){
				
				if (is_uploaded_file($fileData['tmp_name'])) {
					$i = '';
					
					$jsonData = json_decode(file_get_contents($fileData['tmp_name']), true);
					$data	= [];

					foreach($jsonData['results'] as $k=>$data){

						$this->loadModel('Areas');
						$areaObject = $this->Areas->findByObjectIdAndAreaType($data['areanamePointer']['objectId'], $chapter_type)->first()->toArray();
						
						if(!empty($areaObject)){
							$chapterEntity = $this->$modelName->newEntity();

							$chapterEntity->object_id 		= $data['objectId'];
							$chapterEntity->title 			= $data['chapterName'];
							$chapterEntity->description 	= 'null';
							$chapterEntity->status 			= 1;
							$chapterEntity->user_id 		= $user_id = 1;
							$chapterEntity->area_id 		= $areaObject['id'];

							$errors = $chapterEntity->errors();

							if(!empty($errors)){
								foreach ($errors as $key => $value) {
									$error .= "Row : ".$k." ".$value[array_keys($value)[0]].",  ";
								}
							}
							
							$dataSave = false;

							if(empty($error)){
								if($this->$modelName->save($chapterEntity)){
									$error .= '';
									$dataSave = true;
								}else{
									$error .='Row : '.$k.'Data import failed';
									$dataSave = false;
								}
							}	
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
					__('Select .Json file to import data.'),
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
						__('Invalid Chapter'),
						'default',
						[],
						''
					);
			return $this->redirect(['action'=>'index']);
        }
        
        $this->loadModel('Chapters');
        $chapters = $this->Chapters->get($id);
        
        if($this->request->is(['POST', 'PUT']))
		{
			$error = '';

			$chapterData = $this->request->data;
			
			$this->loadComponent('Common');
			if(isset($chapters->object_id) && empty($chapters->object_id)){
				$chapters->object_id = $this->Common->generateRandomString(10);
			}

			$chapter = $this->Chapters->patchEntity($chapters, $chapterData);
			$errors = $chapter->errors();

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

				if($this->Chapters->save($chapter))
				{
					$this->Flash->success(
						__('Chapter successfully Edited.'),
						'default',
						[],
						''
					);
					return $this->redirect(['action'=>'index', 'prefix'=>'admin']);
				} else
				{
					$this->Flash->error(
						__('Chapter cannot be updated right now. Please try again.'),
						'default',
						[],
						''
					);
				}		
			}
		}

		$usersList = [];
		$areasList = [];
		$this->loadModel('Users');
		$users = $this->Users->find('all', ['conditios'=>['Users.group_id'=>'1']]);
		foreach($users as $user){
			$firstname = isset($user->first_name) ? $user->first_name : '';
			$lastname = isset($user->last_name) ? $user->last_name : '';
			$user_type = isset($user->user_type) ? $user->user_type : '';
			if($user->group_id == 2){
				$user_type = ($user_type == 1) ? 'Primary' : 'Elementry';
			}else{
				$user_type = 'Default';
			}
			$usersList[$user->id] = $firstname. ' ' .$lastname. ' ('.$user_type.')';
		}

		$this->loadModel('Areas');
		$areas = $this->Areas->find('all');
		foreach($areas as $area){
			$areaType = 'Elementry';
			if($area->area_type == 1){
				$areaType = 'Primary';
			}

			$areasList[$area->id] = $area->title. ' ( '.$areaType. ' )';
		}
		
		$this->set(compact(['chapters', 'usersList', 'areasList']));
    }
    
    /**
	 * @name Delete
	 * Purpose : This method is used to delete chapter 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if successful edit else error
	 */
	 
    public function delete(){
		$this->viewBuilder()->layout('ajax');
		$this->autoRender = false;
		if($this->request->is(['post', 'ajax'])){
			$this->loadModel('Chapters');
			$action = isset($this->request->data['option']) ? $this->request->data['option'] : '';
			$ids = isset($this->request->data['ids']) ? $this->request->data['ids'] : '';
			if($action == "delete"){
				if(!empty($ids)){
					$chapterIds = [];
					foreach($ids as $key=>$id){
						$chapterData = $this->Chapters->find('all', ['conditions'=>['Chapters.id'=>$id]])->contain(['Lessons.Exercises']);
						$chapterData->hydrate(false);
						$chapterData = $chapterData->first();
						
						$chapterTitle = $chapterData['title'];
						$chapterArray[$key]['Chapter'] = [$chapterData['id']=>$chapterData['title']];
						
						$chapterIds[] = $chapterData['id'];
						
						foreach($chapterData['lessons'] as $lesson){
							$chapterArray[$key]['Lesson'][$lesson['id']] = $lesson['title'];
							
							foreach($lesson['exercises'] as $exercise){
								$chapterArray[$key]['exercises'][$exercise['id']] = $exercise['title'];
							}
						}
					}
					
					$string = $this->createDeleteString($chapterArray);
					echo json_encode(['status'=>'success', 'msg'=>$string, 'data'=>serialize($chapterIds)]);
				}else{
					echo json_encode(['status'=>'error', 'msg'=>'Select Chapter to delete']);
				}
			}
		}
		die;
	}
    
    public function createDeleteString($chapterArray){
		$string = '';
		$chapterId = '';
		$chapterName = '';

		foreach($chapterArray as $chapterArray){
			$association = false;
			if(isset($chapterArray['Chapter']) && !empty($chapterArray['Chapter'])){
				foreach($chapterArray['Chapter'] as $k1=>$a){
					$chapterId = $k1;
					$chapterName = $a;
				}
				$string .= 'Chapter '.$chapterName;
			}

			if(isset($chapterArray['Lesson']) && !empty($chapterArray['Lesson'])){
				 $string .= ' has ' . count($chapterArray['Lesson']). ' Lessons';
				 $association = true;
			}

			if(isset($chapterArray['exercises']) && !empty($chapterArray['exercises'])){
				$string .= ' and '. count($chapterArray['exercises']). ' Exercises';
				$association = true;
			}
			
			if($association){
				$string .= ' associated with';
				$string .= ', deleting will also delete all associated records <br/>';
			}else{
				$string .= ' will get deleted!<br/><br/>';
			}
		}

		return $string;
	}

	/**
	 * @name getTeacher
	 * Purpose : This method is used to get teacher according to user type
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if successful edit else error
	 */

	public function getTeacher(){
		$this->viewBuilder()->layout('ajax');
		if($this->request->is(['post', 'ajax'])){
			$usersList = [];
			if(!empty($this->request->data['area_id'])){
				$this->loadModel('Users');
				$this->loadModel('Areas');
				$areas = $this->Areas->findById($this->request->data['area_id'])->hydrate(false)->first();
				$usersObj = $this->Users->find('all', ['conditions'=>[
													'OR'=>[
														['Users.user_type'=>$areas['area_type']],
														['Users.id'=>1],
													]
												]
											]);

				foreach($usersObj as $user){
					$firstname = isset($user->first_name) ? $user->first_name : '';
					$lastname = isset($user->last_name) ? $user->last_name : '';
					$user_type = isset($user->user_type) ? $user->user_type : '';
					if($user->group_id == 2){
						$user_type = ($user_type == 1) ? 'Primary' : 'Elementry';
					}else{
						$user_type = 'Default';
					}
					
					$usersList[$user->id] = $firstname. ' ' .$lastname. ' ('.$user_type.')';
				}
			}
			$this->set(compact('usersList'));
			echo $this->render('/Admin/Areas/get_teacher');
			die;
		}
	}

	public function ordering($object_id = null)
    {
		if(empty($object_id)){
			$this->Flash->error(
					__('Select Chapter title first to set order.'),
					'default',
					[],
					''
				);
			return $this->redirect(['action'=>'index', 'prefix'=>'admin']);	
		}

		$options['fields'] 			= 	[];
		$options['order'] 			= 	['Chapters.order_no' =>'ASC'];
		$options['conditions'][] 	= 	['Areas.object_id LIKE' 	=> '%'.$object_id.'%'];
		$chapters = $this->Chapters->find('all', $options)->contain(['Users', 'Areas']); 
        $this->set(compact(['chapters', 'keyword']));

    }

    public function orderChapter()
    {
    	$this->authRender = false;
    	$this->viewBuilder()->layout('ajax');

    	if($this->request->is(['post', 'ajax'])){
    		$this->loadModel('Chapters');

    		$i = 0;
			foreach ($this->request->data['item'] as $value) {
			    $data['Chapters']['order_no'] = $i;
			    
			    $entity = $this->Chapters->get($value);
			    $saveChapter = $this->Chapters->patchEntity($entity, $data);
			    $this->Chapters->save($saveChapter);
			    $i++;
			}
    		die;	
    	}
    }
}

