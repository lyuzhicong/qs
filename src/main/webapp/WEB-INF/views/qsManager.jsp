<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>青松管理员</title>
<link href="/resources/css/web/reset.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/web/media.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/web/main.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/web/public.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/resources/js/jquery/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="/resources/js/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function() {
		$('#btnLinkToQs').click(function() {
			location.href = "/";
		});
	});
</script>
</head>
<style type="text/css">
</style>
<body>
	<div style="margin: 20px; text-align: center;">
		<p style="font-weight: 500; font-size: 30px; color: #29754d;">青松后台管理入口</p>
		<div id="foot">
			<nav>
				<a target="_blank" href="${pageContext.request.contextPath }/edit/indexManager">首页</a>
				<a target="_blank" href="${pageContext.request.contextPath }/investment/edit/investmentManager">投资组合</a>
				<a target="_blank" href="${pageContext.request.contextPath }/team/edit/teamManager">投资团队</a>
				<a target="_blank" href="${pageContext.request.contextPath }/article/edit/articleManager.do">文章分享</a>
				<a target="_blank" href="${pageContext.request.contextPath }/share/edit/theyTalkManager">他们说</a>
				<a target="_blank" href="${pageContext.request.contextPath }/about/edit/editAboutQs">关于青松</a>
				<a target="_blank" href="${pageContext.request.contextPath }/edit/indexWapManager">手机首页数据管理</a>
				<a target="_blank" href="${pageContext.request.contextPath }/material/edit/materialManager">素材管理</a>
			</nav>
		</div>
		<button id="btnLinkToQs" class="btn btn-primary btn-sm" type="button">进入青松</button>
	</div>
</body>
</html>