<?php
/** 
*  Project : Fitfix 
*  Author : Xicom Technologies 
*  Creation Date : 26-06-2015 
*  Description : This is Common component which is used for common functions.
*/
namespace App\Controller\Component;

use Cake\Controller\Component;
use Cake\Network\Email\Email;
use Cake\ORM\TableRegistry;


class CommonComponent extends Component
	{
		public function ismobile()
	    {
		    $is_mobile = '0';

		    if(preg_match('/(android|up.browser|up.link|mmp|symbian|smartphone|midp|wap|phone)/i', strtolower($_SERVER['HTTP_USER_AGENT']))) {
		        $is_mobile=1;
		    }

		    if((strpos(strtolower($_SERVER['HTTP_ACCEPT']),'application/vnd.wap.xhtml+xml')>0) or ((isset($_SERVER['HTTP_X_WAP_PROFILE']) or isset($_SERVER['HTTP_PROFILE'])))) {
		        $is_mobile=1;
		    }

		    $mobile_ua = strtolower(substr($_SERVER['HTTP_USER_AGENT'],0,4));
		    $mobile_agents = array('w3c ','acs-','alav','alca','amoi','andr','audi','avan','benq','bird','blac','blaz','brew','cell','cldc','cmd-','dang','doco','eric','hipt','inno','ipaq','java','jigs','kddi','keji','leno','lg-c','lg-d','lg-g','lge-','maui','maxo','midp','mits','mmef','mobi','mot-','moto','mwbp','nec-','newt','noki','oper','palm','pana','pant','phil','play','port','prox','qwap','sage','sams','sany','sch-','sec-','send','seri','sgh-','shar','sie-','siem','smal','smar','sony','sph-','symb','t-mo','teli','tim-','tosh','tsm-','upg1','upsi','vk-v','voda','wap-','wapa','wapi','wapp','wapr','webc','winw','winw','xda','xda-');

		    if(in_array($mobile_ua,$mobile_agents)) {
		        $is_mobile=1;
		    }

		    if (isset($_SERVER['ALL_HTTP'])) {
		        if (strpos(strtolower($_SERVER['ALL_HTTP']),'OperaMini')>0) {
		            $is_mobile=1;
		        }
		    }

		    if (strpos(strtolower($_SERVER['HTTP_USER_AGENT']),'windows')>0) {
		        $is_mobile=0;
		    }

		    return $is_mobile;
		}

		public function encrypt($id)
		{
		    $id = base_convert($id, 10, 36); // Save some space
		    $data = mcrypt_encrypt(MCRYPT_BLOWFISH, Configure::read('Security.cipherSeed'), $id, 'ecb');
		    $data = bin2hex($data);

		    return $data;
		}

		public function decrypt($encrypted_id)
		{
		    $data = pack('H*', $encrypted_id); // Translate back to binary
		    $data = mcrypt_decrypt(MCRYPT_BLOWFISH, Configure::read('Security.cipherSeed'), $data, 'ecb');
		    $data = base_convert($data, 36, 10);

		    return $data;
		}

		public function generateRandomString($length = 10) {
		    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
		    $charactersLength = strlen($characters);
		    $randomString = '';
		    for ($i = 0; $i < $length; $i++) {
		        $randomString .= $characters[rand(0, $charactersLength - 1)];
		    }
		    return $randomString;
		}
		
		public function getRandomColor() {
			return '#' . str_pad(dechex(mt_rand(0, 0xFFFFFF)), 6, '0', STR_PAD_LEFT);
		}
		
		public function _send_email($to, $token, $token_value, $template, $subjectParams, $attachment = []  )
	    {
	        if(!filter_var($to, FILTER_VALIDATE_EMAIL))
	        {
	            return false;
	        }
	        
	        $emailTemplate = TableRegistry::get('EmailTemplates');
	        $template = $emailTemplate->findBySlug($template)->toArray();
	        if (empty($template))
	        {
	            return false;
	        }
	        $template = $template[0];
	        
	        $subject = str_replace('{username}',$subjectParams ,$template['subject']);
	        

	        $msg = $template['content'];
	        
	        $msg = str_replace($token, $token_value, $msg);
	        
	        //$this->log(print_r([$msg], true),'debug');
	        
	        $email = new Email('default');  
	           
	        if(($attachment) && !empty($attachment))
	        {
				
				$filename 		= isset($attachment['fileName']) ? $attachment['fileName'] : 'Export.csv';
				$fileFullPath	= isset($attachment['filePath']) ? $attachment['filePath'] : '';
				$fileType		= isset($attachment['fileType']) ? $attachment['fileType'] : '';
				$fileId			= isset($attachment['fileId']) ? $attachment['fileId'] : '';
				
				$email->attachments([
						$filename => [
							'file' => $fileFullPath,
							'mimetype' => $fileType,
							'contentId' => $fileId
						]
					]);
				
				
			}
			
	        $email->to($to);
	        $email->from($template['from_email']);
	        $email->subject($subject);
	        $email->emailFormat('html');
	        if($email->send($msg)){
				return true;
			}
	    }
	    
	    public function cleanFileName($str){
			return preg_replace("/[^a-z0-9\.]/", "", strtolower($filename));
		}
		
		public function mkdir_recursive($pathname, $mode='777'){
			is_dir(dirname($pathname)) || $this->mkdir_recursive(dirname($pathname), $mode);
			return is_dir($pathname) || @mkdir($pathname);
		}

    }
?>
