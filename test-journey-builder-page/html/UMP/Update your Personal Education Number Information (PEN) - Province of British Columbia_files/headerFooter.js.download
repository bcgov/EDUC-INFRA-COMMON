/**
 * JS functionality that is specific to GOV header and footer elements
 */

$(document).ready(function(event) {

	// Event handler for when a user clicks the "Menu" button
	$('.menu-button').on("focus mousedown", function(e) {

		toggleHeaderElements(e);		
		addScrollableBurgerMenu();
		
		// In full screen view, expand and select the first menu item by default
		if($(window).width() >= 768) {
			var firstNavItem = $('.govNav > ul.firstLevel > li').first();	       	
			firstNavItem.addClass('selected open');
			firstNavItem.find('div.theme-menu').css('display', 'block');
			govNav.showhide(firstNavItem, 'show', {})
		}
		
		e.preventDefault();
	
	});	

	// If the collapsible header search element is currently expanded and the user clicks outside the area, collapse it
	$(document).on('click', function(event) {
		// If header search input is currently being shown and user clicks outside it, collapse the header search
		if($(event.target).closest('#header-search').length == 0 && $("#header-search").hasClass("in")) {
			collapseHeaderSearch();
		}  
	}); 

	$(document).keyup(function(e) {		
		if($('#header-search').hasClass("in")) {			
			// If search is expanded and user hits the tab key, collapse it and move focus to the menu			
			if(e.keyCode == 9) { // tab key maps to keycode `9`
				collapseHeaderSearch();			
				$("#govNavMenuToggle").focus();        
			}
			// If search is expanded and the user hits the escape key, collapse it   			
			else if(e.keyCode == 27) { // escape key maps to keycode `27`
				collapseHeaderSearch();			
			}			
		}
		
	});     

	// When the collapsible header search element is expanded, move focus to the input field
	$('#header-search').on("shown.bs.collapse", function() {
		$("input#global-search").focus();
	});
	
	$('#footerToggle > a').click(function(event) {
        event.preventDefault();
        toggleFooter(event);
    });
	
    $("#govNavMenu li a").on("focus", function(e) {
        var list = $(this).closest("li").addClass("focus")
    }).on("blur", function(e) {
        var list = $(this).closest("li").removeClass("focus")
    });

    // When the search button has focused, show the search (for keyboard navigation)
    $("#searchButton").on("focus", function(e) {
    	$("#header-search").collapse("show");
    }); 
    
    govNav.init({
    	menuid: 'govMainMenu'	
    })
    //navigate menu with keyboard 
    $(document).keydown(function(e) {
    	if($("#govNavMenu").is(":visible") && !$("#govNavMenu input").is(":focus")) {
    		var currentItem= $("#govNavMenu :focus").closest("li");
    	    switch(e.which) {
    	    
    	    	case 9: // tab key   	    		
    	    		// If current focus is on the menu button, tab to the next element with tabindex
    	    		if($("#govNavMenuToggle").is(":focus")) {
    	    			return;
    	    		}
    	    		// If current focus is on a header-link item
    	    		else if($("#header-links ul li a:focus").length) {
    	    			// If focus is on the last header-link item, change focus to the first item in theme navigation
    	    			// After this happens, they will need to navigate the menu with the arrow keys. Pressing tab again will close the menu
    	    			if($("#header-links ul li").last().find("a").is(":focus")) {
        	    			$(".firstLevel > li:first > a").focus();
        	    		} 
    	    			// Otherwise, tab to the next element with tabindex
    	    			else {
        	    			return;
        	    		}   	    			
    	    		} 
    	    		// Otherwise, close the menu
    	    		else {
    	    			toggleHeaderElements(e);
    	    		}  	    		
	    		break;
    	        
	    		case 27: // escape key
	    			// Close the menu
	    			toggleHeaderElements(e);
	    		break;	
	    		
    	    	case 37: // left - select first item in the next sub list 
    	        	var nextItem=currentItem.closest("li").find("ul li:first");
    	        	if(nextItem.length){
    	        		nextItem.find("> a").focus();
    	        	}
    	        	if(nextItem.hasClass("hassub")){
    	        		govNav.showhide(nextItem, 'show',govNav.setting);
    					if(currentItem.hasClass("hassub")){
    	        			govNav.showhide(currentItem, 'hide',govNav.setting);
    	        		}
    	        	}
    	        break;
    	
    	        case 38: // up - open previous item in the current list
    	        	var prevItem=currentItem.closest("li").prev("li");
    	        	if(prevItem.length){
    	        		prevItem.find("> a").focus();
    	    		}		
    	        	if(prevItem.hasClass("hassub")){
    					govNav.showhide(prevItem, 'show',govNav.setting);
    					if(currentItem.hasClass("hassub")){
        					govNav.showhide(currentItem, 'hide',govNav.setting);
    					}
    	        	}
    	        break;
    	
    	        case 39: // right - select parent list item 	        	
    	        	var prevItem=currentItem.closest("ul").closest("li");
    	        	prevItem.find("> a").focus();
					//if top level close menu
    	        	if(!prevItem.length>0){
    	        		$("#govNavMenu").each(function(){
    	        			$(this).addClass("hidden").removeAttr("style");
    	        			$(this).removeClass("expanded");
    	        		});
    	        	}else if(prevItem.hasClass("hassub")){
    					govNav.showhide(prevItem, 'show',govNav.setting);
    					if(currentItem.hasClass("hassub")){
        					govNav.showhide(currentItem, 'hide',govNav.setting);
    					}
    	        	}    	        	
    	        break;
    	
    	        case 40: // down - open next item in the current list
    	        	
    	        	var nextItem=currentItem.closest("li").next("li");
    	        	if(currentItem.closest("#govNavMenu").length<1){
    	        		nextItem=$("#govNavMenu ul.firstLevel li:first");
    	        	}
    	        	
    	        	if(nextItem.length){
    	        		nextItem.find("> a").focus();
    	        	}
    	        	if(nextItem.hasClass("hassub")){
    	        		govNav.showhide(nextItem, 'show',govNav.setting);
    					if(currentItem.hasClass("hassub")){
    	        			govNav.showhide(currentItem, 'hide',govNav.setting);
    	        		}
    	        	}
    	        break;
    	
    	        default: return; // exit this handler for other keys
    	    }
    	    e.preventDefault(); // prevent the default action (scroll / move caret)
    	}else if($(".explore ul:visible").length>0){
    		var currentItem= $(":focus");
    	    switch(e.which) {
    	
    	        case 38: // up - open previous item in the current list
    	        	var prevItem=currentItem.closest("li").prev("li");
    	        	if(prevItem.length){
    	        		prevItem.find("> a").focus();
    	    		}		
    	        break;
    	
    	        case 40: // down - open next item in the current list
    	        	if(currentItem.hasClass("explore")){
    	    			//select first 
    	        		currentItem.find("ul li:first > a").focus();
    	    		}else{
        	        	var nextItem=currentItem.closest("li").next("li");
        	        	if(nextItem.length){
        	        		nextItem.find("> a").focus();
        	        	}
    	    		}
    	        break;
    	
    	        default: return; // exit this handler for other keys
    	    }
    	    e.preventDefault(); // prevent the default action (scroll / move caret)
    	}
	});	

	// Clear out menu searchbox query suggestions when the user hovers away from the current theme
	$("#govMainMenu > ul > li").hover(function() {
		$("#govMainMenu > ul > li").find(".menu-searchbox").val("").addClass("placeholder");
		$("#govMainMenu > ul > li").find(".ss-gac-m").children().remove();		
		$("#govMainMenu > ul > li input").blur();		
	});	
	
	// [RA-368] CS - when focus goes into a burger menu search field, force a scroll to top of page (fix for iPad landscape view)
	$("input.menu-searchbox").focus(function() {
		$("body").scrollTop(0);
	});	
	
	// RA-1022: When a search query suggestion is clicked, hide the suggestions immediately
	$('#header-search #search_suggest').on("click", "td.ss-gac-c", function(e) {
		$('#search_suggest').hide();		
	});	
	
});

$(document).mouseup(function(e) {
	var touchenabled = !!('ontouchstart' in window) || !!('ontouchstart' in document.documentElement) || !!window.ontouchstart || !!window.Touch || !!window.onmsgesturechange || (window.DocumentTouch && window.document instanceof window.DocumentTouch);
	var target = $(e.target);

	// Close the navigation menu when there is a click on the page somewhere other than the menu button or within the menu
	if(!target.hasClass("menu-button") && !target.parent().hasClass("menu-button") && target.closest("#govNavMenu").length == 0) {
		$("#govNavMenu").removeClass("expanded").addClass("hidden");			
		$("#header-main-row2").removeClass("in");
	}
	// Close the search box when there is a click on the page somewhere other than the search box or within the search box
	if(!target.hasClass("search-button") && !target.parent().hasClass("search-button") && target.closest(".header-search").length == 0) {
		$(".header-search").removeClass("in");
	}		
	
	// Close any navigation tile menus
    $(".explore ul").not(target.closest(".explore").find("ul")).slideUp(200, 'linear', function () { });
    
    // [ENHS-730] - GOV header search/search results page search
    // If query suggestions are being displayed and the user clicks outside the search area, clear the suggestions
	if($("table#search_suggest").length > 0 && $("table#search_suggest").children().length > 0 && target.closest(".search").length == 0 && !target.hasClass("ss-gac-c") ) {		
//		console.log("Click detected outside of search area...clearing search suggestions");
		ss_qshown = null;
		ss_clear();
		$("table#search_suggest").children().remove();
	}    

    // [ENHS-730] - GOV main navigation theme search
	// If query suggestions are being displayed and the user clicks outside the search area, clear the suggestions
	if($("#govNavMenu li.open").length > 0 && $("#govNavMenu li.open table.ss-gac-m").children().length > 0 && target.closest("form").length == 0 && !target.hasClass("ss-gac-c") ) {		
//		console.log("Click detected outside of navigation search area...clearing search suggestions");
		ss_qshown = null;
		ss_clear();
		$("#govNavMenu li.open table.ss-gac-m").children().remove();
	} 
	
});

$(window).on("scroll", function(event) {	
	
	// If the header search element is expanded while a user scrolls, hide the search element and clear any input
	// Only for tablet view and above
	if($("#header-search").hasClass("in") && $("input#global-search").is(":focus")) {
		if($(window).width() >= 768) {
			collapseHeaderSearch();
		}		
	}
	
	// If the header menu is expanded while a user scrolls, hide the menu
	$("#govNavMenu").removeClass("expanded").addClass("hidden");			
});

// Pageshow event is fired when a session history entry is being traversed to.
// This includes back/forward as well as initial page-showing after the onload event.
$(window).on('pageshow', function(event) {	

	if(!!window.performance && window.performance.navigation.type == 2) {	// Page was accessed via browser Back button 
		
		//console.log("Navigated to this page via the Back button");
		
		// RA-1022: If there are existing query suggestions on the page, force a full page reload.
		// Otherwise, query suggestions will not work properly.
	    if($("#header-search table#search_suggest").children().length > 0) {
			//console.log("Existing query suggestions detected on the page. Need to reload so that the query suggest will function properly");
	    	window.location.reload();			
		}
	}
});

function toggleHeaderElements(event) {

	// Mobile only?
	if(event.type=="focus"&&$(event.currentTarget).hasClass("navbar-toggle")){		
		if(  $("#header-main-row2.collapse").hasClass('in')){	
			  $("#header-main-row2.collapse").removeClass('in');
		}else{
			  $("#header-main-row2.collapse").addClass('in').attr('style','')	
		}
	}
	
	// Non-mobile?
	else {	
		// Toggle the main menu
		$("#govNavMenu").each(function(){
			if($(this).is(":visible")){	
				$(this).addClass("hidden").removeAttr("style");
				$(this).removeClass("expanded");
	
			}else{					
				$(this).addClass("expanded");
				$(this).removeClass("hidden");
	
			};
		});			
	}
}

var animate = 1;

function toggleFooter(event) {

	var ua = window.navigator.userAgent;
    var msie = ua.indexOf("MSIE ");
    if(msie < 0){
    	//check for IE 11
    	msie = ieVersion();
    }
	
	$("#footerCollapsible").css("height", $("#footerCollapsible").height());

	if (msie > 0) {
		$("#footerCollapsible").slideToggle(0, function() {			
			// expand
			if($(this).is(":visible")) {
				$("#footer").addClass("expanded");
				$("#footerToggle a.footerExpand").hide();
				$("#footerToggle a.footerCollapse").show();
			} 
			// collapse
			else {
				$("#footer").removeClass("expanded");				
				$("#footerToggle a.footerExpand").show();
				$("#footerToggle a.footerCollapse").hide();
			}
			
			$('html, body').animate({
				scrollTop: $(document).height()
			}, 'slow');
		});
	}
	else{
		$("#footerCollapsible").slideToggle('slow', function() {			
			// expand
			if($(this).is(":visible")) {
				$("#footer").addClass("expanded");								
				$("#footerToggle a.footerExpand").hide();
				$("#footerToggle a.footerCollapse").show();
				animate = 0;								
			} 
			// collapse
			else {
				$("#footer").removeClass("expanded");				
				$("#footerToggle a.footerExpand").show();
				$("#footerToggle a.footerCollapse").hide();
				animate = 1;				
			}
		});
		
		if (animate == 1){
			$('html, body').animate({
				scrollTop: $(document).height()
			}, 'slow');		
			var temp = animate;		//get animate var
		}
	}
}

/**
 * If the burger menu overflows beyond the window height, make it scrollable so that all nav links can be accessed.
 */
function addScrollableBurgerMenu() {
	
	var $menu = $("#govNavMenu");	
	
	// Reset the burger menu styles to normal
	$menu.css("height", "auto");
	$menu.css("width", "");		
	$menu.css("overflow-y", "initial");
	$menu.removeClass("scrollable");	
	
	// Position of the burger menu from the top of the page (px)
	var menuTopOffset = $("#header-main > .container").height();
	
	// If the QA banner is on the page, need to add its height to menuTopOffset
	if($(".qa-banner").length) {
		menuTopOffset = menuTopOffset + $(".qa-banner").height();
	}

	// If there is a notification at the top of the page, need to add its height to menuTopOffset
	if($("#notificationMessageBar").length && $("#notificationMessageBar").is("visible")) {
		menuTopOffset = menuTopOffset + $("#notificationMessageBar").height();
	}
		
	//var overflow = $menu.offset().top + $menu.height() - $(window).height();		
	var overflow = menuTopOffset + $menu.height() - $(window).height();			
	//console.log("overflow:" + overflow);
	
	// If overflow is positive, burger menu is too long for the current window height, and some of the links may not be visible to the user
	// To fix this, set the burger menu height so that it goes to the bottom of the window, add a vertical scrollbar, and adjust other values as necessary	
	if($(window).width() >= 750 && overflow > 0) {	
		var newMenuHeight = $menu.height() - overflow;
		$menu.height(newMenuHeight);
		$menu.css("overflow-y", "scroll");
		$menu.addClass("scrollable");
	}  
}

function hideNotificationMessageBar() { 
	$('#notificationMessageBar').hide();
	$('.alert-notification-icon').show();
		
	// Bug: When the notification bar is closed, padding is not recalculated without resizing window or scrolling.
	// Adjust the padding immediately when bar is hidden.
	adjustContentPadding();

	// create cookie if it doesn't exist
	document.cookie = 'hideNotificationMessageBar=true;path=/';
}

function showNotificationMessageBar() { 
	$('#notificationMessageBar').show();
	$('.alert-notification-icon').hide();

	// Bug: When the notification bar is closed, padding is not recalculated without resizing window or scrolling.
	// Adjust the padding immediately when bar is hidden.
	adjustContentPadding();	
	
	// reset cookie
	document.cookie = 'hideNotificationMessageBar=null;path=/';
} 

/**
 * Collapse the main header search and do some cleanup.
 */
function collapseHeaderSearch() {
	// Collapse the div
	$("#header-search").collapse("hide");
	// Clear out the input
	$("input#global-search").val("");
	// Clear out the query suggestions
	$("#header-search table#search_suggest").children().remove();
}
