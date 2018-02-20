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
class UserChaptersTable extends Table
{

    /**
     * Initialize method
     *
     * @param array $config The configuration for the Table.
     * @return void
     */
    public function initialize(array $config)
    {
        $this->table('user_chapters');
        $this->displayField('id');
        $this->primaryKey('id');
        $this->addBehavior('Timestamp');
        $this->belongsTo('Areas');
        $this->belongsTo('Users');
		$this->belongsTo('Chapters');
    }

}
