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
	<script type="text/javascript" src="<%=path%>/resources/jquery-1.8.0.js"></script>
	<link rel="stylesheet" href="<%=path%>/resources/css/table_css_new.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/table.css" type="text/css"></link>
	<script type="text/javascript" src="<%=path%>/resources/common/core.js"></script>

</head>

<body>
<%=request.getAttribute("tablecontent") %>
	<div class="pagestyle" style="">  
    
		 
		 <s:if test="#request.pu.pageno==1">首页　　 上一页</s:if>
            <s:else>
           <a href="dataListShow.action?pageno=1&totalrow=${pu.totalnum}">首页</a>
            &nbsp;&nbsp;&nbsp;
             <a href="dataListShow.action?pageno=${pu.prepageno}&totalrow=${pu.totalnum}">上一页</a></s:else>  
		 &nbsp;&nbsp;&nbsp;
		 <s:if test="#request.pu.pageno==#request.pu.totalpage || #request.pu.totalpage==0">下一页　　  末页</s:if>	 
		 <s:else><a href="dataListShow.action?pageno=${pu.nextpageno}&totalrow=${pu.totalnum}">下一页</a>
		 &nbsp;&nbsp;&nbsp;
		 <a href="dataListShow.action?pageno=${pu.totalpage}&totalrow=${pu.totalnum}">末页 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a> </s:else>
		 <font style="font-size:12px;color:gray">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;第${pu.pageno}/${pu.totalpage}页
		 </font>
    </div>
</body>
</html>