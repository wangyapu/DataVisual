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
	<link href="<%=path%>/resources/loadmask/jquery.loadmask.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=path%>/resources/loadmask/jquery.loadmask.min.js"></script>
	<script type="text/javascript" src="<%=path%>/dataSource/readFileDataset.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/common/core.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/introjs/intro.js"></script>
	
	<%--<script type="text/javascript">
		jQuery(document).ready(function($) {
			introJs().start();
		});
	</script>
	--%>	
	
	<link rel="stylesheet" type="text/css" href="<%=path%>/resources/core.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/header.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/forms.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/table_css_new.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/table.css" type="text/css"></link>
	<link href="<%=path%>/resources/introjs/introjs.css" rel="stylesheet">
	
	<style type="text/css">
		*{margin:0;padding:0;}  
		a{text-decoration:none;}  
		.btn_addPic{  
			display: block;  
			position: relative;  
			width: 100px;  
			height: 25px;  
			overflow: hidden;  
			border: 1px solid #EBEBEB;  
			background: none repeat scroll 0 0 #F3F3F3;  
			color: #999999;  
			cursor: pointer;
			text-align: center;
		}  
		.btn_addPic span{display: block;line-height: 25px;}  
		.btn_addPic em {  
			background:url(http://p7.qhimg.com/t014ce592c1a0b2d489.png) 0 0;  
			display: inline-block;  
			width: 18px;  
			height: 18px;  
			overflow: hidden;  
			margin: 0px 5px 2px 0;  
			line-height: 20em;  
			vertical-align: middle;  
		}  
		.btn_addPic:hover em{background-position:-19px 0;}  
		.filePrew {  
			display: block;  
			position: absolute;  
			top: 0;  
			left: 0;  
			width: 140px;  
			height: 25px;  
			font-size: 100px; /* 增大不同浏览器的可点击区域 */  
			opacity: 0; /* 实现的关键点 */  
			filter:alpha(opacity=0);/* 兼容IE */  
		}
		
		.yastyle,.filePrew{
			border:1px solid #ABADB3;
		
		}
		
		object{
			position: relative;
			top: -12px;
		}
		
		#f div{
			width:100%;
			color: #333;
			font-size: 14px;
			font-family: '微软雅黑';
			margin-bottom:5px;
			border-bottom: 1px solid rgba(26,122,166,1);
		}
		
		#f div a{
			color: red;
			float: right;
		}
		
		#f div a:HOVER{
			color: blue;
		}
		
		
	</style>
</head>

<body>

	<jsp:include page="../common/header.jsp" flush="true"/>
	<jsp:include page="../common/leftmenu.jsp" flush="true"/>
	<jsp:include page="../common/bottom.jsp" flush="true"/>
	
	<div id="content_template" class="content">
		<div>
			<div class='opr_title_style'>文件型数据</div>
			<HR SIZE=1 class='uploadhr'/>
		</div>
		<div id="main">
			<div class="box-header ">
				<div class="contenttitle"><img src="<%=path%>/resources/images/useroption.png"/>用户操作</div>
			</div>
			<div class="box-content touming" id="main"  data-step="1" data-intro="选择你需要分析的数据集，点击相应链接即可完成读取" data-position="top">
					<s:if test="#request.allFileDatasets.size!=0">
			    <table width="100%" height="40" class="table table-hover">
				    <thead>
					    <tr class="theadstyle">
					      <th width="60%">数据集名称</th>
					      <th width="13%">数据集规模</th>
					      <th width="17%">上传时间</th>
					      <th width="10%">上传用户</th> 
					    </tr>
				    </thead>
					<tbody>
			 		<s:iterator value="allFileDatasets" id="s" status="st">
					 	<tr style="CURSOR:hand" align="left">
					      <td>
					      <a href="javascript:readFileDataset(${s.id})">
						      <s:if test="%{#s.datasetname.trim().length()>50}"><s:property value="%{#s.receivername.trim().substring(0,50)+'...'}"/></s:if>
						      <s:else>${s.datasetname}</s:else>
						      </a>
					      </td>
					      <td>${s.filesize}MB</td>
					      <td><s:date name="%{#request.s.uploadtime}" format="yyyy/MM/dd HH:mm:ss"/></td>
					      <td>${s.user}</td> 
					    </tr>
					</s:iterator>
				</tbody>
			 </table><br/>
			 
	    	<div class="pagestyle"  data-step="2" data-intro="没有你要的数据？翻页试试">
	             <s:if test="#request.pu.pageno==1">首页　　 上一页</s:if>
	             <s:else>
	             <a href="fileDatasetList.action?pageno=1">首页</a>
	             &nbsp;&nbsp;&nbsp;
	             <a href="fileDatasetList.action?pageno=${pu.prepageno}">上一页</a></s:else>  
				 &nbsp;&nbsp;&nbsp;
				 <s:if test="#request.pu.pageno==#request.pu.totalpage || #request.pu.totalpage==0">下一页　　  末页</s:if>	 
				 <s:else><a href="fileDatasetList.action?pageno=${pu.nextpageno}">下一页</a>
				 &nbsp;&nbsp;&nbsp;
				 <a href="fileDatasetList.action?pageno=${pu.totalpage}">末页 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a> </s:else>
				 <font style="font-size:12px;color:gray">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;第${pu.pageno}/${pu.totalpage}页
				 </font>
		     </div>
		     
			</s:if>
			<s:else>
	         <table align="center">
		         <tr>
		         <td>
		         <br/>
				 <b style="font-size: 20px;">&nbsp;&nbsp;&nbsp;&nbsp;暂无文件数据集</b>
				 </td></tr>
			  </table>
		    </s:else>
			</div>
			
			<div class="box-header" id="console" style="display:none">
				<div style="height:15px"></div>
				<div class="contenttitle" ><img src="<%=path%>/resources/images/resultshow.png"/>结果展示</div>
			</div>
			<div class="box-content touming" id="result" >
			</div>              
			          
		</div>
	</div>
	
	<script type="text/javascript">
		var spath = "<%=path%>";
	</script>
	
    
</body>
</html>