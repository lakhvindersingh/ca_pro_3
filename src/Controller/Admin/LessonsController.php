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

class LessonsController extends AppController
{
   
    public $paginate = [
        'limit' => ADMINPAGINATIONLIMIT,
		'sortWhitelist' => [
			'Lessons.id', 'Lessons.title', 'Lessons.object_id', 'Lessons.created', 'Lessons.status', 'Areas.title', 'Chapters.title', 'Users.first_name', 'Areas.area_type'
		],
        'order' => [
            'Lessons.order_no' => 'asc'
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
		
		$lessons = $this->Lessons->find('all', [
						'contain'=>['Users', 'Areas', 'Chapters']
					]);
		
		//->order(['Lessons.area_id' => 'ASC', 'Lessons.chapter_id' => 'ASC', 'Lessons.order_no' => 'ASC'])

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
									$entity = $this->Lessons->get($id);
									$result = $this->Lessons->delete($entity);
									if($result){
										$deletedIds[] = $id;
									}
								}

								$deletedCount = count($deletedIds);
								$userC = "Lesson";
								if($deletedCount > 1)
									$userC = "Lessons";

								$this->Flash->set('Selected '.$userC.' deleted', [
									'element' => 'success'
								]);
								return $this->redirect(['controller'=>'Lessons', 'action'=>'index', 'prefix' => 'admin']);
							
						break;
						case 'active':
								$deletedIds = [];
								foreach($ids as $id){
									$entity = $this->Lessons->get($id);
									$entity->status = 1;
									$result = $this->Lessons->save($entity);
									if($result){
										$deletedIds[] = $id;
									}
								}

								$deletedCount = count($deletedIds);
								$userC = "Lesson";
								if($deletedCount > 1)
									$userC = "Lessons";

								$this->Flash->set('Selected '.$userC.' Activated', [
									'element' => 'success'
								]);
								return $this->redirect(['controller'=>'Lessons', 'action'=>'index', 'prefix' => 'admin']);
						break;
						case 'deactive':
								$deletedIds = [];
								foreach($ids as $id){
									$entity = $this->Lessons->get($id);
									$entity->status = 2;
									$result = $this->Lessons->save($entity);
									if($result){
										$deletedIds[] = $id;
									}
								}

								$deletedCount = count($deletedIds);
								$userC = "Lesson";
								if($deletedCount > 1)
									$userC = "Lessons";

								$this->Flash->set('Selected '.$userC.' De-activated', [
									'element' => 'success'
								]);
								return $this->redirect(['controller'=>'Lessons', 'action'=>'index', 'prefix' => 'admin']);
						break;
					}	
				}else
				{
					$this->Flash->error('Select Lessons to complete process!', [
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
				$options['order'] 		= 	['Lessons.order_no'];
			}

			$options['fields'] 			= 	[];
			$options['conditions'][] 	= 	['OR' => 
												[
													['Lessons.title LIKE' 		=> '%'.$keyword.'%'],
													['Lessons.object_id LIKE' 	=> '%'.$keyword.'%'],
													['Chapters.title LIKE' 		=> '%'.$keyword.'%'],
													['Chapters.object_id LIKE' 	=> '%'.$keyword.'%'],
													['Areas.title LIKE' 		=> '%'.$keyword.'%'],
													['Areas.object_id LIKE' 	=> '%'.$keyword.'%'],
													['Users.first_name LIKE' 	=> '%'.$keyword.'%'],
													['Users.last_name LIKE' 	=> '%'.$keyword.'%']
												]
											];

			$lessons = $this->Lessons->find('all', $options)
					->contain(['Users', 'Areas', 'Chapters']); 
					//->order(['Lessons.area_id' => 'ASC', 'Lessons.chapter_id' => 'ASC', 'Lessons.order_no' => 'ASC'])
		}
		
		$lessons = $this->paginate($lessons);
		if($keyword == 1)
		{
			$keyword = "Primary";
		}
		elseif($keyword == 2)
		{
			$keyword = "Elementary"; 
		}
        $this->set(compact(['lessons', 'keyword']));
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
			$this->loadModel('Lessons');
			$lessonsData = $this->request->data;
			
			$this->loadComponent('Common');
			if(isset($lessonsData['object_id']) && empty($lessonsData['object_id'])){
				$lessonsData['object_id'] = $this->Common->generateRandomString(10);
			}
			
			$newChapter = false;
			if(isset($lessonsData['chapter_title'])){
				if(!empty($lessonsData['chapter_title']))
				{
					$newChapter = true;
					$this->loadModel('Chapters');
					$chapterData = [];
					
					$this->loadComponent('Common');
					$chapterData['object_id'] = $this->Common->generateRandomString(10);
					$chapterData['title'] = $lessonsData['chapter_title'];
					$chapterData['area_id'] = $lessonsData['area_id'];
					$chapterData['user_id'] = $lessonsData['user_id'];
					$chapterData['status'] = 1;
					
					$chapter = $this->Chapters->newEntity($chapterData);
					$errors = $chapter->errors();
					
					if(!empty($errors)) {
						foreach ($errors as $key => $value) {
							$error .= $value[array_keys($value)[0]].",  ";
						}
					}
				}else
				{
					$error .= "Chapter Title is required,  ";
				}
			}
			
			if(($newChapter) && empty($error)){
				$lessonsData['chapter_id'] = '';
				$chapter = $this->Chapters->patchEntity($chapter, $chapterData);
				if($chapter = $this->Chapters->save($chapter)){
					$lessonsData['chapter_id'] = $chapter->id;
				}
			}
			
			$lesson = $this->Lessons->newEntity($lessonsData);
			$errors = $lesson->errors();

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
				$lesson = $this->Lessons->patchEntity($lesson, $lessonsData);

				$lesson->order_no = $this->generateAutoOrder('lesson');

				if($this->Lessons->save($lesson))
				{
					$this->Flash->success(
						__('Lessons successfully registered.'),
						'default',
						[],
						''
					);
					return $this->redirect(['action'=>'index', 'prefix'=>'admin']);
				} else
				{
					$this->Flash->error(
						__('Lesson cannot be saved right now. Please try again.'),
						'default',
						[],
						''
					);
				}		
			}
		}

		$usersList = [];
		$areasList = [];
		$chaptersList = [];
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

		
		$this->loadModel('Chapters');
		$chaptersObj = $this->Chapters->find('all');
		foreach($chaptersObj as $chapter){
			$chaptersList[$chapter->id] = $chapter->title. ' ( ' . $chapter->object_id . ' )';
		}
		
		$this->set(compact(['usersList', 'areasList', 'chaptersList']));
	}

	/**
	 * @name AddCsv
	 * Purpose : This method is used to Add multiple Lessons using CSV file 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if successful edit else error
	 */
	public function addCsv()
    {
		if($this->request->is(['post'])){
			$fileData = $this->request->data['csv'];
			$modelName = 'Lessons';
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
	 * Purpose : This method is used to Add multiple Lessons using json file 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if successful edit else error
	 */
	public function addBulkImport()
    {
    	if($this->request->is(['post'])){
    		$lessons_type = isset($this->request->data['lessons_type']) ? $this->request->data['lessons_type'] : '1';
			$fileData = $this->request->data['json'];

			$modelName = 'Lessons';
			$error = '';
			$dataSave = false;

			if($fileData['type'] == "application/octet-stream"){
				
				if (is_uploaded_file($fileData['tmp_name'])) {
					$i = '';
					
					$jsonData = json_decode(file_get_contents($fileData['tmp_name']), true);
					$data	= [];

					if(isset($jsonData['results']) && !empty($jsonData['results'])){
						foreach($jsonData['results'] as $k=>$data){

							$this->loadModel('Chapters');
							$chapterObject = $this->Chapters->findByObjectId($data['chapternamePointer']['objectId'])->contain('Areas')->first()->toArray();

							if(!empty($chapterObject)){
								$lessonEntity = $this->$modelName->newEntity();

								$lessonEntity->object_id 		= $data['objectId'];
								$lessonEntity->title 			= $data['lessonName'];
								$lessonEntity->description 		= 'null';
								$lessonEntity->status 			= 1;
								$lessonEntity->user_id 			= $user_id = 1;
								$lessonEntity->area_id 			= $chapterObject['area']['id'];
								$lessonEntity->chapter_id		= $chapterObject['id'];

								$errors = $lessonEntity->errors();
								
								if(!empty($errors)){
									foreach ($errors as $key => $value) {
										$error .= "Row : ".$k." ".$value[array_keys($value)[0]].",  ";
									}
								}
								
								if(empty($error)){
									if($this->$modelName->save($lessonEntity)){
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
					}else{
						$this->Flash->error(
							__('No data found or Invalid file'),
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
	 * Purpose : This method is used to edit Lesson 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if successful edit else error
	 */
	public function edit($id = null)
    {
		if (!$id) {
            $this->Flash->success(
						__('Invalid Lesson'),
						'default',
						[],
						''
					);
			return $this->redirect(['action'=>'index']);
        }
        
        $this->loadModel('Lessons');
        $lessons = $this->Lessons->get($id);
        if($this->request->is(['POST', 'PUT']))
		{
			$error = '';

			$lessonsData = $this->request->data;
			
			$this->loadComponent('Common');
			if(isset($lessons->object_id) && empty($lessons->object_id)){
				$lessons->object_id = $this->Common->generateRandomString(10);
			}

			$lesson = $this->Lessons->patchEntity($lessons, $lessonsData);
			$errors = $lesson->errors();

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
				
				if($this->Lessons->save($lesson))
				{
					$this->Flash->success(
						__('Lesson successfully Edited.'),
						'default',
						[],
						''
					);
					return $this->redirect(['action'=>'index', 'prefix'=>'admin']);
				} else
				{
					$this->Flash->error(
						__('Lesson cannot be updated right now. Please try again.'),
						'default',
						[],
						''
					);
				}		
			}
		}
		
		$usersList = [];
		$areasList = [];
		$chaptersList = [];
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
		
		$this->loadModel('Chapters');
		$chaptersObj = $this->Chapters->find('all', ['conditions'=>['Chapters.area_id'=>$lessons->area_id]]);
		foreach($chaptersObj as $chapter){
			$chaptersList[$chapter->id] = $chapter->title;
		}
		
		$this->set(compact(['lessons', 'usersList', 'areasList', 'chaptersList']));
    }
    
    /**
	 * @name Delete
	 * Purpose : This method is used to delete lessons 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if successful edit else error
	 */
	 
    public function delete(){
		$this->viewBuilder()->layout('ajax');
		$this->autoRender = false;
		if($this->request->is(['post', 'ajax'])){
			$this->loadModel('Lessons');
			$action = isset($this->request->data['option']) ? $this->request->data['option'] : '';
			$ids = isset($this->request->data['ids']) ? $this->request->data['ids'] : '';
			
			if($action == "delete"){
				if(!empty($ids)){
					$lessonIds = [];
					foreach($ids as $key=>$id){
						$lessonData = $this->Lessons->find('all', ['conditions'=>['Lessons.id'=>$id]])->contain(['Exercises']);
						$lessonData->hydrate(false);
						$lessonData = $lessonData->first();
						
						$chapterTitle = $lessonData['title'];
						$lessonsArray[$key]['Lessons'] = [$lessonData['id']=>$lessonData['title']];
						$lessonIds[] = $lessonData['id'];
						foreach($lessonData['exercises'] as $exercise){
							$lessonsArray[$key]['exercises'][$exercise['id']] = $exercise['title'];
						}
					}
					
					$string = $this->createDeleteString($lessonsArray);
					echo json_encode(['status'=>'success', 'msg'=>$string, 'data'=>serialize($lessonIds)]);
				}else{
					echo json_encode(['status'=>'error', 'msg'=>'Select Lesson to delete']);
				}
			}
		}
		die;
	}
	
	public function createDeleteString($lessonsArray){
		$string = '';
		$lessonId = '';
		$lessonName = '';

		foreach($lessonsArray as $lessons){
			$association = false;
			
			if(isset($lessons['Lessons']) && !empty($lessons['Lessons'])){
				foreach($lessons['Lessons'] as $k1=>$a){
					
					$lessonId = $k1;
					$lessonName = $a;
				}
				$string .= 'Lesson '.$lessonName;
			}

			if(isset($lessons['exercises']) && !empty($lessons['exercises'])){
				$string .= ' has ' . count($lessons['exercises']). ' Exercises ';
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

	public function ordering($object_id = null)
    {
    	$options['fields'] 			= 	[];
		$options['order'] 			= 	['Lessons.order_no' =>'ASC'];
		$options['conditions'][] 	= 	['Chapters.object_id LIKE' 	=> '%'.$object_id.'%'];
		
		if(empty($object_id)){
			$this->Flash->error(
					__('Select lesson title first to set order.'),
					'default',
					[],
					''
				);
			return $this->redirect(['action'=>'index', 'prefix'=>'admin']);	
		}

		$lessons = $this->Lessons->find('all', $options)->contain(['Users', 'Areas', 'Chapters']); 	
        $this->set(compact(['lessons', 'keyword']));
    }

    public function orderLessons()
    {
    	$this->authRender = false;
    	$this->viewBuilder()->layout('ajax');

    	if($this->request->is(['post', 'ajax'])){
    		$this->loadModel('Lessons');

    		$i = 0;
			foreach ($this->request->data['item'] as $value) {
			    $data['Lessons']['order_no'] = $i;
			    
			    $entity = $this->Lessons->get($value);
			    $saveLesson = $this->Lessons->patchEntity($entity, $data);
			    $this->Lessons->save($saveLesson);
			    
			    $i++;
			}
    		die;	
    	}
    }
}
