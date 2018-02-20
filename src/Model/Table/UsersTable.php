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
        $this->addBehavior('Captcha', [
                    'field' => 'securitycode',
                    'message' => 'Incorrect captcha code value'
                ]);

		$this->hasOne('UserProducts');
		$this->hasOne('Products');

        $this->belongsTo('Countries');
        $this->hasMany('Students', [
            'dependent' => true,
        ]);
        $this->hasMany('Notes', [
            'dependent' => true,
        ]);
        $this->hasMany('Areas', [
            'dependent' => true,
        ]);
        $this->hasMany('Chapters', [
            'dependent' => true,
        ]);
        $this->hasMany('Lessons', [
            'dependent' => true,
        ]);
        $this->hasMany('Exercises', [
            'dependent' => true,
        ]);
        $this->hasMany('UserPlans', [
            'foreignKey' => 'user_id',
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
            ->requirePresence('email', 'create', 'Email required.')
            ->requirePresence('username', 'create', 'Username required.')
            ->requirePresence('password', 'create', 'Password required.')
			->add('password', [
				'compare' => [
					'rule' => ['compareWith', 'confirm_password'],
					'message' => 'Both password do not match.'
				]
			])
            ->requirePresence('first_name', 'create', 'First name required.')
            ->requirePresence('last_name', 'create', 'Last name required.')
            ->add('email', 'validFormat',[
                    'rule' => 'email',
                    'message' => 'E-mail must be valid.'
                ])
            ->add('email', [ 'unique' => ['rule' => 'validateUnique', 'provider' => 'table', 'message' => 'This email already has an account.'] ])
            ->add('username', [ 'unique' => ['rule' => 'validateUnique', 'provider' => 'table', 'message' => 'Username already existing.'] ])
            ->notEmpty('password','Please enter password.')
            ->notEmpty('first_name','First name should not be empty.')
            ->notEmpty('last_name','Last name should not be empty.')
            ->requirePresence('classroom', 'create', 'User classroom is required.')
            ->notEmpty('classroom', 'classroom cannot be left empty.')
			->requirePresence('product_id', 'create', 'Product ID is required.')
            ->notEmpty('product_id', 'Product ID cannot be left empty.');
            
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
