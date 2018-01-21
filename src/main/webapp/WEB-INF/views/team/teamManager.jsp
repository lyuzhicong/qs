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
<title>投资团队管理</title>
<script type="text/javascript">
	$(function() {
		$('.editTeam').on('click', function() {
			title = '编辑';
			$.getJSON('${pageContext.request.contextPath}/team/getTeamById?id=' + $(this).data('id'), function(data){
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
										url: '${pageContext.request.contextPath}/team/edit/saveTeam',
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
		
		$('#addTeam').on('click', function(){
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
									url: '${pageContext.request.contextPath}/team/edit/saveTeam',
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
		
		$('.deleteTeam').on('click', function(){
			var id = $(this).data('id');
			var title = $(this).data('name');
			$.Pop("是否确认删除：" + title + "?",{
				Title:'删除确认',
				Btn:{
					yes:{
						vla:"确定",
						class:"btn btn-success",
						ope:function(){
							$.post('${pageContext.request.contextPath}/team/edit/deleteTeamById?id=' + id, function(data){
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
	});
</script>
<script id="editTmpl" type="text/x-dot-template">
<div>
	<form id="editForm" class="form-horizontal">
		<input type="hidden" name="id" value="{{=it.id||''}}"/>
		<div class="form-group">
			<label class="col-sm-3 control-label">姓名：</label>
			<div class="col-md-6">
				<input type="text" name="name" class="form-control" value="{{=it.name||''}}" />
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">简介：</label>
			<div class="col-sm-6">
				<input type="text" name="introduction" class="form-control" value="{{=it.introduction||''}}"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">身份：</label>
			<div class="col-sm-6">
				<input type="text" name="identity" class="form-control" value="{{=it.identity||''}}"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">邮箱：</label>
			<div class="col-sm-6">
				<input type="text" name="email" class="form-control" value="{{=it.email||''}}"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">个人简介：</label>
			<div class="col-sm-6">
				<textarea class="form-control" rows="5" cols="80" name="content">{{=it.content||''}}</textarea>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">投资项目：</label>
			<div class="col-sm-6">
				<input type="text" name="projects" class="form-control" value="{{=it.projects||''}}"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">关注领域：</label>
			<div class="col-sm-6">
				<input type="text" name="focusAreas" class="form-control" value="{{=it.focusAreas||''}}"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">位置：</label>
			<div class="col-sm-6">
				<input type="text" name="location" class="form-control" value="{{=it.location||''}}"/>
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
		<h2>投资团队管理</h2>
		<button type="button" class="btn btn-success btn-sm" id="addTeam">添加</button>
		<table class="table">
			<thead>
				<th nowrap>姓名
				<th nowrap>简介</th>
				<th nowrap>身份</th>
				<th nowrap>邮箱</th>
				<th nowrap>个人经历</th>
				<th nowrap>关注领域</th>
				<th nowrap>图片</th>
				<th nowrap>投资项目</th>
				<th nowrap>位置</th>
				<th></th>
				<th></th>
			</thead>
			<c:forEach items="${teamList }" var="item">
				<tr>
					<td>${item.name }</td>
					<td>${item.introduction }</td>
					<td>${item.identity }</td>
					<td>${item.email }</td>
					<td style="width:400px;">${item.content }</td>
					<td>${item.focusAreas }</td>
					<td><img src="${item.imagePath}" width="100px" height="100px" /></td>
					<td>${item.projects }</td>
					<td>${item.location }</td>
					<td><button type="button" data-id="${item.id }" class="btn btn-primary btn-sm editTeam">编辑</button></td>
					<td><button type="button" data-name="${item.name }" data-id="${item.id }" class="btn btn-danger btn-sm deleteTeam">删除</button></td>
				</tr>
			</c:forEach>
		</table>
		<div id="foot">
			<nav>
				<a href="${pageContext.request.contextPath }/manager">管理员首页</a> <a href="/">进入青松</a>
			</nav>
		</div>
	</div>
</body>
</html>