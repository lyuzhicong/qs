<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/wangEditor/js/wangEditor.min.js"></script>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/web/public.css">
<title>编辑文章</title>
<script type="text/javascript">
	$(function() {
		var E = window.wangEditor;
		var editor = new E('#article');
		editor.customConfig.uploadImgShowBase64 = true;
		editor.customConfig.menus = [ 'head', // 标题
		'bold', // 粗体
		'italic', // 斜体
		'underline', // 下划线
		'link', // 插入链接
		'list', // 列表
		'justify', // 对齐方式
		'image', // 插入图片
		'quote', // 引用
		'undo', // 撤销
		'redo' // 重复
		// 		    'foreColor',  // 文字颜色
		// 		    'emoticon',  // 表情
		// 		    'backColor',  // 背景颜色
		// 		    'strikeThrough',  // 删除线
		// 		    'table',  // 表格
		// 		    'video',  // 插入视频
		// 		    'code',  // 插入代码
		]
		editor.create();

		$('#btnSubmit').click(function() {
			var json = {};
			json.id = $('#hidId').val();
			json.title = $('#articleTitle').val();
			json.content = editor.txt.html();
			json.path = $('#hidImagePath').val();
			if (json.title && json.content && json.path) {
				$.post('${pageContext.request.contextPath}/article/edit/saveShareArticle.do', json, function(data) {
					if (data.Status == 'OK') {
						location.href = '${pageContext.request.contextPath}/article/edit/articleManager.do';
					} else {
						alert("保存失败，请联系后台开发人员！");
					}
				})
			} else {
				alert("缺少数据！");
			}

		});

		$('#backToArticleList').click(function() {
			location.href = "${pageContext.request.contextPath}/article/edit/articleManager.do";
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
							$('#uploadStatus').empty().append('<p>上传成功！</p>')
						} else {
							$('#uploadStatus').empty().append('<p>' + data.errorMsg + '</p>');
						}
					}
				});
			} else {
				alert('请先选择要上传的图片！');
			}
		});
	});
</script>
</head>
<body>
	<div class="main-block">
		<h2>文章管理</h2>
		<button type="button" class="btn btn-primary btn-sm" id="backToArticleList">返回文章列表</button>
		<br /> <br />
		<form id="articleForm" class="form-horizontal">
			<c:if test="${empty article}">
			<input id="hidId" type="hidden">
				<div class="form-group">
					<label class="col-sm-2 control-label">标题：</label>
					<div class="col-sm-4">
						<input type="text" id="articleTitle" name="title" class="form-control"/>
					</div>
				</div>
				<div class="form-group">
					<div id="article"></div>
				</div>
				<input type="hidden" id="hidImagePath" name="path" />
			</c:if>
			<c:if test="${not empty article}">
				<input id="hidId" value="${article.id }" type="hidden">
				<div class="form-group">
					<label class="col-sm-2 control-label">标题：</label>
					<div class="col-sm-4">
						<input type="text" id="articleTitle" name="title" class="form-control" value="${article.title}" />
					</div>
				</div>
				<div class="form-group">
					<div id="article">${article.content }</div>
				</div>
				<input type="hidden" id="hidImagePath" name="path" value="${article.path }" />
			</c:if>
		</form>
		<form id="imageForm" class="form-horizontal" enctype="multipart/form-data"">
			<div class="form-group">
				<label class="col-sm-2 control-label">列表缩略图：</label>
				<div class="col-sm-2">
					<input id="imageInput" type="file" name="file">
				</div>
				<div class="col-sm-2">
					<button type="button" class="btn btn-success btn-sm" id="uploadImage">上传
				</div>
				<div class="col-sm-2" id="uploadStatus"></div>
			</div>
		</form>
		<br />
		<button type="button" class="btn btn-success" id="btnSubmit">保存</button>
	</div>
</body>
</html>