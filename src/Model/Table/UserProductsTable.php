<?php
namespace App\Model\Table;

use App\Model\Entity\UserPlan;
use Cake\ORM\Query;
use Cake\ORM\RulesChecker;
use Cake\ORM\Table;
use Cake\Validation\Validator;
use Cake\ORM\Behavior; 

/**
 * Lessons Model
 */
class UserProductsTable extends Table
{

    /**
     * Initialize method
     *
     * @param array $config The configuration for the Table.
     * @return void
     */
    public function initialize(array $config)
    {
        $this->table('user_products');
        $this->displayField('id');
        $this->primaryKey('id');
        $this->addBehavior('Timestamp');
        
        $this->belongsTo('Users', [
            'className' => 'Users',
            'foreignKey' => 'user_id'
        ]);

		$this->belongsTo('Products', [
            'className' => 'Products',
            'foreignKey' => 'product_id'
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
            ->requirePresence('user_id', 'create', 'User ID should not be empty.')
            ->notEmpty('user_id','User ID should not be empty.');
            
        return $validator;
    }
}
