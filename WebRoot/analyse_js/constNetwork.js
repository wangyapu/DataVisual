


//数据
  var friend_net_origin = {
	  		"nodes":[
			     { "name" : "待命名","special":"false","r":16,"color":"1","catagory":"默认","headImg":"headImg.png"}],
			"edges":[]};
  
    //是否为第一次画图
    var firstDraw = true;
    
    //是否启用拖拽
    var drag_flag = false;
    
    //是否可以缩放；
    var scale_flag = true;
    
    //是否需要显示头像
    var image_show_flag = false;

	var input_name = false;//是否启用编辑姓名
	var input_image = false;//是否启用上传照片
	var input_circle = false;//是否启用图形编辑；
	var input_line = false;//是否启用线条编辑
	var input_image = false;//是否启用图片编辑
	var edit_node = null;//当前编辑的对象
	var edit_link = null;//当前编辑的线条

	var emp_circle = false;//处于强调状态 
	
	var content_html = "<div> "+
					    "	<label>当前名称：</label> "+
						"		<input id='filename_before' type='text' style='width:250px' value='未命名' disabled='true'> "+
					    "</div> "+
					    "<div> "+
					    "	<label>修改名称：</label> "+
						"		<input id='filename_after' type='text' style='width:250px' placeholder='请输入名称...'> "+
					    "</div>";
	var content_html_link = "<div> "+
					    "	<label>当前宽度：</label> "+
						"		<input id='linkweight_before' type='text' style='width:250px' value='16' disabled='true'> "+
					    "</div> "+
					    "<div> "+
					    "	<label>修改宽度：</label> "+
						"		<input id='linkweight_after' type='text' style='width:250px' placeholder='请输入宽度...'> "+
					    "</div>";
	var content_html_circle = "<div> "+
					    "	<label>当前半径：</label> "+
						"		<input id='circle_r_before' type='text' style='width:250px' value='16' disabled='true'> "+
					    "</div> "+
					    "<div> "+
					    "	<label>修改半径：</label> "+
						"		<input id='circle_r_after' type='text' style='width:250px' placeholder='请输入半径...'> "+
					    "</div>"+
					    "<div> "+
					    "	<label>原始分类：</label> "+
						"		<input id='color_before' type='text' style='width:250px' value='16' disabled='true'> "+
					    "</div>"+
					    "<div> "+
					    "	<label>修改分类：</label> "+
						"		<input id='color_after' type='text' style='width:250px' placeholder='请输入新分类...'> "+
					    "</div>";
  
  var width = 1080,
      height = 550,
      color = d3.scale.category10();
  
  // mouse event vars
  var selected_node = null,
      selected_link = null,
      mousedown_link = null,
      mousedown_node = null,
      mouseup_node = null;
  
  var dblclick_node = null;
   
  var outer = null;
  var vis = null;
  var force = null;
  var drag_line = null;
  
//get layout properties
  var nodes = null,
      links = null,
      node = null,
      link = null;
  
  var clustertype = [];
  
  var drawNetwork = function(friend_net){
	  getTimeInfo("初始化...");
	  
	  width = parseInt($("#main").css("width").replace("px",""))-150;
      height = parseInt($("#main").css("height").replace("px",""))-70;
      
	  d3.select("#panel_net").remove();

	// init svg
	  outer = d3.select("#chart")
	      .append("svg:svg").attr("id","panel_net")
	      .attr("width", width)
	      .attr("height", height)
	      .attr("pointer-events", "all")
	      .style("margin-left","75px");
	      //.style("width","95%")
	      //.style("height","90%");

	  vis = outer
	      .append('svg:g')
	      .attr("class","content_net")
	      .call(d3.behavior.zoom().on("zoom", rescale))
	      .on("dblclick.zoom", null)
	      .append('svg:g')
	      .on("mousemove", mousemove)
	      .on("mousedown", mousedown)
	      .on("mouseup", mouseup);

	  vis.append('svg:rect')
	      .attr('width', width)
	      .attr('height', height)
	      .attr('fill', 'white').style("fill-opacity",0);
	  
	  //先对friend_net的颜色值进行重新定义
	  for(var i=0;i<friend_net.nodes.length;i++){
		  friend_net.nodes[i].color = hashCode(friend_net.nodes[i].catagory);
	  }

	  // init force layout
	  force = d3.layout.force()
	      .size([width, height])
	      .charge([-500])
		  .linkDistance([150])
	      .nodes(friend_net.nodes)
	      .links(friend_net.edges)
	      .on("tick", tick);


	  // line displayed when dragging new nodes
	  drag_line = vis.append("line")
	      .attr("class", "drag_line")
	      .attr("x1", 0)
	      .attr("y1", 0)
	      .attr("x2", 0)
	      .attr("y2", 0);

	  // get layout properties
	  nodes = force.nodes();
	  links = force.links();
	  node = vis.selectAll(".node_group");
	  link = vis.selectAll(".link");

	  console.log(nodes);
	  console.log(links);
	  
	  // add keyboard callback
	  d3.select(window).on("keydown", keydown);

	  redraw();

	  // focus on svg
	  // vis.node().focus();
  }
  
  var multiDraw = function(friend_net){
	  getTimeInfo("刷新视图");
	  
	  force.stop();
	  force = null;
	  
	  d3.select("#panel_net").remove();

	  // init svg
	  outer = d3.select("#chart")
	      .append("svg:svg").attr("id","panel_net")
	      .attr("width", width)
	      .attr("height", height)
	      .attr("pointer-events", "all")
	      .style("margin-left","75px");
	      //.style("width","95%")
	      //.style("height","90%");

	  vis = outer
	      .append('svg:g')
	      .attr("class","content_net")
	      .call(d3.behavior.zoom().on("zoom", rescale))
	      .on("dblclick.zoom", null)
	      .append('svg:g')
	      .on("mousemove", mousemove)
	      .on("mousedown", mousedown)
	      .on("mouseup", mouseup);

	  vis.append('svg:rect')
	      .attr('width', width)
	      .attr('height', height)
	      .attr('fill', 'white').style("fill-opacity",0);
	  
	  //先对friend_net的颜色值进行重新定义
	  for(var i=0;i<friend_net.nodes.length;i++){
		  friend_net.nodes[i].color = hashCode(friend_net.nodes[i].catagory);
	  }
	  
	  force = d3.layout.force()
		      .size([width, height])
		      .charge([-500])
			  .linkDistance([150])
		      .nodes(friend_net.nodes)
		      .links(friend_net.edges)
		      .on("tick", tick);
	  //nodes = force.nodes();
	  //links = force.links();
	  
	  // line displayed when dragging new nodes
	  drag_line = vis.append("line")
	      .attr("class", "drag_line")
	      .attr("x1", 0)
	      .attr("y1", 0)
	      .attr("x2", 0)
	      .attr("y2", 0);

	  // get layout properties
	  nodes = force.nodes();
	  links = force.links();
	  node = vis.selectAll(".node_group");
	  link = vis.selectAll(".link");
	  
	  redraw();
  }
  
  function mousedown() {
	    if (!mousedown_node && !mousedown_link) {
	      // allow panning if nothing is selected
	      vis.call(d3.behavior.zoom().on("zoom"), rescale);
	      if(scale_flag){
	    	  getTimeInfo("启动缩放功能");
	    	  scale_flag = false;
	      }
	      //getTimeInfo("启动缩放功能");
	      return;
	    }
	  }

	  function mousemove() {
	    if (!mousedown_node) return;

	    //拖拽了就不划线了
	    if(drag_flag)return;
	    
	    // update drag line
	    drag_line
	        .attr("x1", mousedown_node.x)
	        .attr("y1", mousedown_node.y)
	        .attr("x2", d3.svg.mouse(this)[0])
	        .attr("y2", d3.svg.mouse(this)[1]);

	  }

	  function mouseup() {
		//拖拽了就不划线、画点
		if(drag_flag)return;
		    
	    if (mousedown_node) {
	      // hide drag line
	      drag_line.attr("class", "drag_line_hidden")

	      if (!mouseup_node) {
	        // add node
	        var point = d3.mouse(this);
	        //console.log(point);
	        var node = {"x": point[0], "y": point[1], "r":16, "color":hashCode("默认"), "name":"待命名", "special":"false","catagory":"默认","headImg":"headImg.png"};
	        var n = nodes.push(node);

	        // select new node
	        selected_node = node;
	        selected_link = null;
	        
	        // add link to mousedown node
	        //console.log({source: mousedown_node, target: node});
	        links.push({source: mousedown_node, target: node, weight:3});
	        
	        getTimeInfo("新加节点："+node.name+",类别："+node.catagory);
	        getTimeInfo("新建关系："+node.name+" 与  "+mousedown_node.name+" 建立了 "+node.catagory+" 关系");
	      }

	      redraw();
	    }
	    // clear mouse event vars
	    resetMouseVars();
	  }

	  function resetMouseVars() {
	    mousedown_node = null;
	    mouseup_node = null;
	    mousedown_link = null;
	  }

	  function tick() {
	    link.attr("x1", function(d) { return d.source.x; })
	        .attr("y1", function(d) { return d.source.y; })
	        .attr("x2", function(d) { return d.target.x; })
	        .attr("y2", function(d) { return d.target.y; });

	    //node.attr("cx", function(d) { return d.x; })
	    //    .attr("cy", function(d) { return d.y; });
	    node.attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });
	  }

	  // rescale g
	  function rescale() {
	    trans=d3.event.translate;
	    scale=d3.event.scale;

	    vis.attr("transform",
	        "translate(" + trans + ")"
	        + " scale(" + scale + ")");
	  }

	  // redraw force layout
	  function redraw() {
		
	    //先画出图例
	    clustertype = [];
		for(var i = 0,len = nodes.length;i < len;i++){ 
			! RegExp(nodes[i]["catagory"],"g").test(clustertype.join(",")) && (clustertype.push(nodes[i]["catagory"])); 
		}
		console.log(clustertype);
		//clustertype.sort();
		for(var i=0,len=clustertype.length;i<len;i++){
			clustertype[i] = {"catagory":clustertype[i],"color":hashCode(clustertype[i])};
		}
		console.log(clustertype);
		
		//对图例数据进行前期处理
		
		//画出图例
		var legend_all = outer.selectAll("g.legend").data(clustertype);
		var legend = legend_all.enter().append("g")
		  .attr("class","legend")
		  .style("pointer-events","all")
  		  .style("cursor","pointer")
  		  .attr("transform", function(d, i) { return "translate("+25+"," + (25+i*35) + ")"; })
  		  .on("click",function(xx){
  			  getTimeInfo("您操作了图例,类别："+xx.catagory);
  			
		      var cl = $($(d3.event.target)[0]).attr("class");
		      cl = cl.replace("_label","").replace("legend_text ","").replace("legend_rect ","");
		      c2 = cl.replace("class_",""); 
		      var col = $("#"+cl).attr("fill");
		      //alert(cl);
		      //改动links线条
		      d3.selectAll(".link")
		        .style("stroke-opacity",function(d){
		        	if(col=="gray"){
		        		if(d.source.color==c2 || d.target.color==c2){
    		        		return 1;
    		        	}
		        	}
		        	else{
		        		if(d.source.color==c2 || d.target.color==c2){
    		        		return 0;
    		        	}
		        	}
		        	
		        });
		      
		      d3.selectAll(".node_group")
		        .style("opacity",function(d){
		        	if(col=="gray"){
		        		if(d.color==c2){
    		        		return 1;
    		        	}
		        	}
		        	else{
		        		if(d.color==c2){
    		        		return 0;
    		        	}
		        	}
		        });

		      if(col=="gray"){
				 d3.select("#"+cl).attr("fill",function(d){return color(d.color)});
			  }
		      else{
		    	  d3.select("#"+cl).attr("fill","gray");
			  }
		      d3.select("#"+cl).style("fill-opacity","1");
	          
		  });
			  
		  legend.append("svg:circle") 
			    .attr("id", function(d){return "class_"+d.color})
		  		.attr("class", function(d){return "legend_rect class_"+d.color})
		  		.attr("cx",12)
		  		.attr("cy",12)
		  		.attr('r', 8)
		    	//.attr('height', 20)
		  		.attr("fill", function(d){return color(d.color)})
			  
		  legend.append("svg:text")
		  		.attr("x",25)
		  		.attr("y",18)
				.attr("class", function(d){return "legend_text class_"+d.color+"_label"})
				.text(function(d) { return d.catagory.trim(); });
		  
		  legend_all.exit().remove();
		  
		  //刷新legend视图
		  d3.selectAll(".legend").select(".legend_rect")
		  	.attr("id", function(d){return "class_"+d.color})
	  		.attr("class", function(d){return "legend_rect class_"+d.color})
	  		.attr("fill", function(d){return color(d.color)});
		  d3.selectAll(".legend").select(".legend_text")
		  	.attr("class", function(d){return "legend_text class_"+d.color+"_label"})
			.text(function(d) { return d.catagory.trim(); });
		  
		  
	    link = link.data(links);
	    
	    link.enter().insert("line", ".node_group")
	        .attr("class", function(d){return "link classs_"+d.source.color+"_"+d.target.color})
	        .attr("stroke-width",function(d) {
					//return Math.sqrt(d.weight+1); 
	        	return d.weight; 
		     })
	        .on("mousedown", 
	          function(d) { 
	             mousedown_link = d;
	             if (mousedown_link == selected_link){
	            	 selected_link = null;
	            	 getTimeInfo("取消选中关系："+d.source.name+" 与 "+d.target.name+" 的 "+d.target.catagory+" 关系");
	             }
	             else{
	            	 selected_link = mousedown_link; 
	            	 getTimeInfo("选中关系："+d.source.name+" 与 "+d.target.name+" 的 "+d.target.catagory+" 关系");
	             }
	             selected_node = null; 
	             redraw(); 
	          })
	        .on("dblclick",function(d){
	        	getTimeInfo("弹出修改关系强弱对话框");
	        	edit_link = d;
				var ss = easyDialog.open({
					  container : {
						    header : '修改宽度',
						    content : content_html_link,
						    noFn : bt_no,
						    yesFn : btnFn_crop_link
						  },
					  fixed : false,
				});
				$("#linkweight_before").val(d.weight);
				$("#easyDialogYesBtn").text("修改");
	        });

	    //确定按钮的点击回调事件
	    var btnFn_crop_link = function(){
	    	var linkweight_before = $("#linkweight_before").val();
	        var linkweight_after = $("#linkweight_after").val();
	        if(edit_link!=null && edit_link!=undefined){
	        	links.forEach(function(d){
	    			if(d==edit_link){
	    			//if(d.name==filename_before){
	    				d.weight = linkweight_after;
	    				getTimeInfo(d.source.name+" 与 "+d.target.name+" 的 "+d.target.catagory+" 关系强度由 "+linkweight_before+" 修改为："+linkweight_after);
	    			}
	            });
	        	redraw();
	        }
	    	return true;
	    };

	    link.exit().remove();

	    //对重新绑定的数据进行绘制
	    link.attr("class", function(d){return "link classs_"+d.source.color+"_"+d.target.color})
	    	.attr("stroke-width",function(d) { 
		        if(d.weight!=undefined){
		        	return d.weight;
		        }
	      })
	     .style("stroke-opacity",function(d){
			if(d._stroke_opacity!=undefined && d._stroke_opacity!=null){
				return 0.1;
			}
			else{
				return 1;
			}
	     });

	    link.classed("link_selected", function(d) { return d === selected_link; });

	    node = node.data(nodes);

	    var node_group = node.enter()
			.insert("g","node_group")
			.attr("class",function(d){return "node_group classs_"+d.color})
			.on("mousedown", 
		          function(d) {
		            // disable zoom
					getTimeInfo("关闭缩放功能");
					scale_flag = true;
					
		            vis.call(d3.behavior.zoom().on("zoom"), null);
		
		            mousedown_node = d;
		            if (mousedown_node == selected_node) {
		            	getTimeInfo("取消选中节点："+d.name);
		            	selected_node = null;
		            }
		            else {
		            	getTimeInfo("选中节点："+d.name);
		            	selected_node = mousedown_node; 
		            }
		            selected_link = null; 
		
		            // reposition drag line
		            drag_line
		                .attr("class", "drag_line")
		                .attr("x1", mousedown_node.x)
		                .attr("y1", mousedown_node.y)
		                .attr("x2", mousedown_node.x)
		                .attr("y2", mousedown_node.y);
		
		            redraw(); 
		          })
		        .on("mousedrag",
		          function(d) {
		            // redraw();
		          })
		        .on("mouseup", 
		          function(d) {
		        	//拖拽了就不划线、画点
		    		if(drag_flag)return;
		            if (mousedown_node) {
		              mouseup_node = d; 
		              if (mouseup_node == mousedown_node) { resetMouseVars(); return; }
		
		              //此处可以修改link，优化只有一个关系
		              links.forEach(function(lk){
		            	  if(lk.source==mousedown_node && lk.target==mouseup_node){
		            		  return;
		            	  }
		              });
		              
		              // add link
		              var link = {source: mousedown_node, target: mouseup_node};
		              links.push(link);
		              
		              getTimeInfo("建立关系："+mouseup_node.name+" 和 "+mousedown_node.name+" 成了 "+mouseup_node.catagory+" 关系");
		
		              // select new link
		              selected_link = link;
		              selected_node = null;
		
		              // enable zoom
		              vis.call(d3.behavior.zoom().on("zoom"), rescale);
		              redraw();
		            } 
		          })
				.on("click",function(d){
					if(input_circle){//编辑图形
						alert("编辑图形");
					}
					else{//强调关系
						//alert("强调关系");
	
						//首先清除原始信息
						links.forEach(function(p){
							p._stroke_opacity = undefined;
						});
						nodes.forEach(function(nq){
							nq._opacity = undefined;
						});
	
						//查看是否处于强调状态
						var flag = false;//默认非强调状态
						nodes.forEach(function(nq){
							if(nq._emp_circle!=undefined && nq._emp_circle!=null){
								flag = true;
							}
						});
						if(!flag){
							getTimeInfo("强调与 "+d.name+" 的关系");
							d._emp_circle = "emp";
							links.forEach(function(p){
								if(p.source!=d && p.target!=d){
									p._stroke_opacity = 0.1;
									nodes.forEach(function(nq){
										if(p.source==nq || p.target==nq){
											nq._opacity = 0.1;
										}
									});
								}
							});
							links.forEach(function(p){
								if(p._stroke_opacity==undefined || p._stroke_opacity==null){
									nodes.forEach(function(nq){
										if(p.source==nq || p.target==nq){
											nq._opacity = null;
										}
									});
								}
							});
							
							//拼出跟选中节点有关联的节点，及其关系
							var temp_source = "";//该节点为原节点
							var temp_target = "";//该节点为目标节点
							links.forEach(function(p){
								if(p._stroke_opacity==undefined || p._stroke_opacity==null){
									nodes.forEach(function(nq){
										if(p.source==nq){
											temp_source += "<div>出度："+p.source.name+",入度："+p.target.name+",关系："+p.target.catagory+"</div>";
										}
										else if(p.target==nq){
											temp_source += "<div>入度："+p.source.name+",出度："+p.target.name+",关系："+p.source.catagory+"</div>";
										}
									});
								}
							});
							getTimeInfo(temp_source+";<br>"+temp_target);
							
						}
						else{
							getTimeInfo("取消强调关系");
							nodes.forEach(function(nq){
								nq._emp_circle = null;
							});
						}
						redraw();
					}
		        });//.call(force.drag);
	    
	    //是否启用拖拽
	    if(drag_flag){
	    	//node_group.call(force.drag);
	    }
	    else{
	    	//force.stop();
	    }

	    d3.selectAll(".node_group")
	    	.attr("class",function(d){return "node_group classs_"+d.color})
	    	.style("opacity",function(d){
			if(d._opacity!=undefined && d._opacity!=null){
				return 0.1;
			}
			else{
				return 1;
			}
	     });
	    
	    node_group.insert("circle")
	        .attr("class", "node")
	        .style("fill", function(d) {
	            if(!d._color) d._color = color(d.color);
	            return d._color;
			 })
			 .on("dblclick",function(d){
				 	getTimeInfo("弹出修改 "+d.name+ " 半径和分类的窗口");
		        	edit_node = d;
					var ss = easyDialog.open({
						  container : {
							    header : '修改半径和分类',
							    content : content_html_circle,
							    noFn : bt_no,
							    yesFn : btnFn_crop_circle
							  },
						  fixed : false,
					});
					$("#circle_r_before").val(d.r);
					$("#color_before").val(d.catagory);
					$("#easyDialogYesBtn").text("修改");
		     })
	        .transition()
	        .duration(750)
	        .ease("elastic")
	        .attr("r", function(d){return d.r;});

	    node.exit().transition().remove();

	    //确定按钮的点击回调事件
	    var btnFn_crop_circle = function(){
	    	var circle_r_before = $("#circle_r_before").val();
	        var circle_r_after = $("#circle_r_after").val();
	        var color_before = $("#color_before").val();
	        var color_after = $("#color_after").val();
	        if(edit_node!=null && edit_node!=undefined){
	        	nodes.forEach(function(d){
	    			if(d==edit_node){
	    			//if(d.name==filename_before){
	    				if(circle_r_after.trim()!="")d.r = parseFloat(circle_r_after);
	    				if(color_after.trim()!=""){
	    					d.catagory = color_after;
	    					//动态分配颜色值
	    					d.color = hashCode(color_after);
	    				}
	    				d._color = null;
	    				
	    				var temp = "";
	    				if(circle_r_after.trim()!="" && color_after.trim()!=""){
	    					temp = edit_node.name+" 的半径更改为："+circle_r_after+",分类更改为："+color_after;
	    				}
	    				else if(circle_r_after.trim()==""){
	    					temp = edit_node.name+" 的分类更改为："+color_after;
	    				}
	    				else
	    				{
	    					temp = edit_node.name+" 的半径更改为："+circle_r_after;
	    				}
	    				getTimeInfo(temp);
	    			}
	            });
	        	redraw();
	        }
	    	return true;
	    };

	    //对重新绑定的数据进行绘制
	    //nodes = force.nodes();
	    //console.log(nodes);
	    d3.selectAll(".node_group").select(".node").attr("r", function(d){return d.r;})
			.style("fill", function(d) {
				if(!d._color) d._color = color(d.color);
				return d._color;
			});
	    

	    d3.selectAll(".node").classed("node_selected", function(d) { return d === selected_node; });

	    //********加入名字*****************************************************************************************************
	    node_group.append("svg:text")
			.attr("class","node_name")
			.text(function(d) { return d.name })
			.attr("dx",function(d){return d.r+5})
			.attr("dy",function(d){return d.r/2})
			.on("dblclick",function(d){
				getTimeInfo("弹出修改节点 "+d.name+" 的对话框");
				edit_node = d;
				var ss = easyDialog.open({
					  container : {
						    header : '修改节点名称',
						    content : content_html,
						    noFn : bt_no,
						    yesFn : btnFn_crop
						  },
					  fixed : false,
				});
				$("#filename_before").val(d.name);
				$("#easyDialogYesBtn").text("修改");
    	  });
		  
	    //对重新绑定的数据进行绘制
	    //nodes = force.nodes();
	    //console.log(nodes);
	    d3.selectAll(".node_group").select(".node_name")
		   .text(function(d){return d.name;})
		   .attr("dx",function(d){return d.r+5})
		   .attr("dy",function(d){return d.r/2});
		  
	  //取消按钮的点击回调事件
	    var bt_no = function(){
	    	getTimeInfo("取消弹窗");
	    	return true;
	    };

	    //确定按钮的点击回调事件
	    var btnFn_crop = function(){
	    	var filename_before = $("#filename_before").val();
	        var filename_after = $("#filename_after").val();
	        if(edit_node!=null && edit_node!=undefined){
	        	nodes.forEach(function(d){
	    			if(d==edit_node){
	    			//if(d.name==filename_before){
	    				d.name = filename_after;
	    				getTimeInfo(edit_node.name+" 的名称更改为："+filename_after);
	    			}
	            });
	        	redraw();
	        }
	    	return true;
	    };

	    //********加入图片*****************************************************************************************************
	    node_group.append("svg:image")
			.attr("class","node_images")
		    .attr("xlink:href", function(d){
		    	if(d.headImg!="headImg.png"){
		    		return spath+"/resources/headimg/"+d.headImg;
		    	}
		    	else{
		    		return spath+"/resources/headimg/"+d.name+".jpg";
		    	}
		    })
		    .attr("x", function(d){
				return -(1/Math.sqrt(2))*d.r;
			 })
		    .attr("y",  function(d){
				return -(1/Math.sqrt(2))*d.r;
			 })
		    .attr("width", function(d){
		    	if(image_show_flag==true){
		    		return Math.sqrt(2)*d.r;
				}
				else{
					return 0;
				}
			})
		    .attr("height", function(d){
		    	if(image_show_flag==true){
		    		return Math.sqrt(2)*d.r;
				}
				else{
					return 0;
				}
			}).on("dblclick",function(d){
				getTimeInfo("弹出修改节点 "+d.name+" 的头像对话框");
				dblclick_node = d;
				var ss = easyDialog.open({
					  container : {
						    header : '上传图片',
						    content : pop_string
						  },
					  fixed : false,
				});
				$(".easyDialog_wrapper").css("width","400px");
				send();
    	    });
		   // .attr("pointer-events", "all");

	    //对重新绑定的数据进行绘制
	    d3.selectAll(".node_group").select(".node_images")
		   .attr("xlink:href", function(d){
			   if(d.headImg!="headImg.png"){
		    		return spath+"/resources/headimg/"+d.headImg;
		    	}
		    	else{
		    		return spath+"/resources/headimg/"+d.name+".jpg";
		    	}
		    })
		    .attr("x", function(d){
				return -(1/Math.sqrt(2))*d.r;
			 })
		    .attr("y",  function(d){
				return -(1/Math.sqrt(2))*d.r;
			 })
		    .attr("width", function(d){
		    	if(image_show_flag==true){
		    		return Math.sqrt(2)*d.r;
				}
				else{
					return 0;
				}
			})
		    .attr("height", function(d){
		    	if(image_show_flag==true){
		    		return Math.sqrt(2)*d.r;
				}
				else{
					return 0;
				}
			}).on("dblclick",function(d){
				getTimeInfo("弹出修改节点 "+d.name+" 的头像对话框");
				dblclick_node = d;
				var ss = easyDialog.open({
					  container : {
						    header : '上传图片',
						    content : pop_string
						  },
					  fixed : false,
				});
				$(".easyDialog_wrapper").css("width","400px");
				send();
			});

	    if (d3.event) {
	      // prevent browser's default behavior
	      d3.event.preventDefault();
	    }

	    force.start();
	    
	    if(firstDraw){
	    	inputToCodeArea();
	    	firstDraw = false;
	    }
	    
	    //统计信息
	    getStatInfo();

	  }

	  function spliceLinksForNode(node) {
	    toSplice = links.filter(
	      function(l) { 
	        return (l.source === node) || (l.target === node); });
	    toSplice.map(
	      function(l) {
	        links.splice(links.indexOf(l), 1); });
	  }

	  function keydown() {
	    if (!selected_node && !selected_link) return;
	    switch (d3.event.keyCode) {
	      case 8: // backspace
	      case 46: { // delete
	        if (selected_node) {
	          nodes.splice(nodes.indexOf(selected_node), 1);
	          spliceLinksForNode(selected_node);
	          getTimeInfo("删除节点："+selected_node.name+"(分类："+selected_node.catagory+")"+",及其对应关系");
	        }
	        else if (selected_link) {
	          links.splice(links.indexOf(selected_link), 1);
	          getTimeInfo("删除关系："+selected_link.source.name+" 与 "+selected_link.target.name + "的" + selected_link.target.catagory);
	        }
	        selected_link = null;
	        selected_node = null;
	        redraw();
	        break;
	      }
	    }
	  }

	function getNodeAndLink(){
		var node_link = {};
		node_link.nodes = [];
		node_link.edges = [];
		console.log(nodes);
		console.log(links);
		var obj = {};
		for(var i=0;i<nodes.length;i++){
			obj = {};
			obj.name = nodes[i].name;
			obj.special = nodes[i].special;
			obj.r = nodes[i].r;
			obj.color = nodes[i].color;
			obj.catagory = nodes[i].catagory;
			obj.headImg = nodes[i].headImg;
			node_link.nodes[i] = obj;
		}
		for(var i=0;i<links.length;i++){
			obj = {};
			obj.source = links[i].source.index;
			obj.target = links[i].target.index;
			obj.weight = links[i].weight;
			node_link.edges[i] = obj;
		}
		return node_link;
	}
	
	//填充代码域
	var inputToCodeArea = function(){
		var nl = getNodeAndLink();
		$("#code").text("option = "+JsonUti.convertToString(nl));
		cvtToCode();
	}
	
	//哈希码
	function hashCode(str){
        var h = 0, off = 0;  
        var len = str.length;  
        for(var i = 0; i < len; i++){  
            h = 31 * h + str.charCodeAt(off++);  
        }  
	    var t=-2147483648*2;  
	    while(h>2147483647){  
	      h+=t  
	    }
        return h;  
	    //return str; 
    }
	
	//上传头像
	var callbackF = function(filename){
		nodes.forEach(function(p){
			if(p==dblclick_node){
				p.headImg = filename;
			}
		});
		getTimeInfo(dblclick_node.name+"的头像更改为 "+filename);
		redraw();
	}
	
	//统计信息展示、实时信息监控
	var line_number = 0;
	var getTimeInfo = function(info){
		$("#monitor").html("<div class='monitor_info'>"+(++line_number)+"、"+info+";</div>"+$("#monitor").html());
	}
	
	
	var maps_draw = [];
	var maps_draw_catagory = [];
	var maps_draw_value = [];
	
	var max_min_avg = [];
	var getStatInfo = function(){
		maps_draw = [];
		maps_draw_catagory = [];
		maps_draw_value = [];
		
		max_min_avg = [];
		
		//1、clustertype类别
		$("#stastics").html("<div class='monitor_info'>1、当前圈子分类数："+clustertype.length+"</div>");
		
		var maps = {};
		for(var i=0;i<clustertype.length;i++){
			maps[clustertype[i].catagory] = 0;
		}
		//2、分类最多、最少者
		nodes.forEach(function(d){
			maps[d.catagory] = maps[d.catagory]+1;
		});
		
		//console.log(clustertype);
		//console.log(maps);
		var max = {"count":-1,"catagory":""};
		var min = {"count":1000,"catagory":""};
		for(var i=0;i<clustertype.length;i++){
			if(max.count<maps[clustertype[i].catagory]){
				max.count = maps[clustertype[i].catagory];
				max.catagory = clustertype[i].catagory;
			}
			if(min.count>maps[clustertype[i].catagory]){
				min.count = maps[clustertype[i].catagory];
				min.catagory = clustertype[i].catagory;
			}
		}
		
		//统计所有分类中等于max和min的分类和个数
		var max_String = "";
		var min_String = "";
		var cou = 0;
		var tongji = 0;
		$.each(maps,function(key,val){
            if(val==max.count){
            	max_String += key+",为"+val+";";
            }
            if(val==min.count){
            	min_String += key+",为"+val+";";
            }
            maps_draw_catagory[cou] = key;
    		maps_draw_value[cou] = val;
    		maps_draw[cou] = {};
    		maps_draw[cou].name = key;
    		maps_draw[cou].value = val;
    		tongji += val;
    		cou++;
        });
		cou = 0;
		for(var i=0;i<maps_draw.length;i++){
			maps_draw[i].value = (maps_draw[i].value/tongji).toFixed(2);
		}
		
		
		$("#stastics").append("<div class='monitor_info'>2、个体最多分类："+max_String+"</div>");
		$("#stastics").append("<div class='monitor_info'>3、个体最少分类："+min_String+"</div>");
		//$("#stastics").append("<div class='monitor_info'>个体最多分类："+max.catagory+",为："+max.count+"</div>");
		//$("#stastics").append("<div class='monitor_info'>个体最少分类："+min.catagory+",为："+min.count+"</div>");
		
		//统计节点、线条个数
		$("#stastics").append("<div class='monitor_info'>4、个体总数："+nodes.length+"</div>");
		$("#stastics").append("<div class='monitor_info'>5、关系总数："+links.length+"</div>");
		
		console.log("-----------------------");
		console.log(nodes);
		console.log(links);
		
		//统计关系大小
		var name_To_name = [];
		nodes.forEach(function(d){
			var temp = {};
			temp.name = d.name;
			temp.count = 0;
			links.forEach(function(lk){
				if(lk.source.index==d.index || lk.target.index==d.index){
					temp.count = temp.count+1;
				}
			});
			name_To_name.push(temp);
		});
		
		console.log(name_To_name);
		
		max = {"count":-1,"catagory":""};
		min = {"count":1000,"catagory":""};
		var avg = 0;
		for(var i=0;i<name_To_name.length;i++){
			avg += name_To_name[i].count;
			if(max.count<name_To_name[i].count){
				max.count = name_To_name[i].count;
				max.catagory = name_To_name[i].name;
			}
			if(min.count>name_To_name[i].count){
				min.count = name_To_name[i].count;
				min.catagory = name_To_name[i].name;
			}
		}
		
		max_String = "";
		min_String = "";
		for(var i=0;i<name_To_name.length;i++){
			if(max.count==name_To_name[i].count){
				max_String = max.catagory+",为："+max.count+";";
			}
			if(min.count==name_To_name[i].count){
				min_String = min.catagory+",为："+min.count+";";
			}
		}
		
		$("#stastics").append("<div class='monitor_info'>6、关系最多的为："+max_String+"</div>");
		$("#stastics").append("<div class='monitor_info'>7、关系最少的为："+min_String+"</div>");
		//$("#stastics").append("<div class='monitor_info'>关系最多的为："+max.catagory+",为："+max.count+"</div>");
		//$("#stastics").append("<div class='monitor_info'>关系最少的为："+min.catagory+",为："+min.count+"</div>");
		$("#stastics").append("<div class='monitor_info'>8、平均关系数："+((avg/name_To_name.length).toFixed(2))+"</div>");
		
		max_min_avg = [max.count,min.count,(avg/name_To_name.length).toFixed(2)];
		
	}
	
	//画图分析
	var getStatistic = function(){
		var ss = easyDialog.open({
			  container : {
				    header : '可视化展示构建结果',
				    content : "<div id='showStatistics' style='border:1px solid #b0b0b0;width:100%;height:500px;overflow-y:auto;overflow-x:hidden;'></div>"
				  },
			  fixed : false,
		});
		$(".easyDialog_wrapper").css("width","800px");
		$(".easyDialog_text").css("padding","10px 10px 10px");
		
		//从此处开始画图
		//
		var hei = ($("#showStatistics").height())/2;
		var wid = ($("#showStatistics").width())/2;
		$("#showStatistics").append("<div id='infoEcharts1' style='width:"+wid+"px; height:"+hei+"px; float:left;'></div>");   
		$("#showStatistics").append("<div id='infoEcharts2' style='width:"+wid+"px; height:"+hei+"px; float:left; margin-left:390px; margin-top:-252px;'></div>");
		$("#showStatistics").append("<div id='infoEcharts3' style='width:"+wid+"px; height:"+hei+"px; float:left;'></div>");
		$("#showStatistics").append("<div id='infoEcharts4' style='width:"+wid+"px; height:"+hei+"px; float:left; margin-left:390px; margin-top:-252px;'></div>");
		$("#showStatistics").append("<button id='idb' style='position:absolute;left:15px;z-index:999'>全保存</button>");
		
		$("#idb").click(function(){
			$("#idb").css("display","none");
			$("#showStatistics").cutThisArea();
		});
		
		var myInfoChart1 = echarts.init(document.getElementById('infoEcharts1'));
		var myInfoChart2 = echarts.init(document.getElementById('infoEcharts2'));
		var myInfoChart3 = echarts.init(document.getElementById('infoEcharts3'));
		var myInfoChart4 = echarts.init(document.getElementById('infoEcharts4'));
		
		var option1={
		         title : {
	        	     x:'center',
	                 text: '各关系中个体数比例',
	             },
	             tooltip : {
	                 trigger: 'item'
	             },
	             legend: {
	            	 y:30,
	                 data:maps_draw_catagory
	             },
				 toolbox: {
	                 show : true,
	                 orient:'vertical',
	                 feature : {
	                     mark : {show: true},
	                     dataView : {
	                         show : true,
	                         title : '数据视图',
	                         readOnly: false,
	                         lang : ['数据视图', '关闭', '刷新']
	                     },
	                     restore : {show: true},
	                     saveAsImage : {show: true}
	                 }
	             },
	             calculable : true,
	             series : [
						{
						    name:'各关系中个体数比例',
						    type:'pie',
						    radius : '55%',
						    center: ['50%', '60%'],
						    data:maps_draw
						}
	               ]
	         };
		myInfoChart1.setOption(option1);
		
		var option2={
		         title : {
	        	     x:'center',
	                 text: '各关系中个体数情况',
	             },
	             tooltip : {
	                 trigger: 'axis'
	             },   
	             legend: {
	            	 y:30,
	                 data:[]
	             },
				 toolbox: {
	                 show : true,
	                 orient:'vertical',
	                 feature : {
	                     mark : {show: true},
	                     magicType: {
	                         show : true,
	                         title : {
	                             line : '动态类型切换-折线图',
	                             bar : '动态类型切换-柱形图',
	                             stack : '动态类型切换-堆积',
	                             //tiled : '动态类型切换-平铺'
	                         },
	                         //type : ['line', 'bar', 'stack', 'tiled'],
	                         type : ['line', 'bar','stack'],
	                     },
	                     dataView : {
	                         show : true,
	                         title : '数据视图',
	                         readOnly: false,
	                         lang : ['数据视图', '关闭', '刷新']
	                     },
	                     restore : {show: true},
	                     saveAsImage : {show: true}
	                 }
	             },
	             calculable : true,
	             xAxis : [
	                 {
	                     type : 'category',
	                     boundaryGap : true,
	                     data : maps_draw_catagory
	                 }
	             ],
	             yAxis : [
	                 {
	                     type : 'value',
	                 }
	             ],
	             series : [
						{
						    name:'各关系中个体数情况',
						    type:'bar',
						    data:maps_draw_value
						}
	               ]
	         };
		myInfoChart2.setOption(option2);
		
		var option3={
		         title : {
	        	     x:'center',
	                 text: '个体与关系数比较',
	             },
	             tooltip : {
	                 trigger: 'item'
	             },
	             legend: {
	            	 y:30,
	                 data:[]
	             },
				 toolbox: {
	                 show : true,
	                 orient:'vertical',
	                 feature : {
	                     mark : {show: true},
	                     magicType: {
	                         show : true,
	                         title : {
	                             line : '动态类型切换-折线图',
	                             bar : '动态类型切换-柱形图',
	                             stack : '动态类型切换-堆积',
	                             //tiled : '动态类型切换-平铺'
	                         },
	                         //type : ['line', 'bar', 'stack', 'tiled'],
	                         type : ['line', 'bar','stack'],
	                     },
	                     dataView : {
	                         show : true,
	                         title : '数据视图',
	                         readOnly: false,
	                         lang : ['数据视图', '关闭', '刷新']
	                     },
	                     restore : {show: true},
	                     saveAsImage : {show: true}
	                 }
	             },
	             calculable : true,
	             xAxis : [
	                 {
	                     type : 'category',
	                     boundaryGap : true,
	                     data : ['个体数','关系数']
	                 }
	             ],
	             yAxis : [
	                 {
	                     type : 'value',
	                 }
	             ],
	             series : [
						{
						    type:'bar',
						    data:[nodes.length,links.length]
						}
	               ]
	         };
		myInfoChart3.setOption(option3);
		
		var option4={
		         title : {
	        	     x:'center',
	                 text: '圈子内关系情况',
	             },
	             tooltip : {
	                 trigger: 'item'
	             },
	             legend: {
	            	 y:30,
	                 data:[]
	             },
				 toolbox: {
	                 show : true,
	                 orient:'vertical',
	                 feature : {
	                     mark : {show: true},
	                     magicType: {
	                         show : true,
	                         title : {
	                             line : '动态类型切换-折线图',
	                             bar : '动态类型切换-柱形图',
	                             stack : '动态类型切换-堆积',
	                             //tiled : '动态类型切换-平铺'
	                         },
	                         //type : ['line', 'bar', 'stack', 'tiled'],
	                         type : ['line', 'bar','stack'],
	                     },
	                     dataView : {
	                         show : true,
	                         title : '数据视图',
	                         readOnly: false,
	                         lang : ['数据视图', '关闭', '刷新']
	                     },
	                     restore : {show: true},
	                     saveAsImage : {show: true}
	                 }
	             },
	             calculable : true,
	             xAxis : [
	                 {
	                     type : 'category',
	                     boundaryGap : true,
	                     data : ['最大','最小','平均值']
	                 }
	             ],
	             yAxis : [
	                 {
	                     type : 'value',
	                 }
	             ],
	             series : [
						{
						    name:'最大、最小、平均值',
						    type:'bar',
						    data:max_min_avg
						}
	               ]
	         };
		myInfoChart4.setOption(option4);
	}
	
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	
	  var multiDraw_drag = function(friend_net){
		  getTimeInfo("刷新视图");
		  force.stop();
		  force = null;
		  
		  d3.select("#panel_net").remove();

		  // init svg
		  outer = d3.select("#chart")
		      .append("svg:svg").attr("id","panel_net")
		      .attr("width", width)
		      .attr("height", height)
		      .attr("pointer-events", "all")
		      .style("margin-left","75px");
		      //.style("width","95%")
		      //.style("height","90%");

		  vis = outer
		      .append('svg:g')
		      .attr("class","content_net")
		      .call(d3.behavior.zoom().on("zoom", rescale))
		      .on("dblclick.zoom", null)
		      .append('svg:g')

		  vis.append('svg:rect')
		      .attr('width', width)
		      .attr('height', height)
		      .attr('fill', 'white').style("fill-opacity",0);
		  
		  //先对friend_net的颜色值进行重新定义
		  for(var i=0;i<friend_net.nodes.length;i++){
			  friend_net.nodes[i].color = hashCode(friend_net.nodes[i].catagory);
		  }
		  
		  force = d3.layout.force()
			      .size([width, height])
			      .charge([-500])
				  .linkDistance([150])
			      .nodes(friend_net.nodes)
			      .links(friend_net.edges)
			      .on("tick", tick);
		  //nodes = force.nodes();
		  //links = force.links();
		  
		// line displayed when dragging new nodes
		  drag_line = vis.append("line")
		      .attr("class", "drag_line")
		      .attr("x1", 0)
		      .attr("y1", 0)
		      .attr("x2", 0)
		      .attr("y2", 0);

		  // get layout properties
		  nodes = force.nodes();
		  links = force.links();
		  node = vis.selectAll(".node_group");
		  link = vis.selectAll(".link");

		  
		  redraw_drag();
	  }
	  
	// redraw force layout
	  function redraw_drag() {
		
	    //先画出图例
	    clustertype = [];
		for(var i = 0,len = nodes.length;i < len;i++){ 
			! RegExp(nodes[i]["catagory"],"g").test(clustertype.join(",")) && (clustertype.push(nodes[i]["catagory"])); 
		}
		console.log(clustertype);
		//clustertype.sort();
		for(var i=0,len=clustertype.length;i<len;i++){
			clustertype[i] = {"catagory":clustertype[i],"color":hashCode(clustertype[i])};
		}
		console.log(clustertype);
		
		//对图例数据进行前期处理
		
		//画出图例
		var legend_all = outer.selectAll("g.legend").data(clustertype);
		var legend = legend_all.enter().append("g")
		  .attr("class","legend")
		  .style("pointer-events","all")
  		  .style("cursor","pointer")
  		  .attr("transform", function(d, i) { return "translate("+25+"," + (25+i*35) + ")"; })
  		  .on("click",function(xx){
  			  getTimeInfo("您操作了图例,类别："+xx.catagory);
  			
		      var cl = $($(d3.event.target)[0]).attr("class");
		      cl = cl.replace("_label","").replace("legend_text ","").replace("legend_rect ","");
		      c2 = cl.replace("class_",""); 
		      var col = $("#"+cl).attr("fill");
		      //alert(cl);
		      //改动links线条
		      d3.selectAll(".link")
		        .style("stroke-opacity",function(d){
		        	if(col=="gray"){
		        		if(d.source.color==c2 || d.target.color==c2){
    		        		return 1;
    		        	}
		        	}
		        	else{
		        		if(d.source.color==c2 || d.target.color==c2){
    		        		return 0;
    		        	}
		        	}
		        	
		        });
		      
		      d3.selectAll(".node_group")
		        .style("opacity",function(d){
		        	if(col=="gray"){
		        		if(d.color==c2){
    		        		return 1;
    		        	}
		        	}
		        	else{
		        		if(d.color==c2){
    		        		return 0;
    		        	}
		        	}
		        });

		      if(col=="gray"){
				 d3.select("#"+cl).attr("fill",function(d){return color(d.color)});
			  }
		      else{
		    	  d3.select("#"+cl).attr("fill","gray");
			  }
		      d3.select("#"+cl).style("fill-opacity","1");
	          
		  });
			  
		  legend.append("svg:circle") 
			    .attr("id", function(d){return "class_"+d.color})
		  		.attr("class", function(d){return "legend_rect class_"+d.color})
		  		.attr("cx",12)
		  		.attr("cy",12)
		  		.attr('r', 8)
		    	//.attr('height', 20)
		  		.attr("fill", function(d){return color(d.color)})
			  
		  legend.append("svg:text")
		  		.attr("x",25)
		  		.attr("y",18)
				.attr("class", function(d){return "legend_text class_"+d.color+"_label"})
				.text(function(d) { return d.catagory.trim(); });
		  
		  legend_all.exit().remove();
		  
		  //刷新legend视图
		  d3.selectAll(".legend").select(".legend_rect")
		  	.attr("id", function(d){return "class_"+d.color})
	  		.attr("class", function(d){return "legend_rect class_"+d.color})
	  		.attr("fill", function(d){return color(d.color)});
		  d3.selectAll(".legend").select(".legend_text")
		  	.attr("class", function(d){return "legend_text class_"+d.color+"_label"})
			.text(function(d) { return d.catagory.trim(); });
		  
		  
	    link = link.data(links);
	    
	    link.enter().insert("line", ".node_group")
	        .attr("class", function(d){return "link classs_"+d.source.color+"_"+d.target.color})
	        .attr("stroke-width",function(d) {
					//return Math.sqrt(d.weight+1); 
	        	return d.weight; 
		     })
	        .on("mousedown", 
	          function(d) { 
	             mousedown_link = d;
	             if (mousedown_link == selected_link){
	            	 selected_link = null;
	            	 getTimeInfo("取消选中关系："+d.source.name+" 与 "+d.target.name+" 的 "+d.target.catagory+" 关系");
	             }
	             else{
	            	 selected_link = mousedown_link; 
	            	 getTimeInfo("选中关系："+d.source.name+" 与 "+d.target.name+" 的 "+d.target.catagory+" 关系");
	             }
	             selected_node = null; 
	             redraw_drag(); 
	          })
	        .on("dblclick",function(d){
	        	getTimeInfo("弹出修改关系强弱对话框");
	        	edit_link = d;
				var ss = easyDialog.open({
					  container : {
						    header : '修改宽度',
						    content : content_html_link,
						    noFn : bt_no,
						    yesFn : btnFn_crop_link
						  },
					  fixed : false,
				});
				$("#linkweight_before").val(d.weight);
				$("#easyDialogYesBtn").text("修改");
	        });

	    //确定按钮的点击回调事件
	    var btnFn_crop_link = function(){
	    	var linkweight_before = $("#linkweight_before").val();
	        var linkweight_after = $("#linkweight_after").val();
	        if(edit_link!=null && edit_link!=undefined){
	        	links.forEach(function(d){
	    			if(d==edit_link){
	    			//if(d.name==filename_before){
	    				d.weight = linkweight_after;
	    				getTimeInfo(d.source.name+" 与 "+d.target.name+" 的 "+d.target.catagory+" 关系强度由 "+linkweight_before+" 修改为："+linkweight_after);
	    			}
	            });
	        	redraw_drag();
	        }
	    	return true;
	    };

	    link.exit().remove();

	    //对重新绑定的数据进行绘制
	    link.attr("class", function(d){return "link classs_"+d.source.color+"_"+d.target.color})
	    	.attr("stroke-width",function(d) { 
		        if(d.weight!=undefined){
		        	return d.weight;
		        }
	      })
	     .style("stroke-opacity",function(d){
			if(d._stroke_opacity!=undefined && d._stroke_opacity!=null){
				return 0.1;
			}
			else{
				return 1;
			}
	     });

	    link.classed("link_selected", function(d) { return d === selected_link; });

	    node = node.data(nodes);

	    var node_group = node.enter()
			.insert("g","node_group")
			.attr("class",function(d){return "node_group classs_"+d.color})
			.on("mousedown", 
		          function(d) {
		            // disable zoom
					getTimeInfo("关闭缩放功能");
					scale_flag = true;
					
		            vis.call(d3.behavior.zoom().on("zoom"), null);
		
		            mousedown_node = d;
		            if (mousedown_node == selected_node) {
		            	getTimeInfo("取消选中节点："+d.name);
		            	selected_node = null;
		            }
		            else {
		            	getTimeInfo("选中节点："+d.name);
		            	selected_node = mousedown_node; 
		            }
		            selected_link = null; 
		
		            // reposition drag line
		            drag_line
		                .attr("class", "drag_line")
		                .attr("x1", mousedown_node.x)
		                .attr("y1", mousedown_node.y)
		                .attr("x2", mousedown_node.x)
		                .attr("y2", mousedown_node.y);
		
		            redraw_drag(); 
		          })
		        .on("mousedrag",
		          function(d) {
		            // redraw();
		          })
				.on("click",function(d){
					if(input_circle){//编辑图形
						alert("编辑图形");
					}
					else{//强调关系
						//alert("强调关系");
	
						//首先清除原始信息
						links.forEach(function(p){
							p._stroke_opacity = undefined;
						});
						nodes.forEach(function(nq){
							nq._opacity = undefined;
						});
	
						//查看是否处于强调状态
						var flag = false;//默认非强调状态
						nodes.forEach(function(nq){
							if(nq._emp_circle!=undefined && nq._emp_circle!=null){
								flag = true;
							}
						});
						if(!flag){
							getTimeInfo("强调与 "+d.name+" 的关系");
							d._emp_circle = "emp";
							links.forEach(function(p){
								if(p.source!=d && p.target!=d){
									p._stroke_opacity = 0.1;
									nodes.forEach(function(nq){
										if(p.source==nq || p.target==nq){
											nq._opacity = 0.1;
										}
									});
								}
							});
							links.forEach(function(p){
								if(p._stroke_opacity==undefined || p._stroke_opacity==null){
									nodes.forEach(function(nq){
										if(p.source==nq || p.target==nq){
											nq._opacity = null;
										}
									});
								}
							});
							
							//拼出跟选中节点有关联的节点，及其关系
							var temp_source = "";//该节点为原节点
							var temp_target = "";//该节点为目标节点
							links.forEach(function(p){
								if(p._stroke_opacity==undefined || p._stroke_opacity==null){
									nodes.forEach(function(nq){
										if(p.source==nq){
											temp_source += "出度："+p.source.name+",入度："+p.target.name+",关系："+p.target.catagory+"\n";
										}
										else if(p.target==nq){
											temp_source += "入度："+p.source.name+",出度："+p.target.name+",关系："+p.source.catagory+"\n";
										}
									});
								}
							});
							getTimeInfo(temp_source+";<br>"+temp_target);
							
						}
						else{
							getTimeInfo("取消强调关系");
							nodes.forEach(function(nq){
								nq._emp_circle = null;
							});
						}
						redraw_drag();
					}
		        }).call(force.drag);

	    d3.selectAll(".node_group")
	    	.attr("class",function(d){return "node_group classs_"+d.color})
	    	.style("opacity",function(d){
			if(d._opacity!=undefined && d._opacity!=null){
				return 0.1;
			}
			else{
				return 1;
			}
	     });
	    
	    node_group.insert("circle")
	        .attr("class", "node")
	        .style("fill", function(d) {
	            if(!d._color) d._color = color(d.color);
	            return d._color;
			 })
			 .on("dblclick",function(d){
				 	getTimeInfo("弹出修改 "+d.name+ " 半径和分类的窗口");
		        	edit_node = d;
					var ss = easyDialog.open({
						  container : {
							    header : '修改半径和分类',
							    content : content_html_circle,
							    noFn : bt_no,
							    yesFn : btnFn_crop_circle
							  },
						  fixed : false,
					});
					$("#circle_r_before").val(d.r);
					$("#color_before").val(d.catagory);
					$("#easyDialogYesBtn").text("修改");
		     })
	        .transition()
	        .duration(750)
	        .ease("elastic")
	        .attr("r", function(d){return d.r;});

	    node.exit().transition().remove();

	    //确定按钮的点击回调事件
	    var btnFn_crop_circle = function(){
	    	var circle_r_before = $("#circle_r_before").val();
	        var circle_r_after = $("#circle_r_after").val();
	        var color_before = $("#color_before").val();
	        var color_after = $("#color_after").val();
	        if(edit_node!=null && edit_node!=undefined){
	        	nodes.forEach(function(d){
	    			if(d==edit_node){
	    			//if(d.name==filename_before){
	    				if(circle_r_after.trim()!="")d.r = parseFloat(circle_r_after);
	    				if(color_after.trim()!=""){
	    					d.catagory = color_after;
	    					//动态分配颜色值
	    					d.color = hashCode(color_after);
	    				}
	    				d._color = null;
	    				
	    				var temp = "";
	    				if(circle_r_after.trim()!="" && color_after.trim()!=""){
	    					temp = edit_node.name+" 的半径更改为："+circle_r_after+",分类更改为："+color_after;
	    				}
	    				else if(circle_r_after.trim()==""){
	    					temp = edit_node.name+" 的分类更改为："+color_after;
	    				}
	    				else
	    				{
	    					temp = edit_node.name+" 的半径更改为："+circle_r_after;
	    				}
	    				getTimeInfo(temp);
	    			}
	            });
	        	redraw_drag();
	        }
	    	return true;
	    };

	    //对重新绑定的数据进行绘制
	    //nodes = force.nodes();
	    //console.log(nodes);
	    d3.selectAll(".node_group").select(".node").attr("r", function(d){return d.r;})
			.style("fill", function(d) {
				if(!d._color) d._color = color(d.color);
				return d._color;
			});
	    

	    d3.selectAll(".node").classed("node_selected", function(d) { return d === selected_node; });

	    //********加入名字*****************************************************************************************************
	    node_group.append("svg:text")
			.attr("class","node_name")
			.text(function(d) { return d.name })
			.attr("dx",function(d){return d.r+5})
			.attr("dy",function(d){return d.r/2})
			.on("dblclick",function(d){
				getTimeInfo("弹出修改节点 "+d.name+" 的对话框");
				edit_node = d;
				var ss = easyDialog.open({
					  container : {
						    header : '修改节点名称',
						    content : content_html,
						    noFn : bt_no,
						    yesFn : btnFn_crop
						  },
					  fixed : false,
				});
				$("#filename_before").val(d.name);
				$("#easyDialogYesBtn").text("修改");
    	  });
		  
	    //对重新绑定的数据进行绘制
	    //nodes = force.nodes();
	    //console.log(nodes);
	    d3.selectAll(".node_group").select(".node_name")
		   .text(function(d){return d.name;})
		   .attr("dx",function(d){return d.r+5})
		   .attr("dy",function(d){return d.r/2});
		  
	  //取消按钮的点击回调事件
	    var bt_no = function(){
	    	getTimeInfo("取消弹窗");
	    	return true;
	    };

	    //确定按钮的点击回调事件
	    var btnFn_crop = function(){
	    	var filename_before = $("#filename_before").val();
	        var filename_after = $("#filename_after").val();
	        if(edit_node!=null && edit_node!=undefined){
	        	nodes.forEach(function(d){
	    			if(d==edit_node){
	    			//if(d.name==filename_before){
	    				d.name = filename_after;
	    				getTimeInfo(edit_node.name+" 的名称更改为："+filename_after);
	    			}
	            });
	        	redraw_drag();
	        }
	    	return true;
	    };

	    //********加入图片*****************************************************************************************************
	    node_group.append("svg:image")
			.attr("class","node_images")
		    .attr("xlink:href", function(d){
		    	if(d.headImg!="headImg.png"){
		    		return spath+"/resources/headimg/"+d.headImg;
		    	}
		    	else{
		    		return spath+"/resources/headimg/"+d.name+".jpg";
		    	}
		    })
		    .attr("x", function(d){
				return -(1/Math.sqrt(2))*d.r;
			 })
		    .attr("y",  function(d){
				return -(1/Math.sqrt(2))*d.r;
			 })
		    .attr("width", function(d){
		    	if(image_show_flag==true){
		    		return Math.sqrt(2)*d.r;
				}
				else{
					return 0;
				}
			})
		    .attr("height", function(d){
		    	if(image_show_flag==true){
		    		return Math.sqrt(2)*d.r;
				}
				else{
					return 0;
				}
			}).on("dblclick",function(d){
				getTimeInfo("弹出修改节点 "+d.name+" 的头像对话框");
				dblclick_node = d;
				var ss = easyDialog.open({
					  container : {
						    header : '上传图片',
						    content : pop_string
						  },
					  fixed : false,
				});
				$(".easyDialog_wrapper").css("width","400px");
				send();
    	    });
		   // .attr("pointer-events", "all");

	    //对重新绑定的数据进行绘制
	    d3.selectAll(".node_group").select(".node_images")
		   .attr("xlink:href", function(d){
			   if(d.headImg!="headImg.png"){
		    		return spath+"/resources/headimg/"+d.headImg;
		    	}
		    	else{
		    		return spath+"/resources/headimg/"+d.name+".jpg";
		    	}
		    })
		    .attr("x", function(d){
				return -(1/Math.sqrt(2))*d.r;
			 })
		    .attr("y",  function(d){
				return -(1/Math.sqrt(2))*d.r;
			 })
		    .attr("width", function(d){
		    	if(image_show_flag==true){
		    		return Math.sqrt(2)*d.r;
				}
				else{
					return 0;
				}
			})
		    .attr("height", function(d){
		    	if(image_show_flag==true){
		    		return Math.sqrt(2)*d.r;
				}
				else{
					return 0;
				}
			}).on("dblclick",function(d){
				getTimeInfo("弹出修改节点 "+d.name+" 的头像对话框");
				dblclick_node = d;
				var ss = easyDialog.open({
					  container : {
						    header : '上传图片',
						    content : pop_string
						  },
					  fixed : false,
				});
				$(".easyDialog_wrapper").css("width","400px");
				send();
			});

	    if (d3.event) {
	      // prevent browser's default behavior
	      d3.event.preventDefault();
	    }

	    force.start();
	    
	    if(firstDraw){
	    	inputToCodeArea();
	    	firstDraw = false;
	    }
	    
	    //统计信息
	    getStatInfo();

	  }
	
		
