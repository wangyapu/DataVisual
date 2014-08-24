function stat_analyse()
{
	var attrselected=$("#select2 option");
	var ids="";
	for(var i=0;i<attrselected.length;i++)
	{
		ids+=attrselected.eq(i).val()+",";
	}
	ids=ids.substring(0, ids.length-1);
	var method=$("#method").val();
	
	$("#main").mask("数据分析，请稍后...");
	$.post("statinfo",
	{
		ids:ids,
		method:method
		
	},
	function(success, data) {
		
		$("#result").empty();
		var obj=eval(data);
		var statdata=obj.statdata;
		var scatterdata=obj.scatterdata;
		var colors=obj.colors;
		if(method=="bar"){
			bar();
			var chart = $('#result').highcharts();
			for ( var i = 0; i < statdata.length; i++) {
				 chart.addSeries({data:statdata[i],name:attrselected.eq(i).text()});
	        }
			$('#result').append("<input type='button'  class='btn imageOpr' value='reset the bar' onclick=reset('"+ids+"')>");
			$('#result').append("<input type='button'  class='btn imageOpr' value='sort from high to low' onclick=sorthl('"+ids+"')>");
			$('#result').append("<input type='button'  class='btn imageOpr' value='sort from low to high' onclick=sortlh('"+ids+"')>");
		}
		else if(method=="breakline"){
			breakline();
			var chart = $('#result').highcharts();
			for ( var i = 0; i < statdata.length; i++) {
				 chart.addSeries({data:statdata[i],name:attrselected.eq(i).text()});
	        }
		}
		else if(method=="scatter"){
			for ( var i = 0; i < scatterdata.length; i++) {
				$('#result').append("<div style='width:48%;float:left;border:1px solid #C0C0C0;margin:5px 5px;' id=scatter"+(i+1)+"></div>")
				scatter(i+1);
				var chart = $('#scatter'+(i+1)).highcharts();
				chart.addSeries({data:scatterdata[i],color:colors[i]});
				chart.xAxis[0].setTitle({
			        text: attrselected.eq(obj.varname[i][0]-1).text()
			    });
				chart.yAxis[0].setTitle({
		            text: attrselected.eq(obj.varname[i][1]-1).text()
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


function bar(){
	$('#result').highcharts({
        chart: {
			zoomType: 'x',
            type: 'column'
        },
        title: {
            text: '数据统计信息（条形图）'
        },
        subtitle: {
        	
        },
        xAxis: {
           
        },
        yAxis: {
            
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y} </b></td></tr>',
            footerFormat: '</table>',
            shared: true,
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


function breakline(){
	$('#result').highcharts({
        chart: {
            zoomType: 'x',
            type: 'line',
            resetZoomButton: {
                theme: {
                    fill: 'white',
                    stroke: 'silver',
                    r: 0,
                    states: {
                        hover: {
                            fill: '#41739D',
                            style: {
                                color: 'white'
                            }
                        }
                    }
                }
            }
        },
        title: {
            text: '数据统计信息（折线图）'
        },
        subtitle: {
        },
        xAxis: {
        },
        yAxis: {
        },
        tooltip: {
            enabled: true,
            formatter: function() {
                return '<b>'+ this.series.name +'</b><br/>'+this.x +': '+ this.y ;
            }
        },
        plotOptions: {
            line: {
                dataLabels: {
                    enabled: true
                },
                enableMouseTracking: true
            }
        },
        credits:{
            enabled:false
        }
    });
}

function scatter(i){
	 $("#scatter"+i).highcharts({                                                             
	        chart: {                                                                             
	            type: 'scatter',                                                                 
	            zoomType: 'xy'                                                                   
	        },                                                                                   
	        title: {                                                                             
	            text: '数据统计信息（散点图）'                        
	        },                                                                                   
	        subtitle: {                                                                          
	        },                                                                                   
	        xAxis: {  
	        },                                                                                   
	        yAxis: {  
	        	title: {                                                                             
	            	text: '观测值'                        
		        }
	        },                                                                                   
	        legend: {                                                                            
	            layout: 'vertical',                                                              
	            align: 'bottom',                                                                   
	            verticalAlign: 'top',                                                            
	            x: 100,                                                                          
	            y: 70,                                                                           
	            floating: true,                                                                  
	            backgroundColor: '#FFFFFF',                                                      
	            borderWidth: 1                                                                   
	        },                                                                                   
	        plotOptions: {                                                                       
	            scatter: {                                                                       
	                marker: {                                                                    
	                    radius: 5,                                                               
	                    states: {                                                                
	                        hover: {                                                             
	                            enabled: true,                                                   
	                            lineColor: 'rgb(100,100,100)'                                    
	                        }                                                                    
	                    }                                                                        
	                },                                                                           
	                states: {                                                                    
	                    hover: {                                                                 
	                        marker: {                                                            
	                            enabled: false                                                   
	                        }                                                                    
	                    }                                                                        
	                },                                                                           
	                tooltip: {                                                                   
	                    headerFormat: '<b>数据点</b><br>',                                
	                    pointFormat: '{point.x} , {point.y} '                                
	                }                                                                            
	            }                                                                                
	        },
	        credits:{
	            enabled:false
	        }
	    });
}


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


function sorthl(ids){
	var attrselected=$("#select2 option");
	$.post("sorthl",
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

function sortlh(ids){ 
	var attrselected=$("#select2 option");
	$.post("sortlh",
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