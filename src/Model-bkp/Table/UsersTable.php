<?php
namespace App\Model\Table;

use App\Model\Entity\User;
use Cake\ORM\Query;
use Cake\ORM\RulesChecker;
use Cake\ORM\Table;
use Cake\Validation\Validator;

/**
 * Users Model
 */
class UsersTable extends Table
{

    /**
     * Initialize method
     *
     * @param array $config The configuration for the Table.
     * @return void
     */
    public function initialize(array $config)
    {
        $this->table('users');
        $this->displayField('id');
        $this->primaryKey('id');
        $this->addBehavior('Timestamp');
        $this->hasMany('Students');
        $this->hasMany('Notes');
        $this->hasMany('Areas');
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
            ->requirePresence('email', 'create', 'Email required.')
            ->requirePresence('username', 'create', 'Username required.')
            ->requirePresence('password', 'create', 'Password required.')
            ->requirePresence('first_name', 'create', 'First name required.')
            ->requirePresence('last_name', 'create', 'Last name required.')
            ->add('email', 'validFormat',[
                    'rule' => 'email',
                    'message' => 'E-mail must be valid.'
                ])
            ->add('email', [ 'unique' => ['rule' => 'validateUnique', 'provider' => 'table', 'message' => 'Email address already existing.'] ])
            ->add('username', [ 'unique' => ['rule' => 'validateUnique', 'provider' => 'table', 'message' => 'Username already existing.'] ])
            ->notEmpty('password','Please enter password.')
            ->notEmpty('first_name','First name should not be empty.')
            ->notEmpty('last_name','Last name should not be empty.');
            
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
        $rules->add($rules->isUnique(['email'], __('This email is already in use')));
        return $rules;
    }
}
