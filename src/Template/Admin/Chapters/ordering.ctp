<h1><?php echo __('Order Chapter'); ?></h1>
<div class="row mtop15">
	
</div>
<div class="row mtop30">

	<ul id="sortable">
	<?php foreach($chapters as $key=>$chapter) {
			if($key == 0){ ?>
				<h2>Area : <?php echo $chapter->area->title ?></h2>
		<?php } ?>	
		
		<li id="item-<?= $chapter->id ?>" class="ui-state-default">
			<span class="ui-icon ui-icon-arrowthick-2-n-s"></span>
			<p>Chapter : <?= $chapter->title ?><p>
		</li>
	<?php } ?>
	</ul>

</div>
<style>
  #sortable { list-style-type: none; margin: 0; padding: 0; width: 60%; }
  #sortable li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; font-size: 1.4em; height: auto; }
  #sortable li span { position: absolute; margin-left: -1.3em; }
</style>
<script>
  
  $(document).ready(function () {
    $('ul#sortable').sortable({
    	placeholder: "ui-state-highlight",
        axis: 'y',
        stop: function (event, ui) {
	        var data = $(this).sortable('serialize');
            console.log(data);
            $.ajax({
				url			: defaultUrl + 'chapters/orderChapter',
				type		: 'POST',
				dataType	: 'html',
				data		: data,
				success : function(response){
				}
			});
		}
    });
    $( "#sortable" ).disableSelection();
});
</script>
