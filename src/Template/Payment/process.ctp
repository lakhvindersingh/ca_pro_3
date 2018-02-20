<style>
	/* The Overlay (background) */
	.overlay {
		/* Height & width depends on how you want to reveal the overlay (see JS below) */    
		height: 100%;
		width: 0;
		position: fixed; /* Stay in place */
		z-index: 1; /* Sit on top */
		left: 0;
		top: 0;
		background-color: rgb(0,0,0); /* Black fallback color */
		background-color: rgba(0,0,0, 0.9); /* Black w/opacity */
		overflow-x: hidden; /* Disable horizontal scroll */
		transition: 0.5s; /* 0.5 second transition effect to slide in or slide down the overlay (height or width, depending on reveal) */
	}

	/* Position the content inside the overlay */
	.overlay-content {
		position: relative;
		top: 25%; /* 25% from the top */
		width: 100%; /* 100% width */
		text-align: center; /* Centered text/links */
		margin-top: 30px; /* 30px top margin to avoid conflict with the close button on smaller screens */
	}

	/* The navigation links inside the overlay */
	.overlay a {
		padding: 8px;
		text-decoration: none;
		font-size: 36px;
		color: #818181;
		display: block; /* Display block instead of inline */
		transition: 0.3s; /* Transition effects on hover (color) */
	}

	/* When you mouse over the navigation links, change their color */
	.overlay a:hover, .overlay a:focus {
		color: #f1f1f1;
	}

	/* Position the close button (top right corner) */
	.closebtn {
		position: absolute;
		top: 20px;
		right: 45px;
		font-size: 60px !important; /* Override the font-size specified earlier (36px) for all navigation links */
	}

	/* When the height of the screen is less than 450 pixels, change the font-size of the links and position the close button again, so they don't overlap */
	@media screen and (max-height: 450px) {
		.overlay a {font-size: 20px}
		.closebtn {
			font-size: 40px !important;
			top: 15px;
			right: 35px;
		}
	}
</style>

<?php
	$paypal_url = 'https://www.sandbox.paypal.com/cgi-bin/webscr';
	$paypal_id = 'bharat.borana@xicom.biz'; //Business Email

	$cancelRedirect = $this->Url->build([
						"controller" => "payment",
						"action" => "cancel",
					], true);
	$successRedirect = $this->Url->build([
						"controller" => "payment",
						"action" => "success",
						$user_id,
					], true);

	$ipnRedirect = $this->Url->build([
						"controller" => "payment",
						"action" => "successIpn",
					], true);

?>
	<form action="<?php echo $paypal_url; ?>" method="post" id="paypalForm">
		<!-- Identify your business so that you can collect the payments. -->
		<input type="hidden" name="business" value="<?php echo $paypal_id; ?>">
		
		<!-- Specify a Buy Now button. -->
		<input type="hidden" name="cmd" value="_xclick">
		<input type="hidden" name="rm" value="1">
		
		<input type="hidden" name="custom" value="<?php echo $user_id; ?>"/>

		<!-- Specify details about the item that buyers will purchase. -->
		<input type="hidden" name="item_id" value="<?php echo $productObj['id']; ?>">
		<input type="hidden" name="item_name" value="<?php echo $productObj['title']; ?>">
		<input type="hidden" name="item_number" value="<?php echo $productObj['id']; ?>">
		<input type="hidden" name="amount" value="<?php echo $productObj['price']; ?>">
		<input type="hidden" name="currency_code" value="<?php echo $productObj['currency_code']; ?>">
		
		<!-- Specify URLs -->
		<input type='hidden' name='cancel_return' value='<?php echo $cancelRedirect; ?>'>
		<input type="hidden" name="return" value="<?php echo $successRedirect; ?>">

		<!-- Display the payment button. -->
		<input style="opacity:0" type="image" name="submit" border="0"
		src="https://www.paypalobjects.com/en_US/i/btn/btn_buynow_LG.gif" alt="PayPal - The safer, easier way to pay online">
		<img alt="" border="0" width="1" height="1" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" >
	</form>

	<div id="myNav" class="overlay">
	  <div class="overlay-content">
		<a><?php echo $productObj['title']; ?>: <?php echo $productObj['currency_code']; ?><?php echo $productObj['price']; ?></a>
		<a><?php echo $this->Html->image('ajax-loader.gif'); ?></a>
		<a>Wait while you are redirected to payment page.</a>
		<a>Do not refresh or press back button.</a>
	  </div>
	</div>


	<script>
		$(document).ready(function(){
			document.getElementById("myNav").style.width = "100%";
		});
		$(window).load(function(){
			$('#paypalForm').submit();
		});
	</script>