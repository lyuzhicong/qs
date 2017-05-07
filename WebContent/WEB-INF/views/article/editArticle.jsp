<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadify/jquery.uploadify.min.js"></script>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/uploadify/uploadify.css">
<title>编辑文章</title>
<script type="text/javascript">
	$(function() {
		$("#uploadify").uploadify({
			'swf' : '${pageContext.request.contextPath}/swf/uploadify.swf',
			'uploader' : '${pageContext.request.contextPath}/article/uploadImages.do',
			'queueID' : 'queue',
			'auto' : true,//是否自动上传
			'multi' : true,
			'fileTypeExts' : '*.gif; *.jpg; *.png',
			'buttonText' : '选择',
	        'width':'60',    
	        'height':'28',  
	        'queueSizeLimit' : 5,
	        'removeCompleted' : false,
	        'onUploadSuccess' : function(file, data, response) {
	        	var html = "<input type=\"hidden\" name=\"image\" value=\"" + JSON.parse(data).path + "\">";
	        	$('#editForm').append(html);
	        }
		});
		
// 		$('#startUpload').click(function(){
// 			 $('#uploadify').uploadify('upload','*');
// 		});
		
// 		$('#cancelUpload').click(function(){
// 			$('#uploadify').uplodify('cancel','*');
// 		});
	});
</script>
</head>
<style type="text/css">
.block {
	margin: 20px;
}
</style>
<body>
	<div class="block">
		<h2>
			编辑文章
			</h1>
			<form id="editForm" action="../article/saveArticle.do" method="post" class="form-horizontal">
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
					<label class="col-sm-2 control-label">上传图片：</label>
					<div class="col-sm-4">
						<div id="queue"></div>
						<input id="uploadify" name="uploadify" type="file">
					</div>
				</div>
<!-- 				<div class="form-group"> -->
<!-- 					<div class="col-sm-offset-2 col-sm-10"> -->
<!-- 						<input type="button" class="btn btn-success btn-sm" value="上传" id="startUpload"> -->
<!-- 						<input type="button" class="btn btn-danger btn-sm" value="取消上传" id="cancelUpload"> -->
<!-- 					</div> -->
<!-- 				</div> -->
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="submit" class="btn btn-default">提交</button>
					</div>
				</div>
<%-- 				<img src="${pageContext.request.contextPath }/article/1111.jpg"> --%>
			</form>
	</div>
</body>
</html>