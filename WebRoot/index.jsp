<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>

<head>
	<base href="<%=basePath%>">
	<title>DataGeek数据挖掘可视化平台</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="数据可视化展示">
	<meta http-equiv="description" content="数据可视化展示">
	
	<link rel="stylesheet" type="text/css" href="<%=path%>/resources/core.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/header.css">
	<script type="text/javascript" src="<%=path%>/resources/jquery-1.8.0.js"></script>
</head>

<body>
	<jsp:include page="common/header.jsp" flush="true"/>
	<jsp:include page="common/leftmenu.jsp" flush="true"/>
	<jsp:include page="common/bottom.jsp" flush="true"/>
	
	<jsp:include page="common/content_template.jsp" flush="true"/>
	
</body>
</html>