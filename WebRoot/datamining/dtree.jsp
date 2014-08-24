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
	<script type="text/javascript" src="<%=path%>/resources/loadmask/jquery.loadmask.min.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/common/core.js"></script>
	
	<link rel="stylesheet" type="text/css" href="<%=path%>/resources/core.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/header.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/forms.css">
	<link href="<%=path%>/resources/loadmask/jquery.loadmask.css" rel="stylesheet" type="text/css"/>	
	<link rel="stylesheet" href="<%=path%>/resources/css/table_css_new.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/table.css" type="text/css"></link>
	<link rel="stylesheet" href="<%=path%>/resources/css/tab.css" type="text/css"></link>
	
	<style type="text/css">
		.hint {
		  font-size: 12px;
		  color: #999;
		}
		
		.node rect {
		  cursor: pointer;
		  fill: #fff;
		  /*stroke-width: 1.5px;*/
		  stroke-width:1px;
		}
		
		.node text {
		  font-size: 11px;
		}
		
		path.link {
		  fill: none;
		  stroke: #ccc;
		}
		
		.decideTreeTitle,.rocGraphTitle{
			display:inline-block;
		}
		
		.decideTreeTitle:hover,.rocGraphTitle:hover{
			cursor:pointer;
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
	<%--<script type="text/javascript">
		jQuery(document).ready(function($) {
			introJs().start();
		});
	</script>
--%></head>
	<script type="text/javascript" src="<%=path%>/resources/jquery.jqprint.js"></script>
<body>
	<jsp:include page="../common/header.jsp" flush="true"/>
	<jsp:include page="../common/leftmenu.jsp" flush="true"/>
	<jsp:include page="../common/bottom.jsp" flush="true"/>
	
	<div id="content_template" class="content">
		<div>
			<div class='opr_title_style' style="width: 100px">决策树分析</div>
			<HR SIZE=1 class='uploadhr'/>
		</div>
		<div id="main">
			<div  class='tableList' style="width:50%;">
			    <div  class='key_s' style="position:relative;top:-60px;width: 150px">分析列选择：</div>
			    <div class="value_s">
				    <div style="display:inline-block;">
				        <select multiple="multiple" id="select1" style="width:160px;height:160px;border: 1px solid #a0c3da;font-size: 18px;color: royalblue;"
				        	data-step="1" data-intro="选择你需要进行决策树分析的分析列 ">
					        <s:iterator value="#session.colnames" id="s" status="st">
					        	<option value="${st.index + 1}"><s:property value='s'/></option>
					        </s:iterator>
				        </select>
				    </div>
				    <div id="move" style="display:inline-block;position: relative;top:-20px;margin-left: 5px;"
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
  				<div class='key_s' style="width: 150px">输出属性选择：</div>
			    <div class='value_s'>
			       <SELECT id="outputline" data-step="4" data-intro="选择输出属性" data-position="right">
						<s:iterator value="#session.colnames" id="s" status="st">
       						<option value="<s:property value='s'/>"><s:property value='s'/></option>
       					</s:iterator>
				   </SELECT>
			    </div>
			    <div style='position: relative;
			    		border-top:1px solid gray;
						width: 45%;
						margin-left: 25px;
						padding-top:10px;
						text-align: right;
						margin-top: 15px;'>
		    	<button  class="btn add"  type="button" id="button" onclick="dtree_analyse()" data-step="5" data-intro="开始决策树分析" data-position="right">决策树分析</button>
		    	</div>           
		    </div>

			<div id="flagimg" style="float:left;width:40%;height:340px;position:absolute;top:40px;right:68px;background:url(<%=path%>/resources/images/dataIntro/decideTree.png);background-repeat:no-repeat;"></div>     

		</div>
		
		
		<div style='position: relative;'>     
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
					<div id='dtree' class='div_image' title="决策树"></div>
				</li>
				<li class="tabOption" related-id='result2'>
					<div id='table' class='div_image' title="概率预测矩阵"></div>
				</li>
				<li class="tabOption" related-id='result3'>
					<div id='curvegraph' class='div_image' title="ROC曲线"></div>
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
						$("#tree").attr("style","display:none");
						$("#forecast").attr("style","display:none");
						$("#roc").attr("style","display:none");
						if(related_id=="result1"){
							$("#tree").attr("style","display:visible");
						}
						else if(related_id=="result2"){
							$("#forecast").attr("style","display:visible");
						}
						else if(related_id=="result3"){
							$("#roc").attr("style","display:visible");
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
	
	<script type="text/javascript"  src="<%=path%>/resources/js/d3.v2.js"></script>
	<script src="<%=path%>/resources/qtip/qtip.js"></script>
	<SCRIPT type="text/javascript" src="<%=path%>/analyse_js/classification.js"></SCRIPT>
	<script type="text/javascript">      

		var m = [20, 120, 20, 120],
		    w = 1280 - m[1] - m[3],
		    h = 800 - m[0] - m[2],
		    i = 0,
		    rect_width = 80,
		    rect_height = 20,
		    max_link_width = 20,
		    min_link_width = 1.5,
		    char_to_pxl = 6,
		    root;

	    //var tree,diagonal,vis, link_stoke_scale,color_map,stroke_callback;
		var tree = d3.layout.tree()
		    .size([h, w]);
		
		var diagonal = d3.svg.diagonal()
		    .projection(function(d) { return [d.x, d.y]; });
		
		var vis = null;
		
		// global scale for link width
		var link_stoke_scale = d3.scale.linear();
		
		var color_map = d3.scale.category10();
		
		// stroke style of link - either color or function
		//var stroke_callback = "#ccc";
		var stroke_callback = "#3399ff";

		//d3.json("iris2.json", load_dataset);
		// Add datasets dropdown

		function load_dataset(json) {

			vis = d3.select("#tree").append("svg:svg")
			    .attr("width", w + m[1] + m[3])
			    .attr("height", h + m[0] + m[2] + 1000)
			    .append("svg:g")
			    .attr("transform", "translate(" + m[3] + "," + m[0] + ")");

		    
			  root = json;
			  root.x0 = 0;
			  root.y0 = 0;
			
			  var n_samples = root.samples;
			  var n_labels = root.value.length;
			
			  if (n_labels >= 2) {
			    stroke_callback = mix_colors;
			  } else if (n_labels === 1) {
			    stroke_callback = mean_interpolation(root);
			  }
			
			  link_stoke_scale = d3.scale.linear()
			                             .domain([0, n_samples])
			                             .range([min_link_width, max_link_width]);
			
			  function toggleAll(d) {
			    if (d && d.children) {
			      d.children.forEach(toggleAll);
			      toggle(d);
			    }
			  }
			
			  // Initialize the display to show a few nodes.
			  root.children.forEach(toggleAll);
			
			  update(root);
		}

		function update(source) {
			  var duration = d3.event && d3.event.altKey ? 5000 : 500;
			
			  // Compute the new tree layout.
			  var nodes = tree.nodes(root).reverse();
			
			  // Normalize for fixed-depth.
			  nodes.forEach(function(d) { d.y = d.depth * 180; });

<%--			  vis = d3.select("#result").append("svg:svg")--%>
<%--			    .attr("width", w + m[1] + m[3])--%>
<%--			    .attr("height", h + m[0] + m[2] + 1000)--%>
<%--			    .append("svg:g")--%>
<%--			    .attr("transform", "translate(" + m[3] + "," + m[0] + ")");--%>
			
			  // Update the nodes…
			  var node = vis.selectAll("g.node")
			      .data(nodes, function(d) { return d.id || (d.id = ++i); });
			
			  // Enter any new nodes at the parent's previous position.
			  var nodeEnter = node.enter().append("svg:g")
			      .attr("class", "node")
			      .attr("transform", function(d) { return "translate(" + source.x0 + "," + source.y0 + ")"; })
			      .on("click", function(d) { toggle(d); update(d); });
			
			  nodeEnter.append("svg:rect")
			      .attr("x", function(d) {
			        var label = node_label(d);
			        var text_len = label.length * char_to_pxl+8;
			        var width = d3.max([rect_width, text_len])
			        return -width / 2;
			      })
			      .attr("width", 1e-6)
			      .attr("height", 1e-6)
			      .attr("rx", function(d) { return d.type === "split" ? 2 : 0;})
			      .attr("ry", function(d) { return d.type === "split" ? 2 : 0;})
			      //.style("stroke", function(d) { return d.type === "split" ? "steelblue" : "olivedrab";})
			      .style("stroke", function(d) { return d.type === "split" ? "#3399ff" : "#ff9933";})
			      //.style("fill", function(d) { return d._children ? "lightsteelblue" : "#fff"; });
			  	  .style("fill", function(d) { return d._children ? "rgb(230,230,230)" : "#fff"; })
			  	  
			
			  nodeEnter.append("svg:text")
			      .attr("dy", "14px")
			      //.attr("x",function(d){return d.x+2});//自己加的
			      .attr("text-anchor", "middle")
			      .text(node_label)
			      .style("fill", function(d) { return d._children ? "#000EAD" : "#D50000"; })
			      .style("fill-opacity", 1e-6);

			  nodeEnter.append("svg:text")
			      .attr("class","text_yes")
			      .attr("dy", "40px")
			      .attr("dx",function(d) {
				        var label = node_label(d);
				        var text_len = label.length * char_to_pxl;
				        var width = d3.max([rect_width, text_len])
				        //return width / 2-10;
				        return 40;
				      })
			      //.attr("x",function(d){return d.x+2});//自己加的
			      .attr("text-anchor", "middle")
			      .text("YES")
			      .style("fill", function(d) { return d._children ? "#000EAD" : "#D50000"; })
			      .style("fill-opacity", function(d) { 
			    	      if(d.type!="leaf" && !d._children){
						   	 return 1;
						  }
					      else if(d.type!="leaf" && d._children){
							  return 0;
						  }
					      return 0; 
				  });

			  nodeEnter.append("svg:text")
			  	  .attr("class","text_yes")
			      .attr("dy", "40px")
			      .attr("dx",function(d) {
				        var label = node_label(d);
				        var text_len = label.length * char_to_pxl;
				        var width = d3.max([rect_width, text_len])
				        //return width / 2-10;
				        return -40;
				      })
			      //.attr("x",function(d){return d.x+2});//自己加的
			      .attr("text-anchor", "middle")
			      .text("NO")
			      .style("fill", function(d) { return d._children ? "#000EAD" : "#D50000"; })
			      .style("fill-opacity", function(d) {
				      if(d.type!="leaf" && !d._children){
					   	 return 1;
					  }
				      else if(d.type!="leaf" && d._children){
						  return 0;
					  }
				      return 0; 
				   });

			  d3.selectAll(".text_yes")
			  	.transition()
		      	.duration(duration)
		      	.style("fill", function(d) { return d._children ? "#000EAD" : "#D50000"; })
			  	.style("fill-opacity", function(d) {
			       if(d.type!="leaf" && !d._children){
					   	 return 1;
					  }
				      else if(d.type!="leaf" && d._children){
						  return 0;
					  }
				      return 0; 
				  });
			
			  // Transition nodes to their new position.
			  var nodeUpdate = node.transition()
			      .duration(duration)
			      .attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });
			
			  nodeUpdate.select("rect")
			      .attr("width", function(d) {
			        var label = node_label(d);
			        var text_len = label.length * char_to_pxl;
			        var width = d3.max([rect_width+10, text_len+10])
			        return width;
			      })
			      .attr("height", rect_height)
			      //.style("fill", function(d) { return d._children ? "lightsteelblue" : "#fff"; });
			  	  .style("fill", function(d) { return d._children ? "rgb(230,230,230)" : "#fff"; });
			
			  nodeUpdate.select("text")
			  	  .style("fill", function(d) { return d._children ? "#000EAD" : "#D50000"; })
			      .style("fill-opacity", 1);
			
			  // Transition exiting nodes to the parent's new position.
			  var nodeExit = node.exit().transition()
			      .duration(duration)
			      .attr("transform", function(d) { return "translate(" + source.x + "," + source.y + ")"; })
			      .remove();
			
			  nodeExit.select("rect")
			      .attr("width", 1e-6)
			      .attr("height", 1e-6);
			
			  nodeExit.select("text")
			      .style("fill-opacity", 1e-6);
			
			  // Update the links
			  var link = vis.selectAll("path.link")
			      .data(tree.links(nodes), function(d) { return d.target.id; });
			
			  // Enter any new links at the parent's previous position.
			  link.enter().insert("svg:path", "g")
			      .attr("class", "link")
			      .attr("d", function(d) {
			        var o = {x: source.x0, y: source.y0};
			        return diagonal({source: o, target: o});
			      })
			      .transition()
			      .duration(duration)
			      .attr("d", diagonal)
			      .style("stroke-width", function(d) {return link_stoke_scale(d.target.samples);})
			      .style("stroke", stroke_callback);
			
			  // Transition links to their new position.
			  link.transition()
			      .duration(duration)
			      .attr("d", diagonal)
			      .style("stroke-width", function(d) {return link_stoke_scale(d.target.samples);})
			      .style("stroke", stroke_callback);
			
			  // Transition exiting nodes to the parent's new position.
			  link.exit().transition()
			      .duration(duration)
			      .attr("d", function(d) {
			        var o = {x: source.x, y: source.y};
			        return diagonal({source: o, target: o});
			      })
			      .remove();
			
			  // Stash the old positions for transition.
			  nodes.forEach(function(d) {
			    d.x0 = d.x;
			    d.y0 = d.y;
			  });
		}

		// Toggle children.
		function toggle(d) {
		  if (d.children) {
		    d._children = d.children;
		    d.children = null;
		  } else {
		    d.children = d._children;
		    d._children = null;
		  }
		}

		// Node labels
		function node_label(d) {
		  if (d.type === "leaf") {
		    // leaf
		    var formatter = d3.format(".2f");
		    var vals = [];
		    d.value.forEach(function(v) {
		        vals.push(formatter(v));
		    });
		    return "[" + vals.join(", ") + "]";
		  } else {
		    // split node
		    return d.label;
		  }
		}

		/**
		 * Mixes colors according to the relative frequency of classes.
		 */
		function mix_colors(d) {
		  var value = d.target.value;
		  var sum = d3.sum(value);
		  var col = d3.rgb(0, 0, 0);
		  value.forEach(function(val, i) {
		    var label_color = d3.rgb(color_map(i));
		    var mix_coef = val / sum;
		    col.r += mix_coef * label_color.r;
		    col.g += mix_coef * label_color.g;
		    col.b += mix_coef * label_color.b;
		  });
		  return col;
		}


		/**
		 * A linear interpolator for value[0].
		 *
		 * Useful for link coloring in regression trees.
		 */
		function mean_interpolation(root) {

		  var max = 1e-9,
		      min = 1e9;

		  function recurse(node) {
		    if (node.value[0] > max) {
		      max = node.value[0];
		    }

		    if (node.value[0] < min) {
		      min = node.value[0];
		    }

		    if (node.children) {
		      node.children.forEach(recurse);
		    }
		  }
		  recurse(root);

		  var scale = d3.scale.linear().domain([min, max])
		                               .range(["#2166AC","#B2182B"]);

		  function interpolator(d) {
		    return scale(d.target.value[0]);
		  }

		  return interpolator;
		}

    </script>
	<SCRIPT type="text/javascript">

	</SCRIPT>
</body>
</html>