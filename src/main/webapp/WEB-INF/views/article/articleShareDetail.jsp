<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<link href="${pageContext.request.contextPath }/resources/css/web/reset.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/resources/css/web/media.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/resources/css/web/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/dot/doT.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap/bootstrap.min.js"></script>

<head>
<title>青松基金</title>
</head>
<script type="text/javascript">
    $(function() {
        var id = $('#hidArticleId').val();
        $.getJSON("${pageContext.request.contextPath }/article/getArticleShareById.do?id=" + id, function(data) {
            if (data) {
                var $detail = $(".article-detail");
                $detail.empty();
                var h3 = '<h3>' + data.title + '</h3>';
                var span = '<span>' + data.dateText + '</span>';
                var content = '<div>' + data.content + '</div>';
                $detail.append(h3).append(span).append(content);
            }
        });

        $.getJSON("${pageContext.request.contextPath }/article/getRelatedArticleList.do?currentPage=" + 1 + "&pageSize=" + 4 + "&id=" + id, function(data) {
            if (data) {
                var articleVoList = data.articleVoList;
                pageCount = data.pageCount;
                $(".article-list>ul").empty();

                for (var i = 0; i < articleVoList.length; i++) {
                    var articleVo = articleVoList[i];
                    var title = '<li style="cursor: pointer;" data-id="' + articleVo.id + '">' + articleVo.title + '</li>';
                    $(".article-list>ul").append(title);
                }
            }
        });
        
        $(document).on("click", ".article-list li", function() {
            var id = $(this).data("id");
            location.href = "${pageContext.request.contextPath }/article/articleShareDetail?id=" + id;
        });
    });

</script>

<body>
	<input type="hidden" id="hidArticleId" value="${id }"/>
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
					<li class="active"><a href="${pageContext.request.contextPath }/share">青松动态</a></li>
					<li><a href="${pageContext.request.contextPath }/about">关于青松</a></li>
				</ul>
			</nav>
		</div>

	</header>
	<main class="article-wrap">
	<div class="article">
		<div class="article-detail"></div>
		<div class="article-list">
			<span> 相关推荐 </span>
			<hr>
			<ul>
			</ul>
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