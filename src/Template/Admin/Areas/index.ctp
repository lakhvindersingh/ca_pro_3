<h1><?php echo __('Manage Areas'); ?></h1>
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
										'class' => 'input', 'style' => 'width:300px;', 'value'=>$keyword))?>
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
					'Areas', 'action' => 'add', 'prefix' => 'admin'))?>" class="black_btn">
						<span>Add New Area</span>
					</a>
					<a href="<?php echo $this->Url->build(array('controller' => 
					'Areas', 'action' => 'addCsv', 'prefix' => 'admin'))?>" class="black_btn">
						<span>Import Areas</span>
					</a>
					<a href="<?php echo $this->Url->build(array('controller' => 
					'Areas', 'action' => 'exportCsv', 'Areas', 'prefix' => 'admin'))?>" class="black_btn">
						<span>Export Areas</span>
					</a>
				</div>
			</td>
		</tr>
	</table>
</div>
<div class="row mtop30">
	<?php echo $this->Form->create('User', ['class'=>'deleteArea']);?>
	<table width="100%" cellspacing="0" cellpadding="0" border="0" align="center" class="listing">
		<tr>
			<th width="4%" align="center">S No.</th>
			<th><?php echo $this->Paginator->sort('Areas.object_id', 'ObjectId'); ?></th>
			<th><?php echo $this->Paginator->sort('Areas.title', 'Title'); ?></th>
			<th><?php echo $this->Paginator->sort('Areas.area_color', 'Color'); ?></th>
			<th><?php echo $this->Paginator->sort('Areas.area_type', 'Area Type'); ?></th>
			<th><?php echo $this->Paginator->sort('Users.first_name', 'Teacher'); ?></th>
			<th><?php echo $this->Paginator->sort('Areas.created', 'Created'); ?></th>
			<th><?php echo $this->Paginator->sort('Areas.status', 'Status'); ?></th>
			<th width="6%" align="center">Action</th>
			<th width="5%" align="center"><input type="checkbox" value="check_all" id="check_all" name="check_all"></th>
		</tr>
		<?php
			$i = 0;
			foreach($areas as $key=>$area)
			{	
				$pageNum = $this->Paginator->current();
		?>
			 <tr>
				<td align="center"><?php echo (($pageNum-1) * ADMINPAGINATIONLIMIT) + ++$i  . '.';?></td>
				<td align="center"><?php echo $area->object_id?></td>
				<td align="center"><?php echo $this->Html->link($area->title,  ['action'=>'ordering', $area->area_type], ['title'=>'Set Order']); ?></td>
				<td align="center"><?php echo $area->area_color?> &nbsp;<span style="background-color:<?php echo $area->area_color?>;" class="color-box"></span></td>
				<td align="center"><?php echo ($area->area_type == 1) ? 'Primary' : 'Elementry'; ?></td>
				<td align="center"><?php echo isset($area->user) ? $area->user->first_name. ' '.$area->user->last_name : '&mdash;'?></td>
				<td align="center"><?php echo ($area->created) ? $area->created->format('d/m/Y H:i:s') : '' ?></td>
				<td align="center"><?php echo ($area->status == 1) ? 'Active' : 'Inactive'; ?></td>
				<td align="center" valign="middle" >&nbsp;<?php echo 
				$this->Html->link($this->Html->image('edit_icon.gif'), 
				array('prefix' => 'admin', 'controller' => 'Areas', 'action' => 
				'edit', $area->id), array('escape' => false)); ?></td>
				<td align="center" valign="middle" align="center"><input class = "check-box-select" type="checkbox" value="<?php echo $area->id; ?>" name="ids[]"></td>
			</tr>
		 <?php
		 	}
		 ?>
		<tr align="right">
			<td colspan="10" align="left" class="bordernone">
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
							<option value="delete"><?php echo __('Delete'); ?></option>
						</select>
					</div>
				 	<div class="floatleft mleft10">
				 		<div class="black_btn2">
				 			<span class="upper"><input type="submit" value="SUBMIT" name="" class="submit_action"></span>
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
	.color-box{
		width: 10px;
		height: 10px;
		display:inline-block;
	}
</style>
<script>
	selectOptionUrl = "<?php echo $this->Url->build(array('action' => 'select_option__', 'prefix' => 'admin'))?>";
</script>
