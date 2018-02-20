<?php
namespace App\Model\Table;

use App\Model\Entity\Area;
use Cake\ORM\Query;
use Cake\ORM\RulesChecker;
use Cake\ORM\Table;
use Cake\Validation\Validator;

/**
 * Chapters Model
 */
class ChaptersTable extends Table
{

    /**
     * Initialize method
     *
     * @param array $config The configuration for the Table.
     * @return void
     */
    public function initialize(array $config)
    {
        $this->table('chapters');
        $this->displayField('id');
        $this->primaryKey('id');
        $this->addBehavior('Timestamp');
        $this->belongsTo('Areas');
        $this->belongsTo('Users');
        $this->hasMany('Lessons', ['dependent' => true]);
		$this->hasMany('UserChapters');
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
            ->requirePresence('title', 'create', 'Chapter name required.')
            ->notEmpty('title','Chapter name should not be empty.')
			->add('title', [
				'rule1' =>[
					'rule' => 'uniqueTitle',
					'provider' => 'table',
					'message' => 'Chapter with this name is already exist. Try different'
				]
			])
			->requirePresence('area_id', 'create', 'Area ID should not be empty.')
            ->notEmpty('area_id','Area ID should not be empty.');
            
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
    public function uniqueTitle($title){
		return true;
		$hasTitle = $this->find('all', [
						'conditions'=>['title'=>$title]
					])->first();
			
		if($hasTitle){
			return false;
		}else{
			return true;
		}
	}
}
