function network_analyse()
{
	var attrselected1=$("#select2 option");
	var ids1="";
	for(var i=0;i<attrselected1.length;i++)
	{
		ids1+=attrselected1.eq(i).val()+",";
	}     
	ids1=ids1.substring(0, ids1.length-1);

	var attrselected2=$("#select4 option");
	var ids2="";
	for(var i=0;i<attrselected2.length;i++)
	{
		ids2+=attrselected2.eq(i).val()+",";
	}     
	ids2=ids2.substring(0, ids2.length-1);
	
	if(ids1==""||ids2=="")
	{
		alert("参数不得为空！");
		return false;
	}
	$("#main").mask("社会网络分析，请稍后...");
	
	$.post("network",
	{
		ids1:ids1,
		ids2:ids2
	},
	function(returnedData, status) {
		if("success"==status)
		{
			var obj=eval(returnedData);
			if(ids1.indexOf("id")<0||ids1.indexOf("name")<0||ids1.indexOf("friendnum")<0){
				alert("数据格式有误，请重新检查！");
				$("#main").unmask();
				return false;
			}
			else if(ids2.indexOf("source")<0||ids2.indexOf("target")<0||ids2.indexOf("weight")<0){
				alert("数据格式有误，请重新检查！");
				$("#main").unmask();
				return false;
			}
			$("#result").empty();
			$("#result").append("<div id='network'  style='height:500px;width:100%;margin-bottom:5px;'></div>");			
			drawNetwork();
			
			$("#result").append("<div id='chords' style='display:none;height:500px;width:100%;margin-bottom:5px;'></div>");
			drawChords();      
			
			//社交网络图提示框
			// 使用each（）方法来获得每个元素的属性         
			/*$('.socialNetTitle').each(function(){
				$(this).qtip({      
					content: {
						// 设置您要使用的文字图像的HTML字符串，正确的src URL加载图像
						text: '社会网络分析是研究一组行动者的关系的研究方法。一组行动者可以是人、社区、群体、组织、国家等，他们的关系模式反映出的现象或数据是网络分析的焦点。从社会网络的角度出发，人在社会环境中的相互作用可以表达为基于关系的一种模式或规则，而基于这种关系的有规律模式反映了社会结构，这种结构的量化分析是社会网络分析的出发点。',
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
			});*/
			
			//和弦图提示框
			// 使用each（）方法来获得每个元素的属性         
			/*$('.chordsTitle').each(function(){
				$(this).qtip({      
					content: {
						// 设置您要使用的文字图像的HTML字符串，正确的src URL加载图像
						text: '弦图通常用来展示多个节点间的连结关系。',
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
			});*/

			$("#main").unmask();
		}
	})
}   



function readNameFile(id){
	$.post("readNameFile.action",
	{
		sid:id
	},
	function(returnedData, status)
	{
		if("success"==status)
		{
			var obj=eval(returnedData);
			var datacolnames=obj.datacolnames;
			$("#select1").empty();
			for ( var i = 1; i < datacolnames.length; i++) {
				$("#select1").append("<option>"+datacolnames[i]+"</option>");
			}
			
			$("#namedialog").dialog("close");
			
		}
	}
	)
}


function readLinkFile(id){
	$.post("readLinkFile.action",
	{
		sid:id
	},
	function(returnedData, status)
	{
		if("success"==status)
		{
			var obj=eval(returnedData);
			var datacolnames=obj.datacolnames;
			$("#select3").empty();
			for ( var i = 1; i < datacolnames.length; i++) {
				$("#select3").append("<option>"+datacolnames[i]+"</option>");
			}
			
			$("#linkdialog").dialog("close");
			
		}
	}
	)
}

function myselfnetwork(){      
	window.location=spath+"/datamining/mynetwork.jsp";       
}


