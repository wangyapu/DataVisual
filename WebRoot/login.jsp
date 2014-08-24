<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
	<title>DataGeek数据可视化平台</title>
	<script type="text/javascript" src="<%=path%>/resources/jquery-1.8.0.js"></script>
	<link rel="stylesheet" href="<%=path%>/resources/css/main.css" type="text/css"></link>
	<link rel="stylesheet" href="<%=path%>/resources/css/forms.css" type="text/css"></link>     
	<link rel="stylesheet" href="<%=path%>/resources/css/login.css" type="text/css"></link>    
</head>

<body>
	<input type="hidden" id="userinfo" value="<%=session.getAttribute("username") %>">
	<input type="hidden" id="message" value="<%=session.getAttribute("message") %>">  
	<div class="circle">
		<a href="dataSource/datasetUpload.jsp"><div id="dataupload"></div></a>
		<a href="dataSource/fileDatasetList"><div id="dataselect"></div></a>
		<a href="datamining/showmissing"><div id="datadeal"></div></a>
		<a href="datamining/apriori.jsp"><div id="datamining"></div></a>
	</div>
				

	<div id='line_login'></div>              
	<div id='logo_login'>
		登录     
	</div>   
	
	<div id='logo_body'>
		<div class="logincontent">
			<div class="loginTitle">      
				用户登录    
			</div>
			<div class="loginTitleDiv"></div>
			<form action="userlogin" method="post">     
				<div class="userDiv">
					<div class="user"></div>
					<input class="userInput" name="username" id="username" type="text" value="admin" >
				</div>

				<div class="passwordDiv">
					<div class="password"></div>    
					<input class="passwordInput" name="password" id="password" type="password" value="admin">
				</div>
				<button type="submit" class="login btn add" style="width:188px;">登录</button>      
			</form>
		</div>	
	</div>
 	
	<script type="text/javascript" charset="utf-8">
		var login_body_height = 289;
		var login_body_move_distance = 299;
		var login_body_animate = 299;
		var line_login_height = 35;

		var perPxTime = login_body_animate/login_body_move_distance;   

		var login_body_top = -10;
		var logo_login_top = 25;        
		$(document).ready(function(){
			//点击登录触发       
			$("#logo_login").click(function(){
				var tx = parseInt($(this).css("top").replace("px",""));          
				if(tx<60){
					//$("#logo_body").animate({top: '-10px'},500,"linear",function(){$("#logo_login").text("收起")});
					//$("#line_login").animate({top: '340px'},500,"linear");
					//$(this).animate({top: '375px'},500,"linear");           
					$("#logo_body").animate({top: login_body_top+'px'},login_body_animate,"linear",function(){$("#logo_login").text("收起")});
					$("#line_login").animate({top: (login_body_height+login_body_top)+'px',height:'0px'},login_body_animate,"linear");
					$(this).animate({top: (login_body_height+login_body_top-80)+'px'},login_body_animate,"linear");   
				}           
				else{
					//$("#logo_body").animate({top: '-360px'},500,"linear",function(){$("#logo_login").text("登录")});
					//$("#line_login").animate({top: '-10px'},500,"linear");
					//$(this).animate({top: '25px'},500,"linear");
					$("#logo_body").animate({top: (login_body_top-login_body_height)+'px'},login_body_animate,"linear",function(){$("#logo_login").text("登录")});
					$("#line_login").animate({top: login_body_top+'px',height:line_login_height+'px'},login_body_animate,"linear");
					$(this).animate({top: logo_login_top+'px'},login_body_animate,"linear");
				}

			});	
			<%--
			var info=$("#userinfo").val();
			var message=$("#message").val();
			if(info=="null"&&message!="null"){
				$("#logo_login").trigger("click");
			}
			--%>
			
		});

	</script>
	
</body>
</html>
