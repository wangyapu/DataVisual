
function kmeans_analyse()
{
	var attrselected=$("#select2 option");
	var ids="";
	for(var i=0;i<attrselected.length;i++)
	{
		ids+=attrselected.eq(i).val()+",";
	}
	ids=ids.substring(0, ids.length-1)
	var center=$("#center").val();
	var itermax=$("#itermax").val();
	//var nstart=$("#nstart").val();
	//var algorithm=$("#algorithm").val();
	
	if(ids==""||center==""||itermax=="")
	{
		alert("参数不得为空！");
		return false;
	}
	$("#main").mask("k-means算法分析，请稍后...");
	$.post("kmeans",
	{
		ids:ids,
		center:center,
		itermax:itermax
		//nstart:nstart,
		//algorithm:algorithm
	},
	function(returnedData, status) {
		if("success"==status)
		{
			var obj=eval(returnedData);
			var imagename=obj.imagename;
			var imagename1=obj.imagename1;
			var clustersize=obj.clustersize;
			var centers=obj.centers;
			var datashow=obj.datashow;
			var matrixdata=obj.matrixdata;
			var select2=$("#select2 option");
			 
			$("#result").empty();
			
			
			$("#result").append("<div id='piechart' style='width:100%;height:500px;'></div>");
			var piedata=[];
			var legendArray=[];
			var series_data=[];
			for(var i=0;i<clustersize.length;i++)
			{
				piedata[i]=clustersize[i];
				legendArray[i]="聚类簇"+(i+1);
				series_data[i]={value:piedata[i],name:legendArray[i]};
			}
			
			$("#piechart").append("<div id='piediv' style='width:48%;float:left;margin:5px 5px;height:500px;'></div>");
			$("#piechart").append("<div id='bardiv' style='width:48%;float:left;margin:5px 5px;height:500px;'></div>");
			
			option = {
				    title : {
				        text: '各簇数目所占比例（饼图）',
				        x:'center'
				    },
				    tooltip : {
				        trigger: 'item',
				        formatter: "{a} <br/>{b} : {c} ({d}%)"
				    },
				    legend: {
				        orient : 'vertical',
				        x : 'left',
				        data:legendArray
				    },
				    calculable : true,
				    series : [
				        {
				            name:'聚类信息',
				            type:'pie',
				            radius : '55%',
				            center: ['50%', 225],
				            selectedMode: 'single',
				            data:series_data
				        }
				    ]
				};

				option2 = {
				    tooltip : {
				        trigger: 'axis',
				        axisPointer : {
				            type: 'shadow'
				        }
				    },
				    legend: {
				        data:[]
				    },
				    toolbox: {
				        show : true,
				        orient : 'vertical',
				        y : 'center',
				        feature : {
				            mark : {show: true},
				            magicType : {show: true, type: ['bar', 'stack']},
				            restore : {show: true},
				            saveAsImage : {show: true}
				        }
				    },
				    calculable : true,
				    xAxis : [
				        {
				            type : 'category',
				            data : ['聚类数目']
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value',
				            splitArea : {show : true}
				        }
				    ],
				    grid: {
				        x2:40
				    },
				    series : [
				        
				    ]
				};

				myChart = echarts.init(document.getElementById('piediv'));
				myChart.setOption(option);
				myChart2 = echarts.init(document.getElementById('bardiv'));
				myChart2.setOption(option2);
				
				for ( var i = 0; i < clustersize.length; i++) {
		        	 option2.legend.data.push(legendArray[i]);
		        	 var temp=[];
		        	 temp[0]=Number(clustersize[i]);
		        	 option2.series.push({
		        	         name: legendArray[i], // 系列名称
		        	         type: 'bar', // 图表类型，折线图line、散点图scatter、柱状图bar、饼图pie、雷达图radar
		        	         data: temp,
		        	         barWidth:60
		        	 });
		        	 myChart2.setOption(option2);
		         }

				myChart.connect(myChart2);
				myChart2.connect(myChart);

				setTimeout(function (){
				    window.onresize = function () {
				        myChart.resize();
				        myChart2.resize();
				    }
				},200);
			
			/*var myChart = echarts.init(document.getElementById('piechart'));
			var option = {
				    title : {
				        text: '各簇数目所占比例（饼图）',
				        x:'center'
				    },
				    tooltip : {
				        trigger: 'item',
				        formatter: "{a} <br/>{b} : {c} ({d}%)"
				    },
				    legend: {
				        orient : 'vertical',
				        x : 'left',
				        data:legendArray
				    },
				    toolbox: {
				        show : true,
				        feature : {
				            mark : {show: true},
				            dataView : {show: true, readOnly: false},
				            restore : {show: true},
				            saveAsImage : {show: true}
				        }
				    },
				    calculable : true,
				    series : [{
						name:'聚类信息',
						type:'pie',
						radius : '55%',
						center: ['50%', '60%'],
						selectedMode: 'single',
						data:series_data
				    }]
			};
            myChart.setOption(option);
			$("#piechart").attr("style","display:none");*/
			
			
			/*var html="<div>各簇数据数目：";
			for(var i=0;i<clustersize.length;i++){
				html=html+clustersize[i]+"&nbsp;&nbsp;";
			}
			html=html+"</div>";
			$('#chart').append(html);*/     
			     
			

			
			/*$("#result").append("<div id='barchart' style='display:none;width:50%;height:500px;border:1px solid #000;'></div>");
			

			$("#result").append("<div id='barchart' style='display:none;width:500px;height:500px;border:1px solid #000;'></div>");
			/*bar();                
			var barchart = $('#barchart').highcharts();
			for ( var i = 0; i < clustersize.length; i++) {
				 var temp=[];
				 temp[0]=Number(clustersize[i]);
				 barchart.addSeries({data:temp,name:"聚类簇"+(i+1)});
	        }*/


	        /*var myChart = echarts.init(document.getElementById('barchart'));
	        var option={
		         title : {
	                 text: '各簇聚类数目（条形图）',
	                 x:'center'
	             },
	             tooltip : {
	             },
	             legend: {
	            	 orient : 'vertical',
				     x : 'left',
	                 data:[]
	             },
				 toolbox: {
	                 show : true,
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
	             xAxis : [
	                 {
	                     type : 'category',
	                     boundaryGap : true,
	                     data : ['聚类数目']
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
	         for ( var i = 0; i < clustersize.length; i++) {
	        	 option.legend.data.push(legendArray[i]);
	        	 var temp=[];
	        	 temp[0]=Number(clustersize[i]);
	        	 option.series.push({
	        	         name: legendArray[i], // 系列名称
	        	         type: 'bar', // 图表类型，折线图line、散点图scatter、柱状图bar、饼图pie、雷达图radar
	        	         data: temp,
	        	         barWidth:60
	        	 });
	        	 myChart.setOption(option);
	         }*/
			
			
			
			$("#result").append("<div id='clusterinfo' style='display:none'></div>");
			html="";
			html=html+"<div class='tabletitle' style='margin-top:20px;'><div class='centerPointHeadTitle' title='最佳中心点'>最佳中心点</div></div><div class='exporttable'><img src='resources/images/exporttable.png'/><a href='"+spath+"/export/export_excel'>导出表格</a></div>" +
					"<table width='100%' class='table table-hover'><thead><tr class='theadstyle'><th>序号</th>";
			for(var i=0;i<select2.length;i++){
				html=html+"<th>"+select2.eq(i).html()+"</th>";
			}
			html=html+"</tr></thead>";
			for(var i=0;i<centers.length;i++){
				var arr_link=centers[i];
			    html=html+"<tr><td>["+(i+1)+"]</td>";
			    for(var j=0;j<arr_link.length;j++){
			    	 html=html+"<td>"+arr_link[j]+"</td>";
			    }
			    html=html+"</tr>";
			}
			
			$("#clusterinfo").append(html+"</table>"); 
			             
			
			$("#result").append("<div id='scattermatrix' style='display:none;width:700px;height:700px;margin:0 auto;text-align: center;'><div class='tabletitle'><div class='matrixHeadTitle' title='散点矩阵'>散点矩阵</div></div></div>"); 
			drawScatterMatrix(matrixdata);
			/*seajs.use(["datav", "scatterplotMatrix"], function (DataV, ScatterplotMatrix) {        
		        var scatterplotMatrix = new ScatterplotMatrix("scattermatrix", {"width": 1000, "height": 800, "margin": 50, "typeName": "clustertype", "tagDimen": ""});
		        //DataV.csv("iris.csv", function(dataSource) {
		        	var dataSource=datashow;
		        	
		            scatterplotMatrix.setSource(dataSource);   
		            scatterplotMatrix.setDimensionsX(obj.dimensions);
		            scatterplotMatrix.setDimensionsY(obj.dimensions);
		            scatterplotMatrix.setTypeName(obj.typename);
		            scatterplotMatrix.render();
		        //});
			});*/
			
			
			
//			html="";
//			html=html+"<hr style='width:100%;'>"
//				+"<a style='color:#1841E2' href='"+spath+"/export/export_pdf'>导出图片</a></h3></div>";
//			$("#result").append(html);

			
			$("#result").append("<div id='parallel' style='display:none'><div class='tabletitle'><div class='parallelHeadTitle' title='平行坐标图'>平行坐标图</div></div></div>");
			drawCluster(datashow);
			
			
			
			//最佳中心点提示框
			// 使用each（）方法来获得每个元素的属性         
			$('.centerPointHeadTitle').each(function(){
				$(this).qtip({      
					content: {
						// 设置您要使用的文字图像的HTML字符串，正确的src URL加载图像  
						text: 'sssssssssssssssssssssssssssssssssssssssssssssssss',
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
			 
			
			//散点矩阵提示框
			// 使用each（）方法来获得每个元素的属性         
			$('.matrixHeadTitle').each(function(){
				$(this).qtip({      
					content: {
						// 设置您要使用的文字图像的HTML字符串，正确的src URL加载图像  
						text: '散点矩阵是一个可以展示多维数据的可视化方法，它可以展示出每个两维度之间的关系。'+
							'该组件的输入数据是一张有多个属性的二维表，用户可以选择需要展示的属性。'+
							'每个小的矩形是一个散点图，展示了两个属性之间的关系。散点的不同颜色表示不同的数据类别。'+
							'用户可以通过笔刷选取某些散点或者单独选取某个类别的散点，被选取的散点会被高亮出来。',
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
			
			//平行做标图提示框
			// 使用each（）方法来获得每个元素的属性         
			$('.parallelHeadTitle').each(function(){
				$(this).qtip({      
					content: {
						// 设置您要使用的文字图像的HTML字符串，正确的src URL加载图像  
						text: 'sssssssssssssssssssssssssssssssssssssssssssssssss',
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
			//alert("k-means算法分析完成！");
		}
	})
}


function pie(){
	$('#piechart').highcharts({
        chart: {
			type: 'pie',
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: '各簇数目所占比例（饼图）'
        },
        tooltip: {
    	    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    color: '#000000',
                    connectorColor: '#000000',
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                },
                showInLegend: false
            }
        },
        credits:{
            enabled:false
        }
    });
}

function pie3D(){
	$('#piechart').highcharts({
        chart: {
            type: 'pie',
            options3d: {
                enabled: true,
                alpha: 45,
                beta: 0
            }
        },
        title: {
            text: '各簇数目所占比例（饼图）'
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                depth: 35,
                dataLabels: {
                    enabled: true,
                    format: '{point.name}'
                }
            }
        },
        credits:{
            enabled:false
        }
    });
}


function bar(){
	$('#barchart').highcharts({
        chart: {
			zoomType: 'x',
            type: 'column'
        },
        title: {
            text: '各簇聚类数目（条形图）'
        },
        subtitle: {
        	
        },
        xAxis: {
           
        },
        yAxis: {
            
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">各簇数目：</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y} </b></td></tr>',
            footerFormat: '</table>',
            useHTML: true
        },
        credits:{
            enabled:false
        },
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        }
    });
}
