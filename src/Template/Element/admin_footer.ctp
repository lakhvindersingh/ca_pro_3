<script>
		$(document).ready(function(){
			$('html').height('100%');
		});
		$(window).on('load resize', function(){
			
			$('.menubg').removeAttr('style');
			
			setTimeout(function(){
				$('.menubg').css('min-height', $('html').height() - $('#header').outerHeight() + 20);
			}, 100);
			
		});
</script>
