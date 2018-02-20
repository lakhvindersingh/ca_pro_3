<div class="row">
    <div class="floatleft mtop10">
    	<h1>
    		<?php echo __('Edit Areas'); ?>
		</h1>
	</div>
    <div class="floatright">
        <?php
			echo $this->Html->link(
				'<span>'.__('Back To Manage Areas').'</span>', array(
					'controller' => 'Areas', 'action' => 'index'
				),array(
					'class'=>'black_btn', 'escape'=>false
				)
			);
		?>
	</div>
</div>
<div align="center" class="whitebox mtop15">
    <?= $this->Form->create($chapters,['class' => 'validate_form']) ?>
    <table cellspacing="0" cellpadding="7" border="0" align="center">
		
		<tr>
			<td align="left"><strong class="upper">Title</strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'title', array(
						'label'=>false,
						'class' => 'input required w450',
					)
				);
			?>
			<?= $this->Form->hidden('id');?>
			</td>
		</tr>
		<tr>
			<td valign="top" align="left"><strong class="upper">Description</strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'description',array(
						'label'=>false,
						'type'=>'textarea',
						'class' => 'textarea w450',
					)
				);
			?>
			</td>
		</tr>
		
		<tr>
			<td align="left"><strong class="upper">Area </strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'area_id', array(
						'options'=>$areasList,
						'empty'=>'Select Area',
						'label'=>false,
						'class' => 'input required w450'
					)
				);
			?>
			</td>
		</tr>
		
		<tr>
			<td align="left"><strong class="upper">Teacher</strong></td>
			<td align="left" id="teacher_list">
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

	$(document).on('change', '#area-id', function(){
		var area_id = $(this).val();
		$.ajax({
			url			: defaultUrl + 'chapters/getTeacher',
			type		: 'POST',
			dataType	: 'html',
			data		: {
				'area_id' : area_id
			},
			success : function(response){
				$('#teacher_list').html(response);
				return false;
			}
		});
	});
</script>
