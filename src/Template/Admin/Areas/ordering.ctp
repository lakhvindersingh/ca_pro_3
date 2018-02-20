<h1><?php echo __('Order Area'); ?></h1>
<div class="row mtop15">
	
</div>
<div class="row mtop30">

	<ul id="sortable">
	<?php foreach($areas as $key=>$area) {
			if($key == 0){ ?>
				<h2>Area Type : <?php echo ($area->area_type == 1) ? 'Primary' : 'Elementry'; ?></h2>
		<?php } ?>	
		
		<li id="item-<?= $area->id ?>" class="ui-state-default">
			<span class="ui-icon ui-icon-arrowthick-2-n-s"></span>
			<p>Area : <?= $area->title ?><p>
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
				url			: defaultUrl + 'areas/orderAreas',
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
