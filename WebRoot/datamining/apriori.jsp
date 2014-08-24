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
	<link rel="stylesheet" type="text/css" href="<%=path%>/resources/core.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/header.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/forms.css">
	<link href="<%=path%>/resources/loadmask/jquery.loadmask.css" rel="stylesheet" type="text/css"/>	
	<script type="text/javascript" src="<%=path%>/resources/jquery-1.8.0.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/loadmask/jquery.loadmask.min.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/common/core.js"></script>
	
	<script type="text/javascript" src="<%=path%>/resources/d3.js"></script>

	<script type="text/javascript" src="<%=path%>/resources/datavjs/deps/d3.min.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/datavjs/deps/d3.csv.js"></script>
    <script type="text/javascript" src="<%=path%>/resources/datavjs/deps/d3.layout.min.js"></script>
    <script type="text/javascript" src="<%=path%>/resources/datavjs/deps/raphael.min.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/datavjs/deps/eventproxy.js"></script>
    <script type="text/javascript" src="<%=path%>/resources/datavjs/deps/seajs/sea.js"></script>
	<link rel="stylesheet" href="<%=path%>/resources/css/table.css" type="text/css"></link>    
	<link rel="stylesheet" href="<%=path%>/resources/css/tab.css" type="text/css"></link>
	<link rel="stylesheet" href="<%=path%>/resources/css/tic_tac_toe.css" type="text/css"></link>
	
	<style type="text/css">
		svg {
		  font-size: 14px;
		}
		
		.foreground path {
		  fill: none;
		  stroke-opacity: .5;
		  stroke-width: 1.5px;
		}
		
		.foreground path.fade {
		  stroke: #000;
		  stroke-opacity: .05;
		}
		
		.legend {
		  font-size: 18px;
		  font-style: oblique;
		}
		
		.legend line {
		  stroke-width: 2px;
		}
		
		.setosa {
		  stroke: #800;
		}
		
		.versicolor {
		  stroke: #080;
		}
		
		.virginica {
		  stroke: #008;
		}
		
		.lineColor {
		  /*stroke: #3399ff;*/
		  stroke: rgb(193,58,253);
		}
		
		.brush .extent {
		  fill-opacity: .3;
		  stroke: #fff;
		  shape-rendering: crispEdges;
		}
		
		.axis line, .axis path {
		  /*fill: none;*/
		  stroke: #000;
		  shape-rendering: crispEdges;
		  fill-opacity: 0;
		  /*stroke-width: 0;*/     
		}
		
		.axis text {
		  text-shadow: 0 1px 0 #fff;
		  cursor: move;
		}
		
		.noSelectBg{
			background:url(<%=path%>/resources/images/circle.png);
			background-repeat:no-repeat;         
		}   
		.selectBg{
			background:url(<%=path%>/resources/images/circle_select.png);         
			background-repeat:no-repeat;     
		} 
		.selectBg:hover{
			background:url(<%=path%>/resources/images/circle_select_hover.png);         
			background-repeat:no-repeat;     
			cursor:pointer;                  
		}  
		.circleIcon{
			background:url(<%=path%>/resources/images/circleIcon.png); 
			background-repeat:no-repeat;  
			text-indent:25px;  
			display: inline-block; 
			color: #464646;           
		}   
		.circleSelectIcon{     
			background:url(<%=path%>/resources/images/circle_selectIcon.png); 
			background-repeat:no-repeat;  
			text-indent:25px;              
			display: inline-block;      
			color: #464646;         
		}   
		.lookAttrLocation{
			display:inline-block;
			text-indent:25px; 
			font-family: "微软雅黑";
			font-weight: bold;
			color: #2F4813;
			position: absolute;
			left: 2px;
			font-size: 14px;
			background:url(<%=path%>/resources/images/lookAttrLocation.png);
			background-repeat:no-repeat;    
		}  
		.lookAttrLocation:hover{
			cursor:pointer;
			color:#86c440;
		}
		
		.associalHeadTitle,.singleHeadTitle,.verticalHeadTitle,.paraHeadTitle{
			display:inline-block;
		}
		.associalHeadTitle:hover,.singleHeadTitle:hover,.verticalHeadTitle:hover,.paraHeadTitle:hover{       
			cursor:pointer;          
		}  
		
		#easydialogBar{
			position:relative;
			display: block;
			text-align: center;
			position: absolute;
			background-color: rgb(255, 255, 255);
			top: 50px;
			right: 50px;
			height: 400px;
			left: 50px;
			border-radius: 15px;
			width:750px;         
			height:430px;
			background:#fff; 
			padding-left:20px;     
			box-shadow: rgba(158, 199, 245, 0.4) 0px 2px 2px inset, rgba(158, 199, 245, 0.4) 0px 1px 5px inset, rgba(158, 199, 245, 0.4) 0px 0px 0px 12px inset;
		}  
    </style>           
    
	<script type="text/javascript">
	var spath="<%=path%>";
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
	<link href="<%=path%>/resources/introjs/introjs.css" rel="stylesheet">
	<script type="text/javascript" src="<%=path%>/resources/introjs/intro.js"></script>
	<script src="<%=path%>/resources/echartsjs/echarts-plain.js"></script>
	
	<%--<script type="text/javascript">
		jQuery(document).ready(function($) {
			introJs().start();
		});
	</script>
--%></head>

<body>
	<jsp:include page="../common/header.jsp" flush="true"/>
	<jsp:include page="../common/leftmenu.jsp" flush="true"/>
	<jsp:include page="../common/bottom.jsp" flush="true"/>
	
	<div id="content_template" class="content">
		<div>
			<div class='opr_title_style' style="width: 150px">Apriori关联分析</div>
			<HR SIZE=1 class='uploadhr'/>
		</div>
		<div id="main">
			<div class="tableSelect">
				<div  class='tableList' style="width:50%;">
				    <div  class='key_s' style="position:relative;top:-60px;">分析列选择：</div>
				    <div class="value_s">
					    <div style="display:inline-block;">
					        <select multiple="multiple" id="select1" style="width:160px;height:160px;border: 1px solid #a0c3da;font-size: 18px;color: royalblue;"
					        	data-step="1" data-intro="选择你需要进行关联规则分析的分析列 ">
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
	   					<div class='key_s'>最小支持度：</div>
					    <div class='value_s'>
					      <s:textfield id="lift" name="lift" value="0.1" data-step="4" data-intro="设置最小支持度" data-position="right"></s:textfield>
					    </div>
			   </div>
			   
			   <div class='tableList'>
	   					<div class='key_s'>置  信  度：</div>
					    <div class='value_s'>
					      <s:textfield id="conf" name="conf" value="0.8" data-step="5" data-intro="设置置信度" data-position="right"></s:textfield>
					    </div>
			   </div>
	
			   <div style='border-top:1px solid gray;
							position: relative;
							width: 48%;
							margin-left: 25px;
							padding-top:10px;          
							text-align: right;
							margin-top: 15px;'>
			    	<button  class="btn add"  type="button" id="button" onclick="apriori_analyse()" data-step="6" data-intro="开始关联分析" data-position="right">关联分析</button>
			    </div>
			     <div id="flagimg" style="float:left;width:40%;height:380px;position:absolute;top:45px;right:20px;;opacity:0.8;"><img src="<%=path%>/resources/images/dataIntro/associalRule.png"/></div> 
	
			</div>     
			   
		</div>
		
		<div style='position: relative;' >
			<div>
				<div class='opr_title_style' style="width: 110px;top: 18px;">分析结果展示</div>
				<HR SIZE=1 class='uploadhr'/>
			</div>
			<div>
				<div  class='tableList' style='margin-left:25px;margin-right:25px'>
				    <div id='result'  style='height:500px;width:100%;display:inline-block;margin-bottom:5px;'>
				   		
				    </div>
				</div>
			</div>
		</div>
	</div>
	
	<div id="outerWrap_image" class='outerWrap'>
			<div class="blueline" id="blueline_image" style="top: 0px;"></div>
			<ul class="tabGroup" id='tabGroup_image'>
				<li class="tabOption selectedTab" related-id='result1'>
					<div id='table' class='div_image' title="规则表"></div>
				</li>
				<li class="tabOption" related-id='result2'>
					<div id='parallelgraph' class='div_image' title="平行坐标图"></div>
				</li>
				<li class="tabOption" related-id='result3'>
					<div id='matrix' class='div_image' title="单对单规则"></div>
				</li>
				<li class="tabOption" related-id='result4'>
					<div id='digraph' class='div_image' title="有向图"></div>
				</li>      
			</ul>      
	</div>   
	
	<!-- 新加的弹出框div -->     
	<div id="easydialogBar" style="display:none;">
	<div id="easyDialogTitle" style="width:650px; height:30px;display:inline-block;">       
	</div> 
	<div onclick="easyDialog.close()" style="width:50px; height:30px;display:inline-block;position: absolute;right: 5px;top: 12px;">
			<img src="<%=path%>/resources/images/close.png">              
		</div>        
	<div id='barchart' style="width:700px; height:400px; "></div>
	</div>               
	
	<script type="text/javascript">
		$(document).ready(function(){
			$("ul#tabGroup_image li").each(function(){
				$(this).click(function(){
					var indexs = -1;
					var count = 0;
					$("ul#tabGroup_image li").each(function(){
						$(this).removeClass("selectedTab");
					});//去掉所有的selectedTab
					$(this).addClass("selectedTab");//为本对象添加selectedTab

					$("ul#tabGroup_image li").each(function(){
						indexs++;
						if($(this).attr("class").indexOf("selectedTab")!=-1){
							count = indexs;
						}
					});//
					$("#blueline_image").css("top",(count*48)+"px");

					//这里处理点击后的事件
					var related_id = $(this).attr("related-id");
					var movetothis = function(related_id){
						$("#showrules").attr("style","display:none");
						$("#parallel").attr("style","display:none");
						$("#singletosingle").attr("style","display:none");
						$("#rulesimg").attr("style","display:none");
						if(related_id=="result1"){
							$("#showrules").attr("style","display:visible");
						}
						else if(related_id=="result2"){
							$("#parallel").attr("style","display:visible");
						}
						else if(related_id=="result3"){
							$("#singletosingle").attr("style","display:visible");
						}
						else if(related_id=="result4"){
							$("#rulesimg").attr("style","display:visible");
						}

					}
					movetothis(related_id);
					
				});
			});

			//鼠标移动事件
			$("body").mousemove(function(e){
				var wind_wid = $(window).width(); //浏览器当前窗口可视区域宽度
				var wind_hei = $(window).height(); //浏览器当前窗口可视区域高度
				
				if(e.pageY>72 && e.pageY<72+384){
					if(wind_wid-e.pageX<6){
						$("#outerWrap_image").css("right","0px");
					}
				}

			});

			if(isMobile.any()){
				$("#flagimg").remove();
				$(".tableList").attr("style","width:100%");
				$("#multiSelect").attr("style","display: inline-block;position: relative;top: 40px;margin-left: 5px;");         
				$("#multiSelect1").attr("style","display: inline-block;position: relative;top: 40px;margin-left: 5px;"); 
				$("#multiSelect2").attr("style","display: inline-block;position: relative;top: 40px;margin-left: 5px;");
				$("#move").attr("style","display: inline-block;position: relative;top: 40px;margin-left: 5px;");         
		    }
			else{
				$("body").hover(function(){
					$("#outerWrap_image").css("right","-52px");
				});//content_template
				
				$("#content_template").hover(function(e){
					$("#outerWrap_image").css("right","-52px");
				});//content_template,commonheader

				$("#commonheader").hover(function(){
					$("#outerWrap_image").css("right","-52px");
				});//content_template,commonheader,bottom

				$("#bottom").hover(function(){
					$("#outerWrap_image").css("right","-52px");     
				});//content_template,commonheader,bottom
			}


			//使悬浮栏居中
			var hei = parseInt($("#outerWrap_image").css("height").replace("px",""));
			var top_hei = parseInt($("#commonheader").css("height").replace("px",""));
			var bottom_hei = parseInt($("#bottom").css("height").replace("px",""));
			var ksqy_hei = $(window).height();
			
			$("#outerWrap_image").css("top",((ksqy_hei-top_hei-bottom_hei-hei)/2.0+top_hei)+"px");
			
		});
	</script>
	
	
	<%--<script type="text/javascript">
		seajs.config({
			alias: {
				//'jquery': '/DataVisual/resources/datavjs/deps/jquery-1.7.1.js',
				'datav': '/DataVisual/resources/datavjs/datav.js',
				'matrix': '/DataVisual/resources/datavjs/libs/matrix.js'
			}
		});
		
    </script>
     --%>
	<script type="text/javascript"  src="<%=path%>/resources/js/d3.v2.js"></script>
	<script src="<%=path%>/resources/easydialog/easydialog.js"></script>
	<script src="<%=path%>/resources/qtip/qtip.js"></script>
	<SCRIPT type="text/javascript" src="<%=path%>/analyse_js/apriori.js"></SCRIPT>
	
	<script type="text/javascript">

	var m = [80, 160, 200, 160],
	    w = 1180 - m[1] - m[3],
	    h2 = 800 - m[0] - m[2];

	traits = [],
    col_1 = [];
	col_2 = [];
	var x,y,y_xianshi;

	var traits = ["前件","后件","最小支持度","置信度","提升度"];
    x = d3.scale.ordinal().domain(traits).rangePoints([0, w]);
    y = {};
	y_xianshi = {};

	var flowers = [];

	var line = d3.svg.line(),
	    axis = d3.svg.axis().orient("left"),
	    foreground;
	
	var svg = null;

function drawParallel(allrules,aprinfo){
	x = d3.scale.ordinal().domain(traits).rangePoints([0, w]);
	console.log(allrules);
	console.log(aprinfo);

	var beforeItem = [];
	var afterItem = [];
	var len = allrules.length;
	var baItem = [];
	for(var i=0;i<len;i++){
		baItem = allrules[i].split("=>");
		beforeItem[i] = baItem[0].trim();
		afterItem[i] = baItem[1].trim();
	}
	console.log("第一个位置：");
	console.log(beforeItem);
	console.log(afterItem);
	var beforeItem_set = [];
	var afterItem_set = [];
	for(var i = 0,len = afterItem.length;i < len;i++){ 
		! RegExp(beforeItem[i],"g").test(beforeItem_set.join(",")) && (beforeItem_set.push(beforeItem[i])); 
	}
	for(var i = 0,len = afterItem.length;i < len;i++){ 
		! RegExp(afterItem[i],"g").test(afterItem_set.join(",")) && (afterItem_set.push(afterItem[i])); 
	}
	console.log("第二个位置：");
	console.log(beforeItem_set);
	console.log(afterItem_set);

	//组装数组json
	var c1_map = {};
	var c2_map = {};
	//var c1_array = [];
	//var c2_array = [];
	for(var i=0;i<beforeItem_set.length;i++){
		c1_map[""+beforeItem_set[i]] = i;
		//c1_array[beforeItem_set[i]] = i;
	}
	for(var i=0;i<afterItem_set.length;i++){
		c2_map[""+afterItem_set[i]] = i;
		//c2_array[afterItem_set[i]] = i;
	}
	console.log("第三个位置：");
	console.log(c1_map);
	console.log(c2_map);

	flowers = [];
	var tempObj = {};
	for(var i=0;i<beforeItem.length;i++){
		tempObj = {};
		tempObj["前件"] = c1_map[beforeItem[i].trim()];
		tempObj["后件"] = c2_map[afterItem[i].trim()];
		tempObj["最小支持度"] = aprinfo[i][0];
		tempObj["置信度"] = aprinfo[i][1];
		tempObj["提升度"] = aprinfo[i][2];
		flowers[i] = tempObj;
	}
	console.log("第四个位置：");
	console.log(flowers);

	
    col_1 = beforeItem_set;
	col_2 = afterItem_set;

	//重新规划高度h
	len = beforeItem_set.length;
	h = (h2/20)*len;

	//d3.csv("hf5.csv", function(flowers) {
	//	console.log(flowers);
	//	flowers = this.flowers;
	//	console.log(flowers);
		svg = d3.select("#parallel").append("svg:svg")
	    .attr("width", w + m[1] + m[3])
	    .attr("height", h + m[0] + m[2])
	    .append("svg:g")
	    .attr("transform", "translate(250,30)");

	  // Create a scale and brush for each trait.
	  traits.forEach(function(d) {
	    // Coerce values to numbers.
	    flowers.forEach(function(p) { p[d] = +p[d]; });

	    if(d=="前件"){
	    	y_xianshi[d] = d3.scale.ordinal().domain(col_1).rangePoints([0,h]);
	    	y[d] = d3.scale.linear()
	        .domain(d3.extent(flowers, function(p) { return p[d]; }))
	        .range([0, h]);
	    }
	    else if(d=="后件"){ 
	    	y_xianshi[d] = d3.scale.ordinal().domain(col_2).rangePoints([0,h]);
	    	y[d] = d3.scale.linear()
	        .domain(d3.extent(flowers, function(p) { return p[d]; }))
	        .range([0, h]);
	    }
	    else{
	    	y[d] = d3.scale.linear()
	        .domain(d3.extent(flowers, function(p) { return p[d]; }))
	        .range([h, 0]); 
	    }
	    y[d].brush = d3.svg.brush()
	        .y(y[d])
	        .on("brush", brush);
	 });


	  // Add foreground lines.
	  foreground = svg.append("svg:g")
	      .attr("class", "foreground")
	    .selectAll("path")
	      .data(flowers)
	    .enter().append("svg:path")
	      .attr("d", path_line)//lineColor
	      .attr("class", "lineColor");
	      //.attr("class", function(d) { return d.species; });

	  // Add a group element for each trait.
	  var g = svg.selectAll(".trait")
	      .data(traits)
	    .enter().append("svg:g")
	      .attr("class", "trait")
	      .attr("transform", function(d) { return "translate(" + x(d) + ")"; })
	      .call(d3.behavior.drag()
	      .origin(function(d) { return {x: x(d)}; })
	      .on("dragstart", dragstart)
	      .on("drag", drag)
	      .on("dragend", dragend));

	  // Add an axis and title.
	  g.append("svg:g")
	      .attr("class", "axis")
	      .each(function(d,i){
	          if(i<2)
	          {
	              d3.select(this).style("fill-opacity","0");
	              d3.select(this).style("stroke-width","0");
	          }
	          else
	          {
	              d3.select(this).style("fill-opacity",null);
	          }
	      })
	      .each(function(d) { d3.select(this).call(axis.scale(y[d])); })
	      .append("svg:text")
	      .attr("text-anchor", "middle")
	      .attr("y", -15)
	      .text(String);

	 //Add an axis and title.
	  g.append("svg:g")
	      .attr("class", "axis")
	      .each(function(d,i) {
	          if(i<2){
	        	  d3.select(this).call(axis.scale(y_xianshi[d])); 
	          }
	       })
	      .append("svg:text")
	      .attr("text-anchor", "middle")
	      .attr("y", -15)
	      .text(String);

	  // Add a brush for each axis.
	  g.append("svg:g")
	      .attr("class", "brush")
	      .each(function(d) { d3.select(this).call(y[d].brush); })
	    .selectAll("rect")
	      .attr("x", -8)
	      .attr("width", 16);

	  function dragstart(d) {
	    i = traits.indexOf(d);
	  }

	  function drag(d) {
	    x.range()[i] = d3.event.x;
	    traits.sort(function(a, b) { return x(a) - x(b); });
	    g.attr("transform", function(d) { return "translate(" + x(d) + ")"; });
	    foreground.attr("d", path_line);
	  }

	  function dragend(d) {
	    x.domain(traits).rangePoints([0, w]);
	    var t = d3.transition().duration(500);
	    t.selectAll(".trait").attr("transform", function(d) { return "translate(" + x(d) + ")"; });
	    t.selectAll(".foreground path").attr("d", path_line);
	  }
	//});

	// Returns the path for a given data point.
	function path_line(d) {
	  return line(traits.map(function(p) { return [x(p), y[p](d[p])]; }));
	}
	
	// Handles a brush event, toggling the display of foreground lines.
	function brush() {
	  var actives = traits.filter(function(p) { return !y[p].brush.empty(); }),
	      extents = actives.map(function(p) { return y[p].brush.extent(); });
	  foreground.classed("fade", function(d) {
	    return !actives.every(function(p, i) {
	      return extents[i][0] <= d[p] && d[p] <= extents[i][1];
	    });
	  });
	}

}
     
    </script>
	
    <SCRIPT type="text/javascript">
		
	</SCRIPT>
</body>
</html>