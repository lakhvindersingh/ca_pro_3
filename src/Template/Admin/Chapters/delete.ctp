<?php 
$string = '';
$chapterId = '';
$chapterName = '';

foreach($chapterArray as $chapterArray){
	$association = false;
	if(isset($chapterArray['Chapter']) && !empty($chapterArray['Chapter'])){
		foreach($chapterArray['Chapter'] as $k1=>$a){
			$chapterId = $k1;
			$chapterName = $a;
		}
		$string .= 'Chapter '.$chapterName;
	}

	if(isset($chapterArray['Lesson']) && !empty($chapterArray['Lesson'])){
		 $string .= ' has ' . count($chapterArray['Lesson']). ' Lessons';
		 $association = true;
	}

	if(isset($chapterArray['exercises']) && !empty($chapterArray['exercises'])){
		$string .= ' and '. count($chapterArray['exercises']). ' Exercises';
		$association = true;
	}
	
	if($association){
		$string .= ' associated with';
	}
		
	$string .= ', deleting will also delete all associated records <br/>';
}

echo $string;
?>
