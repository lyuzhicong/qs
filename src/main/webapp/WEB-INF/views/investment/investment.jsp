<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<link href="${pageContext.request.contextPath }/resources/css/web/reset.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/resources/css/web/media.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/resources/css/web/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/dot/doT.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/main.js"></script>

<head>
<title>青松基金</title>
</head>
<body>
	<header>
		<div class="header">
			<div class="logo">
				<img src="${pageContext.request.contextPath }/resources/images/web/logo.png">
			</div>
			<nav>
				<ul class="nav">
					<li><a href="${pageContext.request.contextPath }/">首页</a></li>
					<li class="active"><a href="${pageContext.request.contextPath }/investment">投资组合</a></li>
					<li><a href="${pageContext.request.contextPath }/team">投资团队</a></li>
					<li><a href="${pageContext.request.contextPath }/share">青松动态</a></li>
					<li><a href="${pageContext.request.contextPath }/about">关于青松</a></li>
				</ul>
			</nav>
		</div>

	</header>
	<div class="group-wrap">
		<ul class="group">
			<c:forEach items="${investmentVoList }" var="investment">
				<li style="cursor: pointer;" data-id="${investment.id }"><img src="${pageContext.request.contextPath }${investment.imagePath}">
					<div>${investment.introduction }</div>
				</li>
			</c:forEach>
		</ul>
	</div>
	<footer>
		<div class="footer">
			<div></div>
			<small>© 2012 QingSong Fund All rights reserved. 粤ICP备12034380号</small> <span> <img src="${pageContext.request.contextPath }/resources/images/web/pic_QR_code.png" id="wechatcode"> <img src="${pageContext.request.contextPath }/resources/images/web/icon_wechat_normal.png" id="wechat">
			</span>
		</div>

	</footer>
</body>
<script type="text/javascript">
	$(function() {
		$(".group li").hover(function() {
			$(this).find("div").css("visibility", "visible");
		}, function() {
			$(this).find("div").css("visibility", "hidden");
		})

		$(".group li").click(function() {
			var id = $(this).data('id');
			location.href = '${pageContext.request.contextPath}/investment/investmentDetail?id=' + id;
		})
	})
</script>

</html>