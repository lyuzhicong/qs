<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
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
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery.touchSlider.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/main-wap.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		$("#main-wrap").touchSlider({
			flexible : true,
			speed : 500,
			btn_prev : $("#btn_back"),
			btn_next : $("#btn_next"),
			paging : $(".point li"),
			counter : function(e) {

				$(".point li").removeClass("active").eq(e.current % 6 - 1).addClass("active");
			}
		})

		$(".company").click(function() {
			var idx = $(this).data('id');
			window.location.href = "${pageContext.request.contextPath }/companyDetailWap?id=" + idx;
		})

		timer = setInterval(function() {
			$("#btn_next").click();
		}, 3000000)

	})
</script>
</head>

<body id="index">
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
	<div id="main-wrap">
		<ul class="main">
			<li class="home">
				<ul>
					<div class="wap-index-div">
						<img src="${pageContext.request.contextPath }/resources/images/web/pic_number_frame_1.png">
						<p class="first-p">${indexVoList.get(0).number }</p>
						<p class="second-p">${indexVoList.get(0).content }</p>
					</div>
					<div class="wap-index-div">
						<img src="${pageContext.request.contextPath }/resources/images/web/pic_number_frame_2.png">
						<p class="first-p">${indexVoList.get(1).number }</p>
						<p class="second-p">${indexVoList.get(1).content }</p>
					</div>
					<div class="wap-index-div">
						<img src="${pageContext.request.contextPath }/resources/images/web/pic_number_frame_2.png">
						<p class="first-p">${indexVoList.get(2).number }</p>
						<p class="second-p">${indexVoList.get(2).content }</p>
					</div>
					<%-- 					<li><img src="${pageContext.request.contextPath }/resources/image/pic_number_1.png"></li> --%>
					<%-- 					<li><img src="${pageContext.request.contextPath }/resources/image/pic_number_2.png"></li> --%>
					<%-- 					<li><img src="${pageContext.request.contextPath }/resources/image/pic_number_3.png"></li> --%>

				</ul>
				<div style="margin-top: 30px">
					<h3>
						<hr>
						GREAT COMPANY HAPPEN
					</h3>
					<h4>
						BECAUSE OF GREAT PEOPLE
						<hr>
					</h4>
				</div>

			</li>

			<c:forEach items="${companyList }" var="company">
				<li class="ceo">
					<%-- 					<div class="image" style='background-image: url("${company.imagePath}")'></div> <span class="font" style='background-image: url("${company.littleLogoImagePath}")'> </span> --%> <img src="${company.imagePath}"> <img src="${company.littleLogoImagePath}">
					<p>${company.introduction}</p>
					<div class="company" data-id="${company.id }">了解更多</div>
				</li>
			</c:forEach>

		</ul>
	</div>
	<div class="footer">
		<button id="btn_back" style="visibility: hidden"></button>
		<ul class="point">
			<li class="active"></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
		</ul>
		<button id="btn_next" style="visibility: hidden"></button>
	</div>
	<div class="mask"></div>

</body>
</html>