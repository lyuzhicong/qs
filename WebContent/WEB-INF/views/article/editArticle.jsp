<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/bootstrap/bootstrap.min.js"></script>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/bootstrap/bootstrap.min.css">
<title>编辑文章</title>
</head>
<style type="text/css">
.block{
	margin: 20px;
}
</style>
<body>
<div class="block">
	<h2>编辑文章</h1>
	<form action="../article/saveArticle.do" method="post" class="form-horizontal">
		<div class="form-group">
			<label class="col-sm-2 control-label">标题：</label>
			<div class="col-sm-4">
				<input type="text" name="title" class="form-control" />
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">小标题:</label>
			<div class="col-sm-4">
				<input type="text" name="littleTitle" class="form-control" />
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">内容：</label>
			<div class="col-sm-4">
				<textarea rows="20" cols="200" name="content" class="form-control"></textarea>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" class="btn btn-default">提交</button>
			</div>
		</div>
	</form>
	</div>
</body>
</html>