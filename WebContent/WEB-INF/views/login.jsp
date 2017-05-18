<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/bootstrap/bootstrap.min.js"></script>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/bootstrap/bootstrap.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>登录</title>
<script type="text/javascript">
	$(function(){
		$('#login').click(function(){
			$('#loginForm').ajaxSubmit({
				url : 'login.do',
				dataType : 'json',
				type : 'POST',
				success : function(data){
					if(data.Status == 'OK'){
						location.href="${pageContext.request.contextPath}/article/articleManager.do";
					}else{
						console.info("fail");
					}
				}
			})
		})
	})
</script>
</head>
<style type="text/css">
.block {
	margin: 20px;
}
</style>
<body class="block">
	<form id="loginForm" class="form-horizontal">
		<div class="form-group">
			<label class="col-sm-2 control-label">账号：</label>
			<div class="col-sm-4">
				<input type="text" name="name" class="form-control" />
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">密码:</label>
			<div class="col-sm-4">
				<input type="password" name="password" class="form-control" />
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="button" class="btn btn-success" id="login">登录</button>
			</div>
		</div>
	</form>
</body>
</html>