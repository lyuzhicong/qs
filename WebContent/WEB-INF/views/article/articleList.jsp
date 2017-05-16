<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文章列表</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery.confirm.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/dot/doT.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap/bootstrap.min.js"></script>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css">
<script type="text/javascript">
	$(function() {
		$('.editArticle').click(function() {
			var id = $(this).data('id');
			$(location).attr('href', 'editArticle.do?id=' + id);
		});

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
<body class="block">
	<table class="table table-hover">
		<thead>
			<th>标题</th>
			<th>时间</th>
			<th></th>
		</thead>
		<c:forEach items="${articleVoList }" var="articleVo">
			<tr>
				<td>${articleVo.title }</td>
				<td>${articleVo.date }</td>
				<td>
<%-- 					<button type="button" class="btn btn-warning btn-sm editArticle" data-id="${articleVo.id }">编辑</button> --%>
					<button type="button" class="btn btn-danger btn-sm deleteArticle" data-id="${articleVo.id }">删除</button>
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>