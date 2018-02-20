<h1><?php echo __('Manage Users'); ?></h1>
<div class="row mtop15">
	<table width="100%" cellspacing="0" cellpadding="0" border="0" align="center">
		<tr valign="top">
			<td align="left" class="searchbox">
				<div class="floatleft">
					<?php echo $this->Form->create(null, ['type' => 'get']);?>
						<table cellspacing="0" cellpadding="4" border="0">
							<tr valign="top">
								<td valign="middle" align="left" >
									<?php echo $this->Form->input('keyword', array('placeholder' => 'Enter Keyword', 'div' => false, 'label' => false,
										'class' => 'input', 'style' => 'width:300px;'))?>
								</td>
								<td valign="middle" align="left">
									<div class="black_btn2">
										<span class="upper">
											<input type="submit" value="Search Users" name="">
										</span>
									</div>
								</td>
							</tr>
						</table>
					<?php echo $this->Form->end();?>
				</div>
				<div class="floatright top5">
					<a href="<?php echo $this->Url->build(array('controller' => 
					'Users', 'action' => 'addStudent', 'prefix' => 'admin'))?>" class="black_btn">
						<span>Add New Student</span>
					</a>
				</div>
			</td>
		</tr>
	</table>
</div>
<div class="row mtop30">
	<?php echo $this->Form->create('User');?>
	<table width="100%" cellspacing="0" cellpadding="0" border="0" align="center" class="listing">
		<tr>
			<th width="4%" align="center">S No.</th>
			<th><?php echo $this->Paginator->sort('Name'); ?></th>
			<th><?php echo $this->Paginator->sort('Teacher'); ?></th>
			<th><?php echo $this->Paginator->sort('Users.created', 'Created'); ?></th>
			<th><?php echo $this->Paginator->sort('Statuses.name', 'Status'); ?></th>
			<th width="6%" align="center">Action</th>
			<th width="5%" align="center"><input type="checkbox" value="check_all" id="check_all" name="check_all"></th>
		</tr>
		<?php
			$i = 0;
			foreach($students as $key=>$user)
			{	
				$pageNum = $this->Paginator->current();
		?>
			 <tr>
				<td align="center"><?php echo (($pageNum-1) * ADMINPAGINATIONLIMIT) + ++$i  . '.';?></td>
				<td align="center"><?php echo $user->first_name. ' '.$user->last_name?></td>
				<td align="center"><?php echo $user->user->first_name. ' '.$user->user->last_name?></td>
				<td align="center"><?php echo ($user->created) ? $user->created->format('d/m/Y H:i:s') : '' ?></td>
				<td align="center"><?php echo ($user->status ==1) ? 'Active' : 'Deactive'; ?></td>
				<td align="center" valign="middle" >&nbsp;<?php echo 
				$this->Html->link($this->Html->image('edit_icon.gif'), 
				array('prefix' => 'admin', 'controller' => 'Users', 'action' => 
				'editStudent', $user->id), array('escape' => false)); ?></td>
				<td align="center" valign="middle" align="center"><input class = "check-box-select" type="checkbox" value="<?php echo $user->id; ?>" name="ids[]"></td>
			</tr>
		 <?php
		 	}
		 ?>
		<tr align="right">
			<td colspan="9" align="left" class="bordernone">
				<div class="floatleft mtop7">
					<div class="pagination">
						<ul class="paginate">
						  <?php 
							if($this->Paginator->hasPrev()){
							  echo $this->Paginator->prev(__('Previous'));
							}
						  ?>
						  <?php 
							if($this->Paginator->hasPage()){
							  echo $this->Paginator->numbers();
							}
						  ?>
						  <?php 
							if($this->Paginator->hasNext()){
							  echo $this->Paginator->next(__('Next'));
							}
						  ?>
						 </ul>
					</div>
				</div>
				<div class="floatright">
					<div class="floatleft">
						<select name="option" class="select">
							<option value=""><?php echo __('Select Option'); ?></option>
							<option value="active"><?php echo __('Activate'); ?></option>
							<option value="deactive"><?php echo __('Deactivate'); ?></option>
						</select>
					</div>
				 	<div class="floatleft mleft10">
				 		<div class="black_btn2">
				 			<span class="upper"><input type="submit" value="SUBMIT" name=""></span>
			 			</div>
		 			</div>
				</div>
			</td>
		</tr>
	</table>
	<?php echo $this->Form->end();?>
</div>
<style>
	.paginate li{
		float:left;
		list-style:none;
	}
</style>
<script>
	selectOptionUrl = "<?php echo $this->Url->build(array('action' => 'select_option__', 'prefix' => 'admin'))?>";
</script>
