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
<title>DataGeek数据挖掘平台</title>


	<link rel="stylesheet" href="<%=path%>/resources/js/Jcrop/css/jquery.Jcrop.css" type="text/css" />
	<link rel="stylesheet" href="<%=path%>/resources/js/easydialog/easydialog.css" type="text/css" />
	<link rel="stylesheet" href="<%=path%>/resources/css/cutAndCrop.css" type="text/css" />
	
	<script type="text/javascript" src="<%=path%>/resources/js/canvg/rgbcolor.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/js/canvg/StackBlur.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/js/canvg/canvg.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/js/canvg/StackBlur.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/js/imgSave/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/js/imgSave/html2canvas.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/js/imgSave/jquery.plugin.html2canvas.fix.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/js/Jcrop/jquery.Jcrop.js"></script>
   	<script type="text/javascript" src="<%=path%>/resources/js/easydialog/easydialog.min.js"></script>
   	<script type="text/javascript" src="<%=path%>/resources/js/cutAndCrop.plugin.js"></script>
   	<script type="text/javascript" src="<%=path%>/resources/js/cutAndCrop.js"></script>
	
	
<body>
	
    <h1>截屏测试——01</h1>
    
    <button id="jieping">截屏</button>
    
	<div style="margin-top:5px;border:1px solid blue">
			六合，是古都南京的北门户，人杰地灵。“黄金水道”长江段重要支流的滁河也流经六合区，水资源丰富，沿河两岸工农业蓬勃发展，发展潜力巨大。但是，因为六合地处长江、滁河下游，汛期要承受滁河上游、中游6600多平方公里来水，洪水来量大，且受江潮顶阻，洪涝夹击，素有“洪水走廊”之称。整个境内水资分布不均，水资源短缺，人均及耕地平均占有水资源低于全国水平。特别是在枯水年份，局部地区饮水困难，完全要依赖长江水源。
		从战略意义上，充分考虑滁河的水资源状况和对六合区各行业的基础支撑地位，率先通过“智慧滁河”项目的开展，研究智慧河流，对于滁河乃至江苏都是非常有意义的：
		1）能直接提高六合区水利局对于滁河的防洪、水资源管理的水平；
		2）能间接提高南京的水利现代化水平，为水利现代化建设提供一个示范亮点。
		3）与南京未来全面建设智慧城市的思路是一致的，最终将通过集成与共享的方式，融入成为南京智慧城市的一部分。
		4）通过服务延伸的方式，将智慧流域或智慧河流的成效发挥到其他行业中，利用“水”是重要资源属性的内在，优化资源配置，促进社会稳定和行业均衡发展。	
	</div>
	
	<h1>区域截取——02</h1>
    
    <button id="jiequ">截取元素</button>
    
    <div id="paaa" style="margin-top:5px;border:1px solid blue">
			六合，是古都南京的北门户，人杰地灵。“黄金水道”长江段重要支流的滁河也流经六合区，水资源丰富，沿河两岸工农业蓬勃发展，发展潜力巨大。但是，因为六合地处长江、滁河下游，汛期要承受滁河上游、中游6600多平方公里来水，洪水来量大，且受江潮顶阻，洪涝夹击，素有“洪水走廊”之称。整个境内水资分布不均，水资源短缺，人均及耕地平均占有水资源低于全国水平。特别是在枯水年份，局部地区饮水困难，完全要依赖长江水源。
		从战略意义上，充分考虑滁河的水资源状况和对六合区各行业的基础支撑地位，率先通过“智慧滁河”项目的开展，研究智慧河流，对于滁河乃至江苏都是非常有意义的：
		1）能直接提高六合区水利局对于滁河的防洪、水资源管理的水平；
		2）能间接提高南京的水利现代化水平，为水利现代化建设提供一个示范亮点。
		3）与南京未来全面建设智慧城市的思路是一致的，最终将通过集成与共享的方式，融入成为南京智慧城市的一部分。
		4）通过服务延伸的方式，将智慧流域或智慧河流的成效发挥到其他行业中，利用“水”是重要资源属性的内在，优化资源配置，促进社会稳定和行业均衡发展。	
		
		六合，是古都南京的北门户，人杰地灵。“黄金水道”长江段重要支流的滁河也流经六合区，水资源丰富，沿河两岸工农业蓬勃发展，发展潜力巨大。但是，因为六合地处长江、滁河下游，汛期要承受滁河上游、中游6600多平方公里来水，洪水来量大，且受江潮顶阻，洪涝夹击，素有“洪水走廊”之称。整个境内水资分布不均，水资源短缺，人均及耕地平均占有水资源低于全国水平。特别是在枯水年份，局部地区饮水困难，完全要依赖长江水源。
		从战略意义上，充分考虑滁河的水资源状况和对六合区各行业的基础支撑地位，率先通过“智慧滁河”项目的开展，研究智慧河流，对于滁河乃至江苏都是非常有意义的：
		1）能直接提高六合区水利局对于滁河的防洪、水资源管理的水平；
		2）能间接提高南京的水利现代化水平，为水利现代化建设提供一个示范亮点。
		3）与南京未来全面建设智慧城市的思路是一致的，最终将通过集成与共享的方式，融入成为南京智慧城市的一部分。
		4）通过服务延伸的方式，将智慧流域或智慧河流的成效发挥到其他行业中，利用“水”是重要资源属性的内在，优化资源配置，促进社会稳定和行业均衡发展。	
		
		六合，是古都南京的北门户，人杰地灵。“黄金水道”长江段重要支流的滁河也流经六合区，水资源丰富，沿河两岸工农业蓬勃发展，发展潜力巨大。但是，因为六合地处长江、滁河下游，汛期要承受滁河上游、中游6600多平方公里来水，洪水来量大，且受江潮顶阻，洪涝夹击，素有“洪水走廊”之称。整个境内水资分布不均，水资源短缺，人均及耕地平均占有水资源低于全国水平。特别是在枯水年份，局部地区饮水困难，完全要依赖长江水源。
		从战略意义上，充分考虑滁河的水资源状况和对六合区各行业的基础支撑地位，率先通过“智慧滁河”项目的开展，研究智慧河流，对于滁河乃至江苏都是非常有意义的：
		1）能直接提高六合区水利局对于滁河的防洪、水资源管理的水平；
		2）能间接提高南京的水利现代化水平，为水利现代化建设提供一个示范亮点。
		3）与南京未来全面建设智慧城市的思路是一致的，最终将通过集成与共享的方式，融入成为南京智慧城市的一部分。
		4）通过服务延伸的方式，将智慧流域或智慧河流的成效发挥到其他行业中，利用“水”是重要资源属性的内在，优化资源配置，促进社会稳定和行业均衡发展。	
		
		六合，是古都南京的北门户，人杰地灵。“黄金水道”长江段重要支流的滁河也流经六合区，水资源丰富，沿河两岸工农业蓬勃发展，发展潜力巨大。但是，因为六合地处长江、滁河下游，汛期要承受滁河上游、中游6600多平方公里来水，洪水来量大，且受江潮顶阻，洪涝夹击，素有“洪水走廊”之称。整个境内水资分布不均，水资源短缺，人均及耕地平均占有水资源低于全国水平。特别是在枯水年份，局部地区饮水困难，完全要依赖长江水源。
		从战略意义上，充分考虑滁河的水资源状况和对六合区各行业的基础支撑地位，率先通过“智慧滁河”项目的开展，研究智慧河流，对于滁河乃至江苏都是非常有意义的：
		1）能直接提高六合区水利局对于滁河的防洪、水资源管理的水平；
		2）能间接提高南京的水利现代化水平，为水利现代化建设提供一个示范亮点。
		3）与南京未来全面建设智慧城市的思路是一致的，最终将通过集成与共享的方式，融入成为南京智慧城市的一部分。
		4）通过服务延伸的方式，将智慧流域或智慧河流的成效发挥到其他行业中，利用“水”是重要资源属性的内在，优化资源配置，促进社会稳定和行业均衡发展。	
	</div>
	
	<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"16"},"slide":{"type":"slide","bdImg":"2","bdPos":"right","bdTop":"100"},"image":{"viewList":["qzone","tsina","tqq","renren","weixin"],"viewText":"分享到：","viewSize":"16"},"selectShare":{"bdContainerClass":null,"bdSelectMiniList":["qzone","tsina","tqq","renren","weixin"]}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
	
	<script type="text/javascript">
		$(document).ready(function(){
			$("#jieping").click(function(){
				$("#chongxin").trigger("click");
			});

			$("#jiequ").click(function(){
				$("#paaa").cutThisArea();
			});
		});
	</script>
	
</body>
</html>