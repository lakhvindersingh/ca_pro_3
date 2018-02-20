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

class ExercisesController extends AppController
{
   
    public $paginate = [
        'limit' => ADMINPAGINATIONLIMIT,
		'sortWhitelist' => [
			'Exercises.id', 'Exercises.title', 'Exercises.object_id', 'Exercises.created', 'Exercises.status', 'Areas.title', 'Chapters.title', 'Lessons.title', 'Users.first_name', 'Areas.area_type'
		],
        'order' => [
            'Exercises.order_no' => 'asc'
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
		
		$exercises = $this->Exercises->find('all', [
					'contain'=>['Users', 'Areas', 'Chapters', 'Lessons']
				]);

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
									$entity = $this->Exercises->get($id);
									$result = $this->Exercises->delete($entity);
									if($result){
										$deletedIds[] = $id;
									}
								}

								$deletedCount = count($deletedIds);
								$userC = "Exercise";
								if($deletedCount > 1)
									$userC = "Exercises";

								$this->Flash->set('Selected '.$userC.' deleted', [
									'element' => 'success'
								]);
								return $this->redirect(['controller'=>'Exercises', 'action'=>'index', 'prefix' => 'admin']);
							
						break;
						case 'active':
								$deletedIds = [];
								foreach($ids as $id){
									$entity = $this->Exercises->get($id);
									$entity->status = 1;
									$result = $this->Exercises->save($entity);
									if($result){
										$deletedIds[] = $id;
									}
								}

								$deletedCount = count($deletedIds);
								$userC = "Exercise";
								if($deletedCount > 1)
									$userC = "Exercises";

								$this->Flash->set('Selected '.$userC.' Activated', [
									'element' => 'success'
								]);
								return $this->redirect(['controller'=>'Exercises', 'action'=>'index', 'prefix' => 'admin']);
						break;
						case 'deactive':
								$deletedIds = [];
								foreach($ids as $id){
									$entity = $this->Exercises->get($id);
									$entity->status = 2;
									$result = $this->Exercises->save($entity);
									if($result){
										$deletedIds[] = $id;
									}
								}

								$deletedCount = count($deletedIds);
								$userC = "Exercise";
								if($deletedCount > 1)
									$userC = "Exercises";

								$this->Flash->set('Selected '.$userC.' De-activated', [
									'element' => 'success'
								]);
								return $this->redirect(['controller'=>'Exercises', 'action'=>'index', 'prefix' => 'admin']);
						break;
					}	
				}else
				{
					$this->Flash->error('Select Exercises to complete process!', [
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
				$options['order'] 		= 	['Exercises.order_no'];
			}

			$options['fields'] 			= 	[];
			$options['conditions'][] 	= 	['OR' => 
												[
													['Exercises.title LIKE' 	=> '%'.$keyword.'%'],
													['Exercises.object_id LIKE'	=> '%'.$keyword.'%'],
													['Lessons.title LIKE' 		=> '%'.$keyword.'%'],
													['Chapters.title LIKE' 		=> '%'.$keyword.'%'],
													['Areas.title LIKE' 		=> '%'.$keyword.'%'],
													['Areas.object_id LIKE' 	=> '%'.$keyword.'%'],
													['Users.first_name LIKE' 	=> '%'.$keyword.'%'],
													['Users.last_name LIKE' 	=> '%'.$keyword.'%']
												]
											];
			$exercises = $this->Exercises->find('all', $options)->contain(['Users', 'Areas', 'Chapters', 'Lessons']); 
			//->order(['Exercises.area_id' => 'ASC', 'Exercises.chapter_id' => 'ASC', 'Exercises.lesson_id' => 'ASC', 'Exercises.order_no' => 'ASC'])
		}
		
		$exercises = $this->paginate($exercises);
		if($keyword == 1)
		{
			$keyword = "Primary";
		}
		elseif($keyword == 2)
		{
			$keyword = "Elementary"; 
		}

        $this->set(compact(['exercises', 'keyword']));
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
			$exercisesData = $this->request->data;
			
			$this->loadComponent('Common');
			if(isset($exercisesData['object_id']) || empty($exercisesData['object_id'])){
				$exercisesData['object_id'] = $this->Common->generateRandomString(10);
			}
			
			$newChapter = false;
			if(isset($exercisesData['chapter_title'])){
				if(!empty($exercisesData['chapter_title']))
				{
					$newChapter = true;
					$this->loadModel('Chapters');
					$chapterData = [];
					
					$this->loadComponent('Common');
					$chapterData['object_id'] 	= $this->Common->generateRandomString(10);
					$chapterData['title'] 		= $exercisesData['chapter_title'];
					$chapterData['user_id'] 	= $exercisesData['user_id'];
					$chapterData['area_id'] 	= $exercisesData['area_id'];
					$chapterData['status'] 		= 1;
					
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
				$exercisesData['chapter_id'] = '';
				$chapter = $this->Chapters->patchEntity($chapter, $chapterData);
				if($chapter = $this->Chapters->save($chapter)){
					$exercisesData['chapter_id'] = $chapter->id;
				}
			}
			
			$newLessons = false;
			if(isset($exercisesData['lesson_title'])){
				if(!empty($exercisesData['lesson_title']))
				{
					$newLessons = true;
					$this->loadModel('Lessons');
					$chapterData = [];
					
					$this->loadComponent('Common');
					$LessonData['object_id'] 	= $this->Common->generateRandomString(10);
					$LessonData['title'] 		= $exercisesData['lesson_title'];
					$LessonData['user_id'] 		= $exercisesData['user_id'];
					$LessonData['area_id'] 		= $exercisesData['area_id'];
					$LessonData['chapter_id'] 	= $exercisesData['chapter_id'];
					$LessonData['status'] 		= 1;
					
					$Lesson = $this->Lessons->newEntity($LessonData);
					$errors = $Lesson->errors();
					
					if(!empty($errors)) {
						foreach ($errors as $key => $value) {
							$error .= $value[array_keys($value)[0]].",  ";
						}
					}
				}else
				{
					$error .= "Lessons Title is required,  ";
				}
			}
			
			if(($newLessons) && empty($error)){
				$exercisesData['lesson_id'] = '';
				$Lesson = $this->Lessons->patchEntity($Lesson, $LessonData);
				if($Lesson = $this->Lessons->save($Lesson)){
					$exercisesData['lesson_id'] = $Lesson->id;
				}
			}
			
			
			$exercise = $this->Lessons->newEntity($exercisesData);
			$errors = $exercise->errors();

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
				$exercise = $this->Exercises->patchEntity($exercise, $exercisesData);

				$exercise->order_no = $this->generateAutoOrder('exercise');

				if($this->Exercises->save($exercise))
				{
					$this->Flash->success(
						__('Exercise successfully registered.'),
						'default',
						[],
						''
					);
					return $this->redirect(['action'=>'index', 'prefix'=>'admin']);
				} else
				{
					$this->Flash->error(
						__('Exercise cannot be saved right now. Please try again.'),
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
		$lessonsList = [];
		
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
			$chaptersList[$chapter->id] = $chapter->title. ' ( ' .$chapter->object_id.' ) ' ;
		}
		
		$this->loadModel('Lessons');
		$lessonsObj = $this->Lessons->find('all');
		foreach($lessonsObj as $lesson){
			$lessonsList[$lesson->id] = $lesson->title.' ( '.$lesson->object_id.' ) ';
		}
		
		$this->set(compact(['usersList', 'areasList', 'chaptersList', 'lessonsList']));
	}
	
	/**
	 * @name AddCsv
	 * Purpose : This method is used to Add multiple Exercises using CSV file 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if successful edit else error
	 */
	public function addCsv()
    {
		if($this->request->is(['post'])){
			$fileData = $this->request->data['csv'];
			$modelName = 'Exercises';
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
	 * Purpose : This method is used to Add multiple Exercises using json file 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if successful edit else error
	 */
	public function addBulkImport()
    {
    	if($this->request->is(['post'])){
    		$lessons_type = isset($this->request->data['lessons_type']) ? $this->request->data['lessons_type'] : '1';
			$fileData = $this->request->data['json'];

			$modelName = 'Exercises';
			$error = '';
			$dataSave = false;

			if($fileData['type'] == "application/octet-stream"){
				
				if (is_uploaded_file($fileData['tmp_name'])) {
					$i = '';
					
					$jsonData = json_decode(file_get_contents($fileData['tmp_name']), true);
					$data	= [];

					if(isset($jsonData['results']) && !empty($jsonData['results'])){
						foreach($jsonData['results'] as $k=>$data){

							$this->loadModel('Lessons');
							$lessonsObject = $this->Lessons->findByObjectId($data['lessonnamePointer']['objectId'])->contain(['Areas', 'Chapters']);
							if(isset($lessonsObject)){
								$lessonsObject = $lessonsObject->first();
								if(isset($lessonsObject)){
									$lessonsObject = $lessonsObject->toArray();
									if(isset($lessonsObject)){
										if(!empty($lessonsObject)){
											$lessonEntity = $this->$modelName->newEntity();

											$lessonEntity->object_id 		= $data['objectId'];
											$lessonEntity->title 			= $data['exerciseName'];
											$lessonEntity->description 		= 'null';
											$lessonEntity->status 			= 1;
											$lessonEntity->user_id 			= $user_id = 1;
											$lessonEntity->area_id 			= $lessonsObject['area']['id'];
											$lessonEntity->chapter_id		= $lessonsObject['chapter']['id'];
											$lessonEntity->lesson_id 		= $lessonsObject['id'];

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
						__('Invalid Exercise'),
						'default',
						[],
						''
					);
			return $this->redirect(['action'=>'index']);
        }
        
        $this->loadModel('Exercises');
        $exercise = $this->Exercises->get($id);
        if($this->request->is(['POST', 'PUT']))
		{
			$error = '';

			$exercisesData = $this->request->data;
			
			$this->loadComponent('Common');
			if(isset($exercise->object_id) && empty($exercise->object_id)){
				$exercise->object_id = $this->Common->generateRandomString(10);
			}

			$exercise = $this->Exercises->patchEntity($exercise, $exercisesData);
			$errors = $exercise->errors();

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
				$this->loadComponent('Common');
				if(!isset($exercise->object_id) || empty($exercise->object_id)){
					$exercise->object_id = $this->Common->generateRandomString(10);
				}

				if($this->Exercises->save($exercise))
				{
					$this->Flash->success(
						__('Exercise successfully Edited.'),
						'default',
						[],
						''
					);
					return $this->redirect(['action'=>'index', 'prefix'=>'admin']);
				} else
				{
					$this->Flash->error(
						__('Exercise cannot be updated right now. Please try again.'),
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
		$lessonsList = [];
		
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
		$chaptersObj = $this->Chapters->find('all', ['conditions'=>['Chapters.area_id'=>$exercise->area_id]]);
		foreach($chaptersObj as $chapter){
			$chaptersList[$chapter->id] = $chapter->title;
		}
		
		$this->loadModel('Lessons');
		$lessonsObj = $this->Lessons->find('all', ['conditions'=>['Lessons.chapter_id'=>$exercise->chapter_id]]);
		foreach($lessonsObj as $lesson){
			$lessonsList[$lesson->id] = $lesson->title;
		}
		
		$this->set(compact(['exercise', 'usersList', 'areasList', 'chaptersList', 'lessonsList']));
    }
    
    /**
	 * @name Delete
	 * Purpose : This method is used to delete exercises 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if successful edit else error
	 */
	 
    public function delete(){
		$this->viewBuilder()->layout('ajax');
		$this->autoRender = false;
		if($this->request->is(['post', 'ajax'])){
			$this->loadModel('Exercises');
			$action = isset($this->request->data['option']) ? $this->request->data['option'] : '';
			$ids = isset($this->request->data['ids']) ? $this->request->data['ids'] : '';
			
			if($action == "delete"){
				if(!empty($ids)){
					$exerciseArray 	= [];
					$exerciseids 	= [];
					
					foreach($ids as $key=>$id){
						$exerciseData = $this->Exercises->find('all', ['conditions'=>['Exercises.id'=>$id]]);
						$exerciseData->hydrate(false);
						$exerciseData = $exerciseData->first();
						$exerciseArray[$key]['Exercises'] = [$exerciseData['id']=>$exerciseData['title']];
						$exerciseids[] = $exerciseData['id'];
					}
					
					$string = $this->createDeleteString($exerciseArray);
					echo json_encode(['status'=>'success', 'msg'=>$string, 'data'=>serialize($exerciseids)]);
				}else{
					echo json_encode(['status'=>'error', 'msg'=>'Select Exercises to delete']);
				}
			}
		}
		die;
	}
	
	public function createDeleteString($exerciseArray){
		$string = '';
		$lessonId = '';
		$lessonName = '';

		foreach($exerciseArray as $exercise){
			
			if(isset($exercise['Exercises']) && !empty($exercise['Exercises'])){
				foreach($exercise['Exercises'] as $k1=>$a){
					$exerciseId = $k1;
					$exerciseName = $a;
				}
				$string .= 'Exercise: '.$exerciseName;
			}
			
			$string .= ' will get deleted!<br/><br/>';
		}

		return $string;
	}

	public function ordering($object_id = null)
    {
    	if(empty($object_id)){
			$this->Flash->error(
					__('Select Exercise title first to set order.'),
					'default',
					[],
					''
				);
			return $this->redirect(['action'=>'index', 'prefix'=>'admin']);	
		}

		$options['fields'] 			= 	[];
		$options['order'] 			= 	['Exercises.order_no' =>'ASC'];
		$options['conditions'][] 	= 	['Lessons.object_id LIKE' 	=> '%'.$object_id.'%'];
		$exercises = $this->Exercises->find('all', $options)->contain(['Users', 'Areas', 'Chapters', 'Lessons']); 
        $this->set(compact(['exercises', 'keyword']));
    }

    public function orderExercises()
    {
    	$this->authRender = false;
    	$this->viewBuilder()->layout('ajax');

    	if($this->request->is(['post', 'ajax'])){
    		$this->loadModel('Exercises');
    		
    		$i = 0;
			foreach ($this->request->data['item'] as $value) {
			    $data['Exercises']['order_no'] = $i;
			    
			    $entity = $this->Exercises->get($value);
			    $saveExercise = $this->Exercises->patchEntity($entity, $data);
			    $this->Exercises->save($saveExercise);
			    $i++;
			}
    		die;	
    	}
    }
}
