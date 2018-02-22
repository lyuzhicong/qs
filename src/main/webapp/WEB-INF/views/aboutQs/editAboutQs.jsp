<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/dot/doT.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/wangEditor/js/wangEditor.min.js"></script>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap/bootstrap.min.css">
<title>编辑文章</title>
<script type="text/javascript">
	$(function() {
		var E = window.wangEditor;
		var editor = new E('#content');
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
			$('#hidContent').val(editor.txt.html());
			$('#editForm').ajaxSubmit({
				url : '${pageContext.request.contextPath}/about/edit/updateAboutQs',
				dataType : 'json',
				type : 'POST',
				success : function(data) {
					if (data.Status == 'OK') {
						alert("保存成功");
						location.reload();
					} else {
						alert("保存失敗");
					}
				}
			});
		});

		$('#toQingsong').on('click', function() {
			location.href = "/";
		})
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
		<form id="editForm" class="form-horizontal">
			<input type="hidden" value="${aboutQsVo.id}" name="id" />
			<div class="form-group">
				<label class="col-sm-1 control-label">标题：</label>
				<div class="col-sm-6">
					<input type="text" name="title" class="form-control" value="${aboutQsVo.title}" />
				</div>
			</div>
			<!-- 			<div class="form-group"> 
				<label class="col-sm-1 control-label">内容：</label> 
				<div class="col-sm-6"> 
					<textarea class="form-control" rows="20" cols="100" name="content">${aboutQsVo.content}</textarea>
 				</div> 
			</div> -->
			<div class="form-group">
				<div id="content">${aboutQsVo.content }</div>
				<input type ="hidden" name = "content" id="hidContent"/>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label">邮箱：</label>
				<div class="col-sm-6">
					<input type="text" name="email" class="form-control" value="${aboutQsVo.email}" />
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-1 col-sm-10">
					<button type="button" class="btn btn-success btn-sm" id="btnSubmit">保存</button>
					<button type="button" class="btn btn-primary btn-sm" id="toQingsong">进入青松</button>
				</div>
			</div>
		</form>
	</div>
</body>
</html>