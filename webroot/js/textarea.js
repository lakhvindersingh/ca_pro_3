(function($){var defaults={padding_top:8,padding_bottom:8};$.fn.TextAreaExpander=function(minHeight,maxHeight,options){options=$.extend({},defaults,options||{});var hCheck=!$.browser||!($.browser.msie||$.browser.opera);function ResizeTextarea(e){e=e.target||e;var vlen=e.value.length,ewidth=e.offsetWidth;if(vlen!=e.valLength||ewidth!=e.boxWidth){if(hCheck&&(vlen<e.valLength||ewidth!=e.boxWidth))e.style.height="0px";var h=Math.max(e.expandMin,Math.min(e.scrollHeight,e.expandMax));if(e.expandMax>1900){e.style.overflow="hidden";e.style.height=e.scrollHeight+"px";}else{e.style.overflow=(e.scrollHeight>h?"auto":"hidden");e.style.height=h+"px";}}return true;};this.each(function(){if(this.nodeName.toLowerCase()!="textarea")return;var p=this.className.match(/expand(d+)-*(d+)*/i);this.expandMin=minHeight||(p?parseInt('0'+p[1],10):0);this.expandMax=maxHeight||(p?parseInt('0'+p[2],10):99999);ResizeTextarea(this);if(!this.Initialized){this.Initialized=true;$(this).css("padding-top",options.padding_top).css("padding-bottom",options.padding_bottom);$(this).bind("keyup",ResizeTextarea).bind("focus",ResizeTextarea);}});return this;};})(jQuery);