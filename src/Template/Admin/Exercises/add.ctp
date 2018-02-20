<div class="row">
    <div class="floatleft mtop10">
    	<h1>
    		<?php echo __('Add Exercise'); ?>
		</h1>
	</div>
    <div class="floatright">
        <?php
			echo $this->Html->link(
				'<span>'.__('Back To Manage Exercise').'</span>', array(
					'controller' => 'Exercises', 'action' => 'index'
				),array(
					'class'=>'black_btn', 'escape'=>false
				)
			);
		?>
	</div>
</div>
<div align="center" class="whitebox mtop15">
    <?= $this->Form->create('chapters',['class' => 'validate_form']) ?>
    <table cellspacing="0" cellpadding="7" border="0" align="center">
		
		<tr>
			<td align="left"><strong class="upper">Object ID</strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'object_id', array(
						'label'=>false,
						'class' => 'input w450',
						'placeholder' =>'Leave Empty to auto generate',
						'type'=>'text'
					)
				);
			?>
			</td>
		</tr>
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
			<td align="left"><strong class="upper">Chapter </strong></td>
			<td align="left" id="runtime_chapters">
			<?php
				echo $this->Form->input(
					'chapter_id', array(
						'options'=>$chaptersList,
						'empty'=>'Select Chapter',
						'label'=>false,
						'class' => 'input required w450'
					)
				);
			?>
			</td>
		</tr>
		
		<tr>
			<td align="left"><strong class="upper">Lesson </strong></td>
			<td align="left" id="runtime_lessons">
			<?php
				echo $this->Form->input(
					'lesson_id', array(
						'options'=>$lessonsList,
						'empty'=>'Select Lesson',
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
						'default' => 1,
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
<?php $runtimeElements = $this->Url->build(array('controller' => 'Dashboard', 'action' => 'getRuntimeElements', 'prefix' => 'admin'), true); ?>
<script>
	$(window).load(function(){
		var area_id = $('#area-id').val();
		var chapter_id = $('#chapter-id').val();	

		if(area_id == ""){
			return false;
		}

		$.ajax({
			url 		: '<?= $runtimeElements?>',
			method		: 'POST',
			dataType	: 'html',
			data		: {
				'action'	: 'getChapter',
				'area_id'	: area_id,
			},
			success : function(response) {
				$('#runtime_chapters').html(response);
					$('#chapter-id').val(chapter_id);
					
					if(chapter_id == ""){
						return false;
					}

					$.ajax({
						url 		: '<?= $runtimeElements?>',
						method		: 'POST',
						dataType	: 'html',
						data		: {
							'action'		: 'getLesson',
							'chapter_id'	: chapter_id,
						},
						success : function(response) {
							$('#runtime_lessons').html(response);
							return false;
						}
					});
				return false;
			}
		});
	});

	$(document).ready(function (){
		$( "#datepicker" ).datepicker();
		$('.validate').validate();
		
		/*
		* Get Chapter using area Id
		*/

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
		
		$(document).on('change', '#area-id', function (){
			var area_id = $(this).val();
			
			if(area_id == ""){
				return false;
			}

			$.ajax({
				url 		: '<?= $runtimeElements?>',
				method		: 'POST',
				dataType	: 'html',
				data		: {
					'action'	: 'getChapter',
					'area_id'	: area_id,
				},
				success : function(response) {
					$('#runtime_chapters').html(response);
					return false;
				}
			});
		});
		
		/*
		* Get Lessons using area Id
		*/
		
		$(document).on('change', '#chapter-id', function (){
			var chapter_id = $(this).val();
			
			if(chapter_id == ""){
				return false;
			}
			
			$.ajax({
				url 		: '<?= $runtimeElements?>',
				method		: 'POST',
				dataType	: 'html',
				data		: {
					'action'		: 'getLesson',
					'chapter_id'	: chapter_id,
				},
				success : function(response) {
					$('#runtime_lessons').html(response);
					return false;
				}
			});
		});
	});
</script>

