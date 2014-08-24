function apriori_analyse()
{
	var attrselected=$("#select2 option");
	var ids="";
	for(var i=0;i<attrselected.length;i++)
	{
		ids+=attrselected.eq(i).val()+",";
	}
	ids=ids.substring(0, ids.length-1)
	var lift=$("#lift").val();
	var conf=$("#conf").val();
	
	
	if(ids==""||lift==""||conf=="")
	{
		alert("参数不得为空！");
		return false;
	}
	$("#main").mask("关联规则分析，请稍后...");
	$.post("apriori",
	{
		ids:ids,
		lift:lift,
		conf:conf
	},
	function(returnedData, status) {
		if("success"==status)
		{
			var obj=eval(returnedData);
			var imagename=obj.imagename;
			var matrixcols=obj.matrixcols;
			var colsnum=obj.colsnum;
			
			$("#result").empty();
			/*$("#result").append("<div id='matrix1'></div>");
			$("#result").append("<div id='matrix2'></div>");
			$("#result").append("<div id='matrix3'></div>");
			seajs.use(["matrix", "datav"], function (Matrix, DataV) {
				var matrix1 = new Matrix("matrix1", {});
				DataV.csv("matrix1.csv", function(source){
					matrix1.setSource(source);
					matrix1.render();
				});
				
				var matrix2 = new Matrix("matrix2", {});
				DataV.csv("matrix1.csv", function(source){
					matrix2.setSource(source);
					matrix2.render();
				});
				
				var matrix3 = new Matrix("matrix3", {});
				DataV.csv("matrix1.csv", function(source){
					matrix3.setSource(source);
					matrix3.render();
				});

				matrix1.on("click", function (event) {
					var sort = new Array();
					var count;
					var pt;
					for (n=0;n<100;n++)
					{
						sort[n] = n;
					}

					for (n=0;n<100;n++)
					{	
						count = Math.random() * 99;
						count = Math.round(count);

						pt = sort[n];
						sort[n] = sort[count];
						sort[count] = pt;
					}

					matrix1.update(sort);
				});
			});*/

			var allrules=obj.allrules;
			var aprinfo=obj.aprinfo;
			
			$("#result").append("<div id='showrules'></div>");
			html="";
			html=html+"<div class='tabletitle'><div class='associalHeadTitle' title='关联规则表'>关联规则分析结果</div></div>" +
					"<table width='100%' class='table table-hover'><thead><tr class='theadstyle'>";
			html=html+"<tr>" +
					"<th>序号</th>" +
					"<th>规则</th>" +
					"<th>支持度</th>" +
					"<th>置信度</th>" +
					"<th>提升度</th></tr></thead>";
			
			for(var i=0;i<allrules.length;i++){
				html=html+"<tr>" +
						"<td>["+(i+1)+"]</td>" +
						"<td>"+allrules[i]+"</td>" +
						"<td>"+aprinfo[i][0].toFixed(4)+"</td>" +
						"<td>"+aprinfo[i][1].toFixed(4)+"</td>" +
						"<td>"+aprinfo[i][2].toFixed(4)+"</td>" +
						"</tr>";
			}
			html=html+"</table>";
			$("#showrules").append(html);
			
			
		//	$("#result").append("<div id='barchart' style='display:none;width:1000px;height:500px;margin:0 auto;'></div>");
	        var myChart = echarts.init(document.getElementById('barchart'));    
	        var option={
		         title : {
	                 text: '属性统计条形图',       
	             },
	             tooltip : {
	             },
	             legend: {
	                 data:[]
	             },
				 toolbox: {
	                 show : true,
	                 feature : {
	                     magicType: {
	                         show : true,
	                         title : {
	                             bar : '动态类型切换-柱形图',
	                             //stack : '动态类型切换-堆积',
	                             //tiled : '动态类型切换-平铺'
	                         },
	                         //type : ['line', 'bar', 'stack', 'tiled'],
	                         type : ['line', 'bar'],
	                     },
	                     dataView : {
	                         show : true,
	                         title : '数据视图',
	                         readOnly: false,
	                         lang : ['数据视图', '关闭', '刷新']
	                     },
	                     dataZoom : {
	                         show : true,
	                         title : {
	                             dataZoom : '区域缩放',
	                             dataZoomReset : '区域缩放-后退'
	                         }
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
	                     data : ['属性数目']
	                 }
	             ],
	             yAxis : [
	                 {
	                     type : 'value',
	                 }
	             ],
	             series : [

	             ]
	         };
	         myChart.setOption(option);
	         var namearray=matrixcols.split("&");
	         var numarray=colsnum.split("&");
	         for ( var i = 0; i < numarray.length; i++) {
	        	 option.legend.data.push(namearray[i]);
	        	 var temp=[];
	        	 temp[0]=Number(numarray[i]);
	        	 option.series.push({
	        	         name: namearray[i], // 系列名称
	        	         type: 'bar', // 图表类型，折线图line、散点图scatter、柱状图bar、饼图pie、雷达图radar
	        	         data: temp,
	        	         barWidth:40       
	        	 });
	        	 myChart.setOption(option);
	         }
	        
	        var singlerules=[];
	        var count=0;
	        for ( var k = 0; k < allrules.length; k++) {
				var temp=allrules[k].split("=>");
				if(temp[0].split(",").length>1||temp[1].split(",").length>1){
					continue;
				}
				else if(temp[0].split(",").length==1&&temp[1].split(",").length==1){
					singlerules[count]=allrules[k];  
					count++;
				}
			}
	         
	        $("#result").append("<div id='singletosingle' style='display:none;margin:0 auto;'></div>");
	        var html="<div class='tabletitle'><div class='singleHeadTitle' title='单对单规则'>单对单规则表</div></div>"+              
	        "<div style='margin:0 auto;width:45%;height:30px;text-align:right;position:relative;'>" +
	        "<div class='lookAttrLocation' onclick='showAttrLocation();'>查看属性分布</div>" +     
	        "<div class='circleIcon'>无相关关系</div>&nbsp;" +       
	        "<div class='circleSelectIcon'>有相关关系</div>" +   
	        "</div>"+     
	        "<table class='tic_tac_toe' style='margin:0 auto;'>";                            
	        for ( var i = 0; i < namearray.length+1; i++) {        
	        	html+="<tr>";        
	        	for ( var j = 0; j < namearray.length+1; j++) {
	        		if(i==0&&j==0){
	        			html+="<th scope='col'></th>";     
	        		}
	        		else if(i==0){
	        			html+="<th scope='col'>"+namearray[j-1]+"</th>";
	        		}        
	        		else if(j==0){     
	        			html+="<th scope='row'>"+namearray[i-1]+"</th>";        
	        		}
	        		else{
	        			var hasrule="false";            
	        			for ( var k = 0; k < singlerules.length; k++) {
	        				var temp=singlerules[k].split("=>");
	        				if(temp[0].indexOf(namearray[i-1])>0&&temp[1].indexOf(namearray[j-1])>0){
	        					var tip=singlerules[k]+"\n最小支持度："+aprinfo[k][0].toFixed(4)
	        							+"\n置信度："+aprinfo[k][1].toFixed(4)
	        							+"\n提升度："+aprinfo[k][2].toFixed(4);
	        					html+="<td class='selectBg' title='"+tip+"'></td>";
	        					hasrule="true";
	        					break;
	        				}      				
						}
	        			if(hasrule=="false"){      
	        				html+="<td class='noSelectBg'></td>";
	        			}
	        		}
				}
	        	html+="</tr>"
			}
	        html+="</table>";     
	        $("#singletosingle").append(html);
	         
	         
			
			$("#result").append("<div id='rulesimg' style='display:none'><div class='tabletitle'><div class='verticalHeadTitle' title='规则有向图'>规则有向图</div></div></div>");
			html="";
			html=html+"<div align='center'><img width=600px height=600px  src='"+spath+"/rimages/"+imagename+"'></div>";
			$("#rulesimg").append(html);
			     
			
			$("#result").append("<div id='parallel' style='display:none'><div class='tabletitle'><div class='paraHeadTitle' title='平行坐标图'>平行坐标图</div></div></div>");     
			//平行坐标系的绘制，多对多
			drawParallel(allrules,aprinfo);   
			         
			
			
			//关联规则分析提示框
			// 使用each（）方法来获得每个元素的属性         
			$('.associalHeadTitle').each(function(){
				$(this).qtip({      
					content: {
						// 设置您要使用的文字图像的HTML字符串，正确的src URL加载图像
						text: '',
						title:{
							text: $(this).attr("title"), // 给工具提示使用每个元素的文本标题
							button: '关闭' // 在标题中显示关闭文字按钮
						}
					},
					position: {
						corner: {
							target: 'bottomMiddle', // 定位上面的链接工具提示
							tooltip: 'topMiddle'
						},
						adjust: {
							screen: true // 在任何时候都保持提示屏幕上的
						}
					},
					show: { 
						when: 'mouseover', //或click 
						solo: true // 一次只显示一个工具提示
					},
					hide: 'unfocus',
					style: {
						tip: true, // 设置一个语音气泡提示在指定工具提示角落的工具提示
						border: {
							width: 0,
							radius: 4
						},
						name: 'purple', // 使用默认的淡样式     
						width: 390 // 设置提示的宽度
					}
				})
			});
			
			//单对单规则提示框
			// 使用each（）方法来获得每个元素的属性         
			$('.singleHeadTitle').each(function(){
				$(this).qtip({      
					content: {
						// 设置您要使用的文字图像的HTML字符串，正确的src URL加载图像
						text: '矩阵通常用来展现一组样本的二元关系。图中色块表示对应行列两个样本之间的某种关系值，点击矩阵，将会自动通过聚类算法的计算，将这组样本进行排序聚类，从而看出这个样本集中各个样本之间的主要关系。',
						title:{
							text: $(this).attr("title"), // 给工具提示使用每个元素的文本标题
							button: '关闭' // 在标题中显示关闭文字按钮
						}
					},
					position: {
						corner: {
							target: 'bottomMiddle', // 定位上面的链接工具提示
							tooltip: 'topMiddle'
						},
						adjust: {
							screen: true // 在任何时候都保持提示屏幕上的
						}
					},
					show: { 
						when: 'mouseover', //或click 
						solo: true // 一次只显示一个工具提示
					},
					hide: 'unfocus',
					style: {
						tip: true, // 设置一个语音气泡提示在指定工具提示角落的工具提示
						border: {
							width: 0,
							radius: 4
						},
						name: 'purple', // 使用默认的淡样式     
						width: 390 // 设置提示的宽度
					}       
				})
			});    
			
			//规则有向图提示框
			// 使用each（）方法来获得每个元素的属性         
			$('.verticalHeadTitle').each(function(){
				$(this).qtip({      
					content: {
						// 设置您要使用的文字图像的HTML字符串，正确的src URL加载图像
						text: '关联规则挖掘一个常见的现象是，很多产生的规则并不是有趣的。当其它设置不发生变化的情况下，越小的支持度会产生更多的规则。这种产生的规则中项集之间的关联看起来更像是随机的。支持度，置信度，提升度是选择兴趣规则的三个方法。',
						title:{
							text: $(this).attr("title"), // 给工具提示使用每个元素的文本标题
							button: '关闭' // 在标题中显示关闭文字按钮
						}
					},
					position: {
						corner: {
							target: 'bottomMiddle', // 定位上面的链接工具提示
							tooltip: 'topMiddle'
						},
						adjust: {
							screen: true // 在任何时候都保持提示屏幕上的
						}
					},
					show: { 
						when: 'mouseover', //或click 
						solo: true // 一次只显示一个工具提示
					},
					hide: 'unfocus',
					style: {
						tip: true, // 设置一个语音气泡提示在指定工具提示角落的工具提示
						border: {
							width: 0,
							radius: 4
						},
						name: 'purple', // 使用默认的淡样式     
						width: 390 // 设置提示的宽度
					}       
				})
			});    
			
			//平行坐标系提示框
			// 使用each（）方法来获得每个元素的属性         
			$('.paraHeadTitle').each(function(){
				$(this).qtip({      
					content: {
						// 设置您要使用的文字图像的HTML字符串，正确的src URL加载图像
						text: '平行坐标是一种通常的可视化方法， 用于对 高维几何 和 多元数据 的可视化。为了表示在高维空间的一个点集， 在 N 条平行的线的背景下，（一般这 N条线都竖直且等距），一个在高维空间的点被表示为一条拐点在 N 条平行坐标轴的折线，在第 K 个坐标轴上的位置就表示这个点在第 K 个维的值。',
						title:{
							text: $(this).attr("title"), // 给工具提示使用每个元素的文本标题
							button: '关闭' // 在标题中显示关闭文字按钮
						}
					},
					position: {
						corner: {
							target: 'bottomMiddle', // 定位上面的链接工具提示
							tooltip: 'topMiddle'
						},
						adjust: {
							screen: true // 在任何时候都保持提示屏幕上的
						}
					},
					show: { 
						when: 'mouseover', //或click 
						solo: true // 一次只显示一个工具提示
					},
					hide: 'unfocus',
					style: {
						tip: true, // 设置一个语音气泡提示在指定工具提示角落的工具提示
						border: {
							width: 0,
							radius: 4
						},
						name: 'purple', // 使用默认的淡样式     
						width: 390 // 设置提示的宽度
					}       
				})
			});    
			
			$("#main").unmask();
		}
	})
}


function showAttrLocation(){
	easyDialog.open({
        container:'easydialogBar',
        overlay:false,    
        drag:true
    });
}

