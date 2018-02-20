
<div class="row">
    <div class="floatleft mtop10">
    	<h1>
    		<?php echo __('Add Exercises - Bulk Import'); ?>
		</h1>
	</div>
    <div class="floatright">
        <?php
			echo $this->Html->link('<span>'.__('Back To Manage Exercises').'</span>', array('action' => 'index'),array('class'=>'black_btn', 'escape'=>false));
		?>
	</div>
</div>
<div align="center" class="whitebox mtop15">
    <?= $this->Form->create('Users',['class' => 'validate_form', 'type'=>'file']) ?>
    <table cellspacing="0" cellpadding="7" border="0" align="center">
		<tr>
			<td align="left"><strong class="upper">Exercises Type</strong></td>
			<td align="left">
			<?php
				$exercise_type = ['1'=>'Primary', '2'=>'Elementry'];
				echo $this->Form->input(
					'exercise_type', array(
						'options'=>$exercise_type,
						'empty'=>'Exercises Type',
						'label'=>false,
						'class' => 'input required w450'
					)
				);
			?>
			</td>
		</tr>
		<tr>
			<td align="left"><strong class="upper">Choose .Json file</strong></td>
			<td align="left">
			<?php
				echo $this->Form->file(
					'json', array(
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
