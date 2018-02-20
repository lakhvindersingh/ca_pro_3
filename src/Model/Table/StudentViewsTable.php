<?php
namespace App\Model\Table;

use App\Model\Entity\StudentView;
use Cake\ORM\Query;
use Cake\ORM\RulesChecker;
use Cake\ORM\Table;
use Cake\Validation\Validator;

/**
 * Lessons Model
 */
class StudentViewsTable extends Table
{

    /**
     * Initialize method
     *
     * @param array $config The configuration for the Table.
     * @return void
     */
    public function initialize(array $config)
    {
        $this->table('student_views');
        $this->displayField('id');
        $this->primaryKey('id');
        $this->addBehavior('Timestamp');
        $this->belongsTo('Students');
        $this->belongsTo('Areas');
        $this->belongsTo('Chapters');
        $this->belongsTo('Lessons');
        $this->belongsTo('Exercises');
        $this->belongsTo('Statuses');
        
        $this->belongsTo('UserPlans', [
            'className' => 'UserPlans',
            'foreignKey' => 'user_plan_id'
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
            //->requirePresence('user_id', 'create', 'User ID should not be empty.')
            //->notEmpty('user_id','User ID should not be empty.')
            ->requirePresence('student_id', 'create', 'Student ID should not be empty.')
            ->notEmpty('student_id','Student ID should not be empty.')
			->requirePresence('area_id', 'create', 'Area ID should not be empty.')
            ->notEmpty('area_id','Area ID should not be empty.')
            ->requirePresence('chapter_id', 'create', 'Chapter ID should not be empty.')
            ->notEmpty('chapter_id','Chapter ID should not be empty.')
            ->requirePresence('lesson_id', 'create', 'Lesson ID should not be empty.')
            ->notEmpty('lesson_id','Lesson ID should not be empty.');
            
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
}
