//Replacing this: ss_handleKey

function ss_handleKey(e){
	var keyCode = suggestionService.getKey(e);
	var queryForm = e.srcElement.parentElement;
	var qVal = queryForm.q.value;
	var table_js = suggestionService.getTable(queryForm);
	var table = $(table_js);	//because we want a jQuery object

	
	//var table = $(table_js);	//because we want a jQuery object
	
	switch (keyCode){
	//down arrow
	case 40:
		var suggestionsVisible = table[0].style.visibility == 'visible';
		suggestionsVisible ? suggestionService.highlightNext(table, queryForm) : suggestionService.doNothing();
		break;
	//right arrow
	case 39:
		
		break;
	//up arrow
	case 38:
		var suggestionsVisible = table[0].style.visibility == 'visible';
		suggestionsVisible ? suggestionService.highlightPrev(table, queryForm) : suggestionService.doNothing();
		break;
	//left arrow
	case 37:
		
		break;
	//Default case (all other keys will pull suggestion)
	default:
	    var submitSuggest = suggestionService.handleQuery(qVal, queryForm, renderSearchQueries, table);
		setTimeout(submitSuggest, 500);
		break;
	}
}


function renderSearchQueries(data, table){
	var queryReturn = JSON.parse(data);
	//reset recommendations
	table.children().remove();
	if(queryReturn != null && queryReturn.results.size > 0){
		//table.style.visibility = 'show';
		$.each(queryReturn.results, function() {
			table.append('<tr class="ss-gac-a"><td class="ss-gac-c">'+this.name+'</td></tr>');
		});
		table.append('<tr class="ss-gac-e"><td colspan="2"><span>close</span></td></tr>');
		table.css("visibility", "visible");
	}else{
		table.css("visibility", "hidden");
	}
}


/*
 * ************************************************************
 * SERVICE LAYER
 * ************************************************************
 */

(function loadSuggestionService() {
	
	// Create a library object. Functions are objects!
	suggestionService = function(){};
	
	suggestionService.init = function() {
		//console.log("suggestionService loaded");
	}; 
	
	suggestionService.getKey = function getKey(e){
		var key = (window.event) ? window.event.keyCode : e.keyCode;
		return key;
	};
	
	suggestionService.getFormInput = function getFormInput(queryForm){
		var inputVal = queryForm.q.value;
		return inputVal;
	};
	
	suggestionService.getTable = function getTable(queryForm){
		var table_js = queryForm.getElementsByTagName("table")[0];
		if(!table_js){
			//target homepage flyout
			var formId = queryForm[0].id;
			formId = formId[formId.length -1];
			formId = "tile_search_suggest_".concat(formId);
			table_js = document.getElementById(formId);
		}
		return table_js;
	};
	
	suggestionService.handleQuery = function handleQuery(qVal, queryForm, renderSearchQueries, table){
		
		if(qVal == null || qVal == ''){
			renderSearchQueries(null,table);
			table.css("visibility", "hidden");
			return;	
		}	
		
		var proxyPath = '/suggest';
		//var proxyPath = '/searchxxzxxxxxWS/suggest/querySuggest';
		var uri = suggestionService.buildGSAURI(qVal,queryForm);
		var url = proxyPath + uri;

		$.ajax({
			type: "POST",
			url: url,
			success: function(data){
				renderSearchQueries(data,table);
				table.css("visibility", "visible");
			},
   			error: function(data,status,er) {
   				console.log("Fail response from Mindbreeze");
   				table.css("visibility", "hidden");
   			}
		});
		
	};
	
	suggestionService.buildGSAURI = function buildURI(query, queryForm){
		var uri = "?q="+ encodeURIComponent(query);

		var displayMax = ss_g_max_to_display;
		
		// 'site' hidden input field may be by class or by id depending on context
		// e.g. widgets use class, search result uses id
		var site = $(queryForm).find("span.site").text();
		if ( !site ) {
		    site = $(queryForm).find('span#site').text();
		}
		if ( !site ){
			//we go to defaults as a last resort
			site = "default_collection";
		}
		
		// 'client' hidden input field may be by class or by id depending on context
		// e.g. widgets use class, search result uses id
		var client = $(queryForm).find("span.client").text();
		if ( !client ) {
			client = $(queryForm).find('span#client').text();
		}
		if ( !client ){
			//we go to defaults as a last resort
			client = "default_frontend";
		}
		
		uri = uri + "&max="+displayMax+"&site="+site+"&client="+client;
		
		return uri;
	};
	
	suggestionService.highlightNext = function highlightNext(table, queryForm){
		//length of table is reduced by 1 to omitt last 'close' line
		var selectedChild = null;
		var j = 0;

		for (var i=0; i < table[0].childNodes[0].children.length-1; i++){
			if(table[0].childNodes[0].children[i].classList.contains("ss-gac-b")){
				selectedChild = table[0].childNodes[0].children[i];
				j = i;
			}
		}
		
		if (selectedChild == null){
			selectedChild = table[0].childNodes[0].firstChild;		
			this.highlightRow(selectedChild);
			this.suggestToSearchInput(queryForm, selectedChild);
		}else {
			//if at last element, go back to top			
			if (j+1 >= table[0].childNodes[0].children.length-1){
				j=-1;
			}
			this.unHighlighRow(selectedChild);
			selectedChild = table[0].childNodes[0].children[j+1];
			this.highlightRow(selectedChild);
			this.suggestToSearchInput(queryForm, selectedChild);
		}
		return;
	};
	
	suggestionService.highlightPrev = function highlightPrev(table, queryForm){

		var selectedChild = null;
		var j = 0;
		
		for (var i=0; i < table[0].childNodes[0].children.length-1; i++){
			if(table[0].childNodes[0].children[i].classList.contains("ss-gac-b")){
				selectedChild = table[0].childNodes[0].children[i];
				j = i;
			}
		}
		
		if (selectedChild == null){
			selectedChild = table[0].childNodes[0].lastChild;		
			this.highlightRow(selectedChild);
			this.suggestToSearchInput(queryForm, selectedChild);
		}else {	
			if (j <= 0){
				j= table[0].childNodes[0].children.length-1;
			}
			this.unHighlighRow(selectedChild);
			selectedChild = table[0].childNodes[0].children[j-1];
			this.highlightRow(selectedChild);
			this.suggestToSearchInput(queryForm, selectedChild);
		}
		return;
	};
	
	suggestionService.doNothing = function doNothing(){
		//to be cleaned up
		return;
	};
	
	suggestionService.highlightRow = function highlightRow(selectedChild){
		selectedChild.classList.remove("ss-gac-a");
		selectedChild.classList.add("ss-gac-b");
	};
	
	suggestionService.unHighlighRow = function unHighlighRow(selectedChild){
		selectedChild.classList.remove("ss-gac-b");
		selectedChild.classList.add("ss-gac-a");
	};
	
	suggestionService.suggestToSearchInput = function suggestToSearchInput(queryForm, selectedChild){
		queryForm[1].value = selectedChild.childNodes[0].innerText;
	};
	
	// Attach the Service object to the window, so that it is accessible from everywhere
	window.suggestionService = suggestionService;
})();

suggestionService.init();

/*
 * ************************************************************
 * Mouse Inputs
 * ************************************************************
 */

$(document).on("mouseenter", "table.ss-gac-m > tbody > tr", function() {
	//remove existing highlights
	//this does not apply to the 'close button'
	if(!$(this).hasClass("ss-gac-e")){
		$("table.ss-gac-m > tbody > tr").removeClass("ss-gac-b");
		$("table.ss-gac-m > tbody > tr").addClass("ss-gac-a");
		//add highlight to hovered element
		$(this).removeClass("ss-gac-a");
		$(this).addClass("ss-gac-b");
	}
});

$(document).on("click", "table.ss-gac-m > tbody > tr", function() {
	//this does not apply to the 'close button'
	if(!$(this).hasClass("ss-gac-e")){
		var $form = $(this).closest("form");
		var selectedText = $(this).find("td").text();
		$form.find(".searchbox").val(selectedText);
		$form.submit();
	}
});

$(document).on("click", "table.ss-gac-m > tbody > tr.ss-gac-e > td > span", function(){
	//close 
	var table = $(this).closest("table");
	table.css("visibility", "hidden");
});