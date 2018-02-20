<h1><?php echo __('Manage Lessons'); ?></h1>
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
											<input type="submit" value="Search Lessons" name="">
										</span>
									</div>
								</td>
							</tr>
						</table>
					<?php echo $this->Form->end();?>
				</div>
				<div class="floatright top5">
					<a href="<?php echo $this->Url->build(array('controller' => 
					'Lessons', 'action' => 'add', 'prefix' => 'admin'))?>" class="black_btn">
						<span>Add New Lessons</span>
					</a>
					<a href="<?php echo $this->Url->build(array('controller' => 
					'Lessons', 'action' => 'addCsv', 'prefix' => 'admin'))?>" class="black_btn">
						<span>Import Lessons</span>
					</a>
					<a href="<?php echo $this->Url->build(array('controller' => 
					'Areas', 'action' => 'exportCsv', 'Lessons', 'prefix' => 'admin'))?>" class="black_btn">
						<span>Export Lessons</span>
					</a>
				</div>
			</td>
		</tr>
	</table>
</div>
<div class="row mtop30">
	<?php echo $this->Form->create('Lessons', ['class'=>'deleteLessons']);?>
	<table width="100%" cellspacing="0" cellpadding="0" border="0" align="center" class="listing">
		<tr>
			<th width="4%" align="center">S No.</th>
			<th><?php echo $this->Paginator->sort('Lessons.object_id', 'Object Id'); ?></th>
			<th><?php echo $this->Paginator->sort('Areas.area_type', 'Type'); ?></th>
			<th><?php echo $this->Paginator->sort('Lessons.title', 'Title'); ?></th>
			<th><?php echo $this->Paginator->sort('Areas.title', 'Area'); ?></th>
			<th><?php echo $this->Paginator->sort('Chapters.title', 'Chapters'); ?></th>
			<th><?php echo $this->Paginator->sort('Users.first_name', 'Teacher'); ?></th>
			<th><?php echo $this->Paginator->sort('Lessons.created', 'Created'); ?></th>
			<th><?php echo $this->Paginator->sort('Lessons.status', 'Status'); ?></th>
			<th width="6%" align="center">Action</th>
			<th width="5%" align="center"><input type="checkbox" value="check_all" id="check_all" name="check_all"></th>
		</tr>
		<?php
			$i = 0;
			foreach($lessons as $key=>$lesson)
			{	//pr($lesson);
				$pageNum = $this->Paginator->current();
		?>
			 <tr>
				<td align="center"><?php echo (($pageNum-1) * ADMINPAGINATIONLIMIT) + ++$i  . '.';?></td>
				<td align="center"><?php echo $lesson->object_id ?></td>
				<td align="center"><?php echo ($lesson->area->area_type == 1) ? "Primary" : "Elementary" ?></td>
				<td align="center">
					<?php echo $this->Html->link($lesson->title,  ['controller'=>'lessons', 'action'=>'ordering', $lesson->chapter->object_id], ['title'=>'Set order']); ?>
				</td>
				<td align="center"><?php echo $lesson->area->title ?></td>
				<td align="center"><?php echo $lesson->chapter->title ?></td>
				<td align="center"><?php echo isset($lesson->user) ? $lesson->user->first_name. ' '.$lesson->user->last_name : '&mdash;'?></td>
				<td align="center"><?php echo ($lesson->created) ? $lesson->created->format('d/m/Y H:i:s') : '' ?></td>
				<td align="center"><?php echo ($lesson->status ==1) ? 'Active' : 'Inactive'; ?></td>
				<td align="center" valign="middle" >&nbsp;<?php echo 
				$this->Html->link($this->Html->image('edit_icon.gif'), 
				array('prefix' => 'admin', 'controller' => 'Lessons', 'action' => 
				'edit', $lesson->id), array('escape' => false)); ?></td>
				<td align="center" valign="middle" align="center"><input class = "check-box-select" type="checkbox" value="<?php echo $lesson->id; ?>" name="ids[]"></td>
			</tr>
		 <?php
		 	}
		 ?>
		<tr align="right">
			<td colspan="11" align="left" class="bordernone">
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
