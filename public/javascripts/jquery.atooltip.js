/*
	jQuery Version:				jQuery 1.3.2+
	Plugin Name:				aToolTip V 1.1
	Plugin by: 					Ara Abcarians: http://ara-abcarians.com
	License:					aToolTip is licensed under a Creative Commons Attribution 3.0 Unported License
								Read more about this license at --> http://creativecommons.org/licenses/by/3.0/			
*/
(function($) {
    $.fn.aToolTip = function(options) {
    
    	// setup default settings
    	var defaults = {
    		clickIt: false,
    		closeTipBtn: 'aToolTipCloseBtn',
    		fixed: false,
    		inSpeed: 400,
    		outSpeed: 100,
    		tipContent: '',
    		toolTipClass: 'aToolTip',
    		xOffset: 5,
    		yOffset: 5,
    		onShow: null,
    		onHide: null
    	},
    
    	// This makes it so the users custom options overrides the default ones
    	settings = $.extend({}, defaults, options);
    
		return this.each(function() {
			var obj = $(this);
			// Decide weather to use a title attr as the tooltip content
			if(obj.attr('title')){
				// set the tooltip content/text to be the obj title attribute
				var tipContent = obj.attr('title');	 
			} else {
				// if no title attribute set it to the tipContent option in settings
				var tipContent = settings.tipContent;
			}
			
			// check if obj has a title attribute and if click feature is off
			if(tipContent && !settings.clickIt){	
				// Activate on hover	
				obj.hover(function(el){
					// remove already existing tooltip
					$('.' + settings.toolTipClass).stop().fadeOut(settings.outSpeed, function(){$(this).remove();});
					
					obj.attr({title: ''});						  
					$('body').append("<div class='"+ settings.toolTipClass +"'><p class='aToolTipContent'>"+ tipContent +"</p></div>");
					$('.' + settings.toolTipClass).css({
						position: 'absolute',
						display: 'none',
						zIndex: '50000',
						top: (obj.offset().top - $('.' + settings.toolTipClass).outerHeight() - settings.yOffset) + 'px',
						left: (obj.offset().left + obj.outerWidth() + settings.xOffset) + 'px'
					})
					.stop().fadeIn(settings.inSpeed, function(){
						if ($.isFunction(settings.onShow)){
							settings.onShow(obj);
						}
					});	
			    },
				function(){ 
					// Fade out
					$('.' + settings.toolTipClass).stop().fadeOut(settings.outSpeed, function(){
					    $(this).remove();
					    if ($.isFunction(settings.onHide)){
							settings.onHide(obj);
						}
					});
			    });	
		    }
		    
		    // Follow mouse if fixed is false and click is false
		    if(!settings.fixed && !settings.clickIt){
				obj.mousemove(function(el){
					$('.' + settings.toolTipClass).css({
						top: (el.pageY - $('.' + settings.toolTipClass).outerHeight() - settings.yOffset),
						left: (el.pageX + settings.xOffset)
					});
				});			
			} 		    
		    
		    // check if click feature is enabled
		    if(tipContent && settings.clickIt){
				// Activate on click	
				obj.click(function(el){
					// remove already existing tooltip
					$('.' + settings.toolTipClass).stop().fadeOut(settings.outSpeed, function(){$(this).remove();});
					
					obj.attr({title: ''});						  
					$('body').append("<div class='"+ settings.toolTipClass +"'><p class='aToolTipContent'>"+ tipContent +"</p></div>");
					$('.' + settings.toolTipClass + ' p.aToolTipContent').append("<a class='"+ settings.closeTipBtn +"' href='#' alt='close'>close</a>");
					$('.' + settings.toolTipClass).css({
						position: 'absolute',
						display: 'none',
						zIndex: '50000',
						top: (obj.offset().top - $('.' + settings.toolTipClass).outerHeight() - settings.yOffset) + 'px',
						left: (obj.offset().left + obj.outerWidth() + settings.xOffset) + 'px'
					})
					.fadeIn(settings.inSpeed, function(){
						if ($.isFunction(settings.onShow)){
							settings.onShow(obj);
						}
					});	
					// Click to close tooltip
					$('.' + settings.closeTipBtn).click(function(){
						$('.' + settings.toolTipClass).fadeOut(settings.outSpeed, function(){
							$(this).remove();
							if ($.isFunction(settings.onHide)){
								settings.onHide(obj);
							}
						});
						return false;
					});		 
					return false;			
			    });
		    }
		  
		}); // END: return this
		
		// return this;
    };
})(jQuery);