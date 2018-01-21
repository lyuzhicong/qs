<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/dot/doT.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap/bootstrap.min.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/uploadify/jquery.uploadify.min.js"></script> --%>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap/bootstrap.min.css">
<%-- <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/uploadify/uploadify.css"> --%>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/web/public.css">
<title>编辑文章</title>
<script type="text/javascript">
	$(function() {
		// 		$("#uploadify").uploadify({
		// 			'swf' : '${pageContext.request.contextPath}/resources/swf/uploadify.swf',
		// 			'uploader' : '${pageContext.request.contextPath}/article/uploadImages.do',
		// 			'queueID' : 'queue',
		// 			'auto' : true,//是否自动上传
		// 			'multi' : false,
		// 			'fileTypeExts' : '*.gif;*.jpg; *.png',
		// 			'buttonText' : '选择',
		// 			'width' : '65',
		// 			'height' : '32',
		// 			'uploadLimit' : 5,
		// 			'queueSizeLimit' : 1,
		// 			'removeCompleted' : false,
		// 			'formData' : {
		// 				'session' : 'adminsession'
		// 			},
		// 			'onUploadSuccess' : function(file, data, response) {
		// 				$('#pathId').remove();
		// 				var html = "<input type=\"hidden\" id=\"pathId\" name=\"path\" value=\"" + JSON.parse(data).path + "\">";
		// 				$('#editForm').append(html);

		// 				if ($('#queue').find('.uploadify-queue-item').length > 1) {
		// 					$('.uploadify-queue-item').first().remove();
		// 				}
		// 			},
		// 		});

		$('#btnSubmit').click(function() {
			if ($('#hidImagePath').val()) {
				console.info($('#hidImagePath').val());
				$('#editForm').ajaxSubmit({
					url : '${pageContext.request.contextPath}/article/edit/saveArticle.do',
					dataType : 'json',
					type : 'POST',
					success : function(data) {
						if (data.Status == 'OK') {
							location.href = '${pageContext.request.contextPath}/article/edit/articleManager.do';
						} else {
							alert("保存失败");
						}
					}
				});

			} else {
				alert("请选择一张图片！");
			}
		});

		$(document).on('click', '#uploadImage', function() {
			if ($('input[name="file"]').val()) {
				$('#imageForm').ajaxSubmit({
					dataType : 'json',
					url : '${pageContext.request.contextPath}/investment/uploadImage',
					type : 'post',
					success : function(data) {
						if (data.Status == "OK") {
							$('#hidImagePath').val(data.fileId);
							$('#imageForm').append('<p>上传成功！</p>')
						} else {
							$('#imageForm').append('<p>' + data.errorMsg + '</p>');
						}
					}
				});
			} else {
				alert('请先选择要上传的图片！');
			}
		});

		$('#backToArticleList').click(function() {
			location.href = "${pageContext.request.contextPath}/article/edit/articleManager.do";
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
			// 			content = escapeJson(content);
			// 			console.info(content);
			var conJsonArray = JSON.parse(content);
			var html = doT.template($('#editContentTmpl').text())(conJsonArray);
			$('#content').prepend(html);
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
	<div class="main-block">
		<h2>文章管理</h2>
		<button type="button" class="btn btn-primary btn-sm" id="backToArticleList">返回文章列表</button>
		<form id="editForm" class="form-horizontal">
			<%-- 			<input type="hidden" value="${articleVo.id}" name="id" /> <input type="hidden" name="path" value="${articleVo.path }" id="pathId"> --%>
			<input type="hidden" name="path" id="hidImagePath" value="${articleVo.path }" />
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
		</form>
		<!-- 			<div class="form-group"> -->
		<!-- 				<label class="col-sm-1 control-label">上传图片：</label> -->
		<!-- 				<div class="col-sm-6"> -->
		<!-- 					<div id="queue"></div> -->
		<!-- 					<input id="uploadify" name="uploadify" type="file"> (只能上传一张图片 格式:gif,png,jpg 大小限制：1M) -->
		<!-- 				</div> -->
		<!-- 			</div> -->
		<form id="imageForm" class="form-horizontal" enctype="multipart/form-data"">
			<div class="form-group">
				<label class="col-sm-3 control-label">上传文件：</label>
				<div class="col-sm-6">
					<input type="file" name="file">
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-3 col-sm-9">
					<button type="button" class="btn btn-success btn-sm" id="uploadImage">上传</button>
					&nbsp;&nbsp;[大小：5M；文件格式：jpg,png]
				</div>
			</div>
		</form>
		<div class="form-group">
			<div class="col-sm-offset-1 col-sm-10">
				<button type="button" class="btn btn-success" id="btnSubmit">保存</button>
			</div>
		</div>

	</div>
</body>
</html>