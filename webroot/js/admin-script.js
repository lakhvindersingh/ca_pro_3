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
	dalert.ReplaceAlert();
	dalert.ReplaceConfirm();

	$('.validate_form').each(function(a, b) {
		$(b).validate();
	});

	//flash message
	$('div#flashMessage').delay(JSFlash.delay).fadeOut(JSFlash.fadeOut, function() {$('div#flashMessage').remove()});

	/////////////////////
	$('#check_all').click(function(event) {  //on click
    	var checkboxes = $(this).closest('form').find('.check-box-select');
        if(this.checked) { // check select status
            checkboxes.each(function() { //loop through each checkbox
                this.checked = true;  //select all checkboxes with class "checkbox1"
            });
        }else{
            checkboxes.each(function() { //loop through each checkbox
                this.checked = false; //deselect all checkboxes with class "checkbox1"
            });
        }
    });
	$("textarea").TextAreaExpander(20,2000);

	$(".numeric").keydown(function (e) {
        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
             // Allow: Ctrl+A
            (e.keyCode == 65 && e.ctrlKey === true) || 
             // Allow: home, end, left, right, down, up
            (e.keyCode >= 35 && e.keyCode <= 40)) {
                 // let it happen, don't do anything
                 return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });
});

//Ajax Loader
//Uncomment and ajax loader will automatically get called everytime an ajax call takes place
var $loading = $('#loadingDiv').hide();
$(document)
	.ajaxStart(function () {
		JSFlash.removeFlash();
		$loading.show();
		$('body').css('cursor', 'progress');
	})
	.ajaxStop(function () {
		$loading.hide();
		$('body').css('cursor', 'auto');
	});