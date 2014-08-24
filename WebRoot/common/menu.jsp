<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="黄委信息中心,黄河,水量调度,监视系统">
		<meta http-equiv="description" content="黄河水量调度综合监视系统">
		<title>综合监视菜单项</title>

		<!-- Styles -->
		<link rel="stylesheet" href="<%=path%>/resources/core.css">
		<link rel="stylesheet" href="<%=path%>/resources/css/menu.css">

	</head>
	<body>
		<!-- Header -->
		
		<div id="header" class="section">
					<ul class="nav-h">
						<li> 
							<a href="http://10.4.1.10/QXYB/index.aspx?MenuID=0901" target="_blank">气象信息</a>
							<ul>
								<li>
									<a href="http://10.4.1.10/QXYB/index.aspx?MenuID=0901" target="_blank">预报信息</a>
								</li>
								<li>
									<a href="http://10.4.1.10/YT/index.aspx?MenuID=0100" target="_blank">云图应用</a>
								</li>
								<li>
									<a>半球云图</a>
								</li>
								<li>
									<a href="http://10.4.1.10/QXCZ/index.aspx?MenuID=0600" target="_blank">气象传真</a>
								</li>
								<li>
									<a href="http://10.4.1.9/" target="_blank">综合信息</a>
								</li>
							</ul>
						</li>
						<li> 
							<a href="<%=path%>/main/yq/yq.jsp">雨情信息</a>
							<ul>
								<li>
									<a href="<%=path%>/main/yq/yq.jsp">降雨信息</a>
								</li>
								<%
									String py = (String)session.getAttribute("pinyin");
									if(py!=null && py.equals("super")){
								%>
								<li>
									<a href="<%=path%>/main/yq/yqfxdb.jsp">雨情分析对比</a>
								</li>
								<li>
									<a href="http://10.4.1.10/YLXX/SYL/index.aspx?MenuID=0201" target="_blank">雨量图</a>
								</li>
								<%
									}
								%>
							</ul>
						</li>
						<li> 
							<a href="<%=path%>/main/sqxx/hdsq.jsp">水情信息</a>
							<ul>
								<li>
									<a href="<%=path%>/main/sqxx/hdsq_yesterday.jsp">河道水情</a>
								</li>
								<li>
									<a href="<%=path%>/main/sqxx/sksq.jsp">水库水情</a>
								</li>
								
								<%
									//py = (String)session.getAttribute("pinyin");
									if(py!=null && py.equals("super")){
								%>
								<li>
									<a href="<%=path%>/main/sqxx/hdsqfxdb.jsp">水情分析<span class='sub-arrow'>+</span></a>
									<ul>
										<li>
											<a href="<%=path%>/main/sqxx/hdsqfxdb.jsp">河道水情分析对比</a>
										</li>
										<li>
											<a href="<%=path%>/main/sqxx/hdlsdb.jsp">河道历史对比</a>
										</li>
										<li>
											<a href="<%=path%>/main/sqxx/lshdsq.jsp">历史河道水情</a>
										</li>
										<li>
											<a href="<%=path%>/main/sqxx/sksqfxdb.jsp">水库水情分析对比</a>
										</li>
										<li>
											<a href="<%=path%>/main/sqxx/sklsdb.jsp">水库历史对比</a>
										</li>
										<li>
											<a href="<%=path%>/main/sqxx/lssksq.jsp">历史水库水情</a>
										</li>
										<li>
											<a href="<%=path%>/main/sqxx/skxbl.jsp">水库历史蓄变量</a>
										</li>
									</ul>
								</li>
								<li>
									<a href="<%=path%>/main/sqxx/jlyb.jsp">中长期径流预报</a>
								</li>
								<li>
									<a href="<%=path%>/main/sqxx/sqrb.jsp">水情日报</a>
								</li>
								<%
									}
								%>	
							</ul>
						</li>
						<li> 
							<a href="http://10.4.10.163/sd/themePage.aspx" target="_blank">墒情信息</a>
						</li>
						
						<li> 
							<a href="<%=path%>/main/sz/szsk.jsp">水质信息</a>
							<ul>
								<li>
									<a href="<%=path%>/main/sz/szsk.jsp">水质实况</a>
								</li>
								<li>
									<a href="<%=path%>/main/sz/szyb.jsp">水质预报</a>
								</li>
								<%
									//py = (String)session.getAttribute("pinyin");
									if(py!=null && py.equals("super")){
								%>
								<li>
									<a href="<%=path%>/main/sz/dzszdb.jsp">水质分析<span class='sub-arrow'>+</span></a>
									<ul>
										<li>
											<a href="<%=path%>/main/sz/dzszdb.jsp">多站水质对比查询</a>
										</li>
										<li>
											<a href="<%=path%>/main/sz/szlsdb.jsp">水质历史对比</a>
										</li>
										<li>
											<a href="<%=path%>/main/sz/szskybdb.jsp">水质实况预报对比</a>
										</li>
									</ul>
								</li>
								<%
									}
								%>
							</ul>
						</li>
						
						<li>
							<a href="<%=path%>/main/yts/ssys.jsp">引退水信息</a>
							<ul>
								<li>
									<a href="<%=path%>/main/yts/ssys.jsp">引水信息<span class='sub-arrow'>+</span></a>
									<ul>
										<li>
											<a href="<%=path%>/main/yts/ssys.jsp">省市引水</a>
										</li>
										<%
											//py = (String)session.getAttribute("pinyin");
											if(py!=null && py.equals("super")){
										%>
										<li>
											<a href="<%=path%>/main/yts/hdys.jsp">河段引水</a>
										</li>
										<%
											}
										%>
										<li>
											<a href="<%=path%>/main/yts/hzys.jsp">涵闸引水</a>
										</li>
									</ul>
								</li>
								<%
									if(py!=null && (py.equals("super")||py.equals("ningxia")||py.equals("neimenggu"))||py.equals("zhongshangyou")){
								%>
								<li>
									<a href="#">退水信息<span class='sub-arrow'>+</span></a>
									<ul>
										<li>
											<a href="<%=path%>/main/yts/nmts.jsp">退水信息</a>
										</li>
									</ul>
								</li>
								<%
									}
								%>
								<%
									if(py!=null && py.equals("super")){
								%>
								<li>
									<a href="#">引水分析<span class='sub-arrow'>+</span></a>
									<ul>
										<li>
											<a href="<%=path%>/main/yts/ysjhskdb.jsp">引水计划实况对比</a>
										</li>
										<li>
											<a href="<%=path%>/main/yts/yslstqdb.jsp">引水历史同期对比</a>
										</li>
										<li>
											<a href="<%=path%>/main/yts/sqndhstjb.jsp">省区年度耗水统计</a>
										</li>
										
										<li>
											<a href="<%=path%>/main/yts/lnqjls.jsp">历年区间来水资料</a>
										</li>
										<li>
											<a href="<%=path%>/main/yts/hhgzlsktj.jsp">黄河干支流各省区实况耗水量统计</a>
										</li>
									</ul>
								</li>
								<li>
									<a href="<%=path%>/main/yts/srys.jsp">引水统计<span class='sub-arrow'>+</span></a>
									<ul>
										<li>
											<a href="<%=path%>/main/yts/srys.jsp">省区逐日取水统计</a>
										</li>
									</ul>
								</li>
								<%
									}
								%>
								<li>
									<a href="<%=path%>/main/yts/huanghejc.jsp">
										引水监测查询
										<span class='sub-arrow'>+</span>
									</a>
									<ul>
										<li>
											<a href="<%=path%>/main/yts/huanghejc.jsp">引水监测</a>
										</li>
										<li>
											<a href="<%=path%>/main/yts/huanghejc_new.jsp">引水监测（新）</a>
										</li>
										<li>
											<a href="<%=path%>/main/yts/shengjc.jsp">各省区引水监测</a>
										</li>
										<li>
											<a href="<%=path%>/main/yts/shengjc_new.jsp">各省区引水监测（新）</a>
										</li>
										<%
											if(py!=null && (py.equals("super")||py.equals("henan")||py.equals("shandong"))){
										%>
										<li>
											<a href="<%=path%>/main/yts/shijc.jsp">市引水监测</a>
										</li>
										<li>
											<a href="<%=path%>/main/yts/shijc_new.jsp">市引水监测（新）</a>
										</li>
										<%
											}
										%>
										<li>
											<a href="<%=path%>/main/yts/chokejc.jsp">涵闸引水监测</a>
										</li>
										<li>
											<a href="<%=path%>/main/yts/chokejc_new.jsp">涵闸引水监测（新）</a>
										</li>
									</ul>
								</li>
								<%
									if(py!=null && py.equals("super")){
								%>
								<li>
									<a href="<%=path%>/main/yts/ysrb.jsp">引水日报</a>
								</li>
								<%
									}
								%>
							</ul>
						</li>
						
						<%
							if(py!=null && py.equals("super")){
						%>	
						<li> 
							<a href="#">调度服务</a>
							<ul>
								<li>
									<a href="<%=path%>/main/ddfw/hdcxsl.jsp">河段槽蓄水量统计</a>
								</li>
								<li>
									<a href="<%=path%>/main/ddfw/kgslb.jsp">370亿可供水量分配</a>
								</li>
								<li>
									<a href="<%=path%>/main/ddfw/hdysfx.jsp">河段耗水统计分析</a>
								</li>
								<li>
									<a href="<%=path%>/main/ddfw/sdkyslfx.jsp">时段可用水量分析</a>
								</li>
<%--								<li>--%>
<%--									<a href="#">不平衡量统计</a>--%>
<%--								</li>--%>
<%--								<li>--%>
<%--									<a href="#">可用水量计算统计</a>--%>
<%--								</li>--%>
							</ul>
						</li>
						
						<li> 
							<a href="<%=path%>/main/jsyj/llkzdm.jsp">监视预警</a>
							<ul>
								<li>
									<a href="<%=path%>/main/jsyj/ysyj.jsp">省区用水预警方案</a>
								</li>
								<li>
									<a href="<%=path%>/main/jsyj/llkzdm.jsp">流量控制断面预警设置</a>
								</li>
								<li>
									<a href="<%=path%>/main/jsyj/wtqt.jsp">水质预警设置</a>
								</li>
								<li>
									<a href="<%=path%>/main/jsyj/yjxx.jsp">一般预警信息</a>
								</li>
								<li>
									<a href="<%=path%>/main/jsyj/tfyjxx.jsp">突发预警信息</a>
								</li>
								<li>
									<a href="<%=path%>/main/jsyj/kzdmbzl.jsp">控制断面最小保证率</a>
								</li>
							</ul>
						</li>
						
						<li> 
							<a href="<%=path%>/main/ddfa/sdfa.jsp">方案信息</a>
							<ul>
								<li>
									<a href="<%=path%>/main/ddfa/sdfa.jsp">水调方案查询</a>
								</li>
								<li>
									<a href="http://10.4.10.47:8081/SDB_YW/search/zd_search_ys1.jsp" target="_blank">用水计划查询</a>
								</li>
								<li>
									<a href="<%=path%>/main/ddfa/yjya.jsp">应急响应预案</a>
								</li>
							</ul>
						</li>
						<%
							}
						%>

						<li> 
							<a href="<%=path%>/main/lyxx/lygk_info.jsp">流域概况</a>
							<ul>
								<li>
									<a href="<%=path%>/main/lyxx/lygk_info.jsp">流域概况</a>
								</li>
								<li>
									<a href="<%=path%>/main/lyxx/hdgk.jsp">河段概况</a>
								</li>
								<li>
									<a href="<%=path%>/main/lyxx/skgk.jsp">水库概况</a>
								</li>
								<li>
									<a href="<%=path%>/main/lyxx/hzgk.jsp">涵闸概况</a>
								</li>
								<li>
									<a href="<%=path%>/main/lyxx/gqgk.jsp">灌区概况</a>
								</li>
								<li>
									<a href="<%=path%>/main/lyxx/shjj_info.jsp">社会经济概况</a>
								</li>
							</ul>
						</li>
<%--						--%>
<%--						<li class="current-menu-item">--%>
<%--							<a href="#">帮助</a>--%>
<%--						</li>--%>
					</ul>

				</div>

		<!-- Javascripts -->
		<script type="text/javascript" src="<%=path%>/resources/jquery-1.7.2.js"></script>
<%--		<script type="text/javascript" src="<%=path%>/resources/js/menu.js"></script>--%>
		<script type="text/javascript">
			$(function(){

				$.ajax({
				  //url: 'http://10.4.10.163/sd/themePage.aspx',
				  url: 'http://www.baidu.com/',
				  type: 'GET',
				  complete: function(XMLHttpRequest, textStatus) {
					   //alert(XMLHttpRequest.status);
					   //if(response.status == 200) {
					   // 	alert('有效');
					   //} else {
					   // 	alert('无效');
					   //}
					}
				});
				
				$("ul.nav-h ul ul").hover(function() {
	        		//alert($(this).parent().find("a:first").text());
	        		$(this).parent().find("a:first").each(function(){
		        		//$(this).addClass("blueClass_hover");//#1983af
		        		//$(this).css("background","#1983af");
		        		//$(this).css("background-image","-webkit-linear-gradient(top,#34a2d0 0%,#006791 100%)");
		        		//$(this).css("color","#fff");
		        		});
		        	}, 
		        	function() {
		        		//alert($(this).parent().find("a:first").text()+"-lik");
		        		$(this).parent().find("a:first").each(function(){
			        		//$(this).removeClass("blueClass_hover");
		        			//$(this).css("background","#fff");
			        		//$(this).css("color","#0673a5");
			        		});
		        	});
			});
		</script>
	</body>
</html>