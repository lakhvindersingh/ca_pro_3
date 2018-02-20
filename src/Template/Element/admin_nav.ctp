<?php
	if($this->request->session()->check('Auth.User.id'))
	{
?>
		<div class="menubg">
			<div class="nav">
				<ul id="navigation">
					<li onmouseout="this.className=''" onmouseover="this.className='hov'">
						<?php
							echo $this->Html->link(
								'Home', array(
									'controller' => 'Dashboard', 'action' => 'index', 'prefix' => 'admin'
								), array(
									'class' => ''
								)
							);
						?>
					</li>
					<li onmouseout="this.className=''" onmouseover="this.className='hov'">
						<?php echo $this->Html->link('Manage Site', '#_'); ?>
						<div class="sub">
							<ul>
								<li>
									<?php
										echo $this->Html->link(
											'Change Password', array(
												'controller' => 'Users', 'action' => 'changePassword', 'prefix' => 'admin'
											), array(
												'class' => ''
											)
										);
									?>
								</li>
								<li>
									<?php echo $this->Html->link('Email Settings', array('controller' => 'EmailTemplates', 'action' => 'index', 'prefix' => 'admin')); ?>
								</li>
								<li>
									<?php echo $this->Html->link('Add Limit', array('controller' => 'Users', 'action' => 'limits', 'prefix' => 'admin')); ?>
								</li>
							</ul>
						</div>
					</li>
				
					<li onmouseout="this.className=''" onmouseover="this.className='hov'">
						<?php echo $this->Html->link('Manage Users', '#_'); ?>
						<div class="sub">
							<ul>
								<li>
									<?php echo $this->Html->link('List Admins', array('controller' => 'Users', 'action' => 'index', '1', 'prefix' => 'admin')); ?>
								</li>
								<li>
									<?php echo $this->Html->link('List Teachers', array('controller' => 'Users', 'action' => 'index', 'prefix' => 'admin')); ?>
								</li>
								<li>
									<?php echo $this->Html->link('Add Teacher', array('controller' => 'Users', 'action' => 'add')); ?>
								</li>
								<li>
									<?php echo $this->Html->link('Import Teachers', array('controller' => 'Users', 'action' => 'addCsv', 'prefix' => 'admin')); ?>
								</li>
							</ul>
						</div>
					</li>
					<li onmouseout="this.className=''" onmouseover="this.className='hov'">
						<?php echo $this->Html->link('Manage students', '#_'); ?>
						<div class="sub">
							<ul>
								<li>
									<?php echo $this->Html->link('List Students', array('controller' => 'Students', 'action' => 'index', 'prefix' => 'admin')); ?>
								</li>
								<li>
									<?php echo $this->Html->link('Add Student', array('controller' => 'Students', 'action' => 'add', 'prefix' => 'admin')); ?>
								</li>
								<li>
									<?php echo $this->Html->link('Import Students', array('controller' => 'Students', 'action' => 'addCsv', 'prefix' => 'admin')); ?>
								</li>
							</ul>
						</div>
					</li>
					<li onmouseout="this.className=''" onmouseover="this.className='hov'">
						<?php echo $this->Html->link('Manage Areas', '#_'); ?>
						<div class="sub">
							<ul>
								<li>
									<?php echo $this->Html->link('List Areas', array('controller' => 'Areas', 'action' => 'index', 'prefix' => 'admin')); ?>
								</li>
								<li>
									<?php echo $this->Html->link('Add Area', array('controller' => 'Areas', 'action' => 'add', 'prefix' => 'admin')); ?>
								</li>
								<li>
									<?php echo $this->Html->link('Import Area', array('controller' => 'Areas', 'action' => 'addCsv', 'prefix' => 'admin')); ?>
								</li>
								<li>
									<?php echo $this->Html->link('Bulk Import Areas', array('controller' => 'Areas', 'action' => 'addBulkImport', 'prefix' => 'admin')); ?>
								</li>
							</ul>
						</div>
					</li>
					
					<li onmouseout="this.className=''" onmouseover="this.className='hov'">
						<?php echo $this->Html->link('Manage Chapters', '#_'); ?>
						<div class="sub">
							<ul>
								<li>
									<?php echo $this->Html->link('List Chapters', array('controller' => 'Chapters', 'action' => 'index', 'prefix' => 'admin')); ?>
								</li>
								<li>
									<?php echo $this->Html->link('Add Chapters', array('controller' => 'Chapters', 'action' => 'add', 'prefix' => 'admin')); ?>
								</li>
								<li>
									<?php echo $this->Html->link('Import Chapters', array('controller' => 'Chapters', 'action' => 'addCsv', 'prefix' => 'admin')); ?>
								</li>
								<li>
									<?php echo $this->Html->link('Bulk Import Chapters', array('controller' => 'Chapters', 'action' => 'addBulkImport', 'prefix' => 'admin')); ?>
								</li>
							</ul>
						</div>
					</li>
					
					<li onmouseout="this.className=''" onmouseover="this.className='hov'">
						<?php echo $this->Html->link('Manage Lessons', '#_'); ?>
						<div class="sub">
							<ul>
								<li>
									<?php echo $this->Html->link('List Lessons', array('controller' => 'Lessons', 'action' => 'index', 'prefix' => 'admin')); ?>
								</li>
								<li>
									<?php echo $this->Html->link('Add Lessons', array('controller' => 'Lessons', 'action' => 'add', 'prefix' => 'admin')); ?>
								</li>
								<li>
									<?php echo $this->Html->link('Import Lessons', array('controller' => 'Lessons', 'action' => 'addCsv', 'prefix' => 'admin')); ?>
								</li>
								<li>
									<?php echo $this->Html->link('Bulk Import Lessons', array('controller' => 'Lessons', 'action' => 'addBulkImport', 'prefix' => 'admin')); ?>
								</li>
							</ul>
						</div>
					</li>
					
					<li onmouseout="this.className=''" onmouseover="this.className='hov'">
						<?php echo $this->Html->link('Manage Exercises', '#_'); ?>
						<div class="sub">
							<ul>
								<li>
									<?php echo $this->Html->link('List Exercises', array('controller' => 'Exercises', 'action' => 'index', 'prefix' => 'admin')); ?>
								</li>
								<li>
									<?php echo $this->Html->link('Add Exercises', array('controller' => 'Exercises', 'action' => 'add', 'prefix' => 'admin')); ?>
								</li>
								<li>
									<?php echo $this->Html->link('Import Exercises', array('controller' => 'Exercises', 'action' => 'addCsv', 'prefix' => 'admin')); ?>
								</li>
								<li>
									<?php echo $this->Html->link('Bulk Import Exercises', array('controller' => 'Exercises', 'action' => 'addBulkImport', 'prefix' => 'admin')); ?>
								</li>
							</ul>
						</div>
					</li>
				</ul>
			</div>
			
		</div>
<?php } ?>
