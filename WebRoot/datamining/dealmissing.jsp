<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">

<head>
<base href="<%=basePath%>">
	<title>DataGeek数据挖掘可视化平台</title>
	<link rel="stylesheet" type="text/css" href="<%=path%>/resources/core.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/header.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/forms.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/table_css_new.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/mytable.css">
	<script type="text/javascript" src="<%=path%>/resources/jquery-1.8.0.js"></script>
	<link href="<%=path%>/resources/loadmask/jquery.loadmask.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=path%>/resources/loadmask/jquery.loadmask.min.js"></script>
	<script type="text/javascript" src="<%=path%>/analyse_js/dealmissing.js"></script>
	<link rel="stylesheet" href="<%=path%>/resources/css/table.css" type="text/css"></link>
	<link href="<%=path%>/resources/introjs/introjs.css" rel="stylesheet">
	
	<script type="text/javascript" src="<%=path%>/resources/introjs/intro.js"></script>
	<%--<script type="text/javascript">
		jQuery(document).ready(function($) {
			introJs().start();
		});
	</script>
	--%><script type="text/javascript" src="<%=path%>/resources/common/core.js"></script>
	
	<script type="text/javascript">
	var spath="<%=path%>";
	$(function(){
	    //移到右边
	    $('#add').click(function() {
	    //获取选中的选项，删除并追加给对方
	        $('#select1 option:selected').appendTo('#select2');
	    });
	    //移到左边
	    $('#remove').click(function() {
	        $('#select2 option:selected').appendTo('#select1');
	    });
	    //全部移到右边
	    $('#add_all').click(function() {
	        //获取全部的选项,删除并追加给对方
	        $('#select1 option').appendTo('#select2');
	    });
	    //全部移到左边
	    $('#remove_all').click(function() {
	        $('#select2 option').appendTo('#select1');
	    });
	    //双击选项
	    $('#select1').dblclick(function(){ //绑定双击事件
	        //获取全部的选项,删除并追加给对方
	        $("option:selected",this).appendTo('#select2'); //追加给对方
	    });
	    //双击选项
	    $('#select2').dblclick(function(){
	       $("option:selected",this).appendTo('#select1');
	    });
	});
	</script>
</head>

<body id="all">
		
	<jsp:include page="../common/header.jsp" flush="true"/>
	<jsp:include page="../common/leftmenu.jsp" flush="true"/>
	<jsp:include page="../common/bottom.jsp" flush="true"/>
	
	<div id="content_template" class="content">
		<div>
			<div class='opr_title_style' style="width: 100px">缺失值处理</div>
			<HR SIZE=1 class='uploadhr'/>
		</div>
		<div id="main">
		<div  class='tableList'>
			    <div  class='key_s' style="position:relative;top:-60px;width: 150px">分析列选择：</div>
			    <div class="value_s">
				    <div style="display:inline-block;">
				        <select multiple="multiple" id="select1" style="width:160px;height:160px;border: 1px solid #a0c3da;font-size: 18px;color: royalblue;"
				        		data-step="2" data-intro="选择你需要处理缺失值的分析列，若该列无缺失值可以不需要选择">
					        <s:iterator value="#session.colnames" id="s" status="st">
					        	<option value="${st.index + 1}"><s:property value='s'/></option>
					        </s:iterator>
				        </select>
				    </div>
				    <div id='multiSelect' style="display:inline-block;position: relative;top:-20px;margin-left: 5px;"
				    	data-step="3" data-intro="在这里你可以单个选择分析列，也可以选中多个分系列进行移动">
				    	<div><button class='reset' id="add" style="width: 40px">&gt;</button></div>
				    	<div><button class='reset' id="add_all" style="width: 40px">&gt;&gt;</button></div>
				    	<div><button class='reset' id="remove" style="width: 40px">&lt;</button></div>
				    	<div><button class='reset' id="remove_all" style="width: 40px">&lt;&lt;</button>  </div> 
					</div>
					<div style="display:inline-block;">
				        <select multiple="multiple" id="select2" style="width: 160px;height:160px;border: 1px solid #a0c3da;font-size: 18px;color: blueviolet;"
				        	data-step="4" data-intro="这里是你选择的分析列，若选择错误可以将列属性移动回原位">
				        </select>
				    </div>
			    </div>
			</div>
		    <div class='tableList'>
  					<div class='key_s' style="width: 150px">缺失值处理方法：</div>
			    <div class='value_s'>
			      <select name="method" id="method" data-step="5" data-intro="选择你需要使用的缺失值处理方法">
		    		<option value="prior">临近点替换</option>
		    		<option value="mean">序列均值替换</option>
		    		<option value="spline">三次样条插值</option>
		    	  </select>
			    </div>
		    </div>

		    <div style='border-top:1px solid gray;
						position: relative;
						width: 40%;
						margin-left: 25px;
						padding-top:10px;
						text-align: right;
						margin-top: 15px;'>
				<button  class="btn add"  type="button" id="button1" onclick="missing_view()" data-step="1" data-intro="想看看数据里的缺失值吗？">缺失值预览</button>
		    	<button  class="btn add"  type="button" id="button" onclick="missing_analyse()" data-step="6" data-intro="参数设置完之后再确认进行缺失值处理">缺失值分析</button>
		    </div>
		    
		    <div id="showmissing" style="display: block;
		    	text-align:center;
				position: absolute;
				z-index: 999;
				background: #fff;
				top: -402px;
				right: 50px;        
				height:400px;
				left: 50px;  
				border-radius: 15px;
				box-shadow: inset 0 2px 2px rgba(158, 199, 245, 0.4),inset 0 1px 5px rgba(158, 199, 245, 0.4),inset 0 0 0 12px rgba(158, 199, 245, 0.4);">
				<div  style="font-size: 18px; font-family: '微软雅黑'; padding: 40px 0 20px 0;color: #368DD9；">缺失值预览</div> 
		    	<table class="mytable" style="margin:0 auto;"> 
		    		<thead>       
					    <tr  align="center">
					    	<th width="10%">序号</th>    
				   		    <s:iterator value="#session.colnames" id="s" status="st">
					        	<th><s:property value='s'/></th>     
					        </s:iterator>   
					    </tr>
				    </thead>
				    <tbody>     
				    	<s:iterator value="missdata" id="s" status="st">
						 	<tr>
						 		<s:iterator id="s2" value="missdata[#st.index]" status="st2">
							 		<s:if test="%{#st2.index==0}">
							 			<td><input type="checkbox" id="id" value="${s2}" onclick="selectSub();" style="width: 15px;	height: 15px;margin-right: 3px;opacity:0.6;"/><s:property value="%{#s2}"/></td>
							 		</s:if>
		      						<s:else>
		      							<s:if test="%{#s2==null}"><td><input type="text" name="missinput" value="NA"></td></s:if>
		      							<s:else><td><input type="text" name="missinput" readonly="readonly" value="${s2}"></td></s:else>     
		      						</s:else> 
						     	</s:iterator>
						     	
						    </tr>
						</s:iterator>
				    </tbody>        
				</table>    
				<div style="display:inline-block;position: relative;left: 12px;"><input id="allids" type="checkbox" value="" onclick="selectAll();" style="width: 15px;height: 15px;opacity: 0.7;"/>全选</div>
				<div style="  margin-top: 20px; margin-left: 70px;display:inline-block;">           
					<button  class="btn add"  type="button" id="button2" onclick="delmissing();">剔除选中缺失值</button>  
					<button  class="btn add"  type="button" id="button3" onclick="saveupdate();">保存修改</button>
					<button  class="btn add"  type="button" id="button3" onclick="closeview();">关闭预览</button>
				</div>
		    </div>     
		</div>
		
		<div style='position: relative;'  >
			<div>
				<div class='opr_title_style' style="width: 110px;top: 18px;">分析结果展示</div>
				<HR SIZE=1 class='uploadhr'/>
			</div>
			<div>
				<div  class='tableList' style='margin-left:25px;margin-right:25px'>
				    <div id='result'  style='height:500px;width:100%;display:inline-block;margin-bottom:5px;'>
				   		
				    </div>
				</div>
			</div>
		</div>
	</div>
	
	<SCRIPT type="text/javascript">
		//if(screen.width<=800){
		//	$(".tableList").attr("style","width:100%");
		//	$("#multiSelect").attr("style","display: inline-block;position: relative;top: 40px;margin-left: 5px;");
			         
		//}
	</SCRIPT>
</body>
</html>