//计算内容体高度
$(document).ready(
	function(){
		var wind_hei = $(window).height(); //浏览器当前窗口可视区域高度
	    console.log(wind_hei);
	    hei_content = wind_hei-98;
	    hei_content = hei_content<100?100:hei_content;
	    $("#content_template").css("height",""+hei_content);
	    //$("#content_template").css("border","2px solid red");
	    
	    $(window).resize(function(){ 
	    	wind_hei = $(window).height(); //浏览器当前窗口可视区域高度
		    //console.log(wind_hei);
		    hei_content = wind_hei-98;
		    hei_content = hei_content<100?100:hei_content;
		    $("#content_template").css("height",""+hei_content);
	    });
	    
    	if(isMobile.any()){
			$("#flagimg").remove();
			$(".tableList").attr("style","width:100%");
			$("#multiSelect").attr("style","display: inline-block;position: relative;top: 40px;margin-left: 5px;");         
			$("#multiSelect1").attr("style","display: inline-block;position: relative;top: 40px;margin-left: 5px;"); 
			$("#multiSelect2").attr("style","display: inline-block;position: relative;top: 40px;margin-left: 5px;");
			$("#move").attr("style","display: inline-block;position: relative;top: 40px;margin-left: 5px;");         
	    }
	}
);

var isMobile = {
	Android : function() {
		return navigator.userAgent.match(/Android/i) ? true : false;
	},
	BlackBerry : function() {
		return navigator.userAgent.match(/BlackBerry/i) ? true : false;
	},
	iOS : function() {
		return navigator.userAgent.match(/iPhone|iPad|iPod/i) ? true : false;
	},
	Windows : function() {
		return navigator.userAgent.match(/IEMobile/i) ? true : false;
	},
	any : function() {
		return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile
				.Windows());
	}
}