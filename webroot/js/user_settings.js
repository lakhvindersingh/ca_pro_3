$(document).ready(function(){$("#tabs").tabs().addClass("ui-tabs-vertical ui-helper-clearfix");$("#tabs li").removeClass("ui-corner-top").addClass("ui-corner-left");$('.override_tabs').click(function(e){var $this=$(this);e.preventDefault();location.href=$this.attr('url');});$('[data-countdown]').each(function(){var $this=$(this),finalDate=$(this).data('countdown');$this.countdown(finalDate,function(event){var htmlText='';if($this.hasClass('viewPage')){if(event.strftime('%D')!=00||event.strftime('%H')!=00||event.strftime('%M')!=00||event.strftime('%S')!=00)htmlText='<li>%S<p>Seconds</p></li>'+htmlText;if(event.strftime('%D')!=00||event.strftime('%H')!=00||event.strftime('%M')!=00)htmlText='<li>%M<p>Minutes</p></li>'+htmlText;if(event.strftime('%D')!=00||event.strftime('%H')!=00)htmlText='<li>%H<p>Hours</p></li>'+htmlText;if(event.strftime('%D')!=00)htmlText='<li>%D<p>Days</p></li>'+htmlText;$this.html(event.strftime(htmlText));if(event.strftime('%S')==00&&event.strftime('%M')==00&&event.strftime('%H')==00&&event.strftime('%D')==00){$(this).html('<li class="redColor opacityHalf">Listing Ended</li>');}else if($(this).find('li').length==1)$(this).find('li').addClass('redColor');}else if($this.hasClass('topPage')){htmlText='<li>%S<p>Seconds</p></li>'+htmlText;htmlText='<li>%M<p>Minutes</p></li>'+htmlText;htmlText='<li>%H<p>Hours</p></li>'+htmlText;htmlText='<li>%D<p>Days</p></li>'+htmlText;$this.html(event.strftime(htmlText));}else if($this.hasClass('headerPage')){$this.html(event.strftime('%D.%H.%M.%S'));}else{if(event.strftime('%D')!=00||event.strftime('%H')!=00||event.strftime('%M')!=00||event.strftime('%S')!=00)htmlText='<li>%S<p>Seconds</p></li>'+htmlText;if(event.strftime('%D')!=00||event.strftime('%H')!=00||event.strftime('%M')!=00)htmlText='<li>%M<p>Minutes</p></li>'+htmlText;if(event.strftime('%D')!=00||event.strftime('%H')!=00)htmlText='<li>%H<p>Hours</p></li>'+htmlText;if(event.strftime('%D')!=00)htmlText='<li>%D<p>Days</p></li>'+htmlText;$this.html(event.strftime(htmlText));if(event.strftime('%S')==00&&event.strftime('%M')==00&&event.strftime('%H')==00&&event.strftime('%D')==00){$(this).parent().parent().parent().parent().fadeOut('slow');$(this).parent().parent().parent().parent().remove();}else if($(this).find('li').length==1)$(this).find('li').addClass('redColor');}});});$(".numeric").keydown(function(e){if($.inArray(e.keyCode,[46,8,9,27,13,110])!==-1||(e.keyCode==65&&e.ctrlKey===true)||(e.keyCode>=35&&e.keyCode<=40)){return;}if((e.shiftKey||(e.keyCode<48||e.keyCode>57))&&(e.keyCode<96||e.keyCode>105)){e.preventDefault();}});$(".alphaNumeric").keydown(function(e){if($.inArray(e.keyCode,[46,8,9,27,13,110])!==-1||(e.keyCode==65&&e.ctrlKey===true)||(e.keyCode>=65&&e.keyCode<=90)||(e.keyCode>=97&&e.keyCode<=122)||(e.keyCode>=35&&e.keyCode<=40)){return;}if((e.shiftKey||(e.keyCode<48||e.keyCode>57))&&(e.keyCode<96||e.keyCode>105)){e.preventDefault();}});});function eachLoad(){$('[data-countdown]').each(function(){var $this=$(this),finalDate=$(this).data('countdown');$this.countdown(finalDate,function(event){var htmlText='';if($this.hasClass('viewPage')){if(event.strftime('%D')!=00||event.strftime('%H')!=00||event.strftime('%M')!=00||event.strftime('%S')!=00)htmlText='<li>%S<p>Seconds</p></li>'+htmlText;if(event.strftime('%D')!=00||event.strftime('%H')!=00||event.strftime('%M')!=00)htmlText='<li>%M<p>Minutes</p></li>'+htmlText;if(event.strftime('%D')!=00||event.strftime('%H')!=00)htmlText='<li>%H<p>Hours</p></li>'+htmlText;if(event.strftime('%D')!=00)htmlText='<li>%D<p>Days</p></li>'+htmlText;$this.html(event.strftime(htmlText));if(event.strftime('%S')==00&&event.strftime('%M')==00&&event.strftime('%H')==00&&event.strftime('%D')==00){$(this).html('<li class="redColor opacityHalf">Listing Ended</li>');}else if($(this).find('li').length==1)$(this).find('li').addClass('redColor');}else if($this.hasClass('topPage')){htmlText='<li>%S<p>Seconds</p></li>'+htmlText;htmlText='<li>%M<p>Minutes</p></li>'+htmlText;htmlText='<li>%H<p>Hours</p></li>'+htmlText;htmlText='<li>%D<p>Days</p></li>'+htmlText;$this.html(event.strftime(htmlText));}else if($this.hasClass('headerPage')){$this.html(event.strftime('%D.%H.%M.%S'));}else{if(event.strftime('%D')!=00||event.strftime('%H')!=00||event.strftime('%M')!=00||event.strftime('%S')!=00)htmlText='<li>%S<p>Seconds</p></li>'+htmlText;if(event.strftime('%D')!=00||event.strftime('%H')!=00||event.strftime('%M')!=00)htmlText='<li>%M<p>Minutes</p></li>'+htmlText;if(event.strftime('%D')!=00||event.strftime('%H')!=00)htmlText='<li>%H<p>Hours</p></li>'+htmlText;if(event.strftime('%D')!=00)htmlText='<li>%D<p>Days</p></li>'+htmlText;$this.html(event.strftime(htmlText));if(event.strftime('%S')==00&&event.strftime('%M')==00&&event.strftime('%H')==00&&event.strftime('%D')==00){$(this).parent().parent().parent().parent().fadeOut('slow');$(this).parent().parent().parent().parent().remove();}else if($(this).find('li').length==1)$(this).find('li').addClass('redColor');}});});}