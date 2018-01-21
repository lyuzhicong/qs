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
			<li><a href="${pageContext.request.contextPath }/investment/getInvestmentWap">投资组合</a></li>
			<li><a href="${pageContext.request.contextPath }/team/getTeamWap">投资团队</a></li>
			<li><a href="${pageContext.request.contextPath }/share/getShareWap">青松分享</a></li>
			<li><a href="${pageContext.request.contextPath }/about/getAboutWap">关于青松</a></li>
			<li><a href="${pageContext.request.contextPath }/about/getContactWap">联系我们</a></li>
		</ul>
	</nav>
	<ul class="group">
		<div>
			<h3>
				<hr>
				GREAT COMPANY HAPPEN
			</h3>
			<h4>
				BECAUSE OF GREAT PEOPLE
				<hr>
			</h4>
		</div>
		<ul>
			<c:forEach items="${investmentVoList }" var="item">
				<li data-id="${item.id }"><img src="${item.imagePath }">
			</c:forEach>
			<!-- 			<li><img src="image/logo/1.png"></li> -->
			<!-- 			<li><img src="image/logo/2.png"></li> -->
			<!-- 			<li><img src="image/logo/3.png"></li> -->
			<!-- 			<li><img src="image/logo/4.png"></li> -->
			<!-- 			<li><img src="image/logo/5.png"></li> -->
			<!-- 			<li><img src="image/logo/6.png"></li> -->
			<!-- 			<li><img src="image/logo/7.png"></li> -->
			<!-- 			<li><img src="image/logo/8.png"></li> -->
			<!-- 			<li><img src="image/logo/9.png"></li> -->
			<!-- 			<li><img src="image/logo/10.png"></li> -->
			<!-- 			<li><img src="image/logo/11.png"></li> -->
			<!-- 			<li><img src="image/logo/12.png"></li> -->
			<!-- 			<li><img src="image/logo/13.png"></li> -->
			<!-- 			<li><img src="image/logo/14.png"></li> -->
			<!-- 			<li><img src="image/logo/15.png"></li> -->
			<!-- 			<li><img src="image/logo/16.png"></li> -->
			<!-- 			<li><img src="image/logo/17.png"></li> -->
			<!-- 			<li><img src="image/logo/18.png"></li> -->
			<!-- 			<li><img src="image/logo/19.png"></li> -->
			<!-- 			<li><img src="image/logo/20.png"></li> -->
			<!-- 			<li><img src="image/logo/21.png"></li> -->
			<!-- 			<li><img src="image/logo/22.png"></li> -->
			<!-- 			<li><img src="image/logo/23.png"></li> -->
			<!-- 			<li><img src="image/logo/24.png"></li> -->
			<!-- 			<li><img src="image/logo/25.png"></li> -->
			<!-- 			<li><img src="image/logo/26.png"></li> -->
			<!-- 			<li><img src="image/logo/27.png"></li> -->
			<!-- 			<li><img src="image/logo/28.png"></li> -->
			<!-- 			<li><img src="image/logo/29.png"></li> -->
			<!-- 			<li><img src="image/logo/30.png"></li> -->
		</ul>
	</ul>
	<div class="mask"></div>
</body>
<script src="${pageContext.request.contextPath }/resources/js/main-wap.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		$(".group li").click(function() {
			var idx = $(this).data('id')
			window.location.href = "${pageContext.request.contextPath }/investment/investmentDetailWapid=" + idx;
		});
	})
</script>
</html>