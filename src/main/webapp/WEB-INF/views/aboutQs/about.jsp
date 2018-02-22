<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<link href="/resources/css/web/reset.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/web/media.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/web/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/resources/js/jquery/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="/resources/js/dot/doT.min.js"></script>
<script type="text/javascript" src="/resources/js/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/main.js"></script>
<!-- <script type="text/javascript" src="/resources/js/common.js"></script> -->
<script type="text/javascript">
// 	$(function(){
// 		var content = $('#hidContent').val();
// 		content = content.replace(/\r\n/g, "<br/>");
// 		content = content.replace(/\n/g, "<br/>");
// 		content = content.replace(/\s/g, "&nbsp;");
// 		$('#content').empty().html(content);
// 	})	
</script>
<head>
<title>青松基金</title>
</head>

<body>
<%-- 	<input type="hidden" value="${aboutQsVo.content }" id="hidContent"/> --%>
	<header>
		<div class="header">
			<div class="logo">
				<img src="${pageContext.request.contextPath }/resources/images/web/logo.png">
			</div>
			<nav>
				<ul class="nav">
					<li><a href="${pageContext.request.contextPath }/">首页</a></li>
					<li><a href="${pageContext.request.contextPath }/investment">投资组合</a></li>
					<li><a href="${pageContext.request.contextPath }/team">投资团队</a></li>
					<li><a href="${pageContext.request.contextPath }/share">青松动态</a></li>
					<li class="active"><a href="${pageContext.request.contextPath }/about">关于青松</a></li>
				</ul>
			</nav>
		</div>
	</header>
	<main class="about-wrap">
	<div class="about">
		<section>
			<h3>${aboutQsVo.title }</h3>
			<!-- 			<h3>为什么选择青松基金?</h3> -->
			<div id="content">${aboutQsVo.content }</div>
			<!-- 				&nbsp;&nbsp;&nbsp;&nbsp;青松基金由刘晓松、董占斌、苏蔚三位互联网及投资界资深人士于2012年6月创办，是一家主要致力于早期投资的风险投资机构。基金旗下共管理三期人民币基金，总值约13亿元人民币。截至2016年12月，青松基金已投资了95家公司。 <br>&nbsp;&nbsp;&nbsp;&nbsp;青松基金的创始合伙人均为经验丰富的企业家或投资人。在组建青松基金之前，他们或创立公司并将其发展壮大，或在顶尖的互联网、金融机构中担任高管多年。青松的合伙人有平均15年的投资经验，到2016年12月，合伙人累计投资项目近130个，涉及投资金额约达47亿人民币。经验丰富的基金管理团队长期活跃在北京、深圳、上海等中国产业创新的前沿地带。 <br>&nbsp;&nbsp;&nbsp;&nbsp;在已经投资的企业中，青松独家投资和领投比例达98%；也因为“从立项到打款，最快时间为一周”的超常规效率，备受投资企业赞誉。我们的目标是，充分利用合伙人在资本市场的经验以及广泛的人脉关系，为不同行业、不同阶段的企业提供支持，包括协助投资团队和被投企业进行各类资本市场活动。 -->
		</section>
		<section>
			<h3>联系我们</h3>
			<!-- 			<address>Email:qingsong@qingsongfund.com</address> -->
			<address>Email:${aboutQsVo.email }</address>
		</section>
		<div class="address">
			<div>
				<img src="${pageContext.request.contextPath }/resources/images/web/map_shanghai.png"> <span>上海市静安区南京西路1486号SOHO东海广场3902室</span>
			</div>
			<div>
				<img src="${pageContext.request.contextPath }/resources/images/web/map_shenzhen.png"> <span>深圳市南山区科技园科园路1002号A8音乐大厦23楼</span>
			</div>
		</div>
	</div>
	</main>
	<footer>
		<div class="footer">
			<div></div>
			<small>© 2012 QingSong Fund All rights reserved. 粤ICP备12034380号</small> <span> <img src="${pageContext.request.contextPath }/resources/images/web/pic_QR_code.png" id="wechatcode"> <img src="${pageContext.request.contextPath }/resources/images/web/icon_wechat_normal.png" id="wechat">
			</span>
		</div>
	</footer>
</body>
</html>