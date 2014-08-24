
function missing_analyse()
{
	var attrselected=$("#select2 option");
	var ids="";
	for(var i=0;i<attrselected.length;i++)
	{
		ids+=attrselected.eq(i).val()+",";
	}
	ids=ids.substring(0, ids.length-1)
	var method=$("#method").val();
	
	if(ids=="")
	{
		alert("参数不得为空！");
		return false;
	}
	$("#main").mask("缺失值分析，请稍后...");
	$.post("missdata",
	{
		ids:ids,
		method:method
		
	},
	function(success, data) {
		
		$("#result").empty();
		var obj=eval(data);
		var fddBeans=obj.fddBeans;
		var html="<div class='tabletitle'>缺失值分析结果</div>"+       
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
		$("#main").unmask();
		//alert("缺失值分析成功！")
	});
}


function missing_view(){
	$("#main").mask("正在分析缺失值，请稍后...");
	$.post("judgemissing",
	{
		        
	},
	function(success, data) {
		$("#main").unmask();
		var obj=eval(data);
		if(obj.hasmissing=="true"){
			//var wid = parseInt($("#main").css("width").replace("px",""));
			//$("#showmissing").css("display","block");
			//window.location= spath + "/showmissing";
			$("#showmissing").animate({top: '50px'},300,"linear");
			//$("#showmissing").attr("style","display:block");
		}else{
			alert("该数据集无缺失值！");
		}
		
	});
}


function selectSub()
{
	var checksub=$("input[type='checkbox'][id='id']").length;
	var checkedsub=$("input[type='checkbox'][id='id']:checked").length;
	if(checksub==checkedsub)
		$("#allids").attr("checked",true);
	else
		$("#allids").attr("checked",false);
}

function selectAll()
{
	if($("#allids").attr("checked"))
		$(":checkbox").attr("checked",true);
	else
		$(":checkbox").attr("checked",false);
}

function delmissing()
{
	var checkedsub=$("input[type='checkbox'][id='id']:checked").length;
	if(checkedsub==0)
	{
		alert("您没有选中任何数据");
		return;
	}
	else{
		if(confirm("确认处理所选条目？")){
			var ids="";
			$("input[id='id']:checked").each(function(){
				ids+=$(this).val()+",";
			});
			$("#main").mask("正在剔除缺失值，请稍后...");
			$.post("delmissing",
			{
				ids:ids
			},
			function(success, data) {
				
				var hei = parseInt($("#showmissing").css("height").replace("px",""));
				$("#showmissing").animate({top: (-hei-2)+'px'},300,"linear");
				$("#result").empty();
				var obj=eval(data);
				$("input[id='id']:checked").each(function(){
					$(this).parent().parent().remove();
				});
				var fddBeans=obj.fddBeans;
				var html=
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
				$("#main").unmask();
			});
		}
	}
}

function saveupdate(){
	if(confirm("确认需要修改的值？")){
		var ids="";
		$("input[id='id']").each(function(){
			ids+=$(this).val()+",";
		});
		var missinput="";
		var temp=$("input[name='missinput']");
		for ( var i = 0; i < temp.length; i++) {
			missinput+=temp.eq(i).val()+";";
		}
		missinput=missinput.substring(0, missinput.length-1)
		$("#main").mask("正在替换缺失值，请稍后...");
		$.post("updatemissing",
		{
			ids:ids,
			missinput:missinput
		},
		function(success, data) {
			
			var hei = parseInt($("#showmissing").css("height").replace("px",""));
			$("#showmissing").animate({top: (-hei-2)+'px'},300,"linear");
			$("#result").empty();
			var obj=eval(data);
			var fddBeans=obj.fddBeans;
			var html=
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
			$("#main").unmask();
		});
	}
}

function closeview(){
	//$("#showmissing").attr("style","display:none");
	var hei = parseInt($("#showmissing").css("height").replace("px",""));
	$("#showmissing").animate({top: (-hei-2)+'px'},300,"linear");
}

