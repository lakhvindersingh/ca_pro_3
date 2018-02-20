cl = function(data) {
	console.log(data);
};

/**
 * SHOWING FLASH MESSAGE FROM AJAX
 *
 * delay: ms delay in hiding the flash
 * fadeOut: ms time taken in fading out the div
 * id: id of the flash div (to call the flash)
 * className: class of the success div to place css
 * errorClassName: class of the error div to place css
 * showFlash: function to show the success flash message
 * showFlashError: function to show the error flash message
 * removeFlash: remove flash message (w/ or w/o animation)

 For success, call:
 showFlash();

 For error, call:
 showFlashError();
 */
var JSFlash = {
	'delay' : 5000,
	'fadeOut' : 1500,
	'id' : 'jsFlashMessage',
	'className': 'message success',
	'errorClassName' : 'message error',
	'hideAfterShow' : false,
	'hideAfterShow' : true,
	'appendAfter' : '.appendFlashTo',
	'appendAfter' : '',
	'focus' : true,

	'showFlash': function(message, callback) {
		JSFlash.removeFlash();
		html = '<div id="' + JSFlash.id + '" class="' + JSFlash.className + '">' + message + '</div>';
		html = $(html);
		if(JSFlash.appendAfter != '') {
			html.insertAfter(JSFlash.appendAfter);
			if(JSFlash.focus) {
				$('html, body').animate({ scrollTop: $('#' + JSFlash.id).offset().top }, 1);
			}
		} else {
			html.appendTo('body');
		}
		if(JSFlash.hideAfterShow) {
			html.delay(JSFlash.delay).fadeOut(JSFlash.fadeOut, function() {
				html.remove();
				if(callback)
					callback();
			});
		}
	},

	'showFlashError': function(message, callback) {
		JSFlash.removeFlash();
		html = '<div id="' + JSFlash.id + '" class="' + JSFlash.errorClassName + '">' + message + '</div>';
		html = $(html);
		if(JSFlash.appendAfter != '') {
			html.insertAfter(JSFlash.appendAfter);
			if(JSFlash.focus)
				$('html, body').animate({ scrollTop: $('#' + JSFlash.id).offset().top }, 1);
		} else {
			html.appendTo('body');
		}
		if(JSFlash.hideAfterShow) {
			html.delay(JSFlash.delay).fadeOut(JSFlash.fadeOut, function() {
				html.remove();
				if(callback)
					callback();
			});
		}
	},

	'removeFlash' : function(animate, callback) {
		html = $('#' + JSFlash.id);
		if(animate) {
			html.delay(JSFlash.delay).fadeOut(JSFlash.fadeOut, function() {
				html.remove();
				if(callback)
					callback();
			});
		} else {
			html.remove();
			if(callback)
				callback();
		}
	}
};

showFlash = JSFlash.showFlash;
showFlashError = JSFlash.showFlashError;
removeFlash = JSFlash.removeFlash;
$(document).ready(function() {
	// Script for tabs
	$( "#tabs" ).tabs().addClass( "ui-tabs-vertical ui-helper-clearfix" );
	$( "#tabs li" ).removeClass( "ui-corner-top" ).addClass( "ui-corner-left" );

	// Script For Flex Slider
	$('.flexslider').flexslider({
		animation: "slide",
		start: function(slider){
			$('body').removeClass('loading');
		}
	});

	// Script For Flex Slider Thumbnails
	$('.flexslider-thumb').flexslider({
		animation: "slide",
		controlNav: "thumbnails",
		start: function(slider){
			$('body').removeClass('loading');
		}
	});

	// Script for responsive navigate
	$('.mainmenu').menu({start: 640});

	dalert.ReplaceAlert();
	dalert.ReplaceConfirm();
	$("textarea").TextAreaExpander(20,500);

	$('.validate_form').each(function(a, b) {
		$(b).validate();
	});
});

//Ajax Loader
//Uncomment and ajax loader will automatically get called everytime an ajax call takes place
var $loading = $('#loadingDiv').hide();
$(document)
	.ajaxStart(function () {
		// JSFlash.removeFlash();
		$loading.show();
		$('body').css('cursor', 'progress');
	})
	.ajaxStop(function () {
		$loading.hide();
		$('body').css('cursor', 'auto');
	});