<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery.form.js"></script>
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
			'width' : '60',
			'height' : '28',
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

		$('#btnSubmit').click(function() {

			$('#editForm').ajaxSubmit({
				url : '${pageContext.request.contextPath}/article/saveArticle.do',
				dataType : 'json',
				type : 'POST',
				success : function(data) {
					if (data.Status == 'OK') {
						console.info("success");
					} else {
						console.info("fail");
					}
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

.fb-clonebtn {
	border: 2px dashed #ddd;
	border-radius: 4px;
	width: 100%;
	font-size: 12px;
	color: #666;
	background: #fff;
	outline: none !important;
}
</style>
<body>
	<div class="block">
		<h2>编辑文章</h2>
		<form id="editForm" class="form-horizontal">
			<div class="form-group">
				<label class="col-sm-1 control-label">标题：</label>
				<div class="col-sm-6">
					<input type="text" name="title" class="form-control" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label">内容：</label>
				<div class="col-sm-6" style="border: 1px solid #ccc; border-radius: 5px; padding: 20px 0 20px 0;">
					<div id="content">
						<div class="form-group">
							<label class="col-sm-2 control-label">小标题:</label>
							<div class="col-sm-9">
								<input type="text" name="littleTitle" class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">内容：</label>
							<div class="col-sm-9">
								<textarea rows="15" cols="200" name="content" class="form-control"></textarea>
							</div>
						</div>
					</div>
					<button type="button" class="fb-clonebtn" style="visibility: visible;" title="增加">增加</button>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label">上传图片：</label>
				<div class="col-sm-6">
					<div id="queue"></div>
					<input id="uploadify" name="uploadify" type="file">
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-1 col-sm-10">
					<button class="btn btn-default" id="btnSubmit">提交</button>
				</div>
			</div>
		</form>
	</div>
</body>
</html>