;require.config({
    paths:{
    'echarts':'./resources/echartsjs/echarts',
    'echarts/chart/bar' : './resources/echartsjs/echarts-map'
}});
var echarts;
require(
     [
         'echarts',
         'echarts/chart/bar',
     ],
     function (ec) {echarts=ec}
);

function stat_analyse()
{
	//$("#result").empty();
	var attrselected=$("#select2 option");
	var ids="";
	for(var i=0;i<attrselected.length;i++)
	{
		ids+=attrselected.eq(i).val()+",";
	}
	ids=ids.substring(0, ids.length-1);
	var method=$("#method").val();
	
	if(ids=="")
	{
		alert("参数不得为空！");
		return false;
	}
	
	$("#main").mask("数据分析，请稍后...");
	$.post("statinfo",
	{
		ids:ids,
		method:method
		
	},
	function(success, data) {
		//$("#result").empty();   
		var obj=eval(data);
		var statdata=obj.statdata;
		var scatterdata=obj.scatterdata;
		var scatterdata3d=obj.scatterdata3d;
		var colors=obj.colors;
		if(method=="bar"){
			//$('#result').empty();   			
			var xaxisArray=[];   
			for ( var i = 0; i < statdata[0].length; i++) {
				xaxisArray[i]=i+1;
			}
			var legendArray=[];
			for ( var i = 0; i < statdata.length; i++) {
				legendArray[i]=attrselected.eq(i).text();
			}
			
	         var myChart = echarts.init(document.getElementById('result'));
	         var option={
		         title : {
	        	     x:'center',
	                 text: '数据统计信息（条形图）',
	             },
	             tooltip : {
	                 trigger: 'axis'
	             },
	             legend: {
	            	 y:30,
	                 data:[]
	             },
	             dataZoom : {
						show : true,
						realtime : true,
						start : 20,
						end : 80
				 },
				 toolbox: {
					 orient:'vertical',
					 x:'right',
					 y:40,
	                 show : true,
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
	                     dataZoom : {
	                         show : true,
	                         title : {
	                             dataZoom : '区域缩放',
	                             dataZoomReset : '区域缩放-后退'
	                         }
	                     },
	                     restore : {show: true},
	                     saveAsImage : {show: true},
	                     /**新加的工具箱按钮：升序排列展示**/
	                     myToolRise:{show: true, title:'升序排列', icon:'image://resources/images/icon/upload.png', onclick:function(){sortlh(myChart,ids,method);}},
	                     /**新加的工具箱按钮：降序排列展示**/
	                     myToolDown:{show: true, title:'降序排列', icon:'image://resources/images/icon/download.png', onclick:function(){sorthl(myChart,ids,method);}},
	                     /**新加的工具箱按键：多图展示**/
	                     myTool: {show: true, title:'多图展示', icon:'image://resources/images/icon/manyPicShow.png', onclick:function(){showLotsDraw(myChart,statdata,attrselected,method,ids)}}
	                 }
	             },
	             calculable : true,
	             xAxis : [
	                 {
	                     type : 'category',
	                     boundaryGap : true,
	                     data : xaxisArray
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
	         for ( var i = 0; i < statdata.length; i++) {
	        	 option.legend.data.push(attrselected.eq(i).text());
	        	 option.series.push({
	        	         name: attrselected.eq(i).text(), // 系列名称
	        	         type: 'bar', // 图表类型，折线图line、散点图scatter、柱状图bar、饼图pie、雷达图radar   
	        	         data: statdata[i],
	        	         markPoint : {
	        	                data : [
	        	                    {type : 'max', name: '最大值'},
	        	                    {type : 'min', name: '最小值'}
	        	                ]
	        	         },
	        	         markLine : {
	        	                data : [
	        	                    {type : 'average', name: '平均值'}
	        	                ]
	        	         }
	        	 });
	        	 myChart.setOption(option);
	         }

		}
		else if(method=="breakline"){
			//$('#result').empty();
			var xaxisArray=[];
			for ( var i = 0; i < statdata[0].length; i++) {
				xaxisArray[i]=i+1;
			}
			var legendArray=[];
			for ( var i = 0; i < statdata.length; i++) {
				legendArray[i]=attrselected.eq(i).text();
			}
			
             var myChart = echarts.init(document.getElementById('result'));
             var option={
		         title : {
            	     x:'center',
                     text: '数据统计信息（折线图）',
                 },
                 tooltip : {
                     trigger: 'axis'
                 },
                 legend: {
                	 y:30,
                     data:[]
                 },
                 dataZoom : {
						show : true,
						realtime : true,
						start : 20,
						end : 80
				 },
                 toolbox: {
					 orient:'vertical',
					 x:'right',
					 y:40,
                     show : true,
                     feature : {
                         mark : {show: true},
                         magicType: {
                             show : true,
                             title : {
                                 line : '动态类型切换-折线图',
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
                         saveAsImage : {show: true},   
                         /**新加的工具箱按钮：升序排列展示**/
	                     myToolRise:{show: true, title:'升序排列', icon:'image://resources/images/icon/upload.png', onclick:function(){sortlh(myChart,ids,method);}},
	                     /**新加的工具箱按钮：降序排列展示**/
	                     myToolDown:{show: true, title:'降序排列', icon:'image://resources/images/icon/download.png', onclick:function(){sorthl(myChart,ids,method);}},
                         /**新加的工具箱按键：多图展示**/                         
	                     myTool: {show: true, title:'多图展示', icon:'image://resources/images/icon/manyPicShow.png', onclick:function(){showLotsDraw(myChart,statdata,attrselected,method,ids)}}
                     }
                 },
                 calculable : true,
                 xAxis : [
                     {
                         type : 'category',
                         boundaryGap : false,
                         data : xaxisArray
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
             for ( var i = 0; i < statdata.length; i++) {
            	 option.legend.data.push(attrselected.eq(i).text());
            	 option.series.push({
            	         name: attrselected.eq(i).text(), // 系列名称
            	         type: 'line', // 图表类型，折线图line、散点图scatter、柱状图bar、饼图pie、雷达图radar
            	         data: statdata[i],
            	         markPoint : {
	        	                data : [
	        	                    {type : 'max', name: '最大值'},
	        	                    {type : 'min', name: '最小值'}
	        	                ]
	        	            },
	        	            markLine : {
	        	                data : [
	        	                    {type : 'average', name: '平均值'}
	        	                ]
	        	        }
            	 });
            	 myChart.setOption(option);
             }

		}
		else if(method=="scatter"){
			$('#result').empty();
			var colors=obj.colors;
			for (var i = 0; i < scatterdata.length; i++) {
				$('#result').append("<div style='width:48%;float:left;border:1px solid #C0C0C0;margin:5px 5px;height:500px' id=scatter"+(i+1)+"></div>")
				var myChart = echarts.init(document.getElementById("scatter"+(i+1)));
     			option = {
     				    title : {
     				        text: '数据统计信息（散点图）'
     				    },
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
     				        data:[]
     				    },
     				    toolbox: {
     				        show : true,
     				        feature : {
     				            mark : {show: true},
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
     				            scale:true,
     				            name:attrselected.eq(obj.varname[i][0]-1).text()
     				        }
     				    ],
     				    yAxis : [
     				        {
     				            type : 'value',
     				            power: 1,
     				            precision: 2,
     				            scale:true,
     				            name:attrselected.eq(obj.varname[i][1]-1).text()
     				        }
     				    ],
     				    series : [
     				            
     				        ]
     				};
     				myChart.setOption(option);
     				option.legend.data.push('V-V scatter');
	               	option.series.push({
	               	         name: 'V-V scatter', // 系列名称
	               	         type: 'scatter', // 图表类型，折线图line、散点图scatter、柱状图bar、饼图pie、雷达图radar
	               	         data: scatterdata[i],
		               	     itemStyle: {
			               		normal: {
				                    color:colors[i]
		                     	}
	               			},
	               			markPoint : {
		        	                data : [
		        	                    {type : 'max', name: '最大值'},
		        	                    {type : 'min', name: '最小值'}
		        	                ]
		        	         },
		        	         markLine : {
		        	                data : [
		        	                    {type : 'average', name: '平均值'}
		        	                ]
		        	        }
	               	});
	               	myChart.setOption(option);
             }
		}
		else if(method=="scatter3d"){
			$('#result').empty();
			for ( var i = 0; i < scatterdata3d.length; i++) {
				$('#result').append("<div style='width:48%;float:left;border:1px solid #C0C0C0;margin:5px 5px;' id=scatter3d"+(i+1)+"></div>")
				scatter3D(i+1);
				var chart = $('#scatter3d'+(i+1)).highcharts();
				chart.addSeries({
					name:attrselected.eq(obj.varname[i][0]-1).text()+"-"+attrselected.eq(obj.varname[i][1]-1).text()+"-"+attrselected.eq(obj.varname[i][2]-1).text(),
					data:scatterdata3d[i],
					colorByPoint: true
					});
				
	        }
		}
		else if(method=="box"){
			box();
			var outlier=obj.outlier;
			var chart = $('#result').highcharts();
			var cg=new Array();//x轴分类
			for(var i=0;i<attrselected.length;i++)
			{
				cg[i]=attrselected.eq(i).text();
			}
			for ( var i = 0; i < scatterdata.length; i++) {
				chart.addSeries({data:scatterdata[i],name:"观测值"});
	        }
			for ( var i = 0; i < outlier.length; i++) {
				chart.addSeries({data:outlier[i],type:"scatter",name:'离群点'});
			}
			chart.xAxis[0].setCategories(cg);
		}

		$("#main").unmask();
	});
}



/**新加的多图展示的方法**/
function showLotsDraw(myChart,statdata,attrselected,method,ids)
{
	myChart.dispose(); 
	var hei = $("#result").height();
	var eachHeight = hei/(statdata.length+1);
	
	var methodType;
	if(method == 'bar')methodType = 'bar';
	else if(method == 'breakline')methodType = 'line';
	
	var xaxisArray=[];
	for ( var i = 0; i < statdata[0].length; i++) {
		xaxisArray[i]=i+1;
	}
	var legendArray=[];
	for ( var i = 0; i < statdata.length; i++) {
		legendArray[i]=attrselected.eq(i).text();
	}
	
	var eachEChart = [];
	
	for(var i=0;i<statdata.length;i++)
	{
		if(i == 0)
		{
			var firstHeight = eachHeight+80;
			$("#result").append("<div id=domEChart"+i+" style='width:100%; height:"+firstHeight+"px; border:1px solid #E3E3E3; margin:5px;'></div>");
			eachEChart[i] = echarts.init(document.getElementById("domEChart"+i));
		}		
		else
		{
			$("#result").append("<div id=domEChart"+i+" style='width:100%; height:"+eachHeight+"px; border:1px solid #E3E3E3; margin:5px;'></div>");
			eachEChart[i] = echarts.init(document.getElementById("domEChart"+i));
		}
			
	}
	
	for(var i=0;i<eachEChart.length;i++)
	{
		if(i == 0)
		{
			var option={
			         title : {
				         x:'center',
		                 text: '数据统计信息（条形图）',
		             },
		             tooltip : {
		                 trigger: 'axis',
		                 formatter:function(params){
		            	     var res = params[0][1]+'<br/>'+params[0][0]+':'+params[0][2];
		            	     return res;
		                 }
		             },
		             legend: {
		            	 y: 30,
		                 data:[]
		             },
		             dataZoom : {
							show : true,
							realtime : true,
							start : 20,
							end : 80
					 },
					 toolbox: {
						 //orient:'vertical',
						 //x:'right',
		                 show : true,
		                 feature : {
		                     mark : {show: true},
		                     magicType: {
		                         show : true,
		                         title : {
		                             line : '动态类型切换-折线图',
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
		                     saveAsImage : {show: true},		                        
		                     /**新加的工具箱按键：多图展示**/
		                     myToolSingle: {show: true, title:'单图展示', icon:'image://resources/images/icon/singlePicShow.png', onclick:function(){showSingleDraw(statdata,attrselected,method,ids);}}
		                 }
		             },
		             calculable : true,
		             xAxis : [
		                 {
		                     type : 'category',
		                     boundaryGap : true,
		                     data : xaxisArray
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
			eachEChart[i].setOption(option);
			
			option.legend.data.push(attrselected.eq(i).text());
			option.series.push(
					{
	                	 name: attrselected.eq(i).text(), // 系列名称
	        	         type: methodType, // 图表类型，折线图line、散点图scatter、柱状图bar、饼图pie、雷达图radar
	        	         data: statdata[i],
	        	         markPoint : {
	        	                data : [   
	        	                    {type : 'max', name: '最大值'},
	        	                    {type : 'min', name: '最小值'}
	        	                ]
	        	         },
	        	         markLine : {
	        	                data : [
	        	                    {type : 'average', name: '平均值'}
	        	                ]
	        	         }	   
	                 }	
			);
			eachEChart[i].setOption(option);
			
			for(var j=1;j<eachEChart.length;j++)
			{
				option.legend.data.push(attrselected.eq(j).text());
				option.series.push({
					 name: attrselected.eq(j).text(),
	       	         type: methodType,
	       	         data:[]
				});
				eachEChart[i].setOption(option);
			}
		}
		
		else
		{
			var option={
		             tooltip : {
		                 trigger: 'axis'
		             },
		             legend: {
		            	 y:-120,
		                 data:legendArray
		             },
					 toolbox: {
		            	 y:-120,
		                 show : true,
		                 feature : {
		                     mark : {show: true},
		                     magicType: {
		                         show : true,
		                         title : {
		                             line : '动态类型切换-折线图',
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
		                     saveAsImage : {show: true},
		                     /**新加的工具箱按键：多图展示**/
		                     myTool: {show: true, title:'单图展示'}
		                 }
		             },
		             calculable : true,
		             grid:{
		            	 y:20,
		            	 y2:25
		             },
		             xAxis : [
		                 {
		                     type : 'category',
		                     boundaryGap : true,
		                     data : xaxisArray
		                 }
		             ],
		             yAxis : [
		                 {
		                     type : 'value',
		                 }
		             ],
		             series : [
		                 {
		                	 name: attrselected.eq(i).text(), // 系列名称
		        	         type: methodType, // 图表类型，折线图line、散点图scatter、柱状图bar、饼图pie、雷达图radar
		        	         data: statdata[i],
		        	         markPoint : {
		        	                data : [
		        	                    {type : 'max', name: '最大值'},
		        	                    {type : 'min', name: '最小值'}
		        	                ]
		        	         },
		        	         markLine : {
		        	                data : [
		        	                    {type : 'average', name: '平均值'}
		        	                ]
		        	         }	   
		                 }
		               ]
		         };
			//alert(statdata[i]);
			eachEChart[i].setOption(option);
		}
		
		
		/**var eChartArry = new Array(eachEChart.length);
		for(var i=0;i<eachEChart.length;i++)
		{			
			var temp = new Array(eachEChart.length-1);
			for(var j=0;j<eachEChart.length;j++)
			{
				if(i != j)temp.push(eachEChart[j]);				
			}
			console.log(temp);
			eachEChart[i].connect(temp);
		} 
		
		for(var i=0;i<eachEChart.length;i++)
		{
			eachEChart[i].connect(eChartArry[i]);
		}**/
		if(eachEChart.length == 7)
		{
			eachEChart[0].connect([eachEChart[1],eachEChart[2],eachEChart[3],eachEChart[4],eachEChart[5],eachEChart[6]]);
			eachEChart[1].connect([eachEChart[0],eachEChart[2],eachEChart[3],eachEChart[4],eachEChart[5],eachEChart[6]]);
			eachEChart[2].connect([eachEChart[0],eachEChart[1],eachEChart[3],eachEChart[4],eachEChart[5],eachEChart[6]]);
			eachEChart[3].connect([eachEChart[0],eachEChart[1],eachEChart[2],eachEChart[4],eachEChart[5],eachEChart[6]]);
			eachEChart[4].connect([eachEChart[0],eachEChart[1],eachEChart[2],eachEChart[3],eachEChart[5],eachEChart[6]]);
			eachEChart[5].connect([eachEChart[0],eachEChart[1],eachEChart[2],eachEChart[3],eachEChart[4],eachEChart[6]]);
			eachEChart[6].connect([eachEChart[1],eachEChart[2],eachEChart[3],eachEChart[4],eachEChart[5],eachEChart[5]]);
		}
		if(eachEChart.length == 6)
		{
			eachEChart[0].connect([eachEChart[1],eachEChart[2],eachEChart[3],eachEChart[4],eachEChart[5]]);
			eachEChart[1].connect([eachEChart[0],eachEChart[2],eachEChart[3],eachEChart[4],eachEChart[5]]);
			eachEChart[2].connect([eachEChart[0],eachEChart[1],eachEChart[3],eachEChart[4],eachEChart[5]]);
			eachEChart[3].connect([eachEChart[0],eachEChart[1],eachEChart[2],eachEChart[4],eachEChart[5]]);
			eachEChart[4].connect([eachEChart[0],eachEChart[1],eachEChart[2],eachEChart[3],eachEChart[5]]);
			eachEChart[5].connect([eachEChart[0],eachEChart[1],eachEChart[2],eachEChart[3],eachEChart[4]]);
		}
		if(eachEChart.length == 5)
		{
			eachEChart[0].connect([eachEChart[1],eachEChart[2],eachEChart[3],eachEChart[4]]);
			eachEChart[1].connect([eachEChart[0],eachEChart[2],eachEChart[3],eachEChart[4]]);
			eachEChart[2].connect([eachEChart[0],eachEChart[1],eachEChart[3],eachEChart[4]]);
			eachEChart[3].connect([eachEChart[0],eachEChart[1],eachEChart[2],eachEChart[4]]);
			eachEChart[4].connect([eachEChart[0],eachEChart[1],eachEChart[2],eachEChart[3]]);
		}
		if(eachEChart.length == 4)
		{
			eachEChart[0].connect([eachEChart[1],eachEChart[2],eachEChart[3]]);
			eachEChart[1].connect([eachEChart[0],eachEChart[2],eachEChart[3]]);
			eachEChart[2].connect([eachEChart[0],eachEChart[1],eachEChart[3]]);
			eachEChart[3].connect([eachEChart[0],eachEChart[1],eachEChart[2]]);
		}
		if(eachEChart.length == 3)
		{
			eachEChart[0].connect([eachEChart[1],eachEChart[2]]);
			eachEChart[1].connect([eachEChart[0],eachEChart[2]]);
			eachEChart[2].connect([eachEChart[0],eachEChart[1]]);
		}
		if(eachEChart.length == 2)
		{
			eachEChart[0].connect([eachEChart[1]]);
			eachEChart[1].connect([eachEChart[0]]);   
		}
			
	}
	//alert(statdata[2]);
}
/**结束**/



/**多图恢复到单图的函数**/
function showSingleDraw(statdata,attrselected,method,ids)
{
	$('#result').empty();
	
	if(method=="bar"){
		var xaxisArray=[];
		for ( var i = 0; i < statdata[0].length; i++) {
			xaxisArray[i]=i+1;
		}
		var legendArray=[];
		for ( var i = 0; i < statdata.length; i++) {
			legendArray[i]=attrselected.eq(i).text();
		}
		
         var myChart = echarts.init(document.getElementById('result'));
         var option={
	         title : {
        	     x:'center',
                 text: '数据统计信息（条形图）',
             },
             tooltip : {
                 trigger: 'axis'
             },
             legend: {
            	 y:30,
                 data:[]
             },
             dataZoom : {
					show : true,
					realtime : true,
					start : 20,
					end : 80
			 },
			 toolbox: {
				 orient:'vertical',
				 x:'right',
				 y:40,
                 show : true,
                 feature : {
                     mark : {show: true},
                     magicType: {
                         show : true,
                         title : {
                             line : '动态类型切换-折线图',
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
                     saveAsImage : {show: true},
                     /**新加的工具箱按钮：升序排列展示**/
                     myToolRise:{show: true, title:'升序排列', icon:'image://resources/images/icon/upload.png', onclick:function(){sortlh(myChart,ids,method);}},   
                     /**新加的工具箱按钮：降序排列展示**/
                     myToolDown:{show: true, title:'降序排列', icon:'image://resources/images/icon/download.png', onclick:function(){sorthl(myChart,ids,method);}},
                     /**新加的工具箱按键：多图展示**/
                     myToolLots: {show: true, title:'多图展示', icon:'image://resources/images/icon/manyPicShow.png', onclick:function(){showLotsDraw(myChart,statdata,attrselected,method,ids)}}
                 }
             },
             calculable : true,
             xAxis : [
                 {
                     type : 'category',
                     boundaryGap : true,
                     data : xaxisArray
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
         for ( var i = 0; i < statdata.length; i++) {
        	 option.legend.data.push(attrselected.eq(i).text());
        	 option.series.push({
        	         name: attrselected.eq(i).text(), // 系列名称
        	         type: 'bar', // 图表类型，折线图line、散点图scatter、柱状图bar、饼图pie、雷达图radar
        	         data: statdata[i],
        	         markPoint : {
        	                data : [
        	                    {type : 'max', name: '最大值'},
        	                    {type : 'min', name: '最小值'}
        	                ]
        	         },
        	         markLine : {
        	                data : [
        	                    {type : 'average', name: '平均值'}
        	                ]
        	         }
        	 });
        	 myChart.setOption(option);
         }

	}
	else if(method=="breakline"){
		var xaxisArray=[];
		for ( var i = 0; i < statdata[0].length; i++) {
			xaxisArray[i]=i+1;
		}
		var legendArray=[];
		for ( var i = 0; i < statdata.length; i++) {
			legendArray[i]=attrselected.eq(i).text();
		}
		
         var myChart = echarts.init(document.getElementById('result'));
         var option={
	         title : {
        	     x:'center',
                 text: '数据统计信息（折线图）',
             },
             tooltip : {
                 trigger: 'axis'
             },
             legend: {
            	 y:30,
                 data:[]
             },
             dataZoom : {
					show : true,
					realtime : true,
					start : 20,
					end : 80
			 },
             toolbox: {
				 orient:'vertical',
				 x:'right',
				 y:40,
                 show : true,
                 feature : {
                     mark : {show: true},
                     magicType: {
                         show : true,
                         title : {
                             line : '动态类型切换-折线图',
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
                     saveAsImage : {show: true},
                     /**新加的工具箱按钮：升序排列展示**/
                     myToolRise:{show: true, title:'升序排列', icon:'image://resources/images/icon/upload.png', onclick:function(){sortlh(myChart,ids,method);}},
                     /**新加的工具箱按钮：降序排列展示**/
                     myToolDown:{show: true, title:'降序排列', icon:'image://resources/images/icon/download.png', onclick:function(){sorthl(myChart,ids,method);}},
                     /**新加的工具箱按键：多图展示**/
                     myTool: {show: true, title:'多图展示', icon:'image://resources/images/icon/manyPicShow.png', onclick:function(){showLotsDraw(myChart,statdata,attrselected,method,ids)}}
                 }
             },
             calculable : true,
             xAxis : [
                 {
                     type : 'category',
                     
                     boundaryGap : false,
                     data : xaxisArray
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
         for ( var i = 0; i < statdata.length; i++) {
        	 option.legend.data.push(attrselected.eq(i).text());
        	 option.series.push({
        	         name: attrselected.eq(i).text(), // 系列名称
        	         type: 'line', // 图表类型，折线图line、散点图scatter、柱状图bar、饼图pie、雷达图radar
        	         data: statdata[i],
        	         markPoint : {
        	                data : [
        	                    {type : 'max', name: '最大值'},
        	                    {type : 'min', name: '最小值'}
        	                ]
        	            },
        	            markLine : {
        	                data : [
        	                    {type : 'average', name: '平均值'}
        	                ]
        	        }
        	 });
        	 myChart.setOption(option);
         }

	}
}
/**结束**/



function box(){
	$('#result').highcharts({
	    chart: {
	        type: 'boxplot'
	    },
	    title: {
	        text: '数据统计信息（盒形图）'
	    },
	    legend: {
	        enabled: false
	    },
	    xAxis: {
	    },
	    yAxis: {
	    	title: {
	        	text: '观测值'
	    	},
	    },
        credits:{
            enabled:false
        }
	});
}


function reset(ids){
	var attrselected=$("#select2 option");
	$.post("resetbar",
	{
		ids:ids,
		
	},
	function(success, data) {
		$("#result").empty();
		var obj=eval(data);
		var statdata=obj.statdata;
		
		bar();
		var chart = $('#result').highcharts();
		for ( var i = 0; i < statdata.length; i++) {
			 chart.addSeries({data:statdata[i],name:attrselected.eq(i).text()});
        }
		$('#result').append("<input type='button'  class='btn imageOpr' value='reset the bar' onclick=reset('"+obj.ids+"');>");
		$('#result').append("<input type='button'  class='btn imageOpr' value='sort from high to low' onclick=sorthl('"+obj.ids+"');>");
		$('#result').append("<input type='button'  class='btn imageOpr' value='sort from low to high' onclick=sortlh('"+obj.ids+"');>");
		
	});
}


/**降序排列**/
function sorthl(myChart,ids,method){
	var attrselected=$("#select2 option");
	//myChart.dispose();
	$.post("sorthl",
	{
		ids:ids,
		
	},
	function(success, data) {
		var obj=eval(data);
		var statdata=obj.statdata;
		
		if(method=="bar"){
			var xaxisArray=[];
			for ( var i = 0; i < statdata[0].length; i++) {
				xaxisArray[i]=i+1;
			}
			var legendArray=[];
			for ( var i = 0; i < statdata.length; i++) {
				legendArray[i]=attrselected.eq(i).text();
			}
			
	         var myChart = echarts.init(document.getElementById('result'));
	         var option={
		         title : {
	        	     x:'center',
	                 text: '数据统计信息（条形图）',
	             },
	             tooltip : {
	                 trigger: 'axis'
	             },
	             legend: {
	            	 y:30,
	                 data:[]
	             },
	             dataZoom : {
						show : true,
						realtime : true,
						start : 20,
						end : 80
				 },
				 toolbox: {
					 orient:'vertical',
					 x:'right',
					 y:40,
	                 show : true,
	                 feature : {
	                     mark : {show: true},
	                     magicType: {
	                         show : true,
	                         title : {
	                             line : '动态类型切换-折线图',
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
	                     saveAsImage : {show: true},
	                     /**新加的工具箱按钮：升序排列展示**/
	                     myToolRise:{show: true, title:'正常排列', icon:'image://resources/images/icon/normalSort.png', onclick:function(){stat_analyse();}},
	                     /**新加的工具箱按钮：降序排列展示**/
	                     myToolDown:{show: true, title:'升序排列', icon:'image://resources/images/icon/upload.png', onclick:function(){sortlh(myChart,ids,method);}},
	                     /**新加的工具箱按键：多图展示**/
	                     myToolLots: {show: true, title:'多图展示', icon:'image://resources/images/icon/manyPicShow.png', onclick:function(){showLotsDraw(myChart,statdata,attrselected,method,ids)}}
	                 }
	             },
	             calculable : true,
	             xAxis : [
	                 {
	                     type : 'category',
	                     boundaryGap : true,
	                     data : xaxisArray
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
	         for ( var i = 0; i < statdata.length; i++) {
	        	 option.legend.data.push(attrselected.eq(i).text());
	        	 option.series.push({
	        	         name: attrselected.eq(i).text(), // 系列名称
	        	         type: 'bar', // 图表类型，折线图line、散点图scatter、柱状图bar、饼图pie、雷达图radar
	        	         data: statdata[i],
	        	         markPoint : {
	        	                data : [
	        	                    {type : 'max', name: '最大值'},
	        	                    {type : 'min', name: '最小值'}
	        	                ]
	        	         },
	        	         markLine : {
	        	                data : [
	        	                    {type : 'average', name: '平均值'}
	        	                ]
	        	         }
	        	 });
	        	 myChart.setOption(option);
	         }

		}
		else if(method=="breakline"){
			var xaxisArray=[];
			for ( var i = 0; i < statdata[0].length; i++) {
				xaxisArray[i]=i+1;
			}
			var legendArray=[];
			for ( var i = 0; i < statdata.length; i++) {
				legendArray[i]=attrselected.eq(i).text();
			}
			
	         var myChart = echarts.init(document.getElementById('result'));
	         var option={
		         title : {
	        	     x:'center',
	                 text: '数据统计信息（折线图）',
	             },
	             tooltip : {
	                 trigger: 'axis'
	             },
	             legend: {
	            	 y:30,
	                 data:[]
	             },
	             dataZoom : {
						show : true,
						realtime : true,
						start : 20,
						end : 80
				 },
	             toolbox: {
					 orient:'vertical',
					 x:'right',
					 y:40,
	                 show : true,
	                 feature : {
	                     mark : {show: true},
	                     magicType: {
	                         show : true,
	                         title : {
	                             line : '动态类型切换-折线图',
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
	                     saveAsImage : {show: true},
	                     /**新加的工具箱按钮：升序排列展示**/
	                     myToolRise:{show: true, title:'正常排列', icon:'image://resources/images/icon/normalSort.png', onclick:function(){stat_analyse();}},
	                     /**新加的工具箱按钮：降序排列展示**/
	                     myToolDown:{show: true, title:'升序排列', icon:'image://resources/images/icon/upload.png', onclick:function(){sortlh(myChart,ids,method);}},   
	                     /**新加的工具箱按键：多图展示**/
	                     myTool: {show: true, title:'多图展示', icon:'image://resources/images/icon/manyPicShow.png', onclick:function(){showLotsDraw(myChart,statdata,attrselected,method,ids)}}
	                 }
	             },
	             calculable : true,
	             xAxis : [
	                 {
	                     type : 'category',
	                     boundaryGap : false,
	                     data : xaxisArray
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
	         for ( var i = 0; i < statdata.length; i++) {
	        	 option.legend.data.push(attrselected.eq(i).text());
	        	 option.series.push({
	        	         name: attrselected.eq(i).text(), // 系列名称
	        	         type: 'line', // 图表类型，折线图line、散点图scatter、柱状图bar、饼图pie、雷达图radar
	        	         data: statdata[i],
	        	         markPoint : {
	        	                data : [
	        	                    {type : 'max', name: '最大值'},
	        	                    {type : 'min', name: '最小值'}
	        	                ]
	        	            },
	        	            markLine : {
	        	                data : [
	        	                    {type : 'average', name: '平均值'}
	        	                ]
	        	        }
	        	 });
	        	 myChart.setOption(option);
	         }

		}
		
	});
}

/**升序排列**/
function sortlh(myChart,ids,method){       
	var attrselected=$("#select2 option");
	//myChart.dispose();
	$.post("sortlh",
	{
		ids:ids,
		
	},
	function(success, data) {		
		var obj=eval(data);
		var statdata=obj.statdata;						
		
		if(method=="bar"){
			var xaxisArray=[];
			for ( var i = 0; i < statdata[0].length; i++) {
				xaxisArray[i]=i+1;
			}
			var legendArray=[];
			for ( var i = 0; i < statdata.length; i++) {
				legendArray[i]=attrselected.eq(i).text();
			}
			
	         var myChart = echarts.init(document.getElementById('result'));
	         var option={
		         title : {
	        	     x:'center',
	                 text: '数据统计信息（条形图）',
	             },
	             tooltip : {
	                 trigger: 'axis'
	             },
	             legend: {
	            	 y:30,
	                 data:[]
	             },
	             dataZoom : {
						show : true,
						realtime : true,
						start : 20,
						end : 80
				 },
				 toolbox: {
					 orient:'vertical',
					 x:'right',
					 y:40,
	                 show : true,
	                 feature : {
	                     mark : {show: true},
	                     magicType: {
	                         show : true,
	                         title : {
	                             line : '动态类型切换-折线图',
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
	                     saveAsImage : {show: true},
	                     /**新加的工具箱按钮：升序排列展示**/
	                     myToolRise:{show: true, title:'正常排列', icon:'image://resources/images/icon/normalSort.png', onclick:function(){stat_analyse();}},
	                     /**新加的工具箱按钮：降序排列展示**/
	                     myToolDown:{show: true, title:'降序排列', icon:'image://resources/images/icon/download.png', onclick:function(){sorthl(myChart,ids,method);}},
	                     /**新加的工具箱按键：多图展示**/
	                     myToolLots: {show: true, title:'多图展示', icon:'image://resources/images/icon/manyPicShow.png', onclick:function(){showLotsDraw(myChart,statdata,attrselected,method,ids)}}
	                 }
	             },
	             calculable : true,
	             xAxis : [
	                 {
	                     type : 'category',
	                     boundaryGap : true,
	                     data : xaxisArray
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
	         for ( var i = 0; i < statdata.length; i++) {
	        	 option.legend.data.push(attrselected.eq(i).text());
	        	 option.series.push({
	        	         name: attrselected.eq(i).text(), // 系列名称
	        	         type: 'bar', // 图表类型，折线图line、散点图scatter、柱状图bar、饼图pie、雷达图radar
	        	         data: statdata[i],
	        	         markPoint : {
	        	                data : [
	        	                    {type : 'max', name: '最大值'},
	        	                    {type : 'min', name: '最小值'}
	        	                ]
	        	         },
	        	         markLine : {
	        	                data : [
	        	                    {type : 'average', name: '平均值'}
	        	                ]
	        	         }
	        	 });
	        	 myChart.setOption(option);
	         }

		}
		else if(method=="breakline"){
			var xaxisArray=[];
			for ( var i = 0; i < statdata[0].length; i++) {
				xaxisArray[i]=i+1;
			}
			var legendArray=[];
			for ( var i = 0; i < statdata.length; i++) {
				legendArray[i]=attrselected.eq(i).text();
			}
			
	         var myChart = echarts.init(document.getElementById('result'));
	         var option={
		         title : {
	        	     x:'center',
	                 text: '数据统计信息（折线图）',
	             },
	             tooltip : {
	                 trigger: 'axis'
	             },
	             legend: {
	            	 y:30,
	                 data:[]
	             },
	             dataZoom : {
						show : true,
						realtime : true,
						start : 20,
						end : 80
				 },
	             toolbox: {
					 orient:'vertical',
					 x:'right',
					 y:40,
	                 show : true,
	                 feature : {
	                     mark : {show: true},
	                     magicType: {
	                         show : true,
	                         title : {
	                             line : '动态类型切换-折线图',
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
	                     saveAsImage : {show: true},
	                     /**新加的工具箱按钮：升序排列展示**/
	                     myToolRise:{show: true, title:'正常排列', icon:'image://resources/images/icon/normalSort.png', onclick:function(){stat_analyse();}},
	                     /**新加的工具箱按钮：降序排列展示**/
	                     myToolDown:{show: true, title:'降序排列', icon:'image://resources/images/icon/download.png', onclick:function(){sorthl(myChart,ids,method);}},   
	                     /**新加的工具箱按键：多图展示**/
	                     myTool: {show: true, title:'多图展示', icon:'image://resources/images/icon/manyPicShow.png', onclick:function(){showLotsDraw(myChart,statdata,attrselected,method,ids)}}
	                 }
	             },
	             calculable : true,
	             xAxis : [
	                 {
	                     type : 'category',
	                     boundaryGap : false,
	                     data : xaxisArray
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
	         for ( var i = 0; i < statdata.length; i++) {
	        	 option.legend.data.push(attrselected.eq(i).text());
	        	 option.series.push({
	        	         name: attrselected.eq(i).text(), // 系列名称
	        	         type: 'line', // 图表类型，折线图line、散点图scatter、柱状图bar、饼图pie、雷达图radar
	        	         data: statdata[i],
	        	         markPoint : {
	        	                data : [
	        	                    {type : 'max', name: '最大值'},
	        	                    {type : 'min', name: '最小值'}
	        	                ]
	        	            },
	        	            markLine : {
	        	                data : [
	        	                    {type : 'average', name: '平均值'}
	        	                ]
	        	        }
	        	 });
	        	 myChart.setOption(option);
	         }

		}
		
		
				
	});
}


function scatter3D(i){
	// Give the points a 3D feel by adding a radial gradient
    

    // Set up the chart
    var chart = new Highcharts.Chart({
        chart: {
            renderTo: 'scatter3d'+i,
            margin: 100,
            type: 'scatter',
            options3d: {
                enabled: true,
                alpha: 10,
                beta: 30,
                depth: 250,
                viewDistance: 5,

                frame: {
                    bottom: { size: 1, color: 'rgba(0,0,0,0.02)' },
                    back: { size: 1, color: 'rgba(0,0,0,0.04)' },
                    side: { size: 1, color: 'rgba(0,0,0,0.06)' }
                }
            }
        },
        title: {
            text: '3D透视散点图'
        },
        subtitle: {
            text: '拖动图形可以从不同视角观察数据'
        },
        plotOptions: {
           
        },
        yAxis: {
            min: 0,
            max: 10,
            title: null
        },
        xAxis: {
            min: 0,
            max: 10,
            gridLineWidth: 1
        },
        zAxis: {
            min: 0,
            max: 10
        },
        credits:{
            enabled:false
        }
    });

    var chart = $('#scatter3d'+i).highcharts();
    // Add mouse events for rotation
    $(chart.container).bind('mousedown.hc touchstart.hc', function (e) {
        e = chart.pointer.normalize(e);

        var posX = e.pageX,
            posY = e.pageY,
            alpha = chart.options.chart.options3d.alpha,
            beta = chart.options.chart.options3d.beta,
            newAlpha,
            newBeta,
            sensitivity = 5; // lower is more sensitive

        $(document).bind({
            'mousemove.hc touchdrag.hc': function (e) {
                // Run beta
                newBeta = beta + (posX - e.pageX) / sensitivity;
                newBeta = Math.min(100, Math.max(-100, newBeta));
                chart.options.chart.options3d.beta = newBeta;

                // Run alpha
                newAlpha = alpha + (e.pageY - posY) / sensitivity;
                newAlpha = Math.min(100, Math.max(-100, newAlpha));
                chart.options.chart.options3d.alpha = newAlpha;

                chart.redraw(false);
            },                            
            'mouseup touchend': function () { 
                $(document).unbind('.hc');
            }
        });
    });
}



//生成随机颜色，逆天！
var getRandomColor = function(){
	  return '#'+Math.floor(Math.random()*16777215).toString(16); 
}