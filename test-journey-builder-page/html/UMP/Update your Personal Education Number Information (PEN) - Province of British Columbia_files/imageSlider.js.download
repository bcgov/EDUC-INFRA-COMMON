
$(document).ready(function() {

	var fadeTime = 1000;
	var displayTime = 5000;
	if($('#carousel').attr('data-speed') != ''){
		displayTime = $('#carousel').attr('data-speed')*1000;
	}
	var randomStart = $('#carousel').attr('data-start');
	var currentIndex = 0;
	var slide_count = 0;
	var timer = null;
	var allowFade = true;
	var pages = $('#carousel .page');
	var iterations = $('#carousel').attr('data-iterations') * pages.size();
	
	// RA-1266: If only one carousel item, do not display fade animation and hide the forward/back carousel control arrows
	if(pages.size() <= 1 ) {
		allowFade = false;
		$("#carousel .controls").css("visibility", "hidden");
	}	

	// [RA-392] CS - click event on each carousel item caption box. Clicking the div will open the link
	$("#carousel .imageSliderDiv").click(function() {
		var carouselItemLink = $(this).find("a.pull-left");
		if(carouselItemLink.length > 0) {
			window.open(carouselItemLink.attr("href"), carouselItemLink.attr("target"));
			return false;
		}
	});
	
	function timedFade() {
		if(iterations != '' && iterations != null && iterations != 0) {
			if (slide_count < iterations){
				if (timer) {
					window.clearTimeout(timer);
				}
				timer = setTimeout(fade, fadeTime + displayTime);
				slide_count ++;
			}
		}
		else{
			if (timer) {
				window.clearTimeout(timer);
			}
			timer = setTimeout(fade, fadeTime + displayTime);
		}
	}

	function fade(targetIndex) {
		if (allowFade == false)
			return;
		var currentPage = pages.eq(currentIndex);

		var nextIndex = 0;
		if (targetIndex === undefined) {
			nextIndex = (currentIndex + 1) % pages.length;
		} else {
			nextIndex = targetIndex % pages.length;
		}

		var nextPage = pages.eq(nextIndex);
		currentIndex = nextIndex;

		currentPage.stop(true, true).fadeOut(fadeTime, function() {
		});
		nextPage.stop(true, true).fadeIn(fadeTime, function() {
		});
		timedFade();
	}

	function forward() {
		allowFade = true;
		fade(currentIndex + 1);
		allowFade = false;
	}

	function back() {
		allowFade = true;
		fade(currentIndex - 1);
		allowFade = false;
	}

	$.fn.random = function() {
		var randomIndex = Math.floor(Math.random() * this.length);
		currentIndex = randomIndex
		return this.eq(randomIndex);
	}

	$(function() {
		$('.back').click(back);
		$('.forward').click(forward);
		if(randomStart === 'NO'){
			pages.first().fadeIn(0);
		}else{
			pages.random().fadeIn(0);
		}
		timedFade();
	});
	 //navigate carousel with keyboard 
    $(document).keydown(function(e) {
    	if($("#carousel").is(":focus")){
    	    switch(e.which) {
    	        case 37: // left - prev carousel item
    	        	back();
    	        break;
    	
    	        case 39: // right - next carousel item
    	        	forward();
    	        break;
    	
    	        default: return; // exit this handler for other keys
    	    }
    	    e.preventDefault(); // prevent the default action (scroll / move caret)
    	}
	});
});