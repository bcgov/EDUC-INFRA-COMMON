$(document).ready(function(event) {
	
	//Fix z-index youtube video embedding
	$(document).ready(function (){
	    $('iframe').each(function(){
	        var url = $(this).attr("src");
	        // CLD-1500: Disable related videos at the end of YouTube clips
	        if(url.indexOf("youtube") > -1) {
	        	if (url.indexOf("?") > -1) {
	        		// append if not already in URL
	        		if (url.indexOf("wmode=transparent") == -1)
	        			url = url + "&wmode=transparent";
	        		if (url.indexOf("rel=0") == -1)
	        			url = url + "&rel=0";
	        		
        			$(this).attr("src", url);
	        		
	        	} else {
	        		$(this).attr("src", url + "?wmode=transparent&rel=0");
	        	}
	    	}	
	    });
	});
	
	// [RA-602] CS - trim the text inside anchor tags that contain only whitespace, to prevent an underline from displaying
	$('#main-content a:not([href]), #main-content a:not([href]) > span').each(function() {
		if(jQuery.trim($(this).text()).length == 0) { 
			$(this).text("");
		}
	});	

	// RA-600: Design options to resolve theme search icon display in tablet view
	if ($(window).width() >= 768 && isTouchDevice()) {
		$('.homepage-tile .tile-search').addClass('touchable');
	}
	
	// RA-682 - Cleanup code for accordion widget - hide the empty p tags that CKEditor automatically adds to the end of accordion containers
	$('.accordion-container > p').each(function() {                
		if($(this).html() == '&nbsp;' && $(this).is(':last-child')) {
			$(this).hide();
		}
	});	
	
	// RA-965: Page Subscriptions
    // When a user submits their email address in the 'Subscribe' right column component, create a new NotifyBC subscription via AJAX POST request
    $("a.subscribe-email-button").click(function() {
        createNotifyBCSubscription($(this).closest(".rightColumnBox.subscribe"));
    });
    
    // RA-1190: Workaround for two/three column grid layout rendering issues in mobile view. The issues only occur in certain situations.
    $('div[class*="two-col"]>div[class*="col-"], div[class*="three-col"]>div[class*="col-"]').each(function() {
   	 if(!$(this).hasClass('col-xs-12')) {
   		 $(this).addClass('col-xs-12') ;
   	 }
    });
	
});

/*
 * Utility function used to detect if the user device's touchable device.
 * Any touchable devices that support mouse are not considered as touch device by this function.
 */
function isTouchDevice() {
	return true == ("ontouchstart" in window || window.DocumentTouch && document instanceof DocumentTouch
			|| (navigator.maxTouchPoints > 0) || (navigator.msMaxTouchPoints > 0));
}

/**
 * readCookie
 * 
 * @param cookieName
 * @returns cookieValue
 */
function readCookie(name) {
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for (var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
}

// RA-965: Page Subscriptions
// When a user submits their email address in the 'Subscribe' right column component, create a new NotifyBC subscription via AJAX POST request
function createNotifyBCSubscription(subscribeRightColumnBox) {

	var subscribeEmail = subscribeRightColumnBox.find(".subscribe-email-input").val();	
	
	// Validate the provided email address
	if(!validateEmail(subscribeEmail)) {
		alert("Please provide a valid email address.");
		return false;
	}

	// Add spinning loader icon to button until the AJAX call completes
	subscribeRightColumnBox.html("<i class='fa fa-spinner fa-spin'></i>");

	var pageId = $('meta[name="current_page_id"]').attr("content");
	
	// Send AJAX POST to GOV controller	to subscribe the provided email address to the current page
	$.ajax({
		url: "/subscribe?pageId=" + pageId + "&emailAddress=" + subscribeEmail,
		method: "POST",	
		success: function(response) {
			subscribeRightColumnBox.fadeOut(function() {
				subscribeRightColumnBox.html("<p class='subscribe-result'>" +
						"To complete the subscription process, please check the provided email address for a confirmation email and click the enclosed link." +
						" <strong>If you do not see the confirmation email, check if it has gone to your spam folder.</strong>" +
						"</p>");
			}).fadeIn();
		},
		error:function(){
			subscribeRightColumnBox.fadeOut(function() {
				subscribeRightColumnBox.html("<p class='subscribe-result'>" +
						"There was a problem creating the subscription. Please try again later." +
						"</p>");
			}).fadeIn();                      
		}
	})
}

// Utility method to validate user-entered email addresses
function validateEmail(email) {
	var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	return re.test(email);
}