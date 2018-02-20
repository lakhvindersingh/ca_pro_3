<?php
namespace App\Model\Table;

use App\Model\Entity\Area;
use Cake\ORM\Query;
use Cake\ORM\RulesChecker;
use Cake\ORM\Table;
use Cake\Validation\Validator;

/**
 * Areas Model
 */
class AreasTable extends Table
{

    /**
     * Initialize method
     *
     * @param array $config The configuration for the Table.
     * @return void
     */
	
    public function initialize(array $config)
    {
        $this->table('areas');
        $this->displayField('id');
        $this->primaryKey('id');
        $this->addBehavior('Timestamp');
        $this->belongsTo('Users');
		$this->hasMany('UserAreas');
        $this->hasMany('Chapters', ['dependent' => true]);
        $this->hasMany('Lessons', ['dependent' => true]);
        $this->hasMany('Exercises', ['dependent' => true]);
		$this->hasMany('StudentViews', ['dependent' => true]);
    }

    /**
     * Default validation rules.
     *
     * @param \Cake\Validation\Validator $validator Validator instance.
     * @return \Cake\Validation\Validator
     */
    public function validationDefault(Validator $validator)
    { 
        $validator
            ->add('id', 'valid', ['rule' => 'numeric'])
            ->allowEmpty('id', 'create')
            ->requirePresence('title', 'create', 'Area name required.')
            ->notEmpty('title','Area name should not be empty.')
			->add('title', [
				'rule1' =>[
					'rule' => 'uniqueTitle',
					'provider' => 'table',
					'message' => 'Area with this name is already exist. Try different'
				]
			])
			->requirePresence('area_type', 'create', 'Area Type is required.')
            ->notEmpty('area_type','Area Type should not be empty.');
            
        return $validator;
    }

    /**
     * Returns a rules checker object that will be used for validating
     * application integrity.
     *
     * @param \Cake\ORM\RulesChecker $rules The rules object to be modified.
     * @return \Cake\ORM\RulesChecker
     */
    public function buildRules(RulesChecker $rules)
    {
        return $rules;
    }
    
   
   /**
     * Returns a unique title check for logged in user
     * application integrity.
     *
     * @param title
     * @return true/false
     */
    public function uniqueTitle($title, array $data){

		if(!isset($data['data']['area_type'])){
			$data['data']['area_type'] = '';
		}

		$conditions['conditions'][] = ['title'	=> $title];
		$conditions['conditions'][] = ['user_id'=> $data['data']['user_id']];

		if(!empty($data['data']['area_type'])){
			$conditions['conditions'][] = ['area_type'=>$data['data']['area_type']];
		}

		$hasTitle = $this->find('all', $conditions)->first();
			
		if($hasTitle){
			$hasTitle = $hasTitle->toArray();
			if(isset($data['data']['area_id']) && !empty($data['data']['area_id'])){
				if($hasTitle['id'] == $data['data']['area_id']){
					return true;
				}
			}
			return false;
		}else{
			return true;
		}
	}
	
	/**
     * Returns a user Area count
     * application integrity.
     *
     * @param user_id, area_limit
     * @return true/false
     */
	public function countUserAreas($userId, $type, $areaAddLimit){
        if($userId == 1){
            return true;
        }
		
		$hasTitle = $this->find('all', [
						'conditions'=>['user_id'=>$userId, 'area_type'=>$type]
					])->toArray();
			
		$userAddedArea = count($hasTitle);
		
		if($userAddedArea >= $areaAddLimit){
			return false;
		}else{
			return true;
		}
	}
}
