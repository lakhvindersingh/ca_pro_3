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
    <?= $this->Form->create($areas,['class' => 'validate_form']) ?>
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
				echo $this->Form->hidden('id');
			?>
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
						'class' => 'textarea required w450',
					)
				);
			?>
			</td>
		</tr>
		
		<tr>
			<td align="left"><strong class="upper">Area Color</strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'area_color',array(
						'label'=>false,
						'class' => 'input w450',
						'type'=>'color',
					)
				);
			?>
			</td>
		</tr>
		
		<tr>
			<td align="left"><strong class="upper">Area Type</strong></td>
			<td align="left">
			<?php
				$area_type = ['1'=>'Primary', '2'=>'Elementry'];
				echo $this->Form->input(
					'area_type', array(
						'options'=>$area_type,
						'empty'=>'Area Type',
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

	$(document).on('change', '#area-type', function(){
		var area_type = $(this).val();
		$.ajax({
			url			: defaultUrl + 'areas/getTeacher',
			type		: 'POST',
			dataType	: 'html',
			data		: {
				'area_type' : area_type
			},
			success : function(response){
				$('#teacher_list').html(response);
				return false;
			}
		});
	});
</script>
