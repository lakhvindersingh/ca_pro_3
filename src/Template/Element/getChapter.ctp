<?php
	if(!empty($chaptersList)){
		echo $this->Form->input(
			'chapter_id', array(
				'options'=>$chaptersList,
				'empty'=>'Select Chapter',
				'label'=>false,
				'class' => 'input required w450'
			)
		);
	}else{
		echo $this->Form->input(
			'chapter_title', array(
				'placeholder'=>'Add New Chapter',
				'label'=>false,
				'class' => 'input required w450'
			)
		);
	}
?>
