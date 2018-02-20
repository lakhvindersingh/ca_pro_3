(function(window,$){"use strict";var dalert={alert:function(dalert_msg,title_msg){if(!title_msg)title_msg='Alert';if(!dalert_msg)dalert_msg='';try{$("<div class='add-popup'></div>").html(dalert_msg).dialog({dialogClass:'add-popup-wrap',title:title_msg,resizable:false,draggable:false,modal:true,beforeClose:function(event,ui){$(this).remove();},buttons:{"Ok":function(){$(this).dialog("close");}}});dalert.byPassjQueryUI();}catch(error){console.log(error);alert(dalert_msg);}},customAlert:function(dalert_msg,title_msg,callback){if(!title_msg)title_msg='Alert';if(!dalert_msg)dalert_msg='';try{$("<div class='add-popup'></div>").html(dalert_msg).dialog({dialogClass:'add-popup-wrap',title:title_msg,resizable:false,draggable:false,modal:true,beforeClose:function(event,ui){$(this).remove();},buttons:{"Ok":function(){$(this).dialog("close");if(callback)callback();}}});dalert.byPassjQueryUI();}catch(error){console.log(error);alert(dalert_msg);}},confirm:function(dalertConf_msg,title_msg,t,callback){if(!title_msg)title_msg='Confirm';if(!dalertConf_msg)dalertConf_msg='';if(!t)t=$(this);try{$("<div class='add-popup'></div>").html(dalertConf_msg).dialog({dialogClass:'add-popup-wrap',title:title_msg,resizable:false,draggable:false,modal:true,beforeClose:function(event,ui){$(this).remove();},buttons:{"Yes":function(){if(!callback){$(this).dialog("close");}else{$(this).dialog("close");callback(1,t);}},"No":function(){if(!callback){$(this).dialog("close");}else{$(this).dialog("close");callback(0,t);}}}});dalert.byPassjQueryUI();}catch(error){console.log(error);var conf_val=confirm(dalertConf_msg);if(conf_val==true){callback(1,t);}else{callback(0,t);}}},byPassjQueryUI:function(){},ReplaceAlert:function(){window.alert=dalert.alert;},ReplaceConfirm:function(){window.confirm=dalert.confirm;}};window.dalert=dalert;})(window,jQuery);