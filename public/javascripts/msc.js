$(document).ready(function(){
	var aVal = ""; 
	  $(".focus").focus(function(){  aVal = $(this).val(); $(this).val("");   });
	  $(".focus").blur(function(){  $(this).val(aVal);  });
	  $(".c_bg:odd").addClass("odd");	  
	  $('ul.menumng li:first').addClass("menu_left");
	  $('ul.menumng li:last').addClass("menu_right");
});

$(document).ready(function(){
$(function(){
	$('a.help').aToolTip();
});
/*added by rajeev*/
$('body').append("<div class='aToolTip' style='display:none;'><p class='aToolTipContent'>..</p></div>");

$("#radio1").click(function(){ $(".aToolTip").remove(); $('body').append("<div class='aToolTip' style='display:none;'><p class='aToolTipContent'>..</p></div>"); });
$("#radio2").click(function(){ 
 $(".aToolTip").remove();
 $('body').append("<div class='aToolTip' style='display:none;'><p class='aToolTipContent'>..</p></div>");
/*added by rajeev*/
 });

});

var event_status = function (t) { if (t.value=='paid') { $('.paid_show').show(); } else { $('.paid_show').hide();} }          
	  $(".c_bg:odd").addClass("odd");
/*on focus text hide end*/	 

