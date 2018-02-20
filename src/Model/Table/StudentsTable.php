<?php
namespace App\Model\Table;

use App\Model\Entity\Student;
use Cake\ORM\Query;
use Cake\ORM\RulesChecker;
use Cake\ORM\Table;
use Cake\Validation\Validator;

/**
 * Students Model
 */
class StudentsTable extends Table
{

    /**
     * Initialize method
     *
     * @param array $config The configuration for the Table.
     * @return void
     */
    public function initialize(array $config)
    {
        $this->table('students');
        $this->displayField('id');
        $this->primaryKey('id');
        $this->addBehavior('Timestamp');
        $this->belongsTo('Users');
        $this->hasMany('StudentViews', [
			'dependent' => true,	
		]);
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
            ->requirePresence('first_name', 'create', 'First name required')
            ->requirePresence('last_name', 'create', 'Last name required')
            ->notEmpty('first_name','First name should not be empty')
            ->notEmpty('last_name','Last name should not be empty')
            ->requirePresence('status', 'create', 'Status is required')
            ->notEmpty('status','Status should not be empty');
            
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
     * Returns a user Area count
     * application integrity.
     *
     * @param user_id, area_limit
     * @return true/false
     */
	public function countUserStudents($userId, $studentCountLimit){
        if($userId == 1){
            return true;
        }
		
		$hasTitle = $this->find('all', [
						'conditions'=>['user_id'=>$userId]
					])->toArray();
			
		$userAddedStudent = count($hasTitle);
		
		if($userAddedStudent >= $studentCountLimit){
			return false;
		}else{
			return true;
		}
	}
}
