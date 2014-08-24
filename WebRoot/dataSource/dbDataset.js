function allDbType(){
	 $.post("allDbTypeJson.action",null,
			 function(allDbtype, status)
				{
					if("success"==status)
					{
						var html="";
						for(var i=0;i<allDbtype.length;i++)
						{
							html=html+"<option value ='"+allDbtype[i]+"'>"+allDbtype[i]+"</option>";
						}
						$("#dbtypeselect").append(html);
					}
				}
	 )
}

function getDbName(dbtype){
	 $.post("getDbNameJson.action",
			 {
		 		dbtype:dbtype
			 },
			 function(allDbtype, status)
				{
				 	$("#dbnameselect").empty();
					if("success"==status)
					{
						var html="<option value='-1' selected='selected'>--请选择数据库名称--</option>";
						for(var i=0;i<allDbtype.length;i++)
						{
							html=html+"<option value ='"+dbtype+","+allDbtype[i]+"'>"+allDbtype[i]+"</option>";
						}
						$("#dbnameselect").append(html);
					}
				}
	 )
}

function getTableName(dbname){
	 $.post("getTableNameJson.action",
			 {
		 		dbname:dbname
			 },
			 function(dbdatasetList, status)
				{
				 	$("#tablelist").empty();
					if("success"==status)
					{
						var html="<table width='100%' class='table table-hover'><thead><tr class='theadstyle'>"
							 	+"<th width='40%'>数据表名</th>"
							 	+"<th width='30%'>数据库名</th>"
							 	+"<th>数据库类型</th></tr></thead>";
						for(var i=0;i<dbdatasetList.length;i++)
						{
							var dbid=dbdatasetList[i].id;
							html=html
								+"<tr>"
								+"<td><a href='javascript:void(0);' onclick='readDbDataset("+dbid+")'>"
								+dbdatasetList[i].tablename+"</a></td><td>"
								+dbdatasetList[i].dbname+"</td><td>"
								+dbdatasetList[i].dbtype+"</td></tr>";
						}
						$("#tablelist").append(html+"</table>");
						$("#page").show();
					}
				}
	 )
}

function readDbDataset(id){
		$("#main").mask("读取数据集，请稍后...");
		$.post("readDbDatasetJson.action",
		{
			sid:id
		},
		function(returnedData, status)
		{
			if("success"==status)
			{
				$("#result").empty();
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
				$("#console").css("display","block");
				
				var datatable="";
				var datashow=obj.datashow;
				var datatable="<div class='more'><a href=dataListShow?totalrow="+obj.totalrow+"&pageno=1 target='_blank'>显示更多数据</a></div><table width='100%' class='table table-hover'><thead><tr>";
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
			}
		}
		)
}

