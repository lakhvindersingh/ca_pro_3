<?php 
$string = '';
$areaId = '';
$areaName = '';
foreach($chapterArray as $areaArray){
	$association = false;
	if(isset($areaArray['Area']) && !empty($areaArray['Area'])){
		foreach($areaArray['Area'] as $k1=>$a){
			$areaId = $k1;
			$areaName = $a;
		}
	}

	if(isset($areaArray['Chapter']) && !empty($areaArray['Chapter'])){
		$string .= 'Area '.$areaName.' has ' . count($areaArray['Chapter']). ' Chapters';
		$association = true;
	}

	if(isset($areaArray['Lesson']) && !empty($areaArray['Lesson'])){
		$string .= ' and '. count($areaArray['Lesson']). ' Lessons';
		$association = true;
	}

	if(isset($areaArray['exercises']) && !empty($areaArray['exercises'])){
		$string .= ' and '. count($areaArray['exercises']). ' Exercises';
		$association = true;
	}
	
	if($association){
		$string .= ' associated with';
	}
	
	$string .= ' , deleting will also delete all associated records <br/>';
}

echo $string;
?>
