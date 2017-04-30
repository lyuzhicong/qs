<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑文章</title>
</head>
<body>
	<form action="saveArticle.do" method="post">
		标题：<input type="text" name="title"/><br><br>
		小标题:<input type="text" name="littleTitle"><br><br>
		内容：<textarea rows="20" cols="200" name="content"></textarea><br> 
		<button type="submit">提交</button>
	</form>
</body>
</html>