<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<link href="${pageContext.request.contextPath}/resources/css/web/public.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/web/reset.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/web/main.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/web/media.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/dot/doT.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script type="text/javascript">
	//平台、设备和操作系统
	var system = {
		win : false,
		mac : false,
		xll : false
	};
	//检测平台
	var p = navigator.platform;
	system.win = p.indexOf("Win") == 0;
	system.mac = p.indexOf("Mac") == 0;
	system.x11 = (p == "X11") || (p.indexOf("Linux") == 0);
	//跳转语句，如果是手机访问就自动跳转到wap页面
	if (system.win || system.mac || system.xll) {
	} else {
		window.location.href = "${pageContext.request.contextPath }/getIndexWap";
	}
</script>

<head>
<title>青松</title>
</head>

<body>
	<header>
		<div class="header">
			<div class="logo">
				<img src="${pageContext.request.contextPath}/resources/images/web/logo.png">
			</div>
			<nav>
				<ul class="nav">
					<li class="active"><a href="${pageContext.request.contextPath }">首页</a></li>
					<li><a href="${pageContext.request.contextPath }/investment">投资组合</a></li>
					<li><a href="${pageContext.request.contextPath }/team">投资团队</a></li>
					<li><a href="${pageContext.request.contextPath }/share">青松动态</a></li>
					<li><a href="${pageContext.request.contextPath }/about">关于青松</a></li>
				</ul>
			</nav>
		</div>

	</header>
	<main>
	<div class="main-wrap">
		<div class="main">
			<ul>
				<c:if test="${indexVoList.size() == 3 }">
					<li class="main-li">
						<div class="main-li-fst">
							<p>${indexVoList.get(0).number }</p>
							<p>${indexVoList.get(0).content }</p>
						</div>
					</li>
					<li>
						<div class="main-li-sec">
							<p>${indexVoList.get(1).number }</p>
							<p>${indexVoList.get(1).content }</p>
						</div>
					</li>
					<li>
						<div class="main-li-thd">
							<p>${indexVoList.get(2).number }</p>
							<p>${indexVoList.get(2).content }</p>
						</div>
					</li>
				</c:if>
			</ul>
		</div>
	</div>
	<div class="detail">
		<div class="detail-top">
			<span>挖掘创新型企业</span> <span>助其成为基业长青的伟大公司</span>
		</div>
		<ul class="detail-bottom">
			<li>
				<div>
					<img src="${pageContext.request.contextPath}/resources/images/web/pic_feature_1.png"> <span>种子期</span>
				</div> <!--<div>
                        感谢青松基金，让我在创业路上快速成长，记得我们从见面谈项目到打款只用了一周时间，青松基金是中国最棒的，最专业“快投”天使。
                    </div>-->
			</li>

			<li>
				<div>
					<img src="${pageContext.request.contextPath}/resources/images/web/pic_feature_2.png"> <span>早期</span>
				</div> <!--<div>
                        感谢青松基金，让我在创业路上快速成长，记得我们从见面谈项目到打款只用了一周时间，青松基金是中国最棒的，最专业“快投”天使。
                    </div>-->
			</li>

			<li>
				<div>
					<img src="${pageContext.request.contextPath}/resources/images/web/pic_feature_3.png"> <span>成长期</span>
				</div> <!--<div>
                        感谢青松基金，让我在创业路上快速成长，记得我们从见面谈项目到打款只用了一周时间，青松基金是中国最棒的，最专业“快投”天使。
                    </div>-->
			</li>
		</ul>
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