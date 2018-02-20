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

$cakeDescription = 'Montessori Notes admin panel!';
?>
<!DOCTYPE html>
<html>
	<head>
	    <?= $this->Html->charset() ?>
	    <!--<meta name="viewport" content="width=device-width, initial-scale=1.0">-->
	    <meta name="viewport" content="width=1000, initial-scale=1">
	    <title>
	        <?= $cakeDescription ?>:
	        <?= $this->fetch('title') ?>
	    </title>
	    <?= $this->Html->meta('icon') ?>

	    <?= $this->Html->css('admin-style') ?>
	    <?= $this->Html->css('jquery-ui') ?>
	    <?= $this->Html->script('jquery.min') ?>
		<?= $this->Html->script('jquery-ui') ?>

	    <?= $this->fetch('meta') ?>
	    <?= $this->fetch('css') ?>
	    <?= $this->fetch('script') ?>
	    
	    <?php 
			$value = $this->request->env('HTTP_HOST');
			$is_server = true;
			if($value == "localhost" || $value == "127.0.0.1" || $value== "www.localhost.com"){
				$is_server = false;
				$value = $value . '/' .'teacher-tracking/website/';
			}
			$url = '';
			$prefix = isset($this->request->params['prefix']) ? $this->request->params['prefix'] : NULL;
			if(!empty($prefix)){
				$url = BASE_URL. $prefix . '/'  ;
			}else{
				if($is_server){
					$url = BASE_URL. 'Teacher/' ;    
				}else{
					$url = 'http://'.BASE_URL;    
				}
				
			}
		?>
		<?php 
			$prefix = false; 
			if(isset($this->request->params['prefix']) && !empty($this->request->params['prefix'])){
				$prefix = true;
			}
		?>
		
		<script>
			$(document).ready(function(){
				defaultUrl = '<?= $url ?>';
				ajaxUrl = '';
			});
		</script>
		
	</head>
	<body class="greybg">
		<!--Wrapper Start from Here-->
		<div id="wrapper">
			<!--Header Start from Here-->
			<?php echo $this->element('admin_header'); ?>
			<div class="body-sec">
				<?php echo $this->element('admin_nav'); ?>
				<?= $this->Flash->render() ?>
				<div id="container"  class="right-side-sec">
					<?= $this->fetch('content') ?>
				</div>
			</div>
			<?php echo $this->element('admin_footer'); ?>
		  <!--Container end Here-->
		</div>
		<!--Wrapper End from Here-->
		</div>
		<div id="dialog-confirm" title="Confirm">
			<div class="confirm-img">
				<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span></p>
			</div>
			<div class="confirm-txt">
				<p><span id="confirm-box-text">Are you sure?</span></p>
				<input type="hidden" value="" id="confirm-box-delete" data-attr="">
			</div>
			</div>
		</div>
	    <?= $this->Html->script('common');?>
	    <?= $this->Html->script('admin-script');?>
		<?= $this->Html->script('jquery.validate.min') ?>
		<?= $this->Html->script('additional-methods.min') ?>
		<?= $this->Html->script('ckeditor/ckeditor');?>
		<?= $this->Html->script('dalert.jquery') ?>
		<?= $this->Html->script('textarea') ?>
		<style>
		.confirm-img{
			width: 20px;
			display: inline-block;
			float: left;
		}
		.confirm-txt{
			float: left;
		}
		</style>
	</body>
</html>
