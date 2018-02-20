<div class="row">
    <div class="floatleft mtop10">
    	<h1>
    		<?php echo __('Edit User'); ?>
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
    <?= $this->Form->create($user,['class' => 'validate_form', 'type'=>'file']) ?>
    <table cellspacing="0" cellpadding="7" border="0" align="center">
		<?php echo $this->Form->input('id'); ?>
		<tr>
			<td align="left"><strong class="upper"><?php echo __('Email'); ?></strong></td>
			<td align="left">
				<?php
					echo $this->Form->input('email', ['label'=>false, 'class'=>'input required email w450']);
				?>
			</td>
		</tr>
		<tr>
			<td align="left"><strong class="upper"><?php echo __('First Name'); ?></strong></td>
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
			<td align="left"><strong class="upper"><?php echo __('Last Name'); ?></strong></td>
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
			<td align="left"><strong class="upper"><?php echo __('Profile Image'); ?></strong></td>
			<td align="left">
			<?php 
			
				if(isset($user->image) && !empty($user->image)){
					if(FILE_EXISTS('uploads'.DS.USER_IMAGE_URL.$user->id.DS.$user->image)){
						$imgName = 'uploads'.DS.USER_IMAGE_URL.$user->id.DS.$user->image;
						echo $this->Html->image('../'.$imgName,array('style'=>'width:150px;'));
					}
					echo '<br/>';
					echo $this->Form->file(
						'image', array(
							'label'=>false,
							'class' => 'file input w450',
						)
					);
				}else{
					echo $this->Form->file(
						'image', array(
							'label'=>false,
							'class' => 'input w450',
						)
					);
				}
			?>
			</td>
		</tr>
		<tr>
			<td align="left"><strong class="upper"><?php echo __('Phone'); ?></strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'mobile', array(
						'label'=>false,
						'class' => 'input required w450',
					)
				);
			?>
			</td>
		</tr>
		<tr>
			<td align="left"><strong class="upper"><?php echo __('Address'); ?></strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'address', array(
						'label'=>false,
						'class' => 'input w450',
						'type'	=>	'textarea'
					)
				);
			?>
			</td>
		</tr>
		<tr>
			<td align="left"><strong class="upper"><?php echo __('City'); ?></strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'city', array(
						'label'=>false,
						'class' => 'input w450',
					)
				);
			?>
			</td>
		</tr>
		<tr>
			<td align="left"><strong class="upper"><?php echo __('State'); ?></strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'state', array(
						'label'=>false,
						'class' => 'input w450',
					)
				);
			?>
			</td>
		</tr>
		<tr>
			<td align="left"><strong class="upper"><?php echo __('Country'); ?></strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'country_id', array(
						'label'=>false,
						'empty'=>'Select Country',
						'options'=>$countryList,
						'class' => 'input w450',
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
			<td align="left"><strong class="upper"><?php echo __('Status'); ?></strong></td>
			<td align="left">
			<?php
				$status = ['1'=>'Active','0'=>'Inactive'];
				echo $this->Form->input(
					'is_active', array(
						'options'=>$status,
						'empty'=>'Select Status',
						'label'=>false,
						'class' => 'input required w450'
					)
				);
			?>
			<?php echo $this->Form->hidden('id'); ?>
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
