<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,
    chrome=1" />
<meta name="viewport" content="width=device-width,
    minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<title>青松基金</title>
<link href="${pageContext.request.contextPath }/resources/css/wap/reset.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/resources/css/wap/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery/jquery-2.1.4.min.js"></script>
</head>

<body>
	<header>
		<div class="logo">
			<img src="${pageContext.request.contextPath }/resources/image/logo.png">

		</div>
		<div class="menu">
			<img src="${pageContext.request.contextPath }/resources/image/icon_menu_normal.png">
		</div>
	</header>
	<nav id="floatmenu">
		<ul>
			<li><a href="${pageContext.request.contextPath }/">首页</a></li>
			<li><a href="${pageContext.request.contextPath }/investment/getInvestmentWap">投资组合</a></li>
			<li><a href="${pageContext.request.contextPath }/team/getTeamWap">投资团队</a></li>
			<li><a href="${pageContext.request.contextPath }/share/getShareWap">青松动态</a></li>
			<li><a href="${pageContext.request.contextPath }/about/getAboutWap">关于青松</a></li>
			<li><a href="${pageContext.request.contextPath }/about/getContactWap">联系我们</a></li>
		</ul>
	</nav>
	<main class="contact">
	<h3>上海</h3>
	<p>上海市静安区南京西路1486号SOHO东海广场3902室</p>
	<img src="${pageContext.request.contextPath }/resources/image/map_shanghai.png">
	<h3>深圳</h3>
	<p>深圳市南山区科技园科园路1002号A8音乐大厦24楼</p>
	<img src="${pageContext.request.contextPath }/resources/image/map_shenzhen.png">
	<h3>微信公众号</h3>
	<img src="${pageContext.request.contextPath }/resources/image/pic_QR_code.png" style="width: 40%; margin-top: 20px;">
	<p>长按识别二维码，关注我们</p>
	</main>
	<div class="mask"></div>
</body>
<script src="${pageContext.request.contextPath }/resources/js/main-wap.js" type="text/javascript"></script>

</html>