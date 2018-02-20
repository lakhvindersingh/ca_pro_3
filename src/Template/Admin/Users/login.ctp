<!--Admin logn section Start from Here-->
<div id="login-box">
	<div class="white-box" style="width:325px; padding-top:60px;">
		<div class="tl">
			<div class="tr">
				<div class="tm">&nbsp;</div>
			</div>
		</div>
		<div class="ml">
			<div class="mr">
				<div class="middle">
					<div class="lb-data">
						<h1>Administrator Login</h1>
						<p class="top15 gray12">
							Please enter a valid email and password to gain access to the administration console.
						</p>
						<?= $this->Form->create('Users',['class' => 'validate_form']) ?>
							<p class="top30">
								<?php 
									echo $this->Form->input('username', [
																'label'=>false, 
																'placeholder' => 'Username', 
																'class' => 'input', 
																'type' => 'text',
																'value'=>isset($cookie['username']) ? $cookie['username'] : ''
															]);
								?>
								
							</p>
							<p class="top15">
								<?php 
									echo $this->Form->input('password', [
																'label'=>false, 
																'placeholder' => 'Password', 
																'class' => 'input',
																'value'=>isset($cookie['password']) ? $cookie['password'] : ''
																]);
								?>
								<?php 
									echo $this->Captcha->create('securitycode', [
																		'type'=>'image', //or 'math' 
																		'theme'=>'random'
																	]); 
								?>
							</p>
							
							<div class="top15">
								<div class="floatleft top15 gray12">
									<?php 
									$password = isset($cookie['password']) ? $cookie['password'] : '';
									$checked = '';
									$checkedValue = 0;
									if(!empty($password)){
										$checked = 'checked="checked"';
										$checkedValue = 1;
									} ?>
									<input type="hidden" value="<?=$checkedValue; ?>" name="remember_me">
									<input id="remember-me" type="checkbox" value="1" name="remember_me" <?= $checked;?>>
									Remember my login details
								</div>

								<div class="floatright">
									<div class="black_btn2">
										<span class="upper">
											<?= $this->Form->submit(__('Login')); ?>
										</span>
									</div>
								</div>
							</div>
						<?= $this->Form->end() ?>
					</div>
				</div>
			</div>
		</div>
		<div class="bl">
			<div class="br">
				<div class="bm">&nbsp;</div>
			</div>
		</div>
	</div>
</div>
<!--Admin logn section end Here-->