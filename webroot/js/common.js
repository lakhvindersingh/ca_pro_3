var runtime = false;
$(document).ready(function(){
	setTimeout(function(){ 
		$('.message').hide();
	}, 5000);
})
$(function() {
    $( "#dialog-confirm" ).dialog({
      resizable: true,
      autoOpen: false,
      height:200,
      width:500,
      modal: true,
      buttons: {
        "Delete": function() {
			var controller = $( "#confirm-box-delete" ).attr('data-attr');			
			$.ajax({
				url			: defaultUrl + controller + '/index',
				type		: 'POST',
				dataType	: 'html',
				data		: {
					'option' 	: 'delete',
					'ids'		: $( "#confirm-box-delete" ).val(),
					'attr'		: $( "#confirm-box-delete" ).attr('data-attr')
					},
				success : function(response){
					location.reload();
				}
			});
			$( this ).dialog( "close" );
        },
        Cancel: function() {
			$( this ).dialog( "close" );
        }
      }
    });
});

$(function() {
	var currentTime = new Date()
	var month = currentTime.getMonth() + 1
	var day = currentTime.getDate()
	var year = currentTime.getFullYear()
	$( ".datepicker" ).datepicker({
		dateFormat 	: "yy-mm-dd",
		changeMonth	: true,
      	changeYear	: true,
      	yearRange	: "1980:"+year+"", 
      	maxDate		: year+'-'+month+'-'+day
	});
});
  
$(document).on('submit', '.deleteArea', function(event){
	var $form = $(this);
	var action = $form.find('.select').val();
	
	if(action == "delete"){
		event.preventDefault();
		$.ajax({
			url			: defaultUrl + 'areas/delete',
			type		: 'POST',
			dataType	: 'json',
			data		: $( this ).serialize(),
			success : function(response){
				console.log(response.status);
				if(response.status == "error"){
					alert(response.msg);
				}else if(response.status == "success"){
					$( "#confirm-box-text" ).html(response.msg);
					$( "#confirm-box-delete" ).val(response.data);
					$( "#confirm-box-delete" ).attr('data-attr', 'Areas');
					$( "#dialog-confirm" ).dialog( "open" );
				}
				return false;
			}
		});
		return false;
	}
});

$(document).on('submit', '.deleteChapter', function(event){
	var $form = $(this);
	var action = $form.find('.select').val();

	if(action == "delete"){
		event.preventDefault();
		$.ajax({
			url			: defaultUrl + 'chapters/delete',
			type		: 'POST',
			dataType	: 'json',
			data		: $( this ).serialize(),
			success : function(response){
				console.log(response.status);
				if(response.status == "error"){
					alert(response.msg);
				}else if(response.status == "success"){
					$( "#confirm-box-text" ).html(response.msg);
					$( "#confirm-box-delete" ).val(response.data);
					$( "#confirm-box-delete" ).attr('data-attr', 'Chapters');
					$( "#dialog-confirm" ).dialog( "open" );
				}
				return false;
			}
		});
		return false;
	}
});


$(document).on('submit', '.deleteLessons', function(event){
	var $form = $(this);
	var action = $form.find('.select').val();

	if(action == "delete"){
		event.preventDefault();
		$.ajax({
			url			: defaultUrl + 'lessons/delete',
			type		: 'POST',
			dataType	: 'json',
			data		: $( this ).serialize(),
			success : function(response){
				console.log(response.status);
				if(response.status == "error"){
					alert(response.msg);
				}else if(response.status == "success"){
					$( "#confirm-box-text" ).html(response.msg);
					$( "#confirm-box-delete" ).val(response.data);
					$( "#confirm-box-delete" ).attr('data-attr', 'Lessons');
					$( "#dialog-confirm" ).dialog( "open" );
				}
				return false;
			}
		});
		return false;
	}
});


$(document).on('submit', '.deleteExercise', function(event){
	var $form = $(this);
	var action = $form.find('.select').val();

	if(action == "delete"){
		event.preventDefault();
		$.ajax({
			url			: defaultUrl + 'exercises/delete',
			type		: 'POST',
			dataType	: 'json',
			data		: $( this ).serialize(),
			success : function(response){
				console.log(response.status);
				if(response.status == "error"){
					alert(response.msg);
				}else if(response.status == "success"){
					$( "#confirm-box-text" ).html(response.msg);
					$( "#confirm-box-delete" ).val(response.data);
					$( "#confirm-box-delete" ).attr('data-attr', 'Exercises');
					$( "#dialog-confirm" ).dialog( "open" );
				}
				return false;
			}
		});
		return false;
	}
});


jQuery('.creload').on('click', function() {
    var mySrc = $(this).prev().attr('src');
    var glue = '?';
    if(mySrc.indexOf('?')!=-1)  {
        glue = '&';
    }
    $(this).prev().attr('src', mySrc + glue + new Date().getTime());
    return false;
});