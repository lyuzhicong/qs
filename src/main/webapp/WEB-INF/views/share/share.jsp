<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<link href="${pageContext.request.contextPath }/resources/css/web/reset.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/resources/css/web/media.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/resources/css/web/main.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/font/font-awesome/css/font-awesome.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/dot/doT.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/main.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery.pagination.js"></script>
<script type="text/javascript">
    $(function() {
    	var theyTalkSize =  $('#hidTheyTalkCount').val();
        var count = 1;
        var currentPage = 1;
        var pageSize = 5;
        var pageCount = null;
        $(".share-list ul li").hide();
        $(".share-list ul li:first").show();

        $("#next").click(function() {
            count++;
            if (count <= theyTalkSize) {
                $(".share-list ul li").hide();
                $(".share-list ul li:nth-child(" + count + ")").fadeIn("fast");
            } else {
                count = 1;
                $(".share-list ul li").hide();
                $(".share-list ul li:nth-child(" + count + ")").fadeIn("fast");
            }

        });

        $("#back").click(function() {
            count--;
            if (count <= theyTalkSize && count > 0) {
                $(".share-list ul li").hide();
                $(".share-list ul li:nth-child(" + count + ")").fadeIn("fast");
            } else {
                count = theyTalkSize;
                $(".share-list ul li").hide();
                $(".share-list ul li:nth-child(" + count + ")").fadeIn("fast");
            }

        });

        $.getJSON("article/getArticleList.do?currentPage=" + currentPage + "&pageSize=" + pageSize, function(data) {
            if (data) {
                var articleVoList = data.articleVoList;
                pageCount = data.pageCount;
                console.info(pageCount);
                $(".share-detail>ul").empty();

                for (var i = 0; i < articleVoList.length; i++) {
                    var articleVo = articleVoList[i];
                    var $li = $('<li style="cursor:pointer" id="' + articleVo.id + '"></li>');
                    var img = '<img src="' + articleVo.path + '">';
                    var title = "<h4>" + articleVo.title + "</h4>";
                    var date = "<span>" + articleVo.dateText + "</span>"
                    var $div = $('<div></div>');
                    $div.append(title).append(date);
                    $li.append(img).append($div);
                    $(".share-detail>ul").append($li);
                }

                //此demo通过Ajax加载分页元素
                var initPagination = function() {
                    var num_entries = pageCount;
                    // 创建分页
                    $("#Pagination").pagination(num_entries, {
                        num_edge_entries: 1, //边缘页数
                        num_display_entries: 2, //主体页数
                        callback: pageselectCallback,
                        items_per_page: 1, //每页显示1项
                        prev_text: "<i  class='fa fa-angle-left' aria-hidden='true'></i>",
                        next_text: "<i  class='fa fa-angle-right' aria-hidden='true'></i>"
                    });
                };

                initPagination();
            }
        });

        function pageselectCallback(page_index, jq) {
            $.getJSON("article/getArticleList.do?currentPage=" + (page_index + 1) + "&pageSize=" + pageSize, function(data) {
                if (data) {
                    var articleVoList = data.articleVoList;
                    $(".share-detail>ul").empty();
                    for (var i = 0; i < articleVoList.length; i++) {
                        var articleVo = articleVoList[i];
                        var $li = $('<li style="cursor:pointer" id="' + articleVo.id + '"></li>')
                        var img = '<img src="' + articleVo.path + '">';
                        var title = "<h4>" + articleVo.title + "</h4>";
                        var date = "<span>" + articleVo.dateText + "</span>"
                        var $div = $('<div id="' + articleVo.id + '"></div>');
                        $div.append(title).append(date);
                        $li.append(img).append($div);
                        $(".share-detail>ul").append($li);
                    }
                }
            });
        }
        
        $(document).on("click", ".share-detail li", function() {
            var id = $(this).closest("li").attr("id");
            location.href = "${pageContext.request.contextPath }/article/articleShareDetail?id=" + id;
        });
    });

    
</script>
<script id="theyTalkTmpl" type="text/x-dot-template">
</script>
<head>
<title>青松基金</title>
</head>
<body>
	<input type="hidden" id="hidTheyTalkCount" value="${theyTalkVoList.size() }">
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
	<main class="share-wrap">
	<div class="share">
		<div class="share-detail">
			<span>青松动态</span>
			<hr>
			<ul>
			</ul>
			<div id="Pagination" class="pagination"></div>
		</div>
		<c:if test="${isShow == 1 }">
			<div class="share-list">
				<span>创业者说</span>
				<hr>
				<ul>
					<c:forEach items="${theyTalkVoList }" var="item">
						<li>
							<h4>${item.title }</h4>
							<p>${item.content }</p> <img src="${item.imagePath }">
						</li>
					</c:forEach>
				</ul>
				<div>
					<i id="back" class="fa fa-angle-left" aria-hidden="true"></i> <i id="next" class="fa fa-angle-right" aria-hidden="true"></i>
				</div>
			</div>
		</c:if>
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