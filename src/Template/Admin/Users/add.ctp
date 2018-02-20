<div class="row">
    <div class="floatleft mtop10">
    	<h1>
    		<?php echo __('Add Teacher'); ?>
		</h1>
	</div>
    <div class="floatright">
        <?php
			echo $this->Html->link(
				'<span>'.__('Back To Manage Teachers').'</span>', array(
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
			<td align="left"><strong class="upper">Email</strong></td>
			<td align="left">
				<?php
					echo $this->Form->input(
						'email',array(
							'label'=>false,
							'class' => 'input required email w450'
						)
					);
				?>
			</td>
		</tr>
		<tr>
			<td align="left"><strong class="upper">Username</strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'username', array(
						'label'=>false,
						'class' => 'input required w450',
					)
				);
			?>
			</td>
		</tr>
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
			<td align="left"><strong class="upper">Phone</strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'phone', array(
						'label'=>false,
						'class' => 'input required w450',
					)
				);
			?>
			</td>
		</tr>
		<tr>
			<td align="left"><strong class="upper">Password</strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'password', array(
						'label'=>false,
						'class' => 'input required w450',
					)
				);
			?>
			</td>
		</tr>
		<tr>
			<td align="left"><strong class="upper">User Type</strong></td>
			<td align="left">
			<?php
				$userType = ['1'=>'Primary','2'=>'Elementry'];
				echo $this->Form->input(
					'user_type', array(
						'options'=>$userType,
						'empty'=>'Select User Type',
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
				$status = ['1'=>'Active','0'=>'Deactive'];
				echo $this->Form->input(
					'is_active', array(
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