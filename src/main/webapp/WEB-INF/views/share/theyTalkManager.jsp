<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/dot/doT.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery-plugin-pop.js"></script>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/web/public.css">
<title>创业者说管理</title>
<script type="text/javascript">
	$(function() {
		$('.editTheyTalk').on('click', function() {
			title = '编辑';
			$.getJSON('${pageContext.request.contextPath}/share/getTheyTalkById?id=' + $(this).data('id'), function(data){
				var html = doT.template($('#editTmpl').text())(data);
				$.Pop(html,{
					Title:title,
					Btn:{
						yes:{
							vla:"确定",
							class:"btn btn-success",
							ope:function(){
								if($('#hidImagePath').val()){
									$('#editForm').ajaxSubmit({
										url: '${pageContext.request.contextPath}/share/edit/saveTheyTalk',
										dataType: 'json',
										type: 'post',
										success : function(data){
											if(data.Status == 'OK'){
												location.reload();
											} else{
												alert("服务器异常，请稍后再试！");
											}
										}
									})
								} else{
									alert('请先上传图片！');
								}
							}
						},
						cancel:{
							vla: "取消",
							class:"btn btn-notice",
							ope: function(){
								location.reload();
							}
						}
					}
				});
			});
		});
		
		$('#addTheyTalk').on('click', function(){
			var title = '添加';
			var html = doT.template($('#editTmpl').text());
			$.Pop(html,{
				Title:title,
				Btn:{
					yes:{
						vla:"确定",
						class:"btn btn-success",
						ope:function(){
							if($('#hidImagePath').val()){
								$('#editForm').ajaxSubmit({
									url: '${pageContext.request.contextPath}/share/edit/saveTheyTalk',
									dataType: 'json',
									type: 'post',
									success : function(data){
										if(data.Status == 'OK'){
											location.reload();
										} else{
											alert("服务器异常，请稍后再试！");
										}
									}
								})
							} else{
								alert('请先上传图片！');
							}
						}
					},
					cancel:{
						vla: "取消",
						class:"btn btn-notice",
						ope: function(){
							location.reload();
						}
					}
				}
			});
		})
		
		$('.deleteTheyTalk').on('click', function(){
			var id = $(this).data('id');
			var title = $(this).data('name');
			$.Pop("是否确认删除：" + title + "?",{
				Title:'删除确认',
				Btn:{
					yes:{
						vla:"确定",
						class:"btn btn-success",
						ope:function(){
							$.post('${pageContext.request.contextPath}/share/edit/deleteTheyTalkById?id=' + id, function(data){
								if(data.Status == 'OK'){
									location.reload();
								} else{
									alert("服务器异常，请稍后再试！");
								}
							})
						}
					},
					cancel:{
						vla: "取消",
						class:"btn btn-notice",
						ope: function(){
							location.reload();
						}
					}
				}
			});
		});
		
		$(document).on('click', '#uploadImage', function(){
			if($('input[name="file"]').val()){
				$('#imageForm').ajaxSubmit({
					dataType:'json',
					url:'${pageContext.request.contextPath}/investment/uploadImage',
					type:'post',
					success: function(data){
						if(data.Status == "OK"){
							$('#hidImagePath').val(data.fileId);
							$('#imageForm').append('<p>上传成功！</p>')
						} else{
							$('#imageForm').append('<p>' + data.errorMsg + '</p>');
						}
					}
				});
			} else{
				alert('请先选择要上传的图片！');
			}
		});
		
		$('#changeStatus').on('click', function(){
			var status = 1;
			console.info($(this).text().trim());
			if($(this).text().trim() == "显示"){
				status = 0;
			}
			$.post('${pageContext.request.contextPath}/share/edit/updateIsShow?configVal=' + status, function(data){
				if(data.Status == "OK"){
					location.reload();
				} else{
					alert("切换状态失败，请联系管理员");
				}
			})
		})
	});
	
</script>
<script id="editTmpl" type="text/x-dot-template">
<div>
	<form id="editForm" class="form-horizontal">
		<input type="hidden" name="id" value="{{=it.id||''}}"/>
		<div class="form-group">
			<label class="col-sm-3 control-label">标题：</label>
			<div class="col-md-6">
				<input type="text" name="title" class="form-control" value="{{=it.title||''}}" />
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">内容：</label>
			<div class="col-sm-6">
				<textarea class="form-control" rows="5" cols="80" name="content">{{=it.content||''}}</textarea>
			</div>
		</div>
		<input type="hidden" name="imagePath" id="hidImagePath" value="{{=it.imagePath||''}}"/>
	</form>
	<form id="imageForm" class="form-horizontal" enctype="multipart/form-data"">
		<div class="form-group">
			<label class="col-sm-3 control-label">上传文件：</label>
			<div class="col-sm-6">
				<input type="file" name="file">	
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-3 col-sm-9">
				<button type="button" class="btn btn-success btn-sm" id="uploadImage">上传</button>&nbsp;&nbsp;[大小：5M；文件格式：jpg,png]
			</div>
		</div>
	</form>
<div>
</script>
</head>
<style type="text/css">
td {
	text-align: left;
}
</style>
<body>
	<div class="main-block">
		<h2>创业说管理</h2>
		<button type="button" class="btn btn-success btn-sm" id="addTheyTalk">添加</button>

		<table class="table">
			<thead>
				<th nowrap>标题</th>
				<th nowrap>详细内容</th>
				<th nowrap>图片</th>
				<th></th>
				<th></th>
			</thead>
			<c:forEach items="${theyTalkVoList }" var="item">
				<tr>
					<td>${item.title }</td>
					<td style="width: 600px;">${item.content }</td>
					<td><img src="${item.imagePath}" width="100px" height="100px" /></td>
					<td><button type="button" data-id="${item.id }" class="btn btn-primary btn-sm editTheyTalk">编辑</button></td>
					<td><button type="button" data-name="${item.title }" data-id="${item.id }" class="btn btn-danger btn-sm deleteTheyTalk">删除</button></td>
				</tr>
			</c:forEach>
		</table>
		<div>
			<span>是否在"文章分享"中显示：</span>
			<button type="button" class="btn <c:if test="${isShow==0 }">btn-danger</c:if><c:if test="${isShow==1 }">btn-success</c:if> btn-sm" id="changeStatus">
				<c:if test="${isShow==0 }">隐藏</c:if>
				<c:if test="${isShow==1 }">显示</c:if>
			</button>
			<span>(提示:点击按钮切换状态)</span>
		</div>
		<div id="foot">
			<nav>
				<a href="${pageContext.request.contextPath }/qsManager/edit/console">管理员首页</a> <a href="${pageContext.request.contextPath }/">进入青松</a>
			</nav>
		</div>
	</div>
</body>
</html>