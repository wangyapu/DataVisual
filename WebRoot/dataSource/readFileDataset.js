function readFileDataset(id){
		$("#main").mask("读取数据集，请稍后...");
		$.post("readFileDatasetJson.action",
		{
			sid:id
		},
		function(returnedData, status)
		{
			if("success"==status)
			{
				$("#console").css("display","block");
				$("#result").empty();
				/*$("#result").attr("data-step","3");
				$("#result").attr("data-intro","在这里查看你的数据信息，包括数据统计信息、缺失值比例、变量类型以及详细数据等等");
				$("#result").attr("data-position","top");*/
				var obj=eval(returnedData);
				var fddBeans=obj.fddBeans;
				var html="<div class='tabletitle'>此数据集共有"+obj.totalrow+"行记录</div>" +
						"<table width='100%' class='table table-hover'><thead><tr class='theadstyle'>"
						+"<th width='30%'>变量名</th>"
					 	+"<th width='25%'>变量类型</th>"
						+"<th width='25%'>缺失值数目</th>"
						+"<th width='20%'>缺失值比例</th></tr></thead>";
				for(var i=0;i<fddBeans.length;i++){
					html=html+"<tr>"
						+"<td>"+fddBeans[i].colname+"</td>"
						+"<td>"+fddBeans[i].coltype+"</td>"
						+"<td>"+fddBeans[i].missingnum+"</td>"
						+"<td>"+fddBeans[i].missingratio+"</td></tr>";
				}
				$("#result").append(html+"</table>");
				
				
				var datatable="";
				var datashow=obj.datashow;
				var datatable="<div class='more'><div style='display:inline-block;margin-right:15px;position: relative;top: -4px;'><label>选择格式:</label><select id='dstype'><option value='txt' selected='selected'>.txt</option><option value='xls'>.xls</option><option value='csv'>.csv</option></select><a id='xiazaidstype'>下载</a></div><img src='resources/images/more.png'/><a href=dataListShow?totalrow="+obj.totalrow+"&pageno=1 target='_blank'>显示更多数据</a></div><table width='100%' class='table table-hover'><thead><tr>";
				var datacolnames=obj.datacolnames;
				for(var i=0;i<datacolnames.length;i++){
					datatable=datatable+"<th>"+datacolnames[i]+"</th>";
				}
				datatable+="</tr></thead>";
				for ( var i= 0; i < datashow.length; i++) {
					datatable=datatable+"<tr><td>"+(i+1)+"</td>";
					for ( var j = 0; j < datashow[i].length; j++) {
						datatable=datatable+"<td>"+datashow[i][j]+"</td>";
					}
					datatable=datatable+"</tr>";
				}
				$("#result").append(datatable+"</table>");   
				$("#main").unmask();
				//introJs().goToStep(3).start();
				//alert("数据读取完成！");
				
				$("#xiazaidstype").click(function(){
					var geshi = $("#dstype  option:selected").val();
					//alert(geshi);
					//alert(spath+"/convertFileType?type="+geshi);
					window.open(spath+"/convertType?type="+geshi);
				});
				
			}
		}
		)
}

