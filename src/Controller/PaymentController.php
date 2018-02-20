<?php
namespace App\Controller;

use App\Controller\AppController;
use Cake\Event\Event;
use Cake\Network\Exception\NotFoundException;
use Cake\Routing\Router;
use Cake\Core\Configure;
use Cake\Database\Expression\QueryExpression;

class PaymentController extends AppController
{
	public function beforeFilter(Event $event)
	{
		parent::beforeFilter($event);
		$this->viewBuilder()->layout('default');
		$this->Auth->allow(['process', 'cancel', 'success', 'successIpn']);
	}

	public function process($userId = null, $productId = null, $sessionId = null){

		if(empty($userId) || empty($productId) || empty($sessionId))
		{
			echo $this->Flash->error('Invalid URL, Try again later.');
			return $this->redirect(['action' => 'cancel']);
		}

		$userId		= $this->decode($userId);
		$productId	= $this->decode($productId);
		$sessionId	= $this->decode($sessionId);

		
		if(!empty($userId))
		{
			$this->loadModel('Users');
			
			$userObj = $this->Users->find('all',[
							'conditions' => [
								'Users.id'	=> $userId,
								'sessionId' => $sessionId,
							],
							'contain'	=> ['Products', 'UserProducts.Products']
							])->first();

			if(empty($userObj))
			{
				echo $this->Flash->error('Invalid User, Try again later.');
				return $this->redirect(['action' => 'cancel']);
			}
		}

		if(!empty($productId))
		{
			$this->loadModel('Products');
			$productObj = $this->Products->find('all', ['conditions' => ['Products.id' => $productId]])->first();
			if(empty($productObj))
			{
				echo $this->Flash->error('Invalid Product, Try again later.');
				return $this->redirect(['action' => 'cancel']);
			}
		}
		$userObj	= $userObj->toArray();
		$productObj = $productObj->toArray();

		$paymentData = [
				'user_id'			=> $userObj['id'],
				'product_id'		=> $productObj['id'],
				'txn_id'			=> '',
				'payment_gross'		=> $productObj['price'],
				'currency_code'		=> $productObj['currency_code'],
				'payment_status'	=> '0',
			];
		$prePayment = false;

		if($paymentData)
		{
			$this->loadModel('Payments');
			$paymentObj = $this->Payments->newEntity($paymentData);

			$ifPayment = $this->Payments->find('all', ['conditions' => ['Payments.user_id' => $userObj['id']]])->first();
			if(!empty($ifPayment))
			{
				$ifPayment = $ifPayment->toArray();
				$paymentData['id'] = $ifPayment['id'];
				$paymentObj = $this->Payments->patchEntity($paymentObj, $paymentData);
			}
			if($paymentSaved = $this->Payments->save($paymentObj))
			{
				$prePayment = true;
			}
		}
		
		if(!$prePayment)
		{
			echo $this->Flash->error('Something went wrong, Try again later.');
			return $this->redirect(['action' => 'cancel']);
		}
		
		$user_id = $this->encode($userId);
		$this->set(compact('userObj', 'productObj', 'prePayment', 'user_id'));
	}

	public function cancel(){
	
	}

	public function success($userId = null){
		$payment = false;

		$this->log('requestdata', 'debug');
		if(empty($this->request->data))
		{	
			$this->request->data['txn_id']			= $_GET['tx'];
			$this->request->data['payment_status']	= $_GET['st'];
			$this->request->data['payment_gross']	= $_GET['amt'];
			$this->request->data['mc_currency']		= $_GET['cc'];
			$this->request->data['custom']			= $_GET['cm'];
			$this->request->data['item_number']		= $_GET['item_number'];
			$this->request->data['sig']				= $_GET['sig'];
			$this->request->data['GET']				= $_GET;
		}

		if($this->request->data)
		{
			$this->log("payment log", 'debug');
			$this->log($this->request->data, 'debug');
			
			$userId = $this->decode($this->request->data['custom']);
			
			$this->loadModel('Users');
			$userObj = $this->Users->find('all',[
							'conditions' => [
								'Users.id'	=> $userId,
							],
							'contain'	=> ['Products', 'UserProducts.Products']
							])->first();
			
			if(!empty($userObj))
			{
				$userObj = $userObj->toArray();

				if(!empty($this->request->data['txn_id']) && $this->request->data['payment_status'] == "Completed")
				{
					$paymentData = [
						'user_id'			=> $userObj['id'],
						'product_id'		=> $userObj['user_product']['product_id'],
						'txn_id'			=> $this->request->data['txn_id'],
						'payment_gross'		=> $this->request->data['payment_gross'],
						'currency_code'		=> $this->request->data['mc_currency'],
						'payment_status'	=> '1',
						'payment_data'		=> base64_encode(serialize($this->request->data)),
					];

					$this->loadModel('Payments');
					$paymentObj = $this->Payments->newEntity($paymentData);

					$ifPayment = $this->Payments->find('all', [
							'conditions' => [
								'Payments.user_id' => $userObj['id'], 
								'Payments.product_id' => $userObj['user_product']['product_id']
							]])->first();


					if(!empty($ifPayment))
					{
						$ifPayment			= $ifPayment->toArray();
						$paymentData['id']	= $ifPayment['id'];
						$paymentObj			= $this->Payments->patchEntity($paymentObj, $paymentData);
					}

					if($paymentSaved = $this->Payments->save($paymentObj))
					{
						$userObjData = $this->Users->get($userObj['id']);
						$userObjData->is_trial		= 0;
						$userObjData->is_paid		= 1;
						$userObjData->product_id	= $userObj['user_product']['product_id'];
						$this->Users->save($userObjData);
						$payment = true;
						//$upData = $this->Users->UserProducts->findByUserId&ProductId($userObj['id'], $userObj['user_product']['product_id'])
						//$upData->pack_start_date
					}
				}
				$txnId = $this->request->data['txn_id'];
				$this->set(compact('payment', 'txnId'));
			}
			else{
				echo $this->Flash->error('Invalid User.');
				return $this->redirect(['action' => 'cancel']);
			}
		}else{
			echo $this->Flash->error('Invalid URL.');
			return $this->redirect(['action' => 'cancel']);
		}
	}
	
	public function successIpn()
    {
		die('hello');
		
		// STEP 1: Read POST data
		// reading posted data from directly from $_POST causes serialization 
		// issues with array data in POST
		// reading raw POST data from input stream instead. 
		$raw_post_data = file_get_contents('php://input');
		$raw_post_array = explode('&', $raw_post_data);
		$myPost = array();
		foreach ($raw_post_array as $keyval) {
		  $keyval = explode ('=', $keyval);
		  if (count($keyval) == 2)
			 $myPost[$keyval[0]] = urldecode($keyval[1]);
		}
		// read the post from PayPal system and add 'cmd'
		$req = 'cmd=_notify-validate';
		if(function_exists('get_magic_quotes_gpc')) {
		   $get_magic_quotes_exists = true;
		} 
		foreach ($myPost as $key => $value) {        
		   if($get_magic_quotes_exists == true && get_magic_quotes_gpc() == 1) { 
				$value = urlencode(stripslashes($value)); 
		   } else {
				$value = urlencode($value);
		   }
		   $req .= "&$key=$value";
		}

		// STEP 2: Post IPN data back to paypal to validate
		$paypal_url = 'https://www.sandbox.paypal.com/cgi-bin/webscr';
		//$paypal_url = 'https://www.paypal.com/cgi-bin/webscr';

		$ch = curl_init($paypal_url);
		curl_setopt($ch, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_1);
		curl_setopt($ch, CURLOPT_POST, 1);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $req);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 1);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
		curl_setopt($ch, CURLOPT_FORBID_REUSE, 1);
		curl_setopt($ch, CURLOPT_HTTPHEADER, array('Connection: Close'));

		// In wamp like environments that do not come bundled with root authority certificates,
		// please download 'cacert.pem' from "http://curl.haxx.se/docs/caextract.html" and set the directory path 
		// of the certificate as shown below.
		// curl_setopt($ch, CURLOPT_CAINFO, dirname(__FILE__) . '/cacert.pem');

		if( !($res = curl_exec($ch)) ) {
			// error_log("Got " . curl_error($ch) . " when processing IPN data");
			curl_close($ch);
			exit;
		}
		curl_close($ch);


		// STEP 3: Inspect IPN validation result and act accordingly

		if (strcmp ($res, "VERIFIED") == 0) {
			// check whether the payment_status is Completed
			// check that txn_id has not been previously processed
			// check that receiver_email is your Primary PayPal email
			// check that payment_amount/payment_currency are correct
			// process payment

			// assign posted variables to local variables
			$user_id			= $_POST['custom'];
			$item_name			= $_POST['item_name'];
			$item_number		= $_POST['item_number'];
			$payment_status		= $_POST['payment_status'];
			$payment_amount		= $_POST['mc_gross'];
			$payment_currency	= $_POST['mc_currency'];
			$txn_id				= $_POST['txn_id'];
			$receiver_email		= $_POST['receiver_email'];
			$payer_email		= $_POST['payer_email'];
			
			$user_id = $this->decode($user_id);
			if($payment_status == "Completed"){
				$payment_status = 1;
			}else{
				$payment_status = 0;
			}

			$paymentData = [
				'id'				=> '',
				'user_id'			=> $user_id,
				'product_id'		=> $item_number,
				'txn_id'			=> $txn_id,
				'payment_gross'		=> $payment_amount,
				'currency_code'		=> $payment_currency,
				'payment_status'	=> $payment_status,
				'payment_data'		=> base64_encode(serialize($_POST)),
			];
			$prePayment = false;

			if($paymentData)
			{
				$this->loadModel('Payments');
				$paymentObj = $this->Payments->newEntity($paymentData);

				/*
				$ifPayment = $this->Payments->find('all', ['conditions' => ['Payments.user_id' => $userObj['id']]])->first();
				if(!empty($ifPayment))
				{
					$ifPayment = $ifPayment->toArray();
					$paymentData['id'] = $ifPayment['id'];
					$paymentObj = $this->Payments->patchEntity($paymentObj, $paymentData);
				}
				*/

				if($paymentSaved = $this->Payments->save($paymentObj))
				{
					$prePayment = true;
				}
			}


		} else if (strcmp ($res, "INVALID") == 0) {
			// log for manual investigation
		}
    }
}

//http://localhost/teacher-tracking/website/payment/process/MXRsdGFtb250eQ==/MnRsdGFtb250eQ==/WGdlamt2dnZ0cVZhR29MSXlDMGh6eHU5NnRsdGFtb250eQ==