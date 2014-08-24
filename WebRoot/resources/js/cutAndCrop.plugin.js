(function( $ ){
    $.fn.cutThisArea = function() {
    	var target = $(this).attr('cmd');
		$('#'+target).html2canvas({},function(imgData,w,h){
			capture_w = w;
		    capture_h = h;
			$("#imgLocation").attr('src',imgData).ready(function(){
				$("#imgLocation").attr('src',imgData);
				showDialog(imgData);
    		});		
		});
    };
    $.fn.cutThisArea = function(id) {
    	if(id==undefined||id==null){
    		id = $(this).attr("id");
    	}
    	var target = id;
		$('#'+target).html2canvas({},function(imgData,w,h){
			capture_w = w;
		    capture_h = h;
			$("#imgLocation").attr('src',imgData).ready(function(){
				$("#imgLocation").attr('src',imgData);
				showDialog(imgData);
    		});		
		});
    };
    $.fn.cutThisArea_svg = function() {
    	$("div > svg").each(function(){
			if($(this).attr("id")==null || $(this).attr("id")== undefined){
				$(this).attr("id",(new Date()).getTime().toString());
			}
			$(this).attr("class","block_none");
			var width = parseInt($(this).attr("width"));
			var height = parseInt($(this).attr("height"));
			var svg = $(this).parent().html().trim();
			var id = $(this).parent().attr("id");
			var su_this = this;
			if($("#"+id+">"+"canvas").length!=0){
				$("#"+id+">"+"canvas").remove();
			}
			var c = document.createElement('canvas');
			c.width = width || 500;
			c.height = height || 500;
			document.getElementById(id).appendChild(c);
			$("#"+id+">"+"canvas").attr("class","block_none");
			canvg(c, svg);
			$(su_this).css("display","none");
		});
    	
    	var target = $(this).attr('cmd');
		$('#'+target).html2canvas({},function(imgData,w,h){
			capture_w = w;
		    capture_h = h;
			$("#imgLocation").attr('src',imgData).ready(function(){
				$("#imgLocation").attr('src',imgData);
				$("div > svg").each(function(){
					if($(this).attr("class")=="block_none"){
						$(this).css("display","block");
					}
				});
				$("div > canvas").each(function(){
					if($(this).attr("class")=="block_none"){
						$(this).css("display","none");
					}
				});
				showDialog(imgData);
    		});		
		});
    };
    $.fn.cutThisArea_svg = function(id) {
    	$("div > svg").each(function(){
			if($(this).attr("id")==null || $(this).attr("id")== undefined){
				$(this).attr("id",(new Date()).getTime().toString());
			}
			$(this).attr("class","block_none");
			var width = parseInt($(this).attr("width"));
			var height = parseInt($(this).attr("height"));
			var svg = $(this).parent().html().trim();
			var id = $(this).parent().attr("id");
			var su_this = this;
			if($("#"+id+">"+"canvas").length!=0){
				$("#"+id+">"+"canvas").remove();
			}
			var c = document.createElement('canvas');
			c.width = width || 500;
			c.height = height || 500;
			document.getElementById(id).appendChild(c);
			$("#"+id+">"+"canvas").attr("class","block_none");
			canvg(c, svg);
			$(su_this).css("display","none");
		});
    	
    	var target = id;
		$('#'+target).html2canvas({},function(imgData,w,h){
			capture_w = w;
		    capture_h = h;
			$("#imgLocation").attr('src',imgData).ready(function(){
				$("#imgLocation").attr('src',imgData);
				$("div > svg").each(function(){
					if($(this).attr("class")=="block_none"){
						$(this).css("display","block");
					}
				});
				$("div > canvas").each(function(){
					if($(this).attr("class")=="block_none"){
						$(this).css("display","none");
					}
				});
				showDialog(imgData);
    		});		
		});
    };
})( jQuery );