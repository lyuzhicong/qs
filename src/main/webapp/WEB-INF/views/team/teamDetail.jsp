<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
		$(document).on('click', '.number-list li', function() {
			$(this).addClass('active').siblings().removeClass('active');
			var id = $(this).data('id');

			$.getJSON('${pageContext.request.contextPath }/team/getTeamById?id=' + id, function(data) {
				$('.mainContent').empty().append(doT.template($('#mainTmpl').text())(data));
			})
		});

		var id = $('#hidId').val();
		$('.number-list li').each(function() {
			if ($(this).data('id') == id) {
				$(this).trigger('click');
			}
		})
	})
</script>

<script id="mainTmpl" type="text/x-dot-template">
<li class="number-introduction-detail active">
	<h3>{{=it.name}} </h3>
    <img src="{{=it.imagePath}}">
    <span>个人经历<hr></span>
    <article>
    <div class="personalExp">{{=it.content}}</div>
    <div>邮箱：{{=it.email}}<br>关注领域：{{=it.focusAreas || ''}}</div>
     </article>
    <span>投资项目<hr></span>
    <ul>
        <div>
             {{=it.projects}}            
        </div>
    </ul>
</li>
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
	<input type="hidden" value="${team.id }" id="hidId" />
	<header>
		<div class="header">
			<div class="logo">
				<img src="${pageContext.request.contextPath}/resources/images/web/logo.png">
			</div>
			<nav>
				<ul class="nav">
					<li><a href="${pageContext.request.contextPath }/">首页</a></li>
					<li><a href="${pageContext.request.contextPath }/investment">投资组合</a></li>
					<li class="active"><a href="${pageContext.request.contextPath }/team">投资团队</a></li>
					<li><a href="${pageContext.request.contextPath }/share">青松分享</a></li>
					<li><a href="${pageContext.request.contextPath }/about">关于青松</a></li>
				</ul>
			</nav>
		</div>

	</header>
	<main class="number-wrap">
	<div class="number">
		<div class="number-list">
			<span>团队成员</span>
			<ul>
				<c:forEach items="${teamVoList }" var="team">
					<li data-id="${team.id }">${team.name }</li>
				</c:forEach>
			</ul>
		</div>
		<div class="number-introduction">
			<ul class="mainContent">
			</ul>
		</div>
	</div>
	</main>
	<footer>
		<div class="footer">
			<div></div>
			<small>© 2012 QingSong Fund All rights reserved. 粤ICP备12034380号</small> <span> <img src="${pageContext.request.contextPath}/resources/images/web/pic_QR_code.png" id="wechatcode"> <img src="${pageContext.request.contextPath}/resources/images/web/icon_wechat_normal.png" id="wechat">
			</span>
		</div>

	</footer>
</body>
</html>