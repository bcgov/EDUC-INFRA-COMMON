/*******************************************************************************
 * 
 * Handle Displaying Did you find? Box
 * 
 ******************************************************************************/

// Initialize and display the feedback box
$(document).on("ready", function(e) {

	var hasDidYouFindFlag = $("input#hasDidYouFindFlag").val();
	if (!e.handled) {
		e.handled = true;

		// Set the visbility of the highlight keyword and feedback divs
		setHighlightPaginationControlVisibility(hasDidYouFindFlag);
		// Turn on the click handler for closing the floating bar
		// Show the highlight bar
		showFeedbackBar();

	}
});

function setHighlightPaginationControlVisibility(hasDidYouFindFlag) {
	if (hasDidYouFindFlag == 'true') {
		$(".highlightFeedbackForm").show();
		$(".highlightFeedbackResponseFoundForm").hide();
	} else {
		closeHighlightBar(true);
	}
}

function showFeedbackBar() {
	$("div#highlightKeywordFloatingBar").show();
}

/*******************************************************************************
 * 
 * Handle Feedbax Post
 * 
 ******************************************************************************/

// Yes/No Click
$(document).on("click", "input.btn-feedback", function(e) {
	e.preventDefault();
	e.stopPropagation();
	if (!e.handled) {
		e.handled = true;
		
		// If 'Yes' button clicked, submit feedback
		if($(this).hasClass("btn-yes")){
			var fbkeyword = getRequestParameter("keyword");
			var fbrequest = location.href;
			var fbval = "Yes";
			postFeedback(fbrequest, fbkeyword, fbval);
			
			// Display thank you message
			displayThankYouMessage();
		}
		// If 'No' button clicked, display radio buttons to allow user to select a reason
		else {
                        var fbkeyword = getRequestParameter("keyword");
                        var fbrequest = location.href;
                        var fbval = "No";
                        postFeedback(fbrequest, fbkeyword, fbval);

			displayFeedbackReasons();
		}
	}
});

function displayFeedbackReasons() {
	
	// Populate array with the strings to be displayed as radio button options
	var reasons = [];
	reasons.push('This information is unclear');
	reasons.push('This page is missing the information I need');
	reasons.push('This page is not related to what I searched for');
	reasons.push('Other');
	
	// Randomize radio button options by shuffling the array
	//shuffleArray(reasons);
	
	var reasonsRadioButtonHtml = '';
	
	// Build the HTML for the set of radio buttons
	for(var i=0; i<reasons.length; i++) {
		reasonsRadioButtonHtml += '<div class="radio">' +
		'<label><input type="radio" name="reasons" value="' + reasons[i] + '">' + reasons[i] + '</label>' +
		'</div>';
	}	
	
	// Add the radio buttons to the feedback div
	$("#highlightKeywordFloatingBar")
		.html('<div class="feedback-reasons">' + 
				'<p>Please select reason:</p>' +
				reasonsRadioButtonHtml +
				'<input type="button" class="form-control btn btn-primary btn-no-reason" value="Submit" onclick="postFeedbackWithReason();">' +
		'</div>');
}


/**
 * Randomize array element order in-place.
 * Using Durstenfeld shuffle algorithm.
 */
function shuffleArray(array) {
    for (var i = array.length - 1; i > 0; i--) {
        var j = Math.floor(Math.random() * (i + 1));
        var temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
}

function postFeedbackWithReason() {
	
	// Get the currently selected reason radio button
	var fbreason = $("input[name='reasons']:checked").val();
	
	// If no reason radio button selected, display alert
	if(!fbreason) {
		alert('Please select a reason.')
	} 
	// Otherwise, POST feedback
	else {		
		var fbkeyword = getRequestParameter("keyword");
		var fbrequest = location.href;
		var fbval = 'Reason';
		postFeedback(fbrequest, fbkeyword, fbval, fbreason);
		
		// Display thank you message
		displayThankYouMessage();
	}
}

function displayThankYouMessage() {
	
	// Display thank you message
	var thankYouMessage = 'Thank you for your response.';	
	$("#highlightKeywordFloatingBar")
		.html('<p style="font-weight:bold;padding:10px;margin:10px;">' + thankYouMessage + '</p>')
		.delay(5000)
		.slideUp("slow");	
}

// Contact Us Click
$(document).on("submit", "form#feedback-form", function(e) {
	if ( !e.handled) {
		e.handled = true;
		
		// Gather feedback
		var fbkeyword = getRequestParameter("keyword");
		var fbrequest = location.href;
		var fbval = "Improve-FeedBack-Submitted";
	
		// Send the feedback
		postFeedback(fbrequest, fbkeyword, fbval);
	}
});

// Close button Click
$(document).on("click", "a#close-feedback-box", function(e){
	e.preventDefault();
	closeHighlightBar();
});

function getRequestParameter(name) {
	var decodedRequest = decodeURIComponent(location.search);
	var params = new Array();
	var regexp = new RegExp('[?&]' + encodeURIComponent(name) + '=([^&]*)', 'g');
	var m;
	while (m = regexp.exec(decodedRequest)) {
		params.push(decodeURIComponent(m[1]).split("+").join(" "));
	}
	return params;
}

function postFeedback(fbpage, fbkeyword, fbval, fbreason) {
	var url = "/gov/didyoufind";
	var params = "page=" + encodeURIComponent(fbpage) + "&keyword="
			+ encodeURIComponent(fbkeyword) + "&userinput="
			+ encodeURIComponent(fbval);
	
	if(fbreason) {
		params += "&reason=" + fbreason;
	}
	
	console.log(params);
	
	$.post(url, params, function(data, status) {
	}, "text");
}

$(document).on("keyup", function(e) {
	if (e.keyCode == 27) {
		closeHighlightBar();
	}
});

function closeHighlightBar(closeAll) {

	// Optional input parameter which can be used to force the entire bar to be
	// hidden
	if (true == closeAll) {
		hideHighlightBar();
		return;
	}

	// If the next/previous buttons are visible then hide them
	// Otherwise, hide the entire floating bar
	if ($("div#highlightPaginationControls").is(":visible")) {
		// Hide/show the appropriate divs
		$("div#highlightPaginationControls").hide();

		var hasDidYouFindFlag = $("input#hasDidYouFindFlag").val();
		if ((hasDidYouFindFlag == 'true')
				&& (readCookie("doNotShowDidYouFind") != "true")) {
			$(".highlightFeedbackForm").show();
			// Might need to reset the widget button locations because the
			// highlight bar height might
			// change depending on the size of the messages displayed.

		} else {
			hideHighlightBar();
		}
	} else {
		hideHighlightBar();
	}
}

function hideHighlightBar() {
	// Hide the floating bar
	$("div#highlightKeywordFloatingBar").hide();
	$(".template").css("padding-bottom","80px");
}
