var jcrop_api;
var capture_w = "";
var capture_h = "";

var scrollTop = 0;
var scrollLeft = 0;

var urls = "http://localhost:8080/DataVisual/";

//添加需要的组件
function appendToBody(){
	$("body").prepend("<div id='we' style='display: none;'>"+
	    "<label>X1 <input type='text' size='4' id='x1' name='x1' /></label>"+
	    "<label>Y1 <input type='text' size='4' id='y1' name='y1' /></label>"+
	    "<label>X2 <input type='text' size='4' id='x2' name='x2' /></label>"+
	    "<label>Y2 <input type='text' size='4' id='y2' name='y2' /></label>"+
	    "<label>W <input type='text' size='4' id='w' name='w' /></label>"+
	    "<label>H <input type='text' size='4' id='h' name='h' /></label>"+
		"</div>");
	$("body").prepend("<div id='jcrop_body'><div id='div_body'></div></div>");
	$("body").prepend("<div id='picPre' style='display: none;'>"+
    	"<img id='imgLocation' src='' alt='正在加载中，请稍后......' style='max-width: 850px;max-height: 550px'>"+
    	"</div>");
	$("body").prepend("<div id='tools'>"+
		"<button id='chongxin' class='butlist' style='display:none'>初始化截图区域</button>"+
	    "<button id='xiaohui' style='display: none' class='butlist btn add1'>取消截图</button>"+
		"<button id='cropImage' style='display: none' class='butlist btn add1'>截图预览</button>" +
		"<button id='saveImage' style='display: inline-block' class='butlist btn add1'>保存截图</button>"+
		"</div>");
}

$(document).ready(function(){
	appendToBody();
	
	//注册滚动条事件
	$(window).scroll(function(){
		scrollTop = $(window).scrollTop();
		scrollLeft = $(window).scrollLeft();
		console.log(scrollTop+","+scrollLeft);
	});
	
	//模拟触发
	$(".screenShot").click(function(){$("#chongxin").trigger("click");});
	
    //截图按钮注册
	$('#cropImage').click(function(){
		jcrop_api.release();
		svgToCanvas();
		$('body').html2canvas({},function(imgData,w,h){
			$("body").scrollTop(scrollTop);
			$("body").scrollLeft(scrollLeft);
			
			canvasToSvg();
			//window.open(imgData);
			getImage_crop(imgData.substring(22));
		});
		var newp = [$('#x1').val(),$('#y1').val(),$('#x2').val(),$('#y2').val()];
        jcrop_api.animateTo(newp);
	});
	
	//截图按钮注册
	$('#saveImage').click(function(){
		jcrop_api.release();
		svgToCanvas();
		$('body').html2canvas({},function(imgData,w,h){
			$("body").scrollTop(scrollTop);
			$("body").scrollLeft(scrollLeft);
			
			canvasToSvg();
			//window.open(imgData);
			getImage_crop_save(imgData.substring(22));
		});
		destroyJcrop();
	});

    //初始化截图区域
	$('#chongxin').click(function(e) {
		initJcrop();
		//toolbar控制
    	toolbarControl("none","inline-block","inline-block");
	    return false;
	});
	
	//关闭截图区域，截图功能
    $('#xiaohui').click(function(e) {
    	destroyJcrop();
	    return false;
    });

	//屏幕区域捕获按钮注册
    $('.capture').click(function(){
		$(this).cutThisArea();
	});
    
});//ready结束

//初始化裁剪器
 function initJcrop(){
	var c = {"x":13,"y":7,"x2":487,"y2":107,"w":474,"h":100};
	$("#jcrop_body").css("display","block");
	$("#jcrop_body").html("<div id='div_body'  style='position:absolute;left:0;right:0;top:0;bottom:0px;background-color: rgba(255,255,255,0);'></div>");
	$('#div_body').Jcrop(
    	{
	    	//bgFade: true,
	    	bgOpacity:.9,
	    	setSelect: [c.x,c.y,c.x2,c.y2],
	    	onChange:   showCoords,
	        onSelect:   showCoords
	    },
	    function(){
		    console.log(this);
			jcrop_api = this;
		}
	);
	$(".jcrop-holder").css("background-color","transparent");
	$(".jcrop-holder").css("overflow","hidden");
	$(".jcrop-holder").find("div").first().attr("id","gensui");//目的为了获取其位置，摆放工具栏
}

//得到截图区域的数据
function getImage_crop(imgdata){
	$("body").scrollTop(scrollTop);
	$("body").scrollLeft(scrollLeft);
	$.post(urls+"imgtosCrop",
  		{
			imgData:imgdata,
			x1:parseInt($('#x1').val())+scrollLeft,
			y1:parseInt($('#y1').val())+scrollTop,
			x2:parseInt($('#x2').val())+scrollLeft,
			y2:parseInt($('#y2').val())+scrollTop,
			wei:parseInt($('#w').val()),
			hei:parseInt($('#h').val()),
			fileName:"unknown name"
  		},
	 	function(returndata, status)
		{
  		    //$("#imgLocation").attr('src',spath + "/downloadImg");
  		    $("#imgLocation").attr('src',urls+ "downloadImg");
			showDialog_crop();
		}
	);
}

//得到截图区域的数据
function getImage_crop_save(imgdata){
	$("body").scrollTop(scrollTop);
	$("body").scrollLeft(scrollLeft);
	$.post(urls+"imgtosCrop",
  		{
			imgData:imgdata,
			x1:parseInt($('#x1').val())+scrollLeft,
			y1:parseInt($('#y1').val())+scrollTop,
			x2:parseInt($('#x2').val())+scrollLeft,
			y2:parseInt($('#y2').val())+scrollTop,
			wei:parseInt($('#w').val()),
			hei:parseInt($('#h').val()),
			fileName:"unknown name"
  		},
	 	function(returndata, status)
		{
  		    //$("#imgLocation").attr('src',spath + "/downloadImg");
  		    window.open(urls+ "downloadImg");
  		    destroyJcrop();
		}
	);
}

//记录新的裁剪位置
function showCoords(c)
{
    $('#x1').val(c.x);
    $('#y1').val(c.y);
    $('#x2').val(c.x2);
    $('#y2').val(c.y2);
    $('#w').val(c.w);
    $('#h').val(c.h);
	var tools_wid = $("#tools").css("width").replace("px","");
	tools_wid = parseInt(tools_wid);
    //$("#tools").css("position","absolute");
    //$("#tools").css("z-index","999");
    $("#tools").css("top",(c.y+c.h+1)+"px");
    $("#tools").css("left",(c.x+c.w-tools_wid-8)+"px");
}

//显示截图区域图片预览弹窗
function showDialog_crop(){
	resetDialog_crop();
	var ss = easyDialog.open({
		  container : {
			    header : '图片截取预览',
			    content : $("#picPre").html(),
			    noFn : bt_no,
			    yesFn : btnFn_crop
			  },
		  fixed : false,
	});
	$("#easyDialogYesBtn").text("提交");
	$(".easyDialog_footer").css("border-top","1px solid #e5e5e5");
	$(".easyDialog_footer").css("padding-top","10px");
	$(".easyDialog_footer").append("<div id='fileGroup' style='display:inline-block'>文件名称：<input id='filename' type='text' style='width:250px' placeholder='请输入文件名...'></div>");
	resetDialog_crop();
}

//截图区域弹窗，取消按钮的点击回调事件
var bt_no = function(){
	destroyJcrop();
	return true;
};

//截图区域弹窗，确定按钮的点击回调事件
var btnFn_crop = function(){
    var filename = $("#filename").val();
	//window.open(spath + "/downloadImg?fileName="+filename, "_self");
	window.open(urls + "downloadImg?fileName="+filename, "_self");
	destroyJcrop();
	return true;
};

//关闭截图区域
function destroyJcrop(){
	jcrop_api.destroy();
    $("#jcrop_body").css("display","none");
    //toolbar控制
    $("#tools").css("top","-50px");
    $("#tools").css("left","inherit");
    $("#tools").css("right","-120px");
	toolbarControl("inline-block","none","none");
}

//重置弹出框
function resetDialog_crop(){
	var wid = $('#w').val();
    var hei = $('#h').val();
	if(parseInt(wid)>900){
		$("#imgLocation").attr("width","900px");
		$("#easyDialogWrapper").css("width","920px");
	}
	else{
		var wi = parseInt(wid)+20;
		wi = wi<500?500:wi;
		$("#easyDialogWrapper").css("width",wi+"px");
	}
	if(parseInt(hei)>400){
		$("#imgLocation").attr("height","400px");
	}
	else{
		$("#imgLocation").attr("height",hei+"px");
	}
}

//工具栏控制
function toolbarControl(chongxin,xiaohui,cropImage){
	chongxin = "none";
	$("#chongxin").css("display",chongxin);
	$("#xiaohui").css("display",xiaohui);
	$("#cropImage").css("display",cropImage);
}

/*********************************************屏幕区域抓取***********************************************************/
//显示抓取的图像
function showDialog(imgdata){
	resetDialog();
	var ss = easyDialog.open({
		  container : {
			    header : '图片截取预览',
			    content : $("#picPre").html(),
			    noFn : true,
			    yesFn : btnFn
			  },
		  fixed : false,
	});
	$("#easyDialogYesBtn").text("提交");
	$(".easyDialog_footer").css("border-top","1px solid #e5e5e5");
	$(".easyDialog_footer").css("padding-top","10px");
	$(".easyDialog_footer").append("<div id='fileGroup' style='display:inline-block'>文件名称：<input id='filename' type='text' style='width:250px' placeholder='请输入文件名...'></div>");
	resetDialog();
}

//抓取图像弹框确定的回调函数
var btnFn = function(){
    var imgData = $("#imgLocation").attr('src');
    var filename = $("#filename").val();
	getImage(imgData.substring(22),filename);
	return true;
};

//得到后台数据
function getImage(imgdata,filename){
	$.post("imgtos",
  		{
			imgData:imgdata,
			fileName:filename
  		},
	 	function(returndata, status)
		{
  			//window.open(spath + "/downloadImg", "_self");
  			window.open(urls + "downloadImg", "_self");
		}
	);
}

//重置弹出框
function resetDialog(){
	var wid = capture_w+"";
    var hei = capture_h+"";
	if(parseInt(wid)>900){
		$("#imgLocation").attr("width","900px");
		$("#easyDialogWrapper").css("width","920px");
	}
	else{
		$("#imgLocation").attr("width",wid+"px");
		var wi = parseInt(wid)+20;
		wi = wi<500?500:wi;
		$("#easyDialogWrapper").css("width",wi+"px");
	}
	if(parseInt(hei)>400){
		$("#imgLocation").attr("height","400px");
	}
	else{
		$("#imgLocation").attr("height",hei+"px");
	}
}


/*********************************************svg to canvas**********************************************/
//遍历改变内容
function svgToCanvas(){
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
		render(svg, width, height,id,function(){
			$(su_this).css("display","none");
		});
	});
}

function canvasToSvg(){
	$("div > svg").each(function(){
		if($(this).attr("class")=="block_none"){
			$(this).css("display","block");
		}
	});
	$("div > canvas").each(function(){
		if($(this).attr("class")=="block_none"){
			$(this).remove();
		}
	});
}

//渲染
function render(svg, width, height,id,callback) {
	if($("#"+id+">"+"canvas").length!=0){
		$("#"+id+">"+"canvas").remove();
	}
	var c = document.createElement('canvas');
	c.width = width || 500;
	c.height = height || 500;
	$("#"+id).append(c);
	$("#"+id+">"+"canvas").attr("class","block_none");
	canvg(c, svg);
	callback();
}

