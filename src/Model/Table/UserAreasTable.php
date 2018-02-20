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
class UserAreasTable extends Table
{

    /**
     * Initialize method
     *
     * @param array $config The configuration for the Table.
     * @return void
     */
	
    public function initialize(array $config)
    {
        $this->table('user_areas');
        $this->displayField('id');
        $this->primaryKey('id');
        $this->addBehavior('Timestamp');
        $this->belongsTo('Users');
		$this->belongsTo('Areas');
    }

	/**
     * Returns a user Area count
     * application integrity.
     *
     * @param user_id, area_limit
     * @return true/false
     */
	public function countUserAreas($userId, $areaAddLimit){
        if($userId == 1){
            return true;
        }

		$hasTitle = $this->find('all', [
						'conditions'=>['user_id'=>$userId]
					])->toArray();
			
		$userAddedArea = count($hasTitle);
		
		if($userAddedArea >= $areaAddLimit){
			return false;
		}else{
			return true;
		}
	}
}
