<script type="text/javascript">
	/*
var JS_PATH = '/fnb/js/ckeditor';
//<![CDATA[
	CKEDITOR.replace( 'content',
	    {
		    filebrowserBrowseUrl : JS_PATH + '/ckfinder/ckfinder.html',
		    filebrowserImageBrowseUrl : JS_PATH + '/ckfinder/ckfinder.html?type=Images',
		    filebrowserFlashBrowseUrl : JS_PATH + '/ckfinder/ckfinder.html?type=Flash',
		    filebrowserUploadUrl : JS_PATH + '/ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Files',
		    filebrowserImageUploadUrl : JS_PATH + '/ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Images',
		    filebrowserFlashUploadUrl : JS_PATH + '/ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Flash'
	    });
//]]>
*/
</script>
<div class="row">
    <div class="floatleft mtop10">
    	<h1>
    		<?php echo __('Edit Email Template'); ?>
		</h1>
	</div>
    <div class="floatright">
        <?php
			echo $this->Html->link(
				'<span>'.__('Back To Manage Template').'</span>', array(
					'action' => 'index'
				),array(
					'class'=>'black_btn', 'escape'=>false
				)
			);
		?>
	</div>
</div>
<div align="center" class="whitebox mtop15">
    <?= $this->Form->create('EmailTemplates', ['class' => 'validate_form']) ?>
    <table cellspacing="0" cellpadding="7" border="0" align="center">
		
		<tr>
			<td align="left"><strong class="upper">Title</strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'title', array(
						'label'=>false,
						'class' => 'input required ',
					)
				);
			?>
			</td>
		</tr>
		<tr>
			<td align="left"><strong class="upper">EMAIL SLUG</strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'slug', array(
						'label'=>false,
						'class' => 'input required ',
						'readonly'=>true,
					)
				);
			?>
			</td>
		</tr>
		<tr>
			<td align="left"><strong class="upper">SUBJECT</strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'subject', array(
						'label'=>false,
						'class' => 'input required ',
					)
				);
			?>
			</td>
		</tr>
		<tr>
			<td align="left"><strong class="upper">FROM NAME</strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'from_name', array(
						'label'=>false,
						'class' => 'input ',
					)
				);
			?>
			</td>
		</tr>
		<tr>
			<td align="left"><strong class="upper">FROM EMAIL</strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'from_email', array(
						'label'=>false,
						'class' => 'input required ',
					)
				);
			?>
			</td>
		</tr>
		<tr>
			<td align="left"><strong class="upper">REPLY NAME</strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'reply_name', array(
						'label'=>false,
						'class' => 'input ',
					)
				);
			?>
			</td>
		</tr>
		<tr>
			<td align="left"><strong class="upper">REPLY EMAIL</strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'reply_to', array(
						'label'=>false,
						'class' => 'input required ',
					)
				);
			?>
			</td>
		</tr>
		<tr>
			<td valign="top" align="left"><strong class="upper">EMAIL CONTENT</strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'content',array(
						'label'=>false,
						'type'=>'textarea',
						'class' => 'textarea required  ckeditor',
					)
				);
			?>
			</td>
		</tr>
		
		<tr>
			<td align="left"><strong class="upper">Status</strong></td>
			<td align="left">
			<?php
				$status = ['1'=>'Active','0'=>'Inactive'];
				echo $this->Form->input(
					'status_id', array(
						'options'=>$status,
						'empty'=>'Select status',
						'label'=>false,
						'class' => 'input required '
					)
				);
			?>
			</td>
		</tr>

		<tr>
			<td valign="top" align="left"><strong class="upper">Template Info (list)</strong></td>
			<td align="left">
			<?php
				echo $this->Form->input(
					'template_info',array(
						'label'=>false,
						'type'=>'textarea',
						'class' => 'textarea required',
						'style'=>'width:98%'
					)
				);
			?>
			</td>
		</tr>
		
		<tr>
			<td align="center">&nbsp;</td>
			<td align="left"><div class="black_btn2"><span class="upper"><input type="submit" value="SUBMIT" name=""></span></div></td>
		</tr>
    </table>
    <?= $this->Form->end() ?>
</div>
<script>
	var slug = function(str) {
		var $slug = '';
		var trimmed = $.trim(str);
		$slug = trimmed.replace(/[^a-z0-9-]/gi, '-').
		replace(/-+/g, '-').
		replace(/^-|-$/g, '');
		return $slug.toLowerCase();
	}

	$(document).ready(function (){
		$( "#datepicker" ).datepicker();
		$('.validate').validate();
		
	});
	
	$(document).on('blur','#title', function(){
		$('#slug').val(slug($(this).val()));
	});
</script>
