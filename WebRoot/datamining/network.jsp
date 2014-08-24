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
	
	<style>
		.node {
		  /*stroke: #666;
		  stroke-width: 1.5px;*/
		}
		
		.chord path {
		  fill-opacity: .67;
		  stroke: #000;
		  stroke-width: .5px;
		}
	
	</style>
	
	

	
	<!-- jquery及jquery-ui资源-->
	<link rel="stylesheet" href="<%=path%>/resources/jquery-ui-1.7.3.custom.css" type="text/css">
	<script type="text/javascript" src="<%=path%>/resources/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="<%=path%>/resources/jquery-ui-1.7.3.custom.min.js"></script>
	
	<script type="text/javascript" src="<%=path%>/resources/common/core.js"></script>
	
	<link href="<%=path%>/resources/loadmask/jquery.loadmask.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="<%=path%>/resources/loadmask/jquery.loadmask.min.js"></script>
	
	<link rel="stylesheet" href="<%=path%>/resources/css/table_css_new.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/table.css" type="text/css"></link>
	<link rel="stylesheet" href="<%=path%>/resources/css/tab.css" type="text/css"></link>
	
	<script type="text/javascript">
	var spath="<%=path%>";
	$(function(){

		$("#namedialog").dialog( {
			autoOpen : false,
			closeOnEscape : false,
			modal:true,
			width : 600,
			height : 400,
			buttons : {
				"关闭" : function() {
			$("#namedialog").dialog("close");
				}
			}
		});

		$("#linkdialog").dialog( {
			autoOpen : false,
			closeOnEscape : false,
			modal:true,
			width : 600,
			height : 400,
			buttons : {
				"关闭" : function() {
			$("#linkdialog").dialog("close");
				}
			}
		});
	
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


	  //移到右边
	    $('#add1').click(function() {
	    //获取选中的选项，删除并追加给对方
	        $('#select3 option:selected').appendTo('#select4');
	    });
	    //移到左边
	    $('#remove1').click(function() {
	        $('#select4 option:selected').appendTo('#select3');
	    });
	    //全部移到右边
	    $('#add_all1').click(function() {
	        //获取全部的选项,删除并追加给对方
	        $('#select3 option').appendTo('#select4');
	    });
	    //全部移到左边
	    $('#remove_all1').click(function() {
	        $('#select4 option').appendTo('#select3');
	    });
	    //双击选项
	    $('#select3').dblclick(function(){ //绑定双击事件
	        //获取全部的选项,删除并追加给对方
	        $("option:selected",this).appendTo('#select4'); //追加给对方
	    });
	    //双击选项
	    $('#select4').dblclick(function(){
	       $("option:selected",this).appendTo('#select3');
	    });
	});

	function showChose(id){
		if(id=='role'){
			$("#namedialog").dialog("open");
		}
		else if(id=='weight'){
			$("#linkdialog").dialog("open");
		}
		
	}
	</script>
	<style type="text/css">
	.exportnametable,.exportlinktable{
		display: inline-block;
		font-size: 15px;
		color: #347012;
		padding-left: 2px;
		font-family: "微软雅黑";
		margin-left:70px;
	}
	
	.socialNetTitle,.chordsTitle{
		display:inline-block;
	}
	.socialNetTitle:hover,.chordsTitle:hover{
		cursor:pointer;      
	}
	</style>
	
	<link href="<%=path%>/resources/introjs/introjs.css" rel="stylesheet">
	<script type="text/javascript" src="<%=path%>/resources/introjs/intro.js"></script>
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
			<div class='opr_title_style' style="width: 110px">社会网络分析</div>
			<HR SIZE=1 class='uploadhr'/>
		</div>
		<div id="main">
					
			<div  class='tableList' style="width:50%;">     
			 	
			    <div  class='key_s' style="position:relative;top:-60px" data-step="1" data-intro="选择角色表数据进行读取">
			     <img src="resources/images/exporttable.png"> 
			    	<a href="javascript:void(0);" onclick="javascript:showChose('role')" >
						     角色表选择
					</a></div>
			    <div class="value_s">
				    <div style="display:inline-block;">
				        <select multiple="multiple" id="select1" style="width:160px;height:160px;border: 1px solid #a0c3da;font-size: 18px;color: royalblue;"
				        	data-step="2" data-intro="选择你需要角色表数据的分析列 ">
					        <%--<s:iterator value="#session.colnames" id="s" status="st">
					        	<option value="${st.index + 1}"><s:property value='s'/></option>
					        </s:iterator>
				        --%></select>
				    </div>
				    <div id='multiSelect1' style="display:inline-block;position: relative;top:-20px;margin-left: 5px;"
				    	data-step="3" data-intro="在这里你可以单个选择分析列，也可以选中多个分系列进行移动">
				    	<div><button class='reset' id="add" style="width: 40px">&gt;</button></div>
				    	<div><button class='reset' id="add_all" style="width: 40px">&gt;&gt;</button></div>
				    	<div><button class='reset' id="remove" style="width: 40px">&lt;</button></div>
				    	<div><button class='reset' id="remove_all" style="width: 40px">&lt;&lt;</button>  </div> 
					</div>
					<div style="display:inline-block;">
				        <select multiple="multiple" id="select2" style="width: 160px;height:160px;border: 1px solid #a0c3da;font-size: 18px;color: blueviolet;"
				        	data-step="4" data-intro="这里是你选择的分析列，若选择错误可以将列属性移动回原位">
				        </select>
				    </div>
				    
				    <br><br><br>
				    <div  class='key_s' style="position:relative;top:-60px" data-step="5" data-intro="选择关系表数据进行读取">
						 <img src="resources/images/exporttable.png">
				   	 	<a href="javascript:void(0);" onclick="javascript:showChose('weight')">
						     关系表选择
						</a>
					</div>
				    <div style="display:inline-block;">
				        <select multiple="multiple" id="select3" style="width:160px;height:160px;border: 1px solid #a0c3da;font-size: 18px;color: royalblue;"
				        	data-step="6" data-intro="选择你需要关系表数据的分析列 ">
					        <%--<s:iterator value="#session.colnames" id="s" status="st">
					        	<option value="${st.index + 1}"><s:property value='s'/></option>
					        </s:iterator>
				        --%></select>
				    </div>
				    <div id='multiSelect2' style="display:inline-block;position: relative;top:-20px;margin-left: 5px;" 
				    	data-step="7" data-intro="在这里你可以单个选择分析列，也可以选中多个分系列进行移动">
				    	<div><button class='reset' id="add1" style="width: 40px">&gt;</button></div>
				    	<div><button class='reset' id="add_all1" style="width: 40px">&gt;&gt;</button></div>
				    	<div><button class='reset' id="remove1" style="width: 40px">&lt;</button></div>
				    	<div><button class='reset' id="remove_all1" style="width: 40px">&lt;&lt;</button>  </div> 
					</div>
					<div style="display:inline-block;">
				        <select multiple="multiple" id="select4" style="width: 160px;height:160px;border: 1px solid #a0c3da;font-size: 18px;color: blueviolet;"
				        	data-step="8" data-intro="这里是你选择的分析列，若选择错误可以将列属性移动回原位">
				        </select>
				    </div>
				    <div class="exportlinktable">
				   
				    </div>
				    
				    <div id="namedialog" title="选择数据表">
						<table width="100%" class='table table-hover'><thead>
						   <tr class='theadstyle'>
						      <th width="35%">数据集名称</th>
						      <th width="25%">数据集规模</th>
						      <th width="20%">上传时间</th>
						      <th width="20%">上传用户</th> 
						    </tr></thead>
						    
						 	<s:iterator value="allFileDatasets" id="s" status="st">
						 	
						 	<tr style="CURSOR:hand" align="left">
						      <td>
						      	  <a href="javascript:readNameFile(${s.id});">
								      <s:if test="%{#s.datasetname.trim().length()>50}"><s:property value="%{#s.receivername.trim().substring(0,50)+'...'}"/></s:if>
								      <s:else>${s.datasetname}</s:else>
							      </a>
						      </td>
						      <td>${s.filesize}MB</td>
						      <td><s:date name="%{#request.s.uploadtime}" format="yyyy/MM/dd HH:mm:ss"/></td>
						      <td>${s.user}</td> 
						    </tr>
							</s:iterator>
					    </table>
					</div>
					
					<div id="linkdialog" title="选择数据表">
						<table width="100%" class='table table-hover'><thead>
						    <tr class='theadstyle'>
						      <th width="35%">数据集名称</th>
						      <th width="25%">数据集规模</th>
						      <th width="20%">上传时间</th>
						      <th width="20%">上传用户</th> 
						    </tr></thead>
						    
						 	<s:iterator value="allFileDatasets" id="s" status="st">
						 	
						 	<tr style="CURSOR:hand" align="left">
						      <td>
						      	  <a href="javascript:readLinkFile(${s.id});">
								      <s:if test="%{#s.datasetname.trim().length()>50}"><s:property value="%{#s.receivername.trim().substring(0,50)+'...'}"/></s:if>
								      <s:else>${s.datasetname}</s:else>
							      </a>
						      </td>
						      <td>${s.filesize}MB</td>
						      <td><s:date name="%{#request.s.uploadtime}" format="yyyy/MM/dd HH:mm:ss"/></td>
						      <td>${s.user}</td> 
						    </tr>
							</s:iterator>
					    </table>
					</div>
			    </div>
			    
			    <div style='border-top:1px solid gray;     
						position: relative;    
						margin-left: 25px;
						padding-top:10px;
						text-align: right;
						margin-top: 15px;'>      
		    	<button  class="btn add"  type="button" id="button" onclick="network_analyse()" data-step="9" data-intro="开始进行社会网络分析" data-position="right">社会网络分析</button>
		    	<button  class="btn add"  type="button" id="myselfnetwork" onclick="myselfnetwork()" >搭建自己的社交网络</button>
		    	</div>
			</div>
			
		    <div id="flagimg" style="float:left;width:40%;height:380px;position:absolute;top:58px;right:0px;"><img src="<%=path%>/resources/images/dataIntro/socialNetBg1.png"/></div>     
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
<%--				    <div id='network'  style='border:1px solid gray;height:500px;width:100%;display:inline-block;margin-bottom:5px;'>--%>
<%--				   		--%>
<%--				    </div>--%>
<%--				    <div id='chords'  style='border:1px solid gray;height:500px;width:100%;display:none;margin-bottom:5px;'>--%>
<%--				   		--%>
<%--				    </div>--%>
				</div>
			</div>
		</div>
	</div>
	
	
	<div id="outerWrap_image" class='outerWrap'>
			<div class="blueline" id="blueline_image" style="top: 0px;"></div>
			<ul class="tabGroup" id='tabGroup_image'>
				<li class="tabOption selectedTab" related-id='result1'>
					<div id='socialnet' class='div_image' title="网络图"></div>
				</li>
				<li class="tabOption" related-id='result2'>
					<div id='chordgragh' class='div_image' title="弦图"></div>
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
						$("#network").attr("style","display:none");
						//$(".socialNetTitle").attr("style","display:none");
						$("#chord").attr("style","display:none");
						//$(".chordsTitle").attr("style","display:none");
						if(related_id=="result1"){
							$("#network").attr("style","display:block");
							//$(".socialNetTitle").attr("style","display:inline-block");
						}
						else if(related_id=="result2"){
							$("#chords").attr("style","display:block");
							//$(".chordsTitle").attr("style","display:inline-block");
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
	<script type="text/javascript"  src="<%=path%>/resources/js/d3.v3.min.js"></script>
	<script src="<%=path%>/resources/qtip/qtip.js"></script>
	<SCRIPT type="text/javascript" src="<%=path%>/analyse_js/network.js"></SCRIPT>

	<script type="text/javascript">
		var width = 1200,
	    	height = 550;
		
		var json = null;
		
		var color = d3.scale.category20();
		
		var force = null;
		var nodes = null;
		var links = null;
		var node = null;
		var link = null;
		
		var svg = null;

		function drawNetwork(){
			svg = d3.select("#network")
					.append("svg:svg")
				    .attr("width", width)
				    .attr("height", height);

			d3.json("friend.json", function(error, json_s){
				json = json_s;

				console.log(json);
				
				force = d3.layout.force()
				//.gravity(.1)
			    .charge(-1000)
			    .linkDistance(250)
			    .size([width, height])
				.nodes(json.nodes)
				.links(json.edges)
				.on("tick", function() {
					link.attr("x1", function(d) { return d.source.x; })
					    .attr("y1", function(d) { return d.source.y; })
					    .attr("x2", function(d) { return d.target.x; })
					    .attr("y2", function(d) { return d.target.y; });
					
					node.attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });
				});

				nodes = force.nodes();
				links = force.links();
				node = svg.selectAll(".node"),
			    link = svg.selectAll(".link");
				
				redraw();
			});
		}

		function redraw(){
			link = link.data(links);

			//画线
			link.enter().insert("line", ".node")
		        .attr("class", "link")
		        .transition()
		        .duration(500)
		        .ease("elastic")
		        .style("stroke-width", function(d){
			        if(d.weight!=undefined && d.weight!=null){
			        	return Math.sqrt(d.weight+1); 
				    }
					return 1; 
			     })
			     .style("stroke","#999")
			     .style("stroke-opacity",function(d){
					if(d._stroke_opacity==undefined||d._stroke_opacity==1){
						return 1;
					}
					else{
						return 0;
					}
				 });
		     
			link.exit().remove();

			//重新绑定的数据，重绘
			d3.selectAll(".link").style("stroke-opacity",function(d){
				if(d._stroke_opacity==undefined||d._stroke_opacity==1){
					return 1;
				}
				else{
					return 0;
				}
			 });

			node = node.data(nodes);
			
			var node_group = node.enter().append("g")
		        .attr("class", "node")
		        .style("opacity",function(d){
					if(d._opacity==undefined||d._opacity==1){
						return 1;
					}
					else{
						return 0;
					}
				 })
		        .on("click",function(d){

		        	if(d._color == "#ff0000"){//选中状态
		        		nodes.forEach(function(p){
							p._opacity = undefined;
							p._r = undefined;
							p._color = undefined;
						});

		        		links.forEach(function(lk){
		        			lk._stroke_opacity = undefined;
			        	});
			        	redraw();
			        }
		        	else{
		        		//遍历节点
						nodes.forEach(function(p){
							p._opacity = undefined;
							if(d==p){
								p._r = 35;
								p._color = "#ff0000";
							}
							else{
								p._r = null;
								p._color = null;
							}
						});

						//遍历线
						//var i = 0;
						links.forEach(function(lk){
							if(lk.source==d || lk.target==d){
								lk._stroke_opacity = 1;
								//遍历节点
								nodes.forEach(function(np){
									if(np==lk.source || np==lk.target){
										np._opacity = 1;
									}
								});
							}
							else{
								lk._stroke_opacity = 0;
							}
						});

						//遍历点
						nodes.forEach(function(np){
							if(np._opacity == 1){
								np._opacity = 1;
							}
							else{
								np._opacity = 0;
							}
						});
			        }

					redraw();
			    })
		        .call(force.drag);

	        //重绘
	        d3.selectAll(".node").style("opacity",function(d){
				if(d._opacity==undefined||d._opacity==1){
					return 1;
				}
				else{
					return 0;
				}
			 })

			//画圆
			node_group.append("svg:circle")
			 	.attr("class","nodeChildren")
		  	 	.attr("r", function(d){
			  	 	if(d._r!=undefined && d._r!=null){
			  	 		return d._r;
				  	}
				  	return d.r;
			  	 })
		  	 	.style("fill", function(d) {
			  		if(!d._color){
						return color(d.color); 
					}
				  	else{
				  		return d._color;
					}
				});

			//重新绑定的数据，重绘
			d3.selectAll(".node")
				.select(".nodeChildren")
				.attr("r", function(d){
					if(d._r!=undefined && d._r!=null){
			  	 		return d._r;
				  	}
				  	return d.r;
			  	 })
		  	 	.style("fill", function(d) {
			  		if(!d._color){
						return color(d.color); 
					}
				  	else{
				  		return d._color;
					}
				});

			node_group.append("svg:image")
				.attr("class","images")
			    .attr("xlink:href", function(d){
			  		return "http://localhost:8080/DataVisual/resources/headimg/"+d.name+".jpg";
			    })
			    .attr("x", function(d){
			    	if(d._r!=undefined && d._r!=null){
			    		return -(1/Math.sqrt(2))*d._r;
			    	}
					return -(1/Math.sqrt(2))*d.r;
				 })
			    .attr("y",  function(d){
			    	if(d._r!=undefined && d._r!=null){
			    		return -(1/Math.sqrt(2))*d._r;
			    	}
					return -(1/Math.sqrt(2))*d.r;
				 })
			    .attr("width", function(d){
			    	if(d._r!=undefined && d._r!=null){
			    		return Math.sqrt(2)*d._r;
				    }
			    	return Math.sqrt(2)*d.r;
				})
			    .attr("height", function(d){
			    	if(d._r!=undefined && d._r!=null){
			    		return Math.sqrt(2)*d._r;
				    }
			    	return Math.sqrt(2)*d.r;
				})
		    	.attr("pointer-events", "all");


		   	//图形，重绘
		   	d3.selectAll(".node").select(".images")
		   		.attr("xlink:href", function(d){
			  		return "http://localhost:8080/DataVisual/resources/headimg/"+d.name+".jpg";
			    })
			    .attr("x", function(d){
			    	if(d._r!=undefined && d._r!=null){
			    		return -(1/Math.sqrt(2))*d._r;
			    	}
					return -(1/Math.sqrt(2))*d.r;
				 })
			    .attr("y",  function(d){
			    	if(d._r!=undefined && d._r!=null){
			    		return -(1/Math.sqrt(2))*d._r;
			    	}
					return -(1/Math.sqrt(2))*d.r;
				 })
			    .attr("width", function(d){
			    	if(d._r!=undefined && d._r!=null){
			    		return Math.sqrt(2)*d._r;
				    }
			    	return Math.sqrt(2)*d.r;
				})
			    .attr("height", function(d){
			    	if(d._r!=undefined && d._r!=null){
			    		return Math.sqrt(2)*d._r;
				    }
			    	return Math.sqrt(2)*d.r;
				})
		    	.attr("pointer-events", "all");


		   	//画字
			node_group.append("svg:text")
			  	.attr("class", "nodetext")
			  	.attr("dx",function(d){return d.r+5})
				.attr("dy",function(d){return d.r/2})
			  	.text(function(d) { return d.name });

		  	//重画
		  	d3.selectAll(".node").select(".nodetext")
		  		.attr("dx",function(d){return d.r+5})
				.attr("dy",function(d){return d.r/2})
			  	.text(function(d) { return d.name });

		  	//对.node进行重新布局
		  	

			node.exit().transition()
		       	.attr("r", 0)
		       	.remove();

			force.start();
			
		}//redraw()方法结束

	</script>

	<script>

	var color_chords = d3.scale.category20();

	var matrix=[
	      	[0,1,3,0,6,0,3,4,6,1,0,4,0,1,3,4,6,1,3,4,0,1,3,0,0,1,3,4,0,1,0,4,6,1,3,0,0,0,0,0,0,0,0],
            [3,0,0,0,0,3,0,0,0,0,0,0,0,1,3,0,6,1,3,0,0,0,3,0,0,1,0,4,0,0,0,4,0,1,0,0,0,0,0,0,0,0,0],
            [8,7,0,0,0,0,0,8,7,8,7,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0,9,0,0,0,0,0,0,0,9,0,0,0,9,0,0,0,9,0,0,0,0,9,9,0,9,0,0,0,0,9,0],
            [9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0],
            [4,4,0,0,0,0,0,8,7,8,7,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,1,2,6,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,3,0,2,6,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,4,6,0,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,7,5,3,0,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,5,2,4,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [3,0,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,2,0,0,0,4,0,0,0,5,0,0,0,0,8,4,9,2,0,0,0,0,6,0],
            [0,0,0,0,0,0,0,2,2,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [3,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,5,2,5,0,0,0,0,0,0],
            [3,2,0,0,0,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [3,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [3,5,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,7,0,0,0,1,0,0,0,0,3,5,8,3,0,0,0,0,3,0],
            [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,3,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,1,3,5,8,0,0,0,0,3,0],
            [3,4,0,2,0,0,0,5,1,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [1,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,0,0,2,7,8,3,0,0,0,0,5,0]
	 ];

	var nameByIndex = d3.map();
	//nameByIndex.set(0, "王亚普");
	//nameByIndex.set(1, "周远超");
	//nameByIndex.set(2, "周发超");
	//nameByIndex.set(3, "杨少松");
	//nameByIndex.set(4, "陈亚明");
	nameByIndex.set(0	 ,"杨少松");
	nameByIndex.set(1	 ,"陈亚明");
	nameByIndex.set(2	 ,"陈一鸣");
	nameByIndex.set(3	 ,"戴阳阳");
	nameByIndex.set(4	 ,"董宇超");
	nameByIndex.set(5	 ,"樊杰");
	nameByIndex.set(6	 ,"费云鹏");
	nameByIndex.set(7	 ,"范玉龙");
	nameByIndex.set(8	 ,"高远");
	nameByIndex.set(9	 ,"龚璐");
	nameByIndex.set(10	 ,"顾刚");
	nameByIndex.set(11	 ,"何菁");
	nameByIndex.set(12	 ,"仓一倩");
	nameByIndex.set(13	 ,"黄伟伦");
	nameByIndex.set(14	 ,"姜鹏");
	nameByIndex.set(15	 ,"李春");
	nameByIndex.set(16	 ,"陆斌");
	nameByIndex.set(17	 ,"任向林");
	nameByIndex.set(18	 ,"郭超伦");
	nameByIndex.set(19	 ,"高晓巷");
	nameByIndex.set(20	 ,"王菁雁");
	nameByIndex.set(21	 ,"黄政");
	nameByIndex.set(22	 ,"经晓硕");
	nameByIndex.set(23	 ,"马宏旭");
	nameByIndex.set(24	 ,"邓玲玲");
	nameByIndex.set(25	 ,"李世伟");
	nameByIndex.set(26	 ,"李泽坤");
	nameByIndex.set(27	 ,"刘凤斌");
	nameByIndex.set(28	 ,"王露");
	nameByIndex.set(29	 ,"张宏军");
	nameByIndex.set(30	 ,"聂凤鸣");
	nameByIndex.set(31	 ,"吕萌");
	nameByIndex.set(32	 ,"王媛");
	nameByIndex.set(33	 ,"周远超");
	nameByIndex.set(34	 ,"王亚普");
	nameByIndex.set(35	 ,"王晴");
	nameByIndex.set(36	 ,"周发超");
	nameByIndex.set(37	 ,"吴婷");
	nameByIndex.set(38	 ,"王涛");
	nameByIndex.set(39	 ,"钱振兴");
	nameByIndex.set(40	 ,"郭俊");
	nameByIndex.set(41	 ,"李攀");
	nameByIndex.set(42	,"刘喜凤");
	
	var chord = d3.layout.chord()
	    .padding(.05)
	    .sortSubgroups(d3.descending)
	    .matrix(matrix);
	
	var width_chords = 1366,
	    height_chords = 700,
	    innerRadius = Math.min(width_chords, height_chords) * .35,
	    outerRadius = innerRadius * 1.1;
	
	var svg_chords = null;

	//drawChords();

    function drawChords(){
    	svg_chords = d3.select("#chords").append("svg")
	    .attr("width", width_chords)
	    .attr("height", height_chords)
	  .append("g")
	    .attr("transform", "translate(" + width_chords / 2 + "," + height_chords / 2 + ")");

    	svg_chords.append("g").selectAll("path")
	    .data(chord.groups)
	  .enter().append("path")
	    //.style("fill", function(d) { return fill(d.index); })
	    //.style("stroke", function(d) { return fill(d.index); })
	    .style("fill", function(d) { return color_chords(d.index%20); })
	    .style("stroke", function(d) { return color_chords(d.index%20); })
	    .attr("d", d3.svg.arc().innerRadius(innerRadius).outerRadius(outerRadius))
	    .on("mouseover", fade(.1))
	    .on("mouseout", fade(1));

	svg_chords.selectAll("text").data(chord.groups).enter().append("text")
	   .each(function(d) { d.angle = (d.startAngle + d.endAngle) / 2; })
	   .attr("dx", function(d){
		   return d.angle > Math.PI ? (-0.5*1366/768.0)+"em" : (0.5*1366/768.0)+"em";
		})
	   .attr("dy", ".75em")
	   .attr("transform", function(d) {
	      return "rotate(" + (d.angle * 180 / Math.PI - 90) + ")"
	          + "translate(" + (innerRadius + 26) + ")"
	          + (d.angle > Math.PI ? "rotate(180)" : "");
	    })
	   .style("text-anchor", function(d) { return d.angle > Math.PI ? "end" : null; })
	   .style("fill","red")
	   .text(function(d) { return nameByIndex.get(d.index); });
	
	svg_chords.append("g")
	    .attr("class", "chord")
	  .selectAll("path")
	    .data(chord.chords)
	  .enter().append("path")
	    .attr("d", d3.svg.chord().radius(innerRadius))
	    .style("fill", function(d) { return color_chords(d.target.index%20); })
	    .style("opacity", 1);
	    
    }
	
	// Returns an event handler for fading a given chord group.
	function fade(opacity) {
	  return function(g, i) {
	    svg_chords.selectAll(".chord path")
	        .filter(function(d) { return d.source.index != i && d.target.index != i; })
	      .transition()
	        .style("opacity", opacity);
	  };
	}

	</script>
	
	<SCRIPT type="text/javascript">

	</SCRIPT>
</body>
</html>