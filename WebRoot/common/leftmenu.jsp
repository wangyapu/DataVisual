<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<style>

	ul.functionList li{
		display: block;
		width: 105px;
		height:100px;
		text-align: center;
		vertical-align: middle;
	}
	
	ul li:hover{
		/*background:-webkit-gradient(linear,0% 0%,100% 100%,
								color-stop(0,rgba(211,235,248,0.9)),
								color-stop(1,rgba(221,235,248,0.5)));*/
		background-color:rgb(211,235,248);
		-webkit-transition: background-color .25s linear; 
	}
	
	.dis{
		display:block;
		-webkit-transition: display .25s linear; 
	}
	
	div.popFunctionList{
		width:180px;
		height:160px;
		position: absolute;
		display: none;
	}
	
	div.arrow{
		display: inline;
		width: 15px;
		height:100%;
		position: absolute;
		background: url(<%=path%>/resources/images/arrowV2.png);
		-moz-background-size:15px 30px;
		background-size:17px 30px;
		background-repeat:no-repeat;
		background-origin:content-box;
		background-position:2px 35px;
	}
	
	div.tips{
		display: inline;
		width: 153px;
		left:15px;
		height:100%;
		position: absolute;
		/*border:1px solid #333;
		border-left:none;*/
		/*background-color: rgba(71,141,201,1);*/
		background: #3193c0;
		background-image: -moz-linear-gradient(top,#4cb1e0 0%,#1675a1 100%);
		background-image: -webkit-gradient(linear,left top,left bottom,color-stop(0%,#4cb1e0),color-stop(100%,#1675a1));
		background-image: -webkit-linear-gradient(top,#4cb1e0 0%,#1675a1 100%);
		background-image: -o-linear-gradient(top,#4cb1e0 0%,#1675a1 100%);
		background-image: -ms-linear-gradient(top,#4cb1e0 0%,#1675a1 100%);
		background-image: linear-gradient(top,#4cb1e0 0%,#1675a1 100%);
		-moz-border-radius: 8px;
		-webkit-border-radius: 8px;
		border-radius: 8px;
		-moz-box-shadow: 0 2px 2px rgba(0,0,0,0.3);
		-webkit-box-shadow: 0 2px 1px rgba(0,0,0,0.3);
		box-shadow: 0 2px 1px rgba(0,0,0,0.3);
	}
	
	div.tips > ul li{
		display: block;
		width: 100%;
		height:35px;
		margin-bottom:5px;
		text-align: left;
		vertical-align: middle;
		text-indent: 38px;
	}
	
	div.tips > ul li:first-child{
		margin-top: 5px;
	}
	
	div.tips > ul li div span{
		color: white;
		font-family: '黑体';
		font-size: 16px;
		line-height: 35px;
	}
	div.tips > ul li:hover div span{
		color: #3399ff;
		cursor: pointer;
	}
	
	#f_1{
		/* background: url(<%=path%>/resources/images/association.png) no-repeat 0px 0px;*/
		background: url(<%=path%>/resources/images/association.png);
		-moz-background-size:30px 30px;
		background-size:30px 30px;
		background-repeat:no-repeat;
		background-origin:content-box;
		background-position:2px 3px;
		height:100%;
	}
	
	#f_2{
		background: url(<%=path%>/resources/images/cluster.png);
		-moz-background-size:30px 30px;
		background-size:30px 30px;
		background-repeat:no-repeat;
		background-origin:content-box;
		background-position:2px 3px;
		height:100%;
	}
	
	#f_3{
		background: url(<%=path%>/resources/images/decisiontree.png);
		-moz-background-size:30px 30px;
		background-size:30px 30px;
		background-repeat:no-repeat;
		background-origin:content-box;
		background-position:2px 3px;
		height:100%;
	}
	
	#f_4{
		background: url(<%=path%>/resources/images/network.png);
		-moz-background-size:30px 30px;
		background-size:30px 30px;
		background-repeat:no-repeat;
		background-origin:content-box;
		background-position:2px 3px;
		height:100%;
	}
	
	#f_5{
		background: url(<%=path%>/resources/images/filedata.png);
		-moz-background-size:30px 30px;
		background-size:30px 30px;
		background-repeat:no-repeat;
		background-origin:content-box;
		background-position:2px 3px;
		height:100%;
	}
	#f_6{
		background: url(<%=path%>/resources/images/databasedata.png);
		-moz-background-size:30px 30px;
		background-size:30px 30px;
		background-repeat:no-repeat;
		background-origin:content-box;
		background-position:2px 3px;
		height:100%;
	}
	#f_7{
		background: url(<%=path%>/resources/images/missingvalue.png);
		-moz-background-size:30px 30px;
		background-size:30px 30px;
		background-repeat:no-repeat;
		background-origin:content-box;
		background-position:2px 3px;
		height:100%;
	}
	#f_8{
		background: url(<%=path%>/resources/images/statistic.png);
		-moz-background-size:30px 30px;
		background-size:30px 30px;
		background-repeat:no-repeat;
		background-origin:content-box;
		background-position:2px 3px;
		height:100%;
	}
	
</style>
	
<div id="leftmenu" class="content">
	<ul class='functionList'>
		<li>
			<a href="dataSource/datasetUpload.jsp">
				<div id='upload'>
					<span>数据集上传</span>
				</div>
			</a>
		</li>
		<li>
			<div id='choose'>
				<span>数据集选择</span>
			</div>
		</li>
		<li>
			<div id='preprocess'>
				<span>数据预处理</span>
			</div>
		</li>
		<li>
			<div id='analyse'>
				<span>挖掘与分析</span>
			</div>
		</li>
		<li>
			<div id='other'>
				<span>其他案例</span>
			</div>
		</li>
	</ul>
</div>

<%--数据集上传--%>
<div class='popFunctionList' related-id='upload_unuse'>
	<div class='arrow'>
	
	</div>
	<div class='tips'>
	
	</div>
</div>

<%--数据集选择--%>
<div class='popFunctionList' related-id='choose' style='height:90px'>
	<div class='arrow'>
	
	</div>
	<div class='tips' style='width:160px'>
		<ul>
			<li>
				<a href="fileDatasetList">
					<div id='f_5'>
						<span>选择文件型数据</span>
					</div>
				</a>
			</li>
			<li>
				<a href="dataSource/dbDatasetList.jsp">
					<div id='f_6'>
						<span>选择数据库数据</span>
					</div>
				</a>
			</li>
		</ul>
	</div>
</div>

<%--数据预处理--%>
<div class='popFunctionList' related-id='preprocess' style='height:90px'>
	<div class='arrow'>
	
	</div>
	<div class='tips'>
		<ul>
			<li>
				<a href="showmissing">
					<div id='f_7'>
						<span>缺失值处理</span>
					</div>
				</a>
			</li>
			<li>
				<a href="datamining/statInfo.jsp">
					<div id='f_8'>
						<span>统计信息描述</span>
					</div>
				</a>
			</li>
		</ul>
	</div>
</div>

<%--挖掘与分析--%>
<div class='popFunctionList' related-id='analyse'>
	<div class='arrow'>
	
	</div>
	<div class='tips'>
		<ul>
			<li>
				<a href="datamining/apriori.jsp">
					<div id='f_1'>
						<span>关联规则分析</span>
					</div>
				</a>
			</li>
			<li>
				<a href="datamining/kmeans.jsp">
					<div id='f_2'>
						<span>聚类</span>
					</div>
				</a>
			</li>
			<li>
				<a href="datamining/dtree.jsp">
					<div id='f_3'>
						<span>决策树分析</span>
					</div>
				</a>
			</li>
			<li>
				<a href="networkfileList">
					<div id='f_4'>
						<span>社交网络分析</span>
					</div>
				</a>
			</li>
		</ul>
	</div>
</div>

<%--其他选项--%>
<div id='other_list' class='popFunctionList' related-id='other' style="height:60px; top: 491px;">
	<div class='arrow' style="background-position: 2px 15px;">
	 
	</div>
	<div class='tips'>
		<ul>
			<li>
				<a href="datamining/bigscatter.jsp">
					<div id='f_8'>
						<span>大规模散点图</span>
					</div>
				</a>
			</li>
		</ul>
	</div>
</div>

<script type="text/javascript">

	$(document).ready(function(){
		$("#leftmenu ul > li").mouseover(function(){
			var offset = {"upload":10,"choose":0,"preprocess":0,"analyse":-25,"other":-50};
			var X = $(this).offset().top;
			var Y = $(this).offset().left;
			console.log(X+","+Y+","+$(this).css("width"));

			$("div[related-id]").css("display","none");

			//alert($($(this).children()[0]).attr("id"));
			$("div[related-id='"+$($(this).children()[0]).attr("id")+"']").css("display","block");
			$("div[related-id='"+$($(this).children()[0]).attr("id")+"']").css("z-index","9999");
			$("div[related-id='"+$($(this).children()[0]).attr("id")+"']").css("left",$(this).css("width")+"");
			$("div[related-id='"+$($(this).children()[0]).attr("id")+"']").css("top",(X+offset[$($(this).children()[0]).attr("id")])+"px");

			$("div.arrow").css("background-position","2px "+(35-offset[$($(this).children()[0]).attr("id")])+"px");

			$("#other_list").css("height","60px");
			$("#other_list").css("top","491px");
			//$("#popFunctionList").css("height","60px");
			$("div.arrow").css("background-position","2px 15px");
			
		});

		$("body").children().click(function(){
			//alert($(this).attr("related-id"));
			if($(this).attr("id")!="leftmenu" && $(this).attr("related-id")==undefined){
				$("div[related-id]").css("display","none");
				$("div[related-id]").css("z-index","-1");
			}
		});
		
	});

</script>