<div class="row">
    <div class="floatleft mtop10">
    	<h1>
    		<?php echo __('Add Student'); ?>
		</h1>
	</div>
    <div class="floatright">
        <?php
			echo $this->Html->link(
				'<span>'.__('Back To Manage Students').'</span>', array(
					'controller' => 'Students', 'action' => 'index'
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
			<td align="left"><strong class="upper">First Name</strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'first_name', array(
						'label'=>false,
						'class' => 'input required w450',
					)
				);
			?>
			</td>
		</tr>
		<tr>
			<td align="left"><strong class="upper">Last Name</strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'last_name',array(
						'label'=>false,
						'class' => 'input required w450',
					)
				);
			?>
			</td>
		</tr>
		
		<tr>
			<td align="left"><strong class="upper">Date of Birth</strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'birthday',array(
						'label'=>false,
						'class' => 'input required w450 datepicker',
					)
				);
			?>
			</td>
		</tr>

		<tr>
			<td align="left"><strong class="upper">Teacher</strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'user_id', array(
						'options'=>$usersList,
						'empty'=>'Select Teacher',
						'label'=>false,
						'class' => 'input required w450'
					)
				);
			?>
			</td>
		</tr>
		
		<tr>
			<td align="left"><strong class="upper">Status</strong></td>
			<td align="left">
			<?php
				$status = ['1'=>'Active','0'=>'Inactive'];
				echo $this->Form->input(
					'status', array(
						'options'=>$status,
						'empty'=>'Select status',
						'label'=>false,
						'class' => 'input required w450'
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
