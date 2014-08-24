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
	<link rel="stylesheet" href="<%=path%>/resources/css/table.css" type="text/css"></link>
	<link rel="stylesheet" href="<%=path%>/resources/css/tab.css" type="text/css"></link>
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
		  stroke: #58ADDB;
		}
		
		.versicolor {
		  stroke: #D53F40; 
		}
		
		.virginica {
		  stroke: #9ABC32;
		}
		
		.brush .extent {
		  fill-opacity: .3;
		  stroke: #fff;
		  shape-rendering: crispEdges;
		}
		
		.axis line, .axis path {
		  fill: none;
		  stroke: #000;
		  shape-rendering: crispEdges;
		}
		
		.axis text {
		  text-shadow: 0 1px 0 #fff;
		  cursor: move;
		}


    .axis,
    .frame {
        shape-rendering: crispEdges;
    }

    .axis line {
        stroke: #ddd;
    }

    #scattermatrix .axis path {
        display: none;
    }

    .frame {
        fill: none;
        stroke: #aaa;
    }

    circle {
        fill-opacity: .7;
    }

    circle.hidden {
        fill: #ccc !important;
    }

    .extent {
        fill: #000;
        fill-opacity: .125;
        stroke: #fff;
    }
    
    .centerPointHeadTitle,.matrixHeadTitle,.parallelHeadTitle{
    	display:inline-block;
    }
    .centerPointHeadTitle:hover,.matrixHeadTitle:hover,.parallelHeadTitle:hover{
    	cursor:pointer;
    }
                   

    </style>
		
	<script type="text/javascript" src="<%=path%>/resources/jquery-1.8.0.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/loadmask/jquery.loadmask.min.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/highcharts/highcharts.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/highcharts/highcharts-3d.js"></script>
    <script type="text/javascript" src="<%=path%>/resources/highcharts/modules/exporting.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/common/core.js"></script>
	
	<%--<script type="text/javascript" src="<%=path%>/resources/datavjs/deps/d3.js"></script>
    <script type="text/javascript" src="<%=path%>/resources/datavjs/deps/raphael.js"></script>
    <script type="text/javascript" src="<%=path%>/resources/datavjs/deps/seajs/sea.js"></script>
	--%><script type="text/javascript">
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
	<%--<script type="text/javascript" src="<%=path%>/resources/echartsjs/esl.js"></script>
	<script type="text/javascript">
		jQuery(document).ready(function($) {
			introJs().start();
		});
	</script>
	--%>
	<script src="<%=path%>/resources/qtip/qtip.js"></script>
	<script type="text/javascript" src="<%=path%>/analyse_js/cluster.js"></script>
	
	
</head>

<body>
	<jsp:include page="../common/header.jsp" flush="true"/>
	<jsp:include page="../common/leftmenu.jsp" flush="true"/>
	<jsp:include page="../common/bottom.jsp" flush="true"/>
	
	<div id="content_template" class="content">
		<div>
			<div class='opr_title_style' style="width: 140px">kmeans聚类分析</div>
			<HR SIZE=1 class='uploadhr'/>
		</div>
		<div id="main">
		
			<div  class='tableList' style="width:50%;">
			    <div  class='key_s' style="position:relative;top:-60px">分析列选择：</div>
			    <div class="value_s">
				    <div style="display:inline-block;">
				        <select multiple="multiple" id="select1" style="width:160px;height:160px;border: 1px solid #a0c3da;font-size: 18px;color: royalblue;"
				        	 data-step="1" data-intro="选择你需要进行聚类分析的分析列 ">
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
   					<div class='key_s'>聚  类  数：</div>
				    <div class='value_s'>
				      <s:textfield id="center" name="center" value="3" data-step="4" data-intro="指定聚类数目" data-position="right"></s:textfield>
				    </div>
		    </div>
		   
		    <div class='tableList'>
   					<div class='key_s'>最大迭代次数：</div>
				    <div class='value_s'>
				      <s:textfield id="itermax" name="itermax" value="10" data-step="5" data-intro="设置最大迭代次数" data-position="right"></s:textfield>
				    </div>
		    </div>

		   <div style='border-top:1px solid gray;
						position: relative;
						width: 48%;
						margin-left: 25px;
						padding-top:10px;
						text-align: right;
						margin-top: 15px;'>
		    	<button  class="btn add"  type="button" id="button" onclick="kmeans_analyse()" data-step="6" data-intro="开始聚类分析" data-position="right">聚类分析</button>
		    </div>
			<div id="flagimg" style="float:left;width:40%;height:380px;position:absolute;top:58px;right:50px;opacity:0.6;"><img src="<%=path%>/resources/images/dataIntro/cluster.png"/></div>     
		</div>
		
		
		<div style='position: relative;'  >
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
			<div class="blueline" id="blueline_image" style="top: 144px;"></div>
			<ul class="tabGroup" id='tabGroup_image'>
				<li class="tabOption selectedTab" related-id='result1' >
					<div id='pie' class='div_image' title="饼图"></div>
				</li>
				<li class="tabOption" related-id='result2'>
					<div id='table' class='div_image' title="最佳中心点"></div>
				</li>
				<li class="tabOption" related-id='result3'>
					<div id='gplotmatrix' class='div_image' title="散点矩阵"></div>
				</li>
				<li class="tabOption" related-id='result4'>
					<div id='parallelgraph' class='div_image' title="平行坐标图"></div>
				</li>
			</ul> 
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
							$("#piechart").attr("style","display:none");
							//$("#piediv").attr("style","display:none");
							//$("#bardiv").attr("style","display:none");
							$("#clusterinfo").attr("style","display:none");
							$("#scattermatrix").attr("style","display:none");
							$("#parallel").attr("style","display:none");
							if(related_id=="result1"){
								$("#piechart").attr("style","display:block");
								//$("#piediv").attr("style","display:block");
								//$("#bardiv").attr("style","display:block");
							}
							else if(related_id=="result2"){
								$("#clusterinfo").attr("style","margin:0 auto;display:block");
							}
							else if(related_id=="result3"){
								$("#scattermatrix").attr("style","margin:0 auto;display:block");
							}
							else if(related_id=="result4"){
								$("#parallel").attr("style","margin:0 auto;display:block");
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
	            'datav': '/DataVisual/resources/datavjs/datav.js',
	            'scatterplotMatrix': '/DataVisual/resources/datavjs/libs/scatterplotMatrix.js'
	        }
	    });
    </script>
    --%>
    <script type="text/javascript"  src="<%=path%>/resources/js/d3.v2.js"></script>
	
	<script type="text/javascript">

	//var species = ["setosa", "versicolor", "virginica"],
	var species = [],
	    traits = [],
		//traits = ["sepal length", "petal length", "sepal width", "petal width"];
		flowers = [];
	
	var m = [80, 160, 200, 160],
	    w = 1180 - m[1] - m[3],
	    h = 800 - m[0] - m[2];
	
	var x = d3.scale.ordinal().domain(traits).rangePoints([0, w]),
	    y = {};
	
	var line = d3.svg.line(),
	    axis = d3.svg.axis().orient("left"),
	    foreground;
	
	var svg = null;

	var color20b = d3.scale.category10();
	var clusterType = 1;
	
	//Returns the path for a given data point.
	function path(d) {
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

 function drawCluster(datashow){
	 console.log(datashow);

	 //重置clusterType
	 clusterType = datashow[0][datashow[0].length-1];
	 
	//首先重置species--
	var beforeItem_set = [];
	var sub_len = datashow[0].length-1;
	for(var i = 1,len = datashow.length;i < len;i++){ 
		! RegExp(datashow[i][sub_len],"g").test(beforeItem_set.join(",")) && (beforeItem_set.push(datashow[i][sub_len])); 
	}
	species = [];
	for(var i=0,len=beforeItem_set.length;i<len;i++){
		beforeItem_set[i] = parseInt(beforeItem_set[i]);
		//species[i] = "聚类簇"+beforeItem_set[i];
		species[i] = beforeItem_set[i];
	}
	console.log(beforeItem_set);
	console.log(species);

	//重置traits
	for(var i=0;i<=sub_len-1;i++){
		traits[i] = datashow[0][i].trim();
	}
	console.log(traits);

	//重置x轴
	x = d3.scale.ordinal().domain(traits).rangePoints([0, w]);

	//重置flowers
	flowers = [];
	var obj_f = {};
	for(var i=1;i<datashow.length;i++){
		obj_f = {};
		for(var j=0;j<datashow[0].length;j++){
			obj_f[datashow[0][j].trim()] = datashow[i][j];
		}
		flowers[i-1] = obj_f;
	}
//	console.log(flowers);
	
	 svg = d3.select("#parallel").append("svg:svg")
	    .attr("width", w + m[1] + m[3])
	    .attr("height", h + m[0] + m[2])
	    .append("svg:g").attr("class","no_legend")
	    .attr("transform", "translate(" + m[3] + "," + m[0] + ")");

	  traits.forEach(function(d) {
	    // Coerce values to numbers.
	    flowers.forEach(function(p) {p[d] = +p[d];});
	 });

	  // Create a scale and brush for each trait.
	  traits.forEach(function(d) {
	    y[d] = d3.scale.linear()
	        .domain(d3.extent(flowers, function(p) {return p[d]; }))
	        .range([h, 0]);

	    y[d].brush = d3.svg.brush()
	        .y(y[d])
	        .on("brush", brush);
	 });

	  // Add a legend.
	  var legend_all = svg.selectAll("g.legend")
	      .data(species);
	      
	  var legend = legend_all.enter().insert("svg:g",".no_legend")
	      .attr("class", "legend")
	      .style("pointer-events","all")
	      .style("cursor","pointer")
	      .attr("transform", function(d, i) { return "translate("+(i*130)+","+(h+25)+")"; }).on("click",function(){
		      console.log($(d3.event.target)[0]);
		      var cl = $($(d3.event.target)[0]).attr("class");
		      $("."+cl).each(function(){
					if($(this).css("stroke-opacity")!=undefined && $(this).css("stroke-opacity")<=0){
						$(this).removeAttr("style");
					}
					else{
						$(this).css("stroke-opacity","0");
					}
			  });
			 //$("."+cl).css("stroke-opacity","0");
		      var col = $("#"+cl).attr("stroke");
		      if(col=="gray"){
				 d3.select("#"+cl).attr("stroke",function(d){return color20b(d)});
			  }
		      else{
		    	  d3.select("#"+cl).attr("stroke","gray");
			  }
		      d3.select("#"+cl).style("stroke-opacity","1");
		   });

	  legend.append("svg:rect") 
	      .attr("id", function(d){return "class_"+d})
  		  .attr("class", function(d){return "class_"+d})
  		  .attr("x",0)
  		  .attr("y",0)
  		  .attr('width', 35)
    	  .attr('height', 20)
  		  .attr("fill", function(d){return color20b(d)});

	  legend.append("svg:text")
	      .attr("x",40)
  		  .attr("y",14)
		  .attr("class", function(d){return "class_"+d})
		  .text(function(d) { return "聚类簇 " + d; });

	  legend_all.exit().remove();

	  // Add foreground lines.
	  foreground = svg.append("svg:g")
	      .attr("class", "foreground")
	    .selectAll("path")
	      .data(flowers)
	    .enter().append("svg:path")
	      .attr("d", path)
	      .attr("class", function(d) { return "class_"+d.clustertype; })
	      .attr("stroke", function(d) { return color20b(parseInt(d[clusterType])); });

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
	      .each(function(d) { d3.select(this).call(axis.scale(y[d])); })
	    .append("svg:text")
	      .attr("text-anchor", "middle")
	      .attr("y", -9)
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
	    foreground.attr("d", path);
	  }

	  function dragend(d) {
	    x.domain(traits).rangePoints([0, w]);
	    var t = d3.transition().duration(500);
	    t.selectAll(".trait").attr("transform", function(d) { return "translate(" + x(d) + ")"; });
	    t.selectAll(".foreground path").attr("d", path);
	  }
 }

    </script>
    
    <script type="text/javascript"  src="<%=path%>/resources/js/d3.v3.min.js"></script>
    
    <script type="text/javascript">
		function drawScatterMatrix(data){
			var width = 960,
		    size = 150,
		    padding = 19.5;

			var x = d3.scale.linear()
			    .range([padding / 2, size - padding / 2]);
	
			var y = d3.scale.linear()
			    .range([size - padding / 2, padding / 2]);
	
			var xAxis = d3.svg.axis()
			    .scale(x)
			    .orient("bottom")
			    .ticks(5);
	
			var yAxis = d3.svg.axis()
			    .scale(y)
			    .orient("left")
			    .ticks(5);
	
			var color = d3.scale.category20();

				//首先重置species--
				var clustertype = [];
				for(var i = 1,len = data.length;i < len;i++){ 
					! RegExp(data[i]["clustertype"],"g").test(clustertype.join(",")) && (clustertype.push(data[i]["clustertype"])); 
				}
				console.log(clustertype);
				
			  //console.log(data);
			  var domainByTrait = {},
			      traits = d3.keys(data[0]).filter(function(d) { return d !== "clustertype"; }),
			      n = traits.length;
	
			  traits.forEach(function(trait) {
			    domainByTrait[trait] = d3.extent(data, function(d) { return d[trait]; });
			  });
			  //console.log(domainByTrait);
	
			  xAxis.tickSize(size * n);
			  yAxis.tickSize(-size * n);
	
			  var brush = d3.svg.brush()
			      .x(x)
			      .y(y)
			      .on("brushstart", brushstart)
			      .on("brush", brushmove) 
			      .on("brushend", brushend);
	
			  var svg = d3.select("#scattermatrix").append("svg")
			      .attr("width", size * (n+2) + padding)
			      .attr("height", size * n + padding)
			      .style("padding",10)
			      .append("g")
			      .attr("transform", "translate(" + padding + "," + padding / 2 + ")");
	
			  //画出图例
			  var legend = svg.selectAll("g.legend")
			  				  .data(clustertype)
			  				  .enter().append("g")
			  				  .attr("class","legend")
			  				  .style("pointer-events","all")
				      		  .style("cursor","pointer")
				      		  .attr("transform", function(d, i) { return "translate("+(size*n+25)+"," + (size*n-i*30-padding) + ")"; })
				      		  .on("click",function(){
				    		      var cl = $($(d3.event.target)[0]).attr("class");
				    		      cl = cl.replace("_label","");
				    		      $("."+cl).each(function(){
				    					if($(this).css("fill-opacity")!=undefined && $(this).css("fill-opacity")<=0){
					    					var curCol = $(this).css("fill");
				    						$(this).removeAttr("style");
				    						$(this).css("fill",curCol);
				    					}
				    					else{
				    						$(this).css("fill-opacity","0");
				    					}
				    			  });
				    		      var col = $("#"+cl).attr("fill");
				    		      if(col=="gray"){
				    				 d3.select("#"+cl).attr("fill",function(d){return color(d)});
				    			  }
				    		      else{
				    		    	  d3.select("#"+cl).attr("fill","gray");
				    			  }
				    		      d3.select("#"+cl).style("fill-opacity","1");
				    		   });;
				  
			  legend.append("svg:rect") 
				    .attr("id", function(d){return "class_"+d})
			  		.attr("class", function(d){return "class_"+d})
			  		.attr("x",0)
			  		.attr("y",0)
			  		.attr('width', 35)
			    	.attr('height', 20)
			  		.attr("fill", function(d){return color(d)})
				  
			  legend.append("svg:text")
			  		.attr("x",40)
			  		.attr("y",14)
					.attr("class", function(d){return "class_"+d+"_label"})
					.text(function(d) { return "聚类簇 " + d.trim(); });
	
			  svg.selectAll(".x.axis")
			      .data(traits)
			      .enter().append("g")
			      .attr("class", "x axis")
			      .attr("transform", function(d, i) { return "translate(" + (n - i - 1) * size + ",0)"; })
			      .each(function(d) { x.domain(domainByTrait[d]); d3.select(this).call(xAxis); });
	
			  svg.selectAll(".y.axis")
			      .data(traits)
			      .enter().append("g")
			      .attr("class", "y axis")
			      .attr("transform", function(d, i) { return "translate(0," + i * size + ")"; })
			      .each(function(d) { y.domain(domainByTrait[d]); d3.select(this).call(yAxis); });
	
			  var cell = svg.selectAll(".cell")
			      .data(cross(traits, traits))
			      .enter().append("g")
			      .attr("class", "cell")
			      .attr("transform", function(d) { return "translate(" + (n - d.i - 1) * size + "," + d.j * size + ")"; })
			      .each(plot);
	
			  // Titles for the diagonal.
			  cell.filter(function(d) { return d.i === d.j; }).append("text")
			      .attr("x", padding)
			      .attr("y", padding)
			      .attr("dy", ".71em")
			      .text(function(d) { return d.x; });
	
			  cell.call(brush);
	
			  function plot(p) {
			    var cell = d3.select(this);
			    //console.log(p);
			    x.domain(domainByTrait[p.x]);
			    y.domain(domainByTrait[p.y]);
	
			    cell.append("rect")
			        .attr("class", "frame")
			        .attr("x", padding / 2)
			        .attr("y", padding / 2)
			        .attr("width", size - padding)
			        .attr("height", size - padding);
	
			    cell.selectAll("circle")
			        .data(data)
			        .enter().append("circle")
			        .attr("cx", function(d) { return x(d[p.x]); })
			        .attr("cy", function(d) { return y(d[p.y]); })
			        .attr("r", 3)
			        .attr("class",function(d) {return "class_"+d.clustertype; })
			        .style("fill", function(d) {return color(d.clustertype); });
			  }
	
			  var brushCell;
	
			  // Clear the previously-active brush, if any.
			  function brushstart(p) {
			    if (brushCell !== this) {
			      d3.select(brushCell).call(brush.clear());
			      x.domain(domainByTrait[p.x]);
			      y.domain(domainByTrait[p.y]);
			      brushCell = this;
			    }
			  }
	
			  // Highlight the selected circles.
			  function brushmove(p) {
			    var e = brush.extent();
			    svg.selectAll("circle").classed("hidden", function(d) {
			      return e[0][0] > d[p.x] || d[p.x] > e[1][0]
			          || e[0][1] > d[p.y] || d[p.y] > e[1][1];
			    });
			  }
	
			  // If the brush is empty, select all circles.
			  function brushend() {
			    if (brush.empty()) svg.selectAll(".hidden").classed("hidden", false);
			  }
	
			  function cross(a, b) {
			    var c = [], n = a.length, m = b.length, i, j;
			    for (i = -1; ++i < n;) for (j = -1; ++j < m;) c.push({x: a[i], i: i, y: b[j], j: j});
			    //console.log(c);
			    return c;
			  }
	
			  d3.select(self.frameElement).style("height", size * n + padding + 20 + "px");
		}
	</script>
    
    <SCRIPT type="text/javascript">
               
	</SCRIPT>         
	
</body>
</html>