<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/dot/doT.min.js"></script>
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
			'multi' : false,
			'fileTypeExts' : '*.gif;*.jpg; *.png',
			'buttonText' : '选择',
			'width' : '65',
			'height' : '32',
			'uploadLimit' : 1,
			'removeCompleted' : false,
			'onUploadSuccess' : function(file, data, response) {
				$('#pathId').remove();
				var html = "<input type=\"hidden\" id=\"pathId\" name=\"path\" value=\"" + JSON.parse(data).path + "\">";
				$('#editForm').append(html);
			},
// 			'onCancel' : function(file) {
// 				alert(file.name);
// 			}
		});
		// 		$('#startUpload').click(function(){
		// 			 $('#uploadify').uploadify('upload','*');
		// 		});

		// 		$('#cancelUpload').click(function(){
		// 			$('#uploadify').uplodify('cancel','*');
		// 		});

		$('#btnSubmit').click(function() {
			if($('#pathId').val()){
				console.info($('#pathId').val());
				$('#editForm').ajaxSubmit({
					url : '${pageContext.request.contextPath}/article/saveArticle.do',
					dataType : 'json',
					type : 'POST',
					success : function(data) {
						if (data.Status == 'OK') {
							location.href = 'articleManager.do';
						} else {
							console.info("fail");
						}
					}
				});
				
			}else{
				alert("请选择一张图片！");
			}
		});
		
		$('#backToArticleList').click(function(){
			location.href = "${pageContext.request.contextPath}/article/articleManager.do";
		});

		$('#addContent').click(function() {
			$('#content').find('.form-group:last').after($('#contentTmpl').html());
		});

		$('#removeContent').click(function() {
			if ($('#content').find('.form-group').length > 2) {
				$('#content').find('.form-group:last').remove();
				$('#content').find('.form-group:last').remove();
			}
		});

		var content = '${articleVo.content}';

		if (content) {
			$('#content').find('.form-group').each(function() {
				$(this).remove();
			});
			content = escapeJson(content);
			var conJsonArray = JSON.parse(content);
			var html = doT.template(document.getElementById('editContentTmpl').innerHTML)(conJsonArray);
			$('#content').prepend(html);
		}
		
		function escapeJson(sourceStr) {
			sourceStr = sourceStr.replace("\b", "\\b");
			sourceStr = sourceStr.replace("\t", "\\t");
			sourceStr = sourceStr.replace("\n", "\\n");
			sourceStr = sourceStr.replace("\f", "\\f");
			sourceStr = sourceStr.replace("\r", "\\r");
			return sourceStr;
		}

	});
</script>
<script id="contentTmpl" type="text/x-dot-template">
	<div class="form-group">
		<label class="col-sm-2 control-label">小标题：</label>
		<div class="col-sm-9">
			<input type="text" name="littleTitle" class="form-control" />
		</div>
	</div>
	<div class="form-group">
		<label class="col-sm-2 control-label">内容：</label>
		<div class="col-sm-9">
			<textarea rows="12" cols="200" name="content" class="form-control"></textarea>
		</div>
	</div>
</script>
<script id="editContentTmpl" type="text/x-dot-template">
{{~it : main : index}}
	<div class="form-group">
		<label class="col-sm-2 control-label">小标题：</label>
		<div class="col-sm-9">
			<input type="text" name="littleTitle" class="form-control" value="{{=main.title||''}}"/>
		</div>
	</div>
	<div class="form-group">
		<label class="col-sm-2 control-label">内容：</label>
		<div class="col-sm-9">
			<textarea rows="12" cols="200" name="content" class="form-control">{{=main.content||''}}</textarea>
		</div>
	</div>
{{~}}
</script>
</head>
<style type="text/css">
.block {
	margin: 20px;
}
</style>
<body>
	<div class="block">
	<button type="button" class="btn btn-primary" id="backToArticleList">返回文章列表</button>
		<form id="editForm" class="form-horizontal">
			<input type="hidden" value="${articleVo.id}" name="id" />
			<input type="hidden" name="path" value="${articleVo.path }" id="pathId">
			<div class="form-group">
				<label class="col-sm-1 control-label">标题：</label>
				<div class="col-sm-6">
					<input type="text" name="title" class="form-control" value="${articleVo.title}" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label">内容：</label>
				<div id="content" class="col-sm-6" style="border: 1px solid #ccc; border-radius: 5px; padding: 20px 0 20px 0; margin-left: 12px;">
					<div class="form-group">
						<label class="col-sm-2 control-label">小标题：</label>
						<div class="col-sm-9">
							<input type="text" name="littleTitle" class="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">内容：</label>
						<div class="col-sm-9">
							<textarea rows="12" cols="200" name="content" class="form-control"></textarea>
						</div>
					</div>
					<div style="width: 100%; text-align: center;">
						<button type="button" id="addContent" class="btn btn-default" title="增加" style="margin-right: 5px;">增加</button>
						<button type="button" id="removeContent" class="btn btn-danger" title="减少" style="margin-left: 5px;">减少</button>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label">上传图片：</label>
				<div class="col-sm-6">
					<div id="queue"></div>
					<input id="uploadify" name="uploadify" type="file">
					(只能上传一张图片    格式:gif,png,jpg  大小限制：1M)
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-1 col-sm-10">
					<button type="button" class="btn btn-success" id="btnSubmit">保存</button>
				</div>
			</div>
		</form>
	</div>
</body>
</html>