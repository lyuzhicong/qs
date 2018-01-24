<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>文章列表</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery/jquery.confirm.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/dot/doT.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap/bootstrap.min.js"></script>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/web/public.css">
<script type="text/javascript">
	$(function() {
		$('.editArticle').click(function() {
			var id = $(this).data('id');
// 			window.location.href = 'editArticle.do?id=' + id;
			window.location.href = 'articleShareEdit.do?id=' + id;
		});
		
		$('#addArticle').click(function(){
// 			window.location.href = 'editArticle.do';
			window.location.href = 'articleShareEdit.do';
		})

		$('.deleteArticle').click(function() {
			var id = $(this).data('id');
			$.confirm({
				title : '删除',
				text : '是否确认删除',
				confirmButton : '确定',
				cancelButton : '取消',
				confirm : function() {
					$.post('deleteArticleById.do?id=' + id, function(data) {
						if (data.Status == "OK") {
							window.location.reload(true);
						} else {
						}
					});
				},
				cancel : function() {
				}
			});
		});
		
	});
</script>
</head>
<style type="text/css">
.block {
	margin: 20px;
}
</style>
<body class="main-block">
	<h2>文章管理</h2>
	<button type="button" class="btn btn-success btn-sm" id="addArticle">新增</button>
	<table class="table table-hover">
		<thead>
			<th>标题</th>
			<th>时间</th>
			<th></th>
		</thead>
		<c:forEach items="${articleVoList }" var="articleVo">
			<tr>
				<td>${articleVo.title }</td>
				<td>${articleVo.dateText }</td>
				<td>
					<button type="button" class="btn btn-warning btn-sm editArticle" data-id="${articleVo.id }">编辑</button>
					<button type="button" class="btn btn-danger btn-sm deleteArticle" data-id="${articleVo.id }">删除</button>
				</td>
			</tr>
		</c:forEach>
	</table>
	<div id="foot">
			<nav>
				<a href="${pageContext.request.contextPath }/qsManager/edit/console">管理员首页</a> <a href="${pageContext.request.contextPath }/">进入青松</a>
			</nav>
		</div>
</body>
</html>