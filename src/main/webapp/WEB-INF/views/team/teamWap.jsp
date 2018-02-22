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
</script>
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
	<div class="team">
		<div class="team-top">
			<h3>
				<hr>
				拥有丰富投资经验的青松基金
			</h3>
			<h4>
				随时准备着帮助有梦想的企业家们
				<hr>
			</h4>
		</div>
		<ul>
			<c:forEach items="${teamVoList }" var="teamVo">
				<li data-id="${teamVo.id }"><img src="${teamVo.imagePath }">
					<div class="tip">
						<h4>${teamVo.name }</h4>
						<span>${teamVo.introduction }</span>
					</div></li>
			</c:forEach>
		</ul>

	</div>
	<div class="mask"></div>
</body>
<script src="${pageContext.request.contextPath }/resources/js/main-wap.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		$(".team li").click(function() {
			var id = $(this).data('id');
			window.location.href = "${pageContext.request.contextPath }/team/teamDetailWap?id=" + id;
		});
	})
</script>
</html>