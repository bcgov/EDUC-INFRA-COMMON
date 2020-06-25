$(document).ready(function(event) {     	
	passthroughQueryStringParams();
});	

// RA-1161: Look for specified parameters in the query string. 
// If they are present, append additional query string params to all links on the current page.
function passthroughQueryStringParams() {
	
	// Map containing "utm" query parameter names, along with the corresponding "bcgov" parameter
	var queryParamMap = new Map();
	queryParamMap.set("utm_campaign", "bcgovtm");
	// add additional utm/bcgov parameter combinations to the map if needed
	
	var passthroughValuesString = '';
	
	// Check the current page query string for each utm/bcgov parameter combination in the map 
	queryParamMap.forEach(function(value, key) {
		
		var utmParamValue = getUrlParameter(key);
		var bcgovParamValue = getUrlParameter(value);
		
		// If a matching utm parameter is found, get the corresponding bcgov param and append it to passthroughValuesString
		// If both matching utm and bcgov params are found, utm takes precedence
		if(utmParamValue) {
			passthroughValuesString = passthroughValuesString + '&' + value + '=' + utmParamValue;
		}
		// If a matching bcgov parameter is found instead, append it to passthroughValuesString
		else if(!utmParamValue && bcgovParamValue) {
			passthroughValuesString = passthroughValuesString + '&' + value + '=' + bcgovParamValue;				
		}		
	})
	
	// Remove leading ampersand from passthroughValuesString
	if(passthroughValuesString.startsWith('&')) {
		passthroughValuesString = passthroughValuesString.substring(1);
	}
	
	// If any passthrough values were found, append them to all links on the page
	if(passthroughValuesString !== '') {
		$('body a').each(function() {	
			var linkHref = $(this).attr('href');
			if(linkHref) {
				// Ignore href values with certain protocol prefixes
				if(linkHref.startsWith('mailto:') || linkHref.startsWith('tel:') || linkHref.startsWith('sms:') || 
						linkHref.startsWith('ftp:') || linkHref.startsWith('news:') || linkHref.startsWith('file:')) {
					return;
				}
				// Process all other href values
				else {				
					$(this).attr('href', appendPassthroughValuesToHref(linkHref, passthroughValuesString));
				}
			}							
		});
	}	
}

// Retrieve the value of a query string parameter by name
function getUrlParameter(name) {
   name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
   var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
   var results = regex.exec(location.search);
   return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
}

// Append the passthrough values to an existing href value
function appendPassthroughValuesToHref(href, passthroughValuesString) {	
	
	var updatedHrefValue = "";
	var hashValue = "";	
	
	// If currently processed href is an anchor link to a location on current page, stop processing it
	if(href.charAt(0) == ("#")) {
		return href;
	}
	
	// If href contains a hash value, break it down into parts. Otherwise, use the href value as-is
	if(href.indexOf('#') > -1) {
		var hrefArray = href.split('#');
		updatedHrefValue = hrefArray[0];
		hashValue = "#" + hrefArray[1];		
	} else {
		updatedHrefValue = href;
	}	
	
	// Rebuild the href and include the passthrough values 
	// If the href already has query string params, append the passthrough values with ampersand
	if(href.indexOf('?') > -1) {
		return updatedHrefValue + '&' + passthroughValuesString + hashValue;
	} 
	// If no existing query string params, append passthrough values with question mark
	else {
		return updatedHrefValue + '?' + passthroughValuesString + hashValue;				
	}	
}