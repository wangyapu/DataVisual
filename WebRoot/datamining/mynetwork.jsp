<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">

<head>
<base href="<%=basePath%>">
	<title>DataGeek数据挖掘平台</title>

	<link rel="stylesheet" type="text/css" href="<%=path%>/resources/core.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/header.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/forms.css">

	
	<link href="<%=path%>/resources/loadmask/jquery.loadmask.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="<%=path%>/resources/loadmask/jquery.loadmask.min.js"></script>
	
	<link rel="stylesheet" href="<%=path%>/resources/js/easydialog/easydialog.css" type="text/css" />
	
	<script type="text/javascript" src="<%=path%>/resources/swfupload/swfupload.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/jquery-1.8.0.js"></script>
	
	
	<script type="text/javascript" src="<%=path%>/resources/common/core.js"></script> 
	
	<script type="text/javascript" src="<%=path%>/resources/js/easydialog/easydialog.min.js"></script>
	
	<script src="<%=path%>/resources/js/jsCodeFormat/codemirror.js"></script>
    <script src="<%=path%>/resources/js/jsCodeFormat/javascript.js"></script>
    <link href="<%=path%>/resources/js/jsCodeFormat/codemirror.css" rel="stylesheet">
    <link href="<%=path%>/resources/js/jsCodeFormat/monokai.css" rel="stylesheet">
	
	<style>   
<%--		.content{--%>
<%--			background: url(<%=path%>/resources/images/mynetwork.jpg);     --%>
<%--			-moz-background-size:cover; /* 老版本的 Firefox */--%>
<%--			background-size:cover;--%>
<%--			background-repeat:no-repeat;    --%>
<%--			background-origin:content-box;--%>
<%--		}--%>
<%--		#main{--%>
<%--			width:1000px;     --%>
<%--			height:500px;                   --%>
<%--			margin:0 auto;--%>
<%--			background:rgba(255, 255, 255, 0.3);   --%>
<%--			background: -webkit-gradient(linear, left top, left bottom, from(rgba(255, 255, 255, 0.5)), to(rgba(255, 255, 255, 0)));--%>
<%--			background: -moz-linear-gradient(top, rgba(255, 255, 255, 0.5), rgba(255, 255, 255, 0));--%>
<%--			background: -o-linear-gradient(top, rgba(255, 255, 255, 0.5), rgba(255, 255, 255, 0));     --%>
<%--		}         --%>

		.content{
			background: url(<%=path%>/resources/images/mynetwork.jpg);     
			-moz-background-size:cover; /* 老版本的 Firefox */
			background-size:contain;            
			background-repeat:no-repeat;    
			background-origin:content-box; 
		}
		#main{       
			position:absolute;
			left:0;
			top:0;
			right:0;
			bottom:0;
			/*width:100%;             
			height:97%;     */                   
			margin:0 auto;
		}         
		
		.easyDialog_wrapper .easyDialog_title {
			height: 30px;
			line-height: 30px;       
			overflow: hidden;
			color: #666;
			padding: 0 10px;
			font-size: 14px;
			border-bottom: 1px solid #e5e5e5;
			background: #f7f7f7;
			border-radius: 4px 4px 0 0;
			margin: 0px;
		}
		
		.node {
		  fill: #000;
		  cursor: crosshair;
		}
		
		.node_selected {
		  fill: #ff7f0e;
		  stroke: #ff7f0e;
		}
		
		.drag_line {
		  stroke: #999;
		  stroke-width: 2;
		  /**stroke-width: 5;**/
		  pointer-events: none;
		}
		
		.drag_line_hidden {
		  stroke: #999;
		  stroke-width: 0;
		  pointer-events: none;
		}
		
		.drag_line{
		  stroke: #999;
		  pointer-events: none;
		}
		
		.link {
		  stroke: #999;
		  /**stroke-width: 5;**/
		  cursor: crosshair;
		}
		
		.link_selected {
		  stroke: #ff7f0e;
		}
		
		.line{
			background: -webkit-linear-gradient(left,rgba(255,255,255,0),#4F4698,rgba(255,255,255,0));
			position: relative;
			top: 35px;   
			height: 2px;         
		}
		
		.tool_code{
			/*border:1px solid #b0b0b0;*/
			position: relative;
			text-align: right;
			vertical-align: middle;
			padding-right: 100px;
		}
		
		.tool_code button{
			text-align: right;
		}
		
		.CodeMirror {
			/*border: 1px solid #b0b0b0;*/
			position:absolute;
			/*height: 470px;*/
			top:45px;
			left:0px;
			right:0px;
			bottom:0px;
		}
		
		#code_chart_view{
			position: absolute;
			top:0px;
			right:50px;
			left: 0px;
			bottom:0px;
			/*width: 1000px;
			height:500px;*/
			/*border:1px solid #b0b0b0;*/
			background: url(<%=path%>/resources/images/mynetwork.jpg);     
			-moz-background-size:cover; /* 老版本的 Firefox */
			background-size:cover;            
			background-repeat:no-repeat;    
			background-origin:content-box; 
		}
		
		#codeView{
			position: absolute;
			/*border:1px solid #b0b0b0;*/
			left:0;
			top:0;
			width: 100%;
			height:100%;
			/*z-index: -1;
			
			background: #fff;*/
			display: none;
		}
		
		#chartView{
			position: absolute;
			/*border:1px solid #b0b0b0;*/
			left:0;
			top:0;
			width: 100%;
			height:100%;
			/*background: #fff;*/
		}
		
		.easyDialog_wrapper {
			width: 400px;
		}
		
		.easyDialog_wrapper .easyDialog_text {
			padding: 25px 10px 10px;
		}
		
		object{
			position: absolute;
			top: 3px;
		}
		
		.poplist{
			position: relative;
		}
		
		#documentMonitor{
			position: absolute;
			width: 125px;
			/*height:540px;*/
			top:5px;
			right:0px;
			bottom:0px;
			border-left:1px solid #b0b0b0;
			border-right:1px solid #3399ff;
			background: rgba(255, 255, 255, 0.61);
			/*overflow-y: scroll;*/
		}
		
		.info_window{
			position:relative;
			height: 50%;
		}
		
		.info_title{
			background: rgba(51, 153, 255, 0.72);
			color: #fff;
			font-family: '微软雅黑';
			text-align: center;
			font-size: 16px;
			padding: 5px;
		}
		
		.info_content{
			position: absolute;
			top: 30px;
			left:0px;
			right:0px;
			bottom:0px;
			background: rgba(51, 153, 255, 0.2);/*rgba(177, 177, 177, 0.72);*/
			overflow-x:hidden;
			overflow-y: auto;
		}
		
		.monitor_info{
			word-break: break-all; 
			word-wrap:break-word;
			border-bottom:1px dotted #fff;
			padding-left: 2em;
			color: crimson;
		}
		
		div.monitor_info:first-letter {
		    margin-left: -2em;
		}
		
		#tools {
			width: 218px;
		}
		
	</style>    
	
	
	<link rel="stylesheet" href="<%=path%>/resources/css/table_css_new.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/table.css" type="text/css"></link>
	<link rel="stylesheet" href="<%=path%>/resources/css/tab.css" type="text/css"></link>
  <body>   
	<jsp:include page="../common/header.jsp" flush="true"/>
	<jsp:include page="../common/leftmenu.jsp" flush="true"/>
	<jsp:include page="../common/bottom.jsp" flush="true"/>  
	<div id="content_template" class="content">
		
		<div id="main">
			<div id='pop_image_up' style="display:none">
				<div class="poplist">
					<div id="spanButtonPlaceholder" style='position: relative;top: 12px;'></div>
			    	<div id="newFiles" style='display:inline-block;position: relative;left: 85px;'>
			    		  <div id="f" style='width: 270px;
										height: 30px;
										border: 1px solid #b0b0b0;
										display: inline-block;
										position: relative;
										top: -2px;font-size: 15px;padding-top: 5px;' >
			    		  </div>
					</div>
				</div>
				
				<div class="poplist2">
					<label style="font-size: 16px">输入名称：</label>
					<input name="headname" id="headname" style="line-height: 30px;font-size: 16px;width: 270px;" placeholder="请输入图片名称...">
				</div>
				
				
				<div style='border-top:1px solid #b0b0b0;
									position: relative;
									padding-top:10px;
									text-align: right;
									margin-top: 15px;'>
					<button  class="btn add"  type="button" id="button" style="display: block">上   传</button>
				</div>
			</div>
			
			<div id='code_chart_view'>
		  	  <div id="codeView">
			  	  <div class="tool_code">
			  	  	<div class="line"></div>
				  	<button id="alert" class="btn add1">刷新</button>
				  </div>
				  <textarea id="code" name="code"></textarea>
			  </div>
		
			 <div id="chartView">
			 	<div class="tool_code">
			 	
			 		<div class="line"></div>
			 		<button id="showImage" class="btn add1">显示图像</button>
				  	<button id="getData" class="btn add1">数据视图</button>   
				  	<button id="drag_flag" class="btn add1">启用拖拽</button>      
				  	<button id="huatu" class="btn add1">初始化</button>        

				  </div>
			 	<div id="chart"></div>
			 </div>     
			  
		  </div>
		</div> 
		
		<div id='documentMonitor'>
			<div class="info_window">
				<div id='width_scale' style="cursor: pointer" class="info_title">实时窗口</div>
				<div id='monitor' class="info_content">
					<div class="monitor_info">暂无数据</div>
				</div>
			</div>
			<div class="info_window">
				<div id='tongji_info' class="info_title"  style="cursor: pointer" >统计信息</div>
				<div id='stastics' class="info_content">
					<div class="monitor_info">暂无数据</div>
				</div>
			</div>
		</div>
		
	</div>

  <script src="<%=path%>/resources/echartsjs/echarts-plain.js"></script>
  <script type="text/javascript" src="<%=path%>/analyse_js/upload_network.js"></script>
  <script src="<%=path%>/resources/js/d3.v2.js"></script>
  <script src="<%=path%>/resources/js/jsCodeFormat/jsonFormat.js"></script>
  <script src="<%=path%>/resources/js/jsCodeFormat/codeLineFormat.js"></script>
  <script type="text/javascript" src="<%=path%>/analyse_js/constNetwork.js"></script>
  
		
		<script type="text/javascript">
			var spath="<%=path%>";
			var pop_string = "";

			$(document).ready(function(){
				pop_string = $("#pop_image_up").html();
				$("#pop_image_up").html("").remove();
			});

		  $(document).ready(function(){
				$("#getData").click(function(){
					getTimeInfo("显示数据视图...");
					
					//切换视图
					$("#codeView").css("display","block");
					$("#chartView").css("display","none");

					var nl = getNodeAndLink();
					$("#code").text("option = "+JsonUti.convertToString(nl));
					cvtToCode();
				});

				$("#showImage").click(function(){
					getTimeInfo("显示节点头像...");
					if($(this).text()=="显示图像"){
						image_show_flag = true;//显示图像
						$(this).text("隐藏图像");
					}
					else{
						image_show_flag = false;//不显示图像
						$(this).text("显示图像");
					}
					redraw();
				});

				$("#drag_flag").click(function(){
					var nl = getNodeAndLink();
					$("#code").text("option = "+JsonUti.convertToString(nl));
					cvtToCode();


					//redraw();
					var newdata = getCodeData();
					if($(this).text()=="启用拖拽"){
						//drag_flag = true;//显示图像
						$(this).text("关闭拖拽");
						multiDraw_drag(newdata);
					}
					else{
						//drag_flag = false;//不显示图像
						$(this).text("启用拖拽");
						multiDraw(newdata);
					}
				});

				$("#alert").click(function(){
					getTimeInfo("根据数据视图，刷新可视化网络...");
					//切换视图
					$("#codeView").css("display","none");
					$("#chartView").css("display","block");

					var newdata = getCodeData();
					multiDraw(newdata);
				});

				$("#huatu").click(function(){
					var friend_net_origin = {
					  		"nodes":[
					           { "name" : "待命名","special":"false","r":16,"color":"1","catagory":"默认","headImg":"headImg.png"}],
					         "edges":[]};
					drawNetwork(friend_net_origin);
				});

				$("#width_scale").click(function(){
					var cur_wid = parseInt($("#documentMonitor").css("width").replace("px",""));
					if(cur_wid>130){
						$("#documentMonitor").animate({width:"125px"},250,"swing",function(){$("#documentMonitor").css("width","125px")});
					}
					else{
						$("#documentMonitor").animate({width:"235px"},250,"swing",function(){$("#documentMonitor").css("width","235px")});
					}
				});

				//点击统计信息标题
				$("#tongji_info").click(function(){
					getStatistic();
				});
				$("#saveImage").css("display","none");
				
			});
			
			//send();
		</script>
	
</body>
</html>