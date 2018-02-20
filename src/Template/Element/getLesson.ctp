<?php
	if(!empty($lessonsList)){
		echo $this->Form->input(
			'lesson_id', array(
				'options'=>$lessonsList,
				'empty'=>'Select Lesson',
				'label'=>false,
				'class' => 'input required w450'
			)
		);
	}else{
		echo $this->Form->input(
			'lesson_title', array(
				'placeholder'=>'Add New Lesson',
				'label'=>false,
				'class' => 'input required w450'
			)
		);
	}
?>
