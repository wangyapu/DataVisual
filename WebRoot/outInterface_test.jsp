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
	
	
<body>
	<iframe src="http://localhost:8080/DataVisual/outerInterface.html" 
			scrolling="auto" 
			width="100%" 
			height="620px" 
			style="border: 1px solid #b0b0b0;">
	</iframe>
</body>
</html>