<?php 
$string = '';
$lessonId = '';
$lessonName = '';

foreach($lessonsArray as $lessons){
	$association = false;
	
	if(isset($lessons['Lessons']) && !empty($lessons['Lessons'])){
		foreach($lessons['Lessons'] as $k1=>$a){
			
			$lessonId = $k1;
			$lessonName = $a;
		}
		$string .= 'Lesson '.$lessonName;
	}

	if(isset($lessons['exercises']) && !empty($lessons['exercises'])){
		$string .= ' has ' . count($lessons['exercises']). ' Exercises ';
		$association = true;
	}
	
	if($association){
		$string .= ' associated with';
	}
		
	$string .= ', deleting will also delete all associated records <br/>';
}

echo $string;
?>
