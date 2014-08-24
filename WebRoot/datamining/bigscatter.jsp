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
	<script type="text/javascript" src="<%=path%>/resources/jquery-1.8.0.js"></script>

	<script type="text/javascript" src="<%=path%>/resources/common/core.js"></script>
	
	<script src="<%=path%>/resources/echartsjs/echarts-plain.js"></script>
	
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
			<div class='opr_title_style' style="width: 110px">大规模散点图</div>
			<HR SIZE=1 class='uploadhr'/>
		</div>
		<div id="main" style='height:500px;width:85%;margin-bottom:5px;margin:0 auto;'>
		
		</div>                   
		
	</div>
	
	<script type="text/javascript">
		var option = {
		    tooltip : {
		        trigger: 'axis',
		        showDelay : 0,
		        axisPointer:{
		            type : 'cross',
		            lineStyle: {
		                type : 'dashed',
		                width : 1
		            }
		        }
		    },
		    legend: {
		        data:['sin','cos']
		    },
		    toolbox: {
		        show : true,
		        feature : {
		            dataZoom : {show: true},
		            dataView : {show: true, readOnly: false},
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    xAxis : [
		        {
		            type : 'value',
		            power: 1,
		            precision: 2,
		            scale:true
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value',
		            power: 1,
		            precision: 2,
		            scale:true
		        }
		    ],
		    series : [
		        {
		            name:'sin',
		            type:'scatter',
		            large: true,
		            data: (function () {
		                var d = [];
		                var len = 100000;
		                var x = 0;
		                while (len--) {
		                    x = (Math.random() * 10).toFixed(3) - 0;
		                    d.push([
		                        x,
		                        //Math.random() * 10
		                        (Math.sin(x) - x * (len % 2 ? 0.1 : -0.1) * Math.random()).toFixed(3) - 0
		                    ]);
		                }
		                //console.log(d)
		                return d;
		            })()
		        },
		        {
		            name:'cos',
		            type:'scatter',
		            large: true,
		            data: (function () {
		                var d = [];
		                var len = 100000;
		                var x = 0;
		                while (len--) {
		                    x = (Math.random() * 10).toFixed(3) - 0;
		                    d.push([
		                        x,
		                        //Math.random() * 10
		                        (Math.cos(x) - x * (len % 2 ? 0.1 : -0.1) * Math.random()).toFixed(3) - 0
		                    ]);
		                }
		                //console.log(d)
		                return d;
		            })()
		        }
		    ]
		};

		var myChart = echarts.init(document.getElementById('main'));
		myChart.setOption(option);
	</script>
</body>
</html>