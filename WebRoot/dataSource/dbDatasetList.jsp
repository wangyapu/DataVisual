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
	<script type="text/javascript" src="<%=path%>/dataSource/dbDataset.js"></script>
	<link href="<%=path%>/resources/loadmask/jquery.loadmask.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=path%>/resources/loadmask/jquery.loadmask.min.js"></script>
	
	<script type="text/javascript" src="<%=path%>/resources/common/core.js"></script>
	
	<link rel="stylesheet" type="text/css" href="<%=path%>/resources/core.css">	
	<link rel="stylesheet" href="<%=path%>/resources/css/header.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/forms.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/table_css_new.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/table.css" type="text/css"></link>
	
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
	<script type="text/javascript">
		var spath="<%=path%>";
		$(document).ready(function()    
		{
			$("<option value='-1' selected='selected'>--请选择数据库类型--</option>").appendTo($("#dbtypeselect"));
			$("#dbtypeselect").change(function(){
				var dbtype=$(this).children('option:selected').val();
				if(dbtype.indexOf('-1')==-1){
					getDbName(dbtype);
				}
			});
			$("<option value='-1' selected='selected'>--请选择数据库名称--</option>").appendTo($("#dbnameselect"));
			$("#dbnameselect").change(function(){
				var dbname=$(this).children('option:selected').val();
				if(dbname.indexOf('-1')==-1){
					getTableName(dbname);
				}
			});
			allDbType();
			$("#dselect").change(function(){
				var d=$(this).children('option:selected').val();
				if(d==1){
					$("#ds").show();
					$("#dbtypeselect").hide();
					$("#dbnameselect").hide();
					$("#tablelist").empty();
					$("#page").hide();
				}
				else{
					$("#ds").hide();
					$("#dbtypeselect").val("-1");
					$("#dbnameselect").val("-1");
					$("#dbtypeselect").show();
					$("#dbnameselect").show();
				}
			});
			
		});
	</script>
</head>

<body>
	<jsp:include page="../common/header.jsp" flush="true"/>
	<jsp:include page="../common/leftmenu.jsp" flush="true"/>
	<jsp:include page="../common/bottom.jsp" flush="true"/>
	
		<div id="content_template" class="content">
		<div>
			<div class='opr_title_style'>数据库数据</div>
			<HR SIZE=1 class='uploadhr'/>
		</div>
		<div id="main">
			<div class="box-header ">
				<div class="contenttitle"><img src="<%=path%>/resources/images/useroption.png"/>用户操作</div>
			</div>
					<div class="box-content touming" id="main"  >
						<div class='tableList' style="width:85%;margin:0 auto;">
							<div id=dbtype style="float:left;margin-top:5px;margin-right:20px">
							<select name="dbtype" id="dselect" onchange="">
								<option value="0">选择服务器数据</option>
								<option value="1">配置数据源</option>
							</select>
							</div>
							
							<div id=dbtype style="float:left;margin-top:5px;margin-right:20px">
							<select name="dbtype" id="dbtypeselect" onchange="">
							</select>
							</div>
							
							<div id=dbname style="float:left;;margin-top:5px">
								<select name="dbname" id="dbnameselect" onchange="">
								</select>
							</div>
						</div>
						
						<form class="form-horizontal">
						<div id="ds" style="float:left;display: none;width:400px;">
							<div class="control-group">
		    					<label class="control-label" for="datasetname">数据库IP</label>
							    <div class="controls">
							      <s:textfield id="ip" name="ip" value=""></s:textfield>
							    </div>
						    </div>
						    <div class="control-group">
		    					<label class="control-label" for="datasetname">数据库类型</label>
							    <div class="controls">
							      <select name="dbtype" id="dselect" onchange="">
									<option value="0">MySQL</option>
									<option value="1">SQL Server</option>
								  </select>
							    </div>
						    </div>
						    <div class="control-group">
		    					<label class="control-label" for="datasetname">数据库用户名</label>
							    <div class="controls">
							      <s:textfield id="duser" name="duser" value=""></s:textfield>
							    </div>
						    </div>
						    <div class="control-group">
		    					<label class="control-label" for="datasetname">数据库密码</label>
							    <div class="controls">
							      <s:textfield id="dpwd" name="dpwd" value=""></s:textfield>
							    </div>
						    </div>
						    <div class="control-group">
		 				    	<label class="control-label"></label>
    							<div class="controls">
		 				    	<button class="btn add" type="button" id="button">确   定</button>
		 				    	</div>
		 				    </div>
						</div>
						</form>
						
						<div id=tablelist style="float:left;margin-top: 10px;margin-bottom: 0px;width:100%;">
						</div>
						
						<div width="100%" id="page" style="display:none;border:1px solid #fff;" class="pagestyle">
						<div style="height:15px"></div>
							首页　　 上一页　　  下一页　　  末页
							 <font style="font-size:12px;color:gray">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;第1/1页
							 </font>
						</div>

			</div>
		</div>
		<div class="box-header" id="console" style="display:none">
			<div style="height:15px"></div>
			<div class="contenttitle" ><img src="<%=path%>/resources/images/resultshow.png"/>结果展示</div>
		</div>
		<div class="box-content touming" id="result" >
		</div>
	</div>	
</body>
</html>