$(document).ready(function(){
	$("flickr").each(function(index){
		var flickrObject = $(this);
		var flickrSrc = flickrObject.attr("data-src");
		var lastIndex = flickrSrc.lastIndexOf("/");
		var flikrSrcLength = flickrSrc.length;
		
		if (lastIndex == flikrSrcLength-1){
			//if trailing /
			flickrSrc = flickrSrc.substring(0, lastIndex);
			lastIndex = flickrSrc.lastIndexOf("/");
			//if the last word is player
			if(flickrSrc.split("/").pop() == "player")
				flickrSrc = flickrSrc.substring(0, lastIndex);
		} else{
			//if the last word is player
			if(flickrSrc.split("/").pop() == "player")
				flickrSrc = flickrSrc.substring(0, lastIndex);
		}
		flickrObject.append("<a href='"+flickrSrc+"' class='flickr_link'>"+flickrObject.attr("data-desc")+"</a>");
		
	});//end flickr each
});	//end document ready