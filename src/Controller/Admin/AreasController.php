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

class AreasController extends AppController
{
   
    public $paginate = [
        'limit' => ADMINPAGINATIONLIMIT,
		'sortWhitelist' => [
			'Areas.id', 'Areas.title', 'Areas.created', 'Users.first_name', 'Areas.status', 'Areas.object_id', 'Areas.area_color', 'Areas.area_type'
		],
        'order' => [
            'Areas.order_no' => 'asc'
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
		$this->loadModel('Areas');
		$areas = $this->Areas->find('all', ['contain'=>['Users']]);
		
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
									$entity = $this->Areas->get($id);
									$result = $this->Areas->delete($entity);
									if($result){
										$deletedIds[] = $id;
									}
								}

								$deletedCount = count($deletedIds);
								$userC = "Area";
								if($deletedCount > 1)
									$userC = "Areas";

								$this->Flash->set('Selected '.$userC.' deleted', [
									'element' => 'success'
								]);
								//return $this->redirect(['controller'=>'Areas', 'action'=>'index', 'prefix' => 'admin']);
								echo 'ok';
								die();
						break;
						case 'active':
								$deletedIds = [];
								foreach($ids as $id){
									$entity = $this->Areas->get($id);
									$entity->status = 1;
									$result = $this->Areas->save($entity);
									if($result){
										$deletedIds[] = $id;
									}
								}

								$deletedCount = count($deletedIds);
								$userC = "Area";
								if($deletedCount > 1)
									$userC = "Areas";

								$this->Flash->set('Selected '.$userC.' Activated', [
									'element' => 'success'
								]);
								return $this->redirect(['controller'=>'Areas', 'action'=>'index', 'prefix' => 'admin']);
						break;
						case 'deactive':
								$deletedIds = [];
								foreach($ids as $id){
									$entity = $this->Areas->get($id);
									$entity->status = 0;
									$result = $this->Areas->save($entity);
									if($result){
										$deletedIds[] = $id;
									}
								}

								$deletedCount = count($deletedIds);
								$userC = "Area";
								if($deletedCount > 1)
									$userC = "Areas";

								$this->Flash->set('Selected '.$userC.' De-activated', [
									'element' => 'success'
								]);
								return $this->redirect(['controller'=>'Areas', 'action'=>'index', 'prefix' => 'admin']);
						break;
					}	
				}else
				{
					$this->Flash->error('Select Area to complete process!', [
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
			$options['order'] 			= 	['Areas.id' =>'DESC'];
			$options['conditions'][] 	= 	['OR' => 
												[
													['Areas.title LIKE' 		=> '%'.$keyword.'%'],
													['Areas.object_id LIKE' 	=> '%'.$keyword.'%'],
													['Areas.created LIKE' 		=> '%'.$keyword.'%'],
													['Users.first_name LIKE' 	=> '%'.$keyword.'%'],
													['Users.last_name LIKE' 	=> '%'.$keyword.'%']
												]
											];
											
			$areas = $this->Areas->find('all', $options)->contain(['Users']); 
		}
		
		$areas = $this->paginate($areas);
        $this->set(compact(['areas', 'keyword']));
    }

   	/**
	* @name add
	* Purpose : This method is used to add new Area
	* @author Pawan Bhatia
	* @access public
	* @return true
	*/
	public function add() {
		
		if($this->request->is('POST'))
		{
			$error = '';
			$this->loadModel('Areas');
			$areaData = $this->request->data;
			
			$areaColor = isset($areaData['area_color']) ? $areaData['area_color'] : '';
				
			$this->loadComponent('Common');
			$areaData['object_id'] 		= $this->Common->generateRandomString(10);
			$areaData['area_color'] 	= (!empty($areaColor)) ? $areaColor : $this->Common->getRandomColor();
			
			$countUserAreas = $this->Areas->countUserAreas($areaData['user_id'], $areaData['area_type'], ADD_AREA_LIMIT);
			
			if(!$countUserAreas){
				$error .= "You have already added ". ADD_AREA_LIMIT ." Areas for selected Teacher,  ";
				$this->Flash->success(
						__($error),
						'default',
						[],
						''
					);
			}else{
				$area = $this->Areas->newEntity($areaData);
				$errors = $area->errors();

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
					
					$area = $this->Areas->patchEntity($area, $areaData);
					
					$area->order_no = $this->generateAutoOrder('area');

					if($this->Areas->save($area))
					{
						$this->Flash->success(
							__('Areas successfully registered.'),
							'default',
							[],
							''
						);
						return $this->redirect(['action'=>'index', 'prefix'=>'admin']);
					} else
					{
						$this->Flash->error(
							__('Areas cannot be saved right now. Please try again.'),
							'default',
							[],
							''
						);
					}		
				}
			}
		}
		
		$this->loadModel('Users');
		$users = $this->Users->find('all');

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
		$this->set(compact('usersList'));
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
			if(!empty($this->request->data['area_type'])){
				$this->loadModel('Users');
				$usersObj = $this->Users->find('all', ['conditions'=>[
													'OR'=>[
														['Users.user_type'=>$this->request->data['area_type']],
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
			$modelName = 'Areas';
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
										
								}elseif($h[1] == 'area_color'){
									
									if(isset($row[$k]) && !empty($row[$k]))
										$data[$i][$h[1]] = $row[$k];
									else
										$data[$i][$h[1]] = $this->Common->getRandomColor();
										
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
										
								}elseif($head == 'area_color'){

									if(isset($row[$k]) && !empty($row[$k]))
										$data[$i][$head] = $row[$k];
									else
										$data[$i][$head] = $this->Common->getRandomColor();
										
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
	 * @name add buil import
	 * Purpose : This method is used to Add multiple area using json file 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if successful edit else error
	 */
	public function addBulkImport()
    {
    	if($this->request->is(['post'])){
    		$area_type = isset($this->request->data['area_type']) ? $this->request->data['area_type'] : '1';
			$fileData = $this->request->data['json'];

			$modelName = 'Areas';
			$error = '';
			if($fileData['type'] == "application/octet-stream"){
				
				if (is_uploaded_file($fileData['tmp_name'])) {
					$i = '';
					
					$jsonData = json_decode(file_get_contents($fileData['tmp_name']), true);
					$data	= [];
					foreach($jsonData['results'] as $k=>$data){

						$areaEntity = $this->$modelName->newEntity();
						

						$areaEntity->object_id 		= $data['objectId'];
						$areaEntity->area_type 		= $area_type;
						$areaEntity->title 			= $data['areaName'];
						$areaEntity->description 	= 'null';
						$areaEntity->status 		= 1;
						$areaEntity->area_color 	= $data['areaColor'];
						$areaEntity->user_id 		= $user_id = 1;

						$errors = $areaEntity->errors();

						if(!empty($errors)){
							foreach ($errors as $key => $value) {
								$error .= "Row : ".$k." ".$value[array_keys($value)[0]].",  ";
							}
						}
						
						$dataSave = false;

						if(empty($error)){
							if($this->$modelName->save($areaEntity)){
								$error .= '';
								$dataSave = true;
							}else{
								$error .='Row : '.$k.'Data import failed';
								$dataSave = false;
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
						__('Invalid Area'),
						'default',
						[],
						''
					);
			return $this->redirect(['action'=>'index']);
        }
        
        $this->loadModel('Areas');
        $areas = $this->Areas->get($id);
        
        if($this->request->is(['POST', 'PUT']))
		{
			$error = '';

			$areaData = $this->request->data;
			
			$this->loadComponent('Common');
			
			if(empty($areas['object_id']))
				$areaData['object_id'] = $this->Common->generateRandomString(10);
			
			$this->Areas->validator()->remove('title', 'rule1');
			
			$area = $this->Areas->patchEntity($areas, $areaData);
			$errors = $area->errors();

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
				
				if($this->Areas->save($area))
				{
					$this->Flash->success(
						__('Areas successfully Edited.'),
						'default',
						[],
						''
					);
					return $this->redirect(['action'=>'index', 'prefix'=>'admin']);
				} else
				{
					$this->Flash->error(
						__('Areas cannot be saved right now. Please try again.'),
						'default',
						[],
						''
					);
				}		
			}
		}
		
		
		$this->loadModel('Users');

		$users = $this->Users->find('all', ['conditions'=>[
													'OR'=>[
														['Users.user_type'=>$areas->area_type],
														['Users.id'=>1],
													]
												]
											]);
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
		$this->set(compact(['areas', 'usersList']));
    }
	
	/**
	 * @name Delete
	 * Purpose : This method is used to delete area 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if successful edit else error
	 */
	 
	public function delete(){
		$this->viewBuilder()->layout('ajax');
		$this->autoRender = false;
		if($this->request->is(['post', 'ajax'])){
			$this->loadModel('Areas');
			$action = isset($this->request->data['option']) ? $this->request->data['option'] : '';
			$ids = isset($this->request->data['ids']) ? $this->request->data['ids'] : '';
			if($action == "delete"){
				if(!empty($ids)){
					$areaIds = [];
					
					foreach($ids as $key=>$id){
						$areasData = $this->Areas->find('all', ['conditions'=>['Areas.id'=>$id]])->contain(['Chapters.Lessons.Exercises']);
						$areasData->hydrate(false);
						$areasData = $areasData->first();
						
						$areaTitle = $areasData['title'];
						$chapterArray[$key]['Area'] = [$areasData['id']=>$areasData['title']];
						$areaIds[] = $areasData['id'];
					
						foreach($areasData['chapters'] as $chapter){
							$chapterArray[$key]['Chapter'][$chapter['id']] = $chapter['title'];
							
							foreach($chapter['lessons'] as $lesson){
								$chapterArray[$key]['Lesson'][$lesson['id']] = $lesson['title'];
								
								foreach($lesson['exercises'] as $exercise){
									$chapterArray[$key]['exercises'][$exercise['id']] = $exercise['title'];
								}
							}
						}
					}
					
					$string = $this->createDeleteString($chapterArray);
					echo json_encode(['status'=>'success', 'msg'=>$string, 'data' =>serialize($areaIds)]);
				}else{
					echo json_encode(['status'=>'error', 'msg'=>'Select Area to delete']);
				}
			}
		}
		die;
	}
	
	public function createDeleteString($chapterArray){
		$string = '';
		$areaId = '';
		$areaName = '';
		foreach($chapterArray as $areaArray){
			$association = false;
			if(isset($areaArray['Area']) && !empty($areaArray['Area'])){
				foreach($areaArray['Area'] as $k1=>$a){
					$areaId = $k1;
					$areaName = $a;
				}
				$string .= 'Area '.$areaName;
			}

			if(isset($areaArray['Chapter']) && !empty($areaArray['Chapter'])){
				 $string .= ' has ' . count($areaArray['Chapter']). ' Chapters';
				$association = true;
			}

			if(isset($areaArray['Lesson']) && !empty($areaArray['Lesson'])){
				$string .= ' and '. count($areaArray['Lesson']). ' Lessons';
				$association = true;
			}

			if(isset($areaArray['exercises']) && !empty($areaArray['exercises'])){
				$string .= ' and '. count($areaArray['exercises']). ' Exercises';
				$association = true;
			}
			
			if($association){
				$string .= ' associated with , deleting will also delete all associated records <br/><br/>';
			}else{
				$string .= ' will get deleted!<br/><br/>';
			}
		}

		return $string;
	}

	/**
	 * @name exportCsv
	 * Purpose : This method is used to export area using CSV file 
	 * @author Pawan Bhatia
	 * @access public
	 * @return returns true if successful edit else error
	 */
	 
	public function exportCsv($model = 'Areas')
    {
		$this->viewBuilder()->layout('ajax');
		
		$this->loadModel($model);
 		$areaData = $this->$model->find('all')->hydrate(false);

		$delimiter = ',';
		$enclosure = '"';
		$flatData = array();
		foreach($areaData as $numericKey => $row){

			$flatRow = array();
			$this->flattenArray($row, $flatRow);
			$flatData[$numericKey] = $flatRow;
		}
		
		$headerRow = $this->getKeysForHeaderRow($flatData);
		$flatData = $this->mapAllRowsToHeaderRow($headerRow, $flatData);
		
		if(empty($fileName)){
			$fileName = "export".$model."_".date("Y-m-d").".csv";
		}

		$csvFile = fopen('php://output', 'w');
		header('Content-type: application/csv');
		header('Content-Disposition: attachment; filename="'.$fileName.'"');

		fputcsv($csvFile,$headerRow, $delimiter, $enclosure);
		foreach ($flatData as $key => $value) {
			fputcsv($csvFile, $value, $delimiter, $enclosure);
		}
		fclose($csvFile);
		die;
    }
    
    public function flattenArray($array, &$flatArray, $parentKeys = ''){
		foreach($array as $key => $value){
			$chainedKey = ($parentKeys !== '')? $parentKeys.'.'.$key : $key;
			if(is_array($value)){
				$this->flattenArray($value, $flatArray, $chainedKey);
			} else {
				$flatArray[$chainedKey] = $value;
			}
		}
	}
	
	public function getKeysForHeaderRow($data){
		$headerRow = array();
		foreach($data as $key => $value){
			foreach($value as $fieldName => $fieldValue){
				if(array_search($fieldName, $headerRow) === false){
					$headerRow[] = $fieldName;
				}
			}
		}

		return $headerRow;
	}

	public function mapAllRowsToHeaderRow($headerRow, $data){
		$newData = array();
		foreach($data as $intKey => $rowArray){
			foreach($headerRow as $headerKey => $columnName){
				if(!isset($rowArray[$columnName])){
					//$rowArray[$columnName] = '';
					$newData[$intKey][$columnName] = '';
				} else {
					$newData[$intKey][$columnName] = $rowArray[$columnName];
				}
			}
		}

		return $newData;
	}

	public function ordering($area_type = null)
    {
		if(empty($area_type)){
			$this->Flash->error(
					__('Select Area title first to set order.'),
					'default',
					[],
					''
				);
			return $this->redirect(['action'=>'index', 'prefix'=>'admin']);	
		}

		$options['fields'] 			= 	[];
		$options['order'] 			= 	['Areas.order_no' =>'ASC'];
		$options['conditions'][] 	= 	['Areas.area_type LIKE' 	=> '%'.$area_type.'%'];
		$areas = $this->Areas->find('all', $options)->contain(['Users']); 
        $this->set(compact(['areas']));

    }

    public function orderAreas()
    {
    	$this->authRender = false;
    	$this->viewBuilder()->layout('ajax');

    	if($this->request->is(['post', 'ajax'])){
    		$this->loadModel('Areas');

    		$i = 0;
			foreach ($this->request->data['item'] as $value) {
			    $data['Areas']['order_no'] = $i;
			    
			    $entity = $this->Areas->get($value);
			    $saveArea = $this->Areas->patchEntity($entity, $data);
			    $this->Areas->save($saveArea);
			    $i++;
			}
    		die;	
    	}
    }
}

