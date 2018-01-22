<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<link href="${pageContext.request.contextPath}/resources/css/web/reset.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/web/media.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/web/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/dot/doT.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script type="text/javascript">
	$(function() {

	})
</script>

<head>
<title>青松基金</title>
</head>
<style type="text/css">
.returnButton {
	border: 1px solid #e2e2e2;
	padding: 2px;
	border-radius: 2px;
}
</style>
<body>
	<header>
		<div class="header">
			<div class="logo">
				<img src="${pageContext.request.contextPath}/resources/images/web/logo.png">
			</div>
			<nav>
				<ul class="nav">
					<li><a href="${pageContext.request.contextPath }/">首页</a></li>
					<li class="active"><a href="${pageContext.request.contextPath }/investment">投资组合</a></li>
					<li><a href="${pageContext.request.contextPath }/team">投资团队</a></li>
					<li><a href="${pageContext.request.contextPath }/share">青松分享</a></li>
					<li><a href="${pageContext.request.contextPath }/about">关于青松</a></li>
				</ul>
			</nav>
		</div>

	</header>
	<main class="group-detail-wrap">
	<ul class="group-detail">
		<li class="active">
			<h3>${investment.title }</h3> <span>发表日期： ${investment.time }</span>
			<p>${investment.content }</p>
		</li>
	</ul>
	<span><a class="returnButton" href="${pageContext.request.contextPath }/investment">返回</a></span> </main>
	<footer>
		<div class="footer">
			<div></div>
			<small>© 2012 QingSong Fund All rights reserved. 粤ICP备12034380号</small> <span> <img src="${pageContext.request.contextPath }/resources/images/web/pic_QR_code.png" id="wechatcode"> <img src="${pageContext.request.contextPath }/resources/images/web/icon_wechat_normal.png" id="wechat">
			</span>
		</div>
	</footer>
</body>
</html>