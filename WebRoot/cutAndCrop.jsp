<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>图片保存测试</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" href="<%=path%>/resources/js/Jcrop/css/jquery.Jcrop.css" type="text/css" />
	<link rel="stylesheet" href="<%=path%>/resources/js/easydialog/easydialog.css" type="text/css" />
	<link rel="stylesheet" href="<%=path%>/resources/css/cutAndCrop.css" type="text/css" />
	
	<style type="text/css">

	</style>

  </head>
  
  <body id="all">
	<div id="charts" style="border:1px soilid gray;height:400px;width:500px;font-size: 20px">
	   <label>zhoufachao</label>
	   <label>zhoufachao</label>
	   <h2>Popular Programming Languages</h2>
<%--	   <button class="capture" type="button" cmd="charts">图形保存(无需截图)</button>--%>
	</div>
	<button class="capture" type="button" cmd="charts">图形保存(无需截图)</button>
	
	<div id="charts2" style="border:1px soilid gray;height:400px;width:500px;font-size: 20px">
	   <label>denglingling</label>
	   <h2>sdkjfghskdjghksdgfhksjdghsjhgjsdghjsdghj</h2>
	   <button class="capture" type="button" cmd="charts2">图形保存(无需截图)</button>
	</div>
	
	<div id="charts3" style="border:1px soilid gray;height:400px;width:500px;font-size: 20px">
	   <label>denglingling</label>
	   <h2>sdkjfghskdjghksdgfhksjdghsjhgjsdghjsdghj</h2>
	   <button class="capture" type="button" cmd="charts3">图形保存(无需截图)</button>
	</div>
	
	<div id="charts4" style="border:1px soilid gray;height:400px;width:500px;font-size: 20px">
	   <label>denglingling</label>
	   <h2>sdkjfghskdjghksdgfhksjdghsjhgjsdghjsdghj</h2>
	   <button class="capture" type="button" cmd="charts4">图形保存(无需截图)</button>
	</div>

    <script type="text/javascript" src="<%=path%>/resources/js/imgSave/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="<%=path%>/resources/js/imgSave/html2canvas.min.js"></script>
    <script type="text/javascript" src="<%=path%>/resources/js/imgSave/jquery.plugin.html2canvas.fix.js"></script>
    <script type="text/javascript" src="<%=path%>/resources/js/Jcrop/jquery.Jcrop.js"></script>
    <script type="text/javascript" src="<%=path%>/resources/js/easydialog/easydialog.min.js"></script>
    <script type="text/javascript" src="<%=path%>/resources/js/cutAndCrop.plugin.js"></script>
    <script type="text/javascript" src="<%=path%>/resources/js/cutAndCrop.js"></script>
    
    <script type="text/javascript">
    	var spath = "<%=path%>";
    </script>

  </body>
</html>
