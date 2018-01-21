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
			var idx = $(this).closest("li").index() - 1;
			window.location.href = "group-detail-wap.html?idx=" + idx;
		})

		timer = setInterval(function() {
			$("#btn_next").click();
		}, 2000)

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
					<li><img src="${pageContext.request.contextPath }/resources/image/pic_number_1.png"></li>
					<li><img src="${pageContext.request.contextPath }/resources/image/pic_number_2.png"></li>
					<li><img src="${pageContext.request.contextPath }/resources/image/pic_number_3.png"></li>
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
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/1.jpg")'></div> <!--<img src="${pageContext.request.contextPath }/resources/image/ceo/1.jpg">--> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z1.png")'> <!--<span>
                   一花科技-->
			</span>
				<p>一花科技是一家从事休闲棋牌游戏开发和运营工作的互联网公司，于2016年被上市公司以9.86亿全资收购。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/2.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z2.png")'> </span>
				<p>哒哒英语是一家专注于5-16周岁青少儿英语学习的1对1在线教育品牌，纯正英语外教为小学员们提供最优质的教育服务。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/3.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z3.png")'> </span>
				<p>睿悦信息Nibiru是全球领先的移动VR技术及运营服务商，目前Nibiru VR系统已占据绝对领先的市场份额。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/4.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z4.png")'> </span>
				<p>小恒水饺是一家主打消费升级的新兴餐饮品牌，以门店堂食+外卖的形式为大家提供绿色健康的中国传统手工水饺。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/5.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z5.png")'> </span>
				<p>美丽约致力于为用户构建真实、高效、愉悦的同城约会交友平台，附近美女帅哥，一网打尽。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/6.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z6.png")'> </span>
				<p>掌门1对1专注于10-18岁青少年在线1对1课外辅导，是国内营业规模、学生数量、老师数量、融资数额最大的K12在线课外辅导品牌。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/7.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z7.png")'> </span>
				<p>洛克公园是以美式文化为核心打造的新一代运动场馆，也是全国最著名的连锁体育场馆之一。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/8.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z8.png")'> </span>
				<p>欢乐互娱是一家国内领先的页游、手游研发及运营商，尤其擅长动作格斗类网络游戏，代表游戏有《街机三国》、《街机之王》、《热血街霸》等。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/9.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z9.png")'> </span>
				<p>捞月狗以社交与游戏数据为基础，打造全球最大的游戏玩家社区。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/10.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z10.png")'> </span>
				<p>泰坦云是中国领先的一站式旅游技术服务平台，致力于为旅游供应商和旅游分销商提供互联网产品服务与电子商务解决方案。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/11.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z11.png")'> </span>
				<p>火溶信息专注于手机3D网络游戏开发，于2013年推出全球首款3D卡牌策略游戏《啪啪三国》，后被拓维信息以8.1亿收购。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/12.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z12.png")'> </span>
				<p>雷尚科技专注于军事题材游戏和策略玩法游戏的细分领域，在该领域保持国内领先，是最早出海的国内游戏公司之一，于2015年被上市公司以8.8亿元全资收购。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/13.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z13.png")'> </span>
				<p>乂学教育致力于打造智能技术和大数据相结合的自适应学习系统，成为中学生课外辅导的领先品牌。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/14.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z14.png")'> </span>
				<p>飞猪保险是国内领先的互联网保险服务提供商。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/15.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z15.png")'> </span>
				<p>北京彩球世纪是一家从彩票行业切入，专注从事竞技体育大数据应用服务的创新型科技公司。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/16.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z16.png")'> </span>
				<p>东娱传媒是一家以娱乐内容开发为核心的传媒机构，致力于通过娱乐行销生态链的打造国内一线的娱乐IP运营商。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/17.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z17.png")'> </span>
				<p>兰渡文化是国内领先的专注女性视频和女性社区的互联网文化公司，代表节目有《深夜蜜语》、《爱in思谈》。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/18.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z18.png")'> </span>
				<p>咕噜咕噜是一家专业的少儿运动成长中心，为孩子和家长提供专业的少儿多方位健身运动培训。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/19.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z19.png")'> </span>
				<p>热擎科技致力于移动互联网平台游戏产品的设计与研发，成为引领业界的互联网精品游戏研发商，代表游戏《轩辕剑之天之痕》。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/20.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z20.png")'> </span>
				<p>美颜家通过与日本及国内优秀实验室的合作研发，致力打造“中国质造”的专业护肤品牌，为女性消费者创造更多愉悦的护肤体验。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/21.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z21.png")'> </span>
				<p>轻停网络是基于自主研发的物联网专利技术，打造全连接、轻模式、生态化的一站式智慧停车云服务平台。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/22.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z22.png")'> </span>
				<p>微商水印相机是助梦工场旗下的一款微商服务APP，是微商行业最大的工具及服务提供商。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/23.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z23.png")'> </span>
				<p>壹线互动致力于精品化、系列化互联网影视内容的投资制作与发行，代表作品有《电竞高校》、《充气女友进化论》等。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/24.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z24.png")'> </span>
				<p>优曼集团是美国时尚家居生活品牌集团。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/25.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z25.png")'> </span>
				<p>婚礼纪是国内最大的一站式结婚服务平台。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/26.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z26.png")'> </span>
				<p>丛林文化专注打造全中国最具影响力的电子音乐派对品牌，引领国内电音文化先锋。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/27.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z27.png")'> </span>
				<p>Xbed用技术创新和共享模式打造纯互联网运营的分散式客房产品，是业界公认的世界最先进的酒店运营互联网解决方案。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/28.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z28.png")'> </span>
				<p>Learnta 是一家专注于学习技术与教育大数据的互联网公司，使命是“让每一个孩子的学习都更有效”。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/29.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z29.png")'> </span>
				<p>掌上大学是中国高校最早最大的校园营销服务sass平台。</p>
				<div class="company">了解更多</div>
			</li>
			<li class="ceo">
				<div class="image" style='background-image: url("${pageContext.request.contextPath }/resources/image/ceo/30.jpg")'></div> <span class="font" style='background-image: url("${pageContext.request.contextPath }/resources/image/fontlogo/z30.png")'> </span>
				<p>发到家为数万个小零售业主提供供应链及整套新零售技术及运营解决方案，打造新一代便利店。</p>
				<div class="company">了解更多</div>
			</li>

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