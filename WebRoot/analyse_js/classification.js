
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

var tree,diagonal,vis, link_stoke_scale,color_map,stroke_callback;


function dtree_analyse()
{
	var outputline=$("#outputline").val();
	var attrselected=$("#select2 option");
	var ids="";
	for(var i=0;i<attrselected.length;i++)
	{
		ids+=attrselected.eq(i).val()+",";
	}
	ids=ids.substring(0, ids.length-1)
	
	if(ids=="")
	{
		alert("参数不得为空！");
		return false;
	}
	$("#main").mask("决策树分析，请稍后...");
	$.post("dtree",
			{
				outputline:outputline,
				ids:ids
			},
			function(returnedData, status) {
				if("success"==status)
				{
					var obj=eval(returnedData);
					var tempArrays=obj.tempArrays;
					var pnames=obj.pnames;
					var imagename=obj.imagename;
					var totalrow=obj.totalrow;
					var acc=obj.acc;   
					
					$("#result").empty();
					
					$("#result").append("<div id='tree'><div class='tabletitle'><div class='decideTreeTitle' title='决策树'>决策树</div></div></div>");                   
					d3.json("iris2.json", load_dataset);
					
					$("#result").append("<div id='forecast' style='display:none'></div>");
					var html="";
					html="<div class='tabletitle'>概率预测：共"+totalrow+"行数据（取前20行）</div><div class='exporttable'><img src='resources/images/exporttable.png'/><a href='"+spath+"/export/export_excel'>导出表格</a></div>" +
						"<table width='100%' class='table table-hover'><thead><tr class='theadstyle'>"
						+"<th>序号</th>";
					for(var j=0;j<pnames.length;j++){
						html=html+"<th>"+pnames[j]+"</th>";
					}
					html=html+"</tr></thead>";
					for(var i=0;i<tempArrays.length;i++){
						var arr_link=tempArrays[i];
					    html=html+"<tr><td>["+(i+1)+"]</td>";
					    for(var j=0;j<arr_link.length;j++){
					    	 html=html+"<td>"+arr_link[j]+"</td>";
					    }
					    html=html+"</tr>";
					}
					html=html+"</table>";
					$("#forecast").append(html);
					
					$("#result").append("<div id='roc' style='display:none'></div>");
					html="";
					html=html+"<div class='curvegraph'><div class='rocGraphTitle' title='ROC曲线图'>ROC曲线图</div></div>" +
							"<div style='width:85%;	margin:0 auto;height:30px;position:relative;'>" +
									"<div class='printgraph'><a href='javascript:printcontent();'>打印图片</a></div>" +
									"<div class='exportgraph1'><a href='"+spath+"/export/export_pdf'>导出图片</a></div><div>" +
									"<div class='graphstyle'><img src='"+spath+"/rimages/"+imagename+"'></div>"
						+"<div class='illustratestyle'>分类器性能评估："+acc+"%</div>";
					html=html+"<hr style='width:100%;'>"
						+"</div>";
					$("#roc").append(html);             
					
					//决策树提示框
					// 使用each（）方法来获得每个元素的属性         
					$('.decideTreeTitle').each(function(){
						$(this).qtip({      
							content: {
								// 设置您要使用的文字图像的HTML字符串，正确的src URL加载图像
								text: 'Tree通常用来展示层级数据的父子关系，图中每一个点代表一个节点，由根节点自上向下排列，通过连线表示节点之间的相关性。',
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
					
					//ROC曲线图提示框
					// 使用each（）方法来获得每个元素的属性         
					$('.rocGraphTitle').each(function(){
						$(this).qtip({      
							content: {
								// 设置您要使用的文字图像的HTML字符串，正确的src URL加载图像
								text: 'ROC曲线越靠近左上角,试验的准确性就越高。最靠近左上角的ROC曲线的点是错误最少的最好阈值，其假阳性和假阴性的总数最少。',
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
			});
}


function printcontent(){
	$("#roc").jqprint({debug: true,importCSS: false});
}

