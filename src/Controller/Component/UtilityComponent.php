<?php
/**
 * CakePHP(tm) : Rapid Development Framework (http://cakephp.org)
 * Copyright (c) Cake Software Foundation, Inc. (http://cakefoundation.org)
 *
 * Licensed under The MIT License
 * For full copyright and license information, please see the LICENSE.txt
 * Redistributions of files must retain the above copyright notice.
 *
 * @copyright     Copyright (c) Cake Software Foundation, Inc. (http://cakefoundation.org)
 * @link          http://cakephp.org CakePHP(tm) Project
 * @since         0.10.0
 * @license       http://www.opensource.org/licenses/mit-license.php MIT License
 */
namespace App\Controller\Component;

use Cake\Controller\Component;
use Cake\Routing\Router;
/**
 * Utility component class
 *
 * Used for several common methods
 * @author Agam
 * 
 */
class UtilityComponent extends Component
{
	 protected $_defaultConfig = [
        'is_thumb_generation' => false,
        'thumb_width' => 200,
    ];
	
/**
 * Purpose : The function will be used for sanitizing the file name
 * @author Agam
 * @param string| File name
 * @return sanitized file name
 */
	public function clean_file_name($filename)
	{
		return preg_replace("/[^a-z0-9\.]/", "", strtolower($filename));
	}
/**
 * Purpose : The function will be used for image saving
 * @author Agam
 * @param integer | Id of the record
 * @param array| The multipart image array
 * @param string| Image Type Folder
 * @return true if saved else fail
 */
	public function saveFileToServer($img_data, $img_type)
    {
		//pr($img_data);
    	$return = array('status' => false, 'name' => '');
    	$dir_path = WWW_ROOT . 'uploads' . DS . $img_type . DS ;
		// creating the directory of new model uploads
		if (!file_exists($dir_path))
		{
			mkdir($dir_path , 0777, true);
		}
		$dir_path = $dir_path . DS;
		if (!file_exists($dir_path))
		{
			mkdir($dir_path, 0777, true);
		}
		$fileName = mt_rand() . '_' . $this->clean_file_name($img_data['name']);
		$file_path = $dir_path . $fileName;
		@move_uploaded_file($img_data['tmp_name'], $file_path);		
		return array('status' => true, 'name' => $fileName );
    }

    public function saveVideoToServer($id, $img_data, $img_type)
    {
    	$return = array('status' => false, 'name' => '');
    	$dir_path = WWW_ROOT . 'uploads' . DS . $img_type . DS ;
		// creating the directory of new model uploads
		if (!file_exists($dir_path))
		{
			mkdir($dir_path , 0777, true);
		}
		$dir_path = $dir_path . $id . DS;
		if (!file_exists($dir_path))
		{
			mkdir($dir_path, 0777, true);
		}
		$fileName = mt_rand() . '_' . $this->clean_file_name($img_data['name']);
		$file_path = $dir_path . $fileName;
		@move_uploaded_file($img_data['tmp_name'], $file_path);
		return array('status' => true, 'name' => $fileName );
    }
    public function saveImageToServer($id, $img_data, $img_type)
    {
    	$return = array('status' => false, 'name' => '');
    	$dir_path = WWW_ROOT . 'uploads' . DS . $img_type . DS ;
		// creating the directory of new model uploads
		
		if (!file_exists($dir_path))
		{
			mkdir($dir_path , 0777, true);
		}
		$dir_path = $dir_path . $id . DS;
		if (!file_exists($dir_path))
		{
			mkdir($dir_path, 0777, true);
		}
		$fileName = mt_rand() . '_' . $this->clean_file_name($img_data['name']);
		$file_path = $dir_path . $fileName;
		@move_uploaded_file($img_data['tmp_name'], $file_path);
		if($this->config('is_thumb_generation'))
		{
			$img_abs_path = Router::url(array('prefix' => false, 'controller' => 'uploads', 'action' => $img_type . DS . $id . DS . $fileName),true);
			$this->__make_thumb_img($img_abs_path, 'uploads' . DS . $img_type . DS . $id . DS, $fileName);
		}
		return array('status' => true, 'name' => $fileName );
    }

    public function saveToServerFromThumb($id, $name, $source, $img_type)
    {
		$return = array('status' => false, 'name' => '');
		$dir_path = WWW_ROOT . 'uploads' . DS . $img_type . DS ;
		// creating the directory of new model uploads
		if (!file_exists($dir_path))
		{
			mkdir($dir_path , 0777, true);
		}
		$dir_path = $dir_path . $id . DS;
		if (!file_exists($dir_path))
		{
			mkdir($dir_path, 0777, true);
		}
		$fileName = mt_rand() . '_' . $this->clean_file_name($name);
		$file_path = $dir_path . $fileName;
		@copy($source, $file_path);
		if($this->config('is_thumb_generation'))
		{
			$img_abs_path = Router::url(array('prefix' => false, 'controller' => 'uploads', 'action' => $img_type . DS . $id . DS . $fileName),true);
			$this->__make_thumb_img($img_abs_path, 'uploads' . DS . $img_type . DS . $id . DS, $fileName);
		}
		return array('status' => true, 'name' => $fileName );
    }

	public function __make_thumb_img($src, $dir_path, $fileName)
	{
		$thumbnail_width = $thumbnail_height = $this->config('thumb_width');
		$thumb_beforeword = "thumb";
		$arr_image_details = getimagesize($src); // pass id to thumb name
		$original_width = $arr_image_details[0];
		$original_height = $arr_image_details[1];
		if ($original_width > $original_height) {
		    $new_width = $thumbnail_width;
		    $new_height = intval($original_height * $new_width / $original_width);
		} else {
		    $new_height = $thumbnail_height;
		    $new_width = intval($original_width * $new_height / $original_height);
		}
		$dest_x = intval(($thumbnail_width - $new_width) / 2);
		$dest_y = intval(($thumbnail_height - $new_height) / 2);
		if ($arr_image_details[2] == 1)
		{
			$imgt = "ImageGIF";
			$imgcreatefrom = "ImageCreateFromGIF";
		} else if ($arr_image_details[2] == 2)
		{
			$imgt = "ImageJPEG";
			$imgcreatefrom = "ImageCreateFromJPEG";
		} else if ($arr_image_details[2] == 3)
		{
			$imgt = "ImagePNG";
			$imgcreatefrom = "ImageCreateFromPNG";
		}
		if ($imgt)
		{
			$old_image = $imgcreatefrom($src);
			$new_image = imagecreatetruecolor($thumbnail_width, $thumbnail_height);
			imagecopyresized($new_image, $old_image, $dest_x, $dest_y, 0, 0, $new_width, $new_height, $original_width, $original_height);
			
			$thumb_path = WWW_ROOT . $dir_path . 'thumb' . DS;
			if (!file_exists($thumb_path))
			{
				mkdir($thumb_path, 0777, true);
			}
			$imgt($new_image, $thumb_path . $fileName);
		}
	}
}

?>
