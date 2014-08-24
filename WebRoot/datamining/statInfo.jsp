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
	<title>DataGeek数据挖掘可视化平台</title>
	<link rel="stylesheet" type="text/css" href="<%=path%>/resources/core.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/header.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/forms.css">
<%--	<link rel="stylesheet" href="<%=path%>/resources/css/table_css_new.css">--%>
	<script type="text/javascript" src="<%=path%>/resources/jquery-1.8.0.js"></script>
	<link href="<%=path%>/resources/loadmask/jquery.loadmask.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/resources/introjs/introjs.css" rel="stylesheet">
	
	<script type="text/javascript" src="<%=path%>/resources/loadmask/jquery.loadmask.min.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/d3.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/highcharts/highcharts.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/highcharts/highcharts-3d.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/highcharts/highcharts-more.js"></script>
    <script type="text/javascript" src="<%=path%>/resources/highcharts/modules/exporting.js"></script>
	
	<script type="text/javascript" src="<%=path%>/resources/common/core.js"></script>
	<script type="text/javascript">
	$(function(){
	    //移到右边
	    $('#add').click(function() {
	    //获取选中的选项，删除并追加给对方
	        $('#select1 option:selected').appendTo('#select2');
	    });
	    //移到左边
	    $('#remove').click(function() {
	        $('#select2 option:selected').appendTo('#select1');
	    });
	    //全部移到右边
	    $('#add_all').click(function() {
	        //获取全部的选项,删除并追加给对方
	        $('#select1 option').appendTo('#select2');
	    });
	    //全部移到左边
	    $('#remove_all').click(function() {
	        $('#select2 option').appendTo('#select1');
	    });
	    //双击选项
	    $('#select1').dblclick(function(){ //绑定双击事件
	        //获取全部的选项,删除并追加给对方
	        $("option:selected",this).appendTo('#select2'); //追加给对方
	    });
	    //双击选项
	    $('#select2').dblclick(function(){
	       $("option:selected",this).appendTo('#select1');
	    });
	});
	</script>
	<script type="text/javascript" src="<%=path%>/resources/introjs/intro.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/echartsjs/esl.js"></script>
	<%--<script type="text/javascript">
		jQuery(document).ready(function($) {
			introJs().start();
		});
	</script>
	--%><SCRIPT type="text/javascript" src="<%=path%>/analyse_js/dealstat_echarts.js"></SCRIPT>
	
	<style type="text/css">
		.sumData{
			background:url(<%=path%>/resources/images/dataIntro/sumData.png);
			-moz-background-size:cover;
			-webkit-background-size:cover;    
			-o-background-size:cover;           
			background-size:cover;
			background-repeat:no-repeat;
			-webkit-background-origin:border-box;
			-moz-background-origin:border-box;
			-o-background-origin:border-box;   
			background-origin:border-box;			
			background-position: right center;
			margin: 0 40px 0 0;
		}
	</style>
</head>

<body>
	<jsp:include page="../common/header.jsp" flush="true"/>
	<jsp:include page="../common/leftmenu.jsp" flush="true"/>
	<jsp:include page="../common/bottom.jsp" flush="true"/>
	
	<div id="content_template" class="content">
		<div>
			<div class='opr_title_style' style="width: 110px">统计信息描述</div>
			<HR SIZE=1 class='uploadhr'/>
		</div>
		<div id="main">
		
			<div  class='tableList' style="width:50%;" >
			    <div  class='key_s' style="position:relative;top:-60px;width: 150px">分析列选择：</div>
			    <div class="value_s">
				    <div style="display:inline-block;">
				        <select multiple="multiple" id="select1" style="width:160px;height:160px;border: 1px solid #a0c3da;font-size: 18px;color: royalblue;"
				        				data-step="1" data-intro="选择你需要进行统计的分析列，注意相应方法处理的数据类型" data-position='right'>
					        <s:iterator value="#session.colnames" id="s" status="st">
					        	<option value="${st.index + 1}"><s:property value='s'/></option>
					        </s:iterator>
				        </select>            
				    </div>
				    <div id='multiSelect' style="display:inline-block;position: relative;top:-20px;margin-left: 5px;"
				    	data-step="2" data-intro="在这里你可以单个选择分析列，也可以选中多个分系列进行移动">
				    	<div><button class='reset' id="add" style="width: 40px">&gt;</button></div>
				    	<div><button class='reset' id="add_all" style="width: 40px">&gt;&gt;</button></div>
				    	<div><button class='reset' id="remove" style="width: 40px">&lt;</button></div>
				    	<div><button class='reset' id="remove_all" style="width: 40px">&lt;&lt;</button>  </div> 
					</div>
					<div style="display:inline-block;">
				        <select multiple="multiple" id="select2" style="width: 160px;height:160px;border: 1px solid #a0c3da;font-size: 18px;color: blueviolet;"
				        	data-step="3" data-intro="这里是你选择的分析列，若选择错误可以将列属性移动回原位">
				        </select>
				    </div>
			    </div>    
			</div>
			
		    <div class='tableList'>
  				<div class='key_s' style="width: 150px">统计信息图类型：</div>
			    <div class='value_s'>
			      <select id="method" data-step="4" data-intro="选择你希望看到的统计图">
		    			<option value="bar">条形图</option>
						<option value="breakline">折线图</option>
						<option value="scatter">散点图</option>
						<option value="scatter3d">3D散点图</option>
						<option value="box">箱线图</option>
		    	  </select>
			    </div>
		    </div>

		   <div style='border-top:1px solid gray;
						position: relative;
						width: 48%;
						margin-left: 25px;
						padding-top:10px;
						text-align: right;
						margin-top: 15px;'>
		    	<button  class="btn add"  type="button" id="button" onclick="stat_analyse()" data-step="5" data-intro="确认参数之后就开始数据分析吧">数据统计</button>
		    </div>
		    
		    <div id="flagimg" style="float:left;width:40%;height:380px;position:absolute;top:58px;right:50px;"><img src="<%=path%>/resources/images/dataIntro/sumData.png"/></div> 
		</div>                   
		
		<div style='position: relative;' >
			<div>
				<div class='opr_title_style' style="width: 110px;top: 18px;">分析结果展示</div>
				<HR SIZE=1 class='uploadhr'/>               
			</div>
			<div>
				<div  class='tableList' style='margin-left:25px;margin-right:25px'>
				    <div id='result'  style='height:500px;width:85%;margin-bottom:5px;margin:0 auto;'>
				   		
				    </div>
				</div>
			</div>
		</div>

	</div>
	<SCRIPT type="text/javascript">
		//if(screen.width<=800){
		//	$("#flagimg").remove();
		//	$(".tableList").attr("style","width:100%");
		//	$("#multiSelect").attr("style","display: inline-block;position: relative;top: 40px;margin-left: 5px;");         
		//}
	</SCRIPT>
	<%--<script type="text/javascript">
		jQuery(document).ready(function($) {
			introJs().start();
		});
	</script>
--%></body>
</html>