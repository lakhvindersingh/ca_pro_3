<?php
	echo $this->Form->input(
		'user_id', array(
			'options'=>$usersList,
			'empty'=>'Select Teacher',
			'label'=>false,
			'default' => 1,
			'class' => 'input required w450'
		)
	);
?>