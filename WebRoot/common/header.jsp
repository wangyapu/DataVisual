<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<link rel="stylesheet" href="<%=path%>/resources/js/Jcrop/css/jquery.Jcrop.css" type="text/css" />
<link rel="stylesheet" href="<%=path%>/resources/js/easydialog/easydialog.css" type="text/css" />
<link rel="stylesheet" href="<%=path%>/resources/css/cutAndCrop.css" type="text/css" />

<style>
	.logoIcon{
		position: absolute;
		left: 17px;
		top: 10px;
		width:80px;
		height:53px;
		background:url(<%=path%>/resources/images/logo1.png);
		background-repeat:no-repeat;
	}            
	#logo{
		width: 500px;
		height: 80px;
		background: url(<%=path%>/resources/images/titleV02.png);
		-moz-background-size:500px 80px; /* 老版本的 Firefox */
		background-size:500px 80px;
		background-repeat:no-repeat;     
		background-origin:content-box;
		background-position:0px -8px;
		position: absolute;     
		left: 85px;     
	}     
	.toolBar{
		width: 500px;       
		height: 70px;     
		position: absolute;
		top: 0px;
		right: 40px;     
	}	
	.userGuide{
		width: 90px;    
		height: 70px;     
		position: absolute;
		right: 100px;
		box-shadow: -1px 0 1px rgba(255, 255, 255, 0.2), 0 0px 0px rgba(255, 255, 255, 0), 0 0px 0px rgba(255, 255, 255, 0.2), 0px 0 0px rgba(255, 255, 255, 0.2);
	}
	.userGuide:hover{
		width: 90px;    
		height: 70px;     
		position: absolute;
		right: 100px;
		cursor:pointer;
		box-shadow: -1px 0 1px rgba(255, 255, 255, 0.2), 0 0px 0px rgba(255, 255, 255, 0), 0 0px 0px rgba(255, 255, 255, 0.2), 0px 0 0px rgba(255, 255, 255, 0.2);
		background:#3A99D3;
		background: -webkit-gradient(linear, left top, left bottom, from(rgba(255, 255, 255, 0)), to(rgba(255, 255, 255, 0.5)));
		background: -moz-linear-gradient(top, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0.5));
		background: -o-linear-gradient(top, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0.5));  
	}
	.screenShot{
		width: 100px;
		height: 70px;
		position: absolute;
		top: 0px;
		right: 190px;      
		box-shadow: -1px 0 1px rgba(255, 255, 255, 0.2), 0 0px 0px rgba(255, 255, 255, 0), 0 0px 0px rgba(255, 255, 255, 0.2), 0px 0 0px rgba(255, 255, 255, 0.2);
	}
	.screenShot:hover{
		width: 100px;
		height: 70px;
		position: absolute;
		top: 0px;
		right: 190px;      
		cursor:pointer;
		box-shadow: -1px 0 1px rgba(255, 255, 255, 0.2), 0 0px 0px rgba(255, 255, 255, 0), 0 0px 0px rgba(255, 255, 255, 0.2), 0px 0 0px rgba(255, 255, 255, 0.2);
		background:#3A99D3;
		background: -webkit-gradient(linear, left top, left bottom, from(rgba(255, 255, 255, 0)), to(rgba(255, 255, 255, 0.5)));
		background: -moz-linear-gradient(top, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0.5));
		background: -o-linear-gradient(top, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0.5));        
	}
	.exit{
		width: 90px;
		height: 70px;         
		position: absolute;    
		right: 10px;
		box-shadow: -1px 0 1px rgba(255, 255, 255, 0.2), 0 0px 0px rgba(255, 255, 255, 0), 0 0px 0px rgba(255, 255, 255, 0.6), 1px 0 1px rgba(255, 255, 255, 0.2);
	}  
	.exit:hover{
		width: 90px;
		height: 70px;         
		position: absolute;    
		right: 10px;
		cursor:pointer;
		box-shadow: -1px 0 1px rgba(255, 255, 255, 0.2), 0 0px 0px rgba(255, 255, 255, 0), 0 0px 0px rgba(255, 255, 255, 0.6), 1px 0 1px rgba(255, 255, 255, 0.2);
		background:#3A99D3;
		background: -webkit-gradient(linear, left top, left bottom, from(rgba(255, 255, 255, 0)), to(rgba(255, 255, 255, 0.5)));
		background: -moz-linear-gradient(top, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0.5));
		background: -o-linear-gradient(top, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0.5));  
	}   
</style>
	
<div id="commonheader" class="content">
	<div class="logoIcon"></div>
	<div id='logo'>
	</div>
	<div class="toolBar">
		<div class="userGuide"><a href="javascript:userguide();"><img src="<%=path%>/resources/images/toolBar/userGuide.png"/></a></div>
		<div class="screenShot"><img src="<%=path%>/resources/images/toolBar/screenShot.png"/></div>
		<div class="exit"><a href="logout"><img src="<%=path%>/resources/images/toolBar/exit.png"/></a></div>
	</div>
</div>

<script type="text/javascript" src="<%=path%>/resources/js/canvg/rgbcolor.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/canvg/StackBlur.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/canvg/canvg.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/canvg/StackBlur.js"></script>

<%--    <script type="text/javascript" src="<%=path%>/resources/js/imgSave/jquery-1.7.2.min.js"></script>--%>
	<script type="text/javascript" src="<%=path%>/resources/js/imgSave/html2canvas.js"></script>
    <script type="text/javascript" src="<%=path%>/resources/js/imgSave/jquery.plugin.html2canvas.fix.js"></script>
    <script type="text/javascript" src="<%=path%>/resources/js/Jcrop/jquery.Jcrop.js"></script>
    <script type="text/javascript" src="<%=path%>/resources/js/easydialog/easydialog.min.js"></script>
    <script type="text/javascript" src="<%=path%>/resources/js/cutAndCrop.plugin.js"></script>
    <script type="text/javascript" src="<%=path%>/resources/js/cutAndCrop.js"></script>
	<script type="text/javascript">
		function userguide(){
			introJs().start();
		}
	</script>
