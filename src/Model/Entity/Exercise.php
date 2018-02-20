<?php
namespace App\Model\Entity;

use Cake\Auth\DefaultPasswordHasher;
use Cake\ORM\Entity;
/**
 * Area Entity.
 */
class Exercise extends Entity
{

    /**
     * Fields that can be mass assigned using newEntity() or patchEntity().
     *
     * @var array
     */

    // Make all fields mass assignable for now.
    protected $_accessible = ['*' => true];

}

