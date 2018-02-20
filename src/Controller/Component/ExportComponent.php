<?php
namespace App\Controller\Component;

use Cake\Controller\Component;

class ExportComponent extends Component {


	var $delimiter = ',';
	var $enclosure = '"';
	var $filename = 'Export.csv';
	var $line = array();
	var $buffer;
	var $output = '';


/**
 * The calling Controller
 *
 * @var Controller
 */
	public $controller;

/**
 * Starts up ExportComponent for use in the controller
 *
 * @param Controller $controller A reference to the instantiating controller object
 * @return void
 */
	public function startup(Controller $controller) {
		$this->controller = $controller;
	}

	function exportCsv($data, $fileName = '', $maxExecutionSeconds = null, $delimiter = ',', $enclosure = '"') {

		$this->controller->autoRender = false;

		// Flatten each row of the data array
		$flatData = array();
		foreach($data as $numericKey => $row){
			$flatRow = array();
			$this->flattenArray($row, $flatRow);
			$flatData[$numericKey] = $flatRow;
		}

		$headerRow = $this->getKeysForHeaderRow($flatData);
		$flatData = $this->mapAllRowsToHeaderRow($headerRow, $flatData);

		if(!empty($maxExecutionSeconds)){
			ini_set('max_execution_time', $maxExecutionSeconds); //increase max_execution_time if data set is very large
		}

		if(empty($fileName)){
			$fileName = "export_".date("Y-m-d").".csv";
		}

		$csvFile = fopen('php://output', 'w');
		header('Content-type: application/csv');
		header('Content-Disposition: attachment; filename="'.$fileName.'"');

		fputcsv($csvFile,$headerRow, $delimiter, $enclosure);
		foreach ($flatData as $key => $value) {
			fputcsv($csvFile, $value, $delimiter, $enclosure);
		}
		fclose($csvFile);
	}

	public function flattenArray($array, &$flatArray, $parentKeys = ''){
		foreach($array as $key => $value){
			$chainedKey = ($parentKeys !== '')? $parentKeys.'.'.$key : $key;
			if(is_array($value)){
				$this->flattenArray($value, $flatArray, $chainedKey);
			} else {
				$flatArray[$chainedKey] = $value;
			}
		}
	}

	public function getKeysForHeaderRow($data){
		$headerRow = array();
		foreach($data as $key => $value){
			foreach($value as $fieldName => $fieldValue){
				if(array_search($fieldName, $headerRow) === false){
					$headerRow[] = $fieldName;
				}
			}
		}

		return $headerRow;
	}

	public function mapAllRowsToHeaderRow($headerRow, $data){
		$newData = array();
		foreach($data as $intKey => $rowArray){
			foreach($headerRow as $headerKey => $columnName){
				if(!isset($rowArray[$columnName])){
					//$rowArray[$columnName] = '';
					$newData[$intKey][$columnName] = '';
				} else {
					$newData[$intKey][$columnName] = $rowArray[$columnName];
				}
			}
		}

		return $newData;
	}

	
	///////////////////////////////////////////////////////////////////////////////////
    ////////////////////////// CSV EXPORT /////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////
	
	public function initialize(array $config)
    {
        $this->clear();
    }
	
	function clear() 
	{
		$this->line = array();
		$this->buffer = fopen('php://temp/maxmemory:'. (5*1024*1024), 'w+');
	}

	function addField($value) 
	{
		$this->line[] = $value;
	}

	function endRow() 
	{
		$this->addRow($this->line);
		$this->line = array();
	}

	function addRow($row) 
	{
		fputcsv($this->buffer, $row, $this->delimiter, $this->enclosure);
	}

	function renderHeaders() 
	{
		header('Content-Type: text/csv');
		header("Content-type:application/vnd.ms-excel");
		header("Content-disposition:attachment;filename=".$this->filename);
	}

	function setFilename($filename) 
	{
		$this->filename = $filename;
		if (strtolower(substr($this->filename, -4)) != '.csv') 
		{
			$this->filename .= '.csv';
		}
	}

	function render($outputHeaders = true, $to_encoding = null, $from_encoding ="auto") 
	{
		if ($outputHeaders) 
		{
			if (is_string($outputHeaders)) 
			{
				$this->setFilename($outputHeaders);
			}
			$this->renderHeaders();
		}
		rewind($this->buffer);
		$output = stream_get_contents($this->buffer);

		if ($to_encoding) 
		{
			$output = mb_convert_encoding($output, $to_encoding, $from_encoding);
		}
		return $output;
		
		/*
		if (!$fp = fopen('php://temp', 'w+')) return FALSE;
		fputcsv($fp, array('ID', 'Company', 'Name', 'Company Account Number', 'Email', 'Phone Number', 'Invoice'));
		while ($line = mysql_fetch_assoc($data)) fputcsv($fp, $line);
		rewind($fp);
		return stream_get_contents($fp);
		* 
		*/
	}

}
