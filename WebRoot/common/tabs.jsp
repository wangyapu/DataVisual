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
	
	<style type="text/css">
	
		.tabmain {
			width: 616px;
			height: 384px;
			margin: 150px auto;
			background: #F3F3F3;
			border: 1px solid #F3F3F3;
		}
		
		#outerWrap2 {
			position: relative;
			z-index: 999;
			margin: 0;
			padding: 0;
		}
		
		.outerWrap {
			width:50px;
			/*height: 384px;
			margin: 150px auto;*/
			background: #F3F3F3;
			border: 1px solid #72C9FA;
			position: absolute;
			right: -52px;
			top: 72px;
			z-index: 999;
			display:inline-block;
		}
		
		.blueline {
			position: absolute;
			top: 0px;
			left: 0px;
			width: 3px;
			height: 48px;
			background: #1d9fd3;
			overflow: hidden;
		}
		
		.tabGroup {
			float: left;
			width: 50px;
			height: auto;
			z-index: 3;
		}
		
		ol, ul, li {
			list-style: none outside;
		}
		
		.tabGroup li.selectedTab {
			/*padding-left: 10px;*/
			padding-left: 3px;
			background: #fff;
			color: #1d9fd3;
			font-weight: bold;
		}
		
		.tabGroup li {
			height: 48px;
			line-height: 48px;
			/*padding-left: 8px;*/
			padding-left: 3px;
			text-align: left;
			cursor: pointer;
			-webkit-user-select: none;
			-moz-user-select: none;
			font-size: 14px;
			font-family: 'Microsoft yahei';
			color: #666;
		}
		
		.div_image{
			width: 41px;
			height: 42px;
			padding-top: 3px;
			padding-left: 4px;
			border:0px solid red;
			background: url(<%=path%>/common/column.png);
			-moz-background-size:38px 39px; /* 老版本的 Firefox */
			background-size:38px 39px;
			background-repeat:no-repeat;
			background-origin:content-box;
		}
		
		 
	
	</style>

	
	<!-- jquery及jquery-ui资源-->
	<link rel="stylesheet" href="<%=path%>/resources/jquery-ui-1.7.3.custom.css" type="text/css">
	<script type="text/javascript" src="<%=path%>/resources/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="<%=path%>/resources/jquery-ui-1.7.3.custom.min.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/common/core.js"></script>
	
	<script type="text/javascript">
		var spath="<%=path%>";
		$(function(){
	
		});
	</script>
</head>

<body>
	<jsp:include page="../common/header.jsp" flush="true"/>
	<jsp:include page="../common/leftmenu.jsp" flush="true"/>
	<jsp:include page="../common/bottom.jsp" flush="true"/>
	
	<div id="content_template" class="content">
		<div>
			<div class='opr_title_style' style="width: 110px">社会网络分析</div>
			<HR SIZE=1 class='uploadhr'/>
		</div>
		<div id="main">

			<div  class='tableList'>
			    <span id='adds'>.</span>
			</div>

		</div>
	</div>
	
		<div id="outerWrap_image" class='outerWrap'>
			<div class="blueline" id="blueline_image" style="top: 0px;"></div>
			<ul class="tabGroup" id='tabGroup_image'>
				<li class="tabOption selectedTab" related-id='图一'>
					<div style="" class='div_image'></div>
				</li>
				<li class="tabOption" related-id='图二'>
					<div class='div_image'></div>
				</li>
				<li class="tabOption" related-id='图三'>
					<div class='div_image'></div>
				</li>
				<li class="tabOption" related-id='图四'>
					<div class='div_image'></div>
				</li>
				<li class="tabOption" related-id='图五'>
					<div class='div_image'></div>
				</li>
				<li class="tabOption" related-id='图六'>
					<div class='div_image'></div>
				</li>
				<li class="tabOption" related-id='图七'>
					<div class='div_image'></div>
				</li>
			</ul> 
		</div>
		
		<script type="text/javascript">

			$(document).ready(function(){
				$("ul#tabGroup_image li").each(function(){
					$(this).click(function(){
						var indexs = -1;
						var count = 0;
						$("ul#tabGroup_image li").each(function(){
							$(this).removeClass("selectedTab");
						});//去掉所有的selectedTab
						$(this).addClass("selectedTab");//为本对象添加selectedTab

						$("ul#tabGroup_image li").each(function(){
							indexs++;
							if($(this).attr("class").indexOf("selectedTab")!=-1){
								count = indexs;
							}
						});//
						$("#blueline_image").css("top",(count*48)+"px");

						//这里处理点击后的事件
						var related_id = $(this).attr("related-id");
						var movetothis = function(related_id){
							$("#adds").text(related_id);//方法体，需要写的js都写在这里
						}
						movetothis(related_id);
						
					});
				});

				//鼠标移动事件
				$("body").mousemove(function(e){
					var wind_wid = $(window).width(); //浏览器当前窗口可视区域宽度
					var wind_hei = $(window).height(); //浏览器当前窗口可视区域高度
					
					if(e.pageY>72 && e.pageY<72+384){
						if(wind_wid-e.pageX<6){
							$("#outerWrap_image").css("right","0px");
						}
					}

				});

				$("body").hover(function(){
					$("#outerWrap_image").css("right","-52px");
				});//content_template
				
				$("#content_template").hover(function(e){
					$("#outerWrap_image").css("right","-52px");
				});//content_template,commonheader

				$("#commonheader").hover(function(){
					$("#outerWrap_image").css("right","-52px");
				});//content_template,commonheader,bottom

				$("#bottom").hover(function(){
					$("#outerWrap_image").css("right","-52px");
				});//content_template,commonheader,bottom


				//使悬浮栏居中
				var hei = parseInt($("#outerWrap_image").css("height").replace("px",""));
				var top_hei = parseInt($("#commonheader").css("height").replace("px",""));
				var bottom_hei = parseInt($("#bottom").css("height").replace("px",""));
				var ksqy_hei = $(window).height();
				
				$("#outerWrap_image").css("top",((ksqy_hei-top_hei-bottom_hei-hei)/2.0+top_hei)+"px");
				
			});
		
		</script>
	
</body>
</html>