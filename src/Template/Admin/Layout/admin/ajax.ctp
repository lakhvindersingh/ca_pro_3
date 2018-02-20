<?php
/**
 * CakePHP(tm) : Rapid Development Framework (http://cakephp.org)
 * Copyright (c) Cake Software Foundation, Inc. (http://cakefoundation.org)
 *
 * Licensed under The MIT License
 * For full copyright and license information, please see the LICENSE.txt
 * Redistributions of files must retain the above copyright notice.
 *
 * @copyright     Copyright (c) Cake Software Foundation, Inc. (http://cakefoundation.org)
 * @link          http://cakephp.org CakePHP(tm) Project
 * @since         0.10.0
 * @license       http://www.opensource.org/licenses/mit-license.php MIT License
 */
?>
<?= $this->Html->meta('icon') ?>
		<?= $this->Html->css('jquery-ui') ?>
		<?= $this->Html->css('reset') ?>
		<?= $this->Html->css('font-awesome') ?>
		<?= $this->Html->css('style') ?>
		<?= $this->Html->css('custom') ?>
		<?= $this->Html->css('flexslider') ?>
		<?= $this->Html->css('responsive') ?>
		<?= $this->Html->css('jquery-ui.structure.min') ?>
		<?= $this->Html->css('jquery-ui.theme.min') ?>
		<?= $this->Html->script('jquery.min') ?>
		<?= $this->Html->script('jquery-ui') ?>
		<?= $this->Html->script('jquery.countdown.min') ?>
		<?= $this->Html->script('custom/user_settings') ?>

		<?= $this->fetch('meta') ?>
		<?= $this->fetch('css') ?>
		<?= $this->fetch('script') ?>
<?= $this->fetch('content') ?>
