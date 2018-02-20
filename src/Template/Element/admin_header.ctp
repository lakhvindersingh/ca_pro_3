<div id="header">
	<div id="head_lt">
    	<!--Logo Start from Here-->
		<span class="floatleft">
			<?php
					echo $this->Html->image('logo.png', array('style' => "margin-right:10px; width:35px;"), array('url'=>array(
							'controller' => 'Users', 'action' => 'dashboard', 'prefix' => 'admin'
						))
					);
				
			?>
		</span><span class="slogan">administration suite</span>
    	<!--Logo end  Here-->
		<div style="padding: 10px 0 0 20px; float: left;">
			<?php 
				//echo $this->Form->postLink($this->Html->image('british-flag.png'),['controller'	=>	'users','action'	=>	'set_lang','en'],['escape'	=> false, 'style'	=>	'padding:5px;']);
				//echo $this->Form->postlink($this->Html->image('thai-flag.png'),['controller'	=>	'users','action'	=>	'set_lang','th'],['escape'	=> false, 'style'	=>	'padding:5px;']);
				 ?>
		</div>
    </div>
	
	<?php
		if($this->request->session()->check('Auth.User.id'))
		{
	?>
	<div class="logout">
				<?php
					echo $this->Html->image("logout.gif", array(
							"alt" => "Logout",
							'url' => array('controller' => 'Users', 'action' => 'logout', 'prefix' => 'admin')
						));
				?>
			</div>
	
		<div id="head_rt">Welcome <span> <?php echo $this->request->session()->read('Auth.User.username')?></span>&nbsp;&nbsp;|&nbsp;&nbsp; <?php echo date('d M, Y h:i A'); ?></div>
	<?php
		}
	?>
</div>
