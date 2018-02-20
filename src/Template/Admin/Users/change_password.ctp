<div class="row">
    <div class="floatleft mtop10">
    	<h1>
    		<?php echo __('Change Password'); ?>
		</h1>
	</div>
    <div class="floatright">
        <?php
			echo $this->Html->link(
				'<span>'.__('Back To Manage Users').'</span>', array(
					'controller' => 'Users', 'action' => 'index'
				),array(
					'class'=>'black_btn', 'escape'=>false
				)
			);
		?>
	</div>
</div>
<div align="center" class="whitebox mtop15">
    <?= $this->Form->create('Users',['class' => 'validate_form']) ?>
    <table cellspacing="0" cellpadding="7" border="0" align="center">
		<tr>
			<td align="left"><strong class="upper"><?php echo __('Old Password'); ?></strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'old_password', array(
						'label'=>false,
						'type'=>'password',
						'class' => 'input required w450',
					)
				);
			?>
			</td>
		</tr>
		<tr>
			<td align="left"><strong class="upper"><?php echo __('New Password'); ?></strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'password',array(
						'label'=>false,
						'type'=>'password',
						'class' => 'input required w450',
					)
				);
			?>
			</td>
		</tr>
		<tr>
			<td align="left"><strong class="upper"><?php echo __('Confirm Password'); ?></strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'confirm_password',array(
						'label'=>false,
						'type'=>'password',
						'class' => 'input required w450',
					)
				);
				
			?>
			</td>
		</tr>
		<tr>
			<td align="center">&nbsp;</td>
			<td align="left"><div class="black_btn2"><span class="upper"><input type="submit" value="SUBMIT" name=""></span></div></td>
		</tr>
    </table>
    <?= $this->Form->end() ?>
</div>
<script>
	$(document).ready(function (){
		$( "#datepicker" ).datepicker();
		$('.validate').validate();
	});
</script>
