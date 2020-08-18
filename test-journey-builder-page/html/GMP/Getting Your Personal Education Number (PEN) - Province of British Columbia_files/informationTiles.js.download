/**
 * Contains the functionality for the search flyouts found on each homepage theme tile.
 */

$(document).ready(function() {  
	
	// Handler for when the magnifying glass icon is clicked
    $(".homepage-theme-tiles .tile-search, .mobile-menu-search .tile-search").on("click", function(e) {
    	
    	e.stopPropagation();
    	
    	var $homepageTile = $(e.currentTarget).closest(".homepage-tile");
    	var $flyout = $homepageTile.find(".tile-search-flyout");  	        	
		
    	// If there is already a flyout being animated, do not proceed
    	if($(".tile-search-flyout").is(":animated")) return;
    	    	
    	// Flyout is already expanded, so execute the search
    	if($homepageTile.hasClass("flyout-expanded")) {   		
    		var $form = $flyout.find("form");
  	    	$form.submit(); 		
    	} 
    	// Expand flyout from right to left
    	else {   		
    		closeTileFlyouts();
        	
    		$homepageTile.addClass("flyout-expanded");  
    	
    		// Slide the flyout from right to left
        	($flyout).animate({
        	    left: "0"
        	}, 800, function() {
            	$flyout.find("input[name='q']").focus();
        	} );       		
    	}    	
    })

	// Handler for when a tile flyout input field is clicked into
    $(".tile-search-flyout input[name='q']").on("click", function(e) {
    	e.stopPropagation();  
    })    
    
	// Handler for when the Popular Services search button is clicked
    $(".popular-services-search .tile-search").on("click", function(e) {
    	var $homepageTile = $(e.currentTarget).closest(".homepage-tile");
    	var $flyout = $homepageTile.find(".tile-search-flyout");  	        	  		
    	var $form = $flyout.find("form");
  	    $form.submit(); 		
	})     
    
	// Handler for submission of the flyout forms. Validate the form input before submitting
	$(".tile-search-flyout > form").submit(function(e) {
		var $textInput = $(this).find("input[name='q']");
	    if($textInput.val() == '') {
		    e.preventDefault();
	    	closeTileFlyouts();
		}	
	})    	
});

// When a click outside of a tile with expanded flyout is detected, close all flyouts
$(document).mouseup(function(e) {
	var target = $(e.target);
	// If the click is outside of any search flyout, close all flyouts
	if(target.closest(".homepage-tile.flyout-expanded").length == 0) {
		// Also check that the click is outside the popular services search
		if(target.closest(".popular-services-search").length == 0) {
			closeTileFlyouts();
		}
    }
	// If the click is outside of the popular services search, reset it
	if(target.closest(".popular-services-search").length == 0) {
		// Reset text inputs
		$(".popular-services-search .homepage-tile").find("input[name='q']").val("");
		// Add placeholder background image
		$(".popular-services-search .homepage-tile").find("input[name='q']").addClass("placeholder");		
		// Remove any query suggestions
		$(".popular-services-search .homepage-tile table.ss-gac-m").empty();				
    }	
});

// When escape key is pressed, close all flyouts 
$(document).keyup(function(e) { 
    if (e.keyCode == 27) { // esc keycode
		closeTileFlyouts();
    }   
});

$(window).on("load resize",function(e) {	
	
	// Keep the width of the query suggest dropdown equal to the tile content width
	$(".homepage-tile").each(function() {
		var querySuggestWidth = $(this).width();
		// If a homepage theme tile ("How may we help you" section), need to account for the icon width
		if($(this).find(".tile-icon").length > 0 && $(window).width() >= 768) {
			querySuggestWidth = querySuggestWidth - $(this).find(".tile-icon").outerWidth();
		}
		$(this).find("table.ss-gac-m").width(querySuggestWidth);
	});		
	
	if($(window).width() < 768) {
		// Calculate the width of the mobile menu search elements dynamically	
		var mobileNavWidth = $(window).width() - 50;
		$(".mobile-menu-search > .homepage-tile").width(mobileNavWidth);
	}
});

// If one of the flyout inputs is tabbed into and it has focus, ensure the layout is the same as if it were clicked on normally
$(window).keyup(function (e) {
    if (e.keyCode == 9) {
    	
    	closeTileFlyouts();    	
    	
    	if($('.homepage-theme-tiles .tile-searchbox:focus').length) {
	    	var $homepageTile = $('.homepage-theme-tiles .tile-searchbox:focus').closest(".homepage-tile");
	    	var $flyout = $homepageTile.find(".tile-search-flyout");  	        					        	
	        $homepageTile.addClass("flyout-expanded");      	       	      	
	    	($flyout).css("left", "0");
    	}
    }
});

function closeTileFlyouts() {

	// If there is a flyout currently being animated, do not proceed
	if($(".tile-search-flyout").is(":animated")) return;
	
	$(".homepage-tile").removeClass("flyout-expanded");
	// Reset text inputs
	$(".homepage-tile").find("input[name='q']").val("");
	// Add placeholder background image
	$(".homepage-tile").find("input[name='q']").addClass("placeholder");	
	// Reset left property so the flyout doesn't display
	$(".homepage-tile .tile-search-flyout").css("left", "");	
	// Remove any query suggestions
	$(".homepage-tile table.ss-gac-m").empty();		
}
