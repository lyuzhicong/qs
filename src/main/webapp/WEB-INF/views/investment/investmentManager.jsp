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
<title>投资组合管理</title>
<script type="text/javascript">
	$(function() {
		$('.editInvestment').on('click', function() {
			title = '编辑';
			$.getJSON('${pageContext.request.contextPath}/investment/getInvestmentById?id=' + $(this).data('id'), function(data){
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
										url: '${pageContext.request.contextPath}/investment/edit/saveInvestment',
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
		
		$('#addInvestment').on('click', function(){
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
									url: '${pageContext.request.contextPath}/investment/edit/saveInvestment',
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
		
		$('.deleteInvestment').on('click', function(){
			var id = $(this).data('id');
			var title = $(this).data('name');
			$.Pop("是否确认删除：" + title + "?",{
				Title:'删除确认',
				Btn:{
					yes:{
						vla:"确定",
						class:"btn btn-success",
						ope:function(){
							$.post('${pageContext.request.contextPath}/investment/edit/deleteInvestmentById?id=' + id, function(data){
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
			<label class="col-sm-3 control-label">标题：</label>
			<div class="col-md-6">
				<input type="text" name="title" class="form-control" value="{{=it.title||''}}" />
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">简介：</label>
			<div class="col-sm-6">
				<input type="text" name="introduction" class="form-control" value="{{=it.introduction||''}}"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">内容：</label>
			<div class="col-sm-6">
				<textarea class="form-control" rows="5" cols="80" name="content">{{=it.content||''}}</textarea>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">位置：</label>
			<div class="col-sm-6">
				<input type="text" name="location" class="form-control" value="{{=it.location||''}}"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">时间：</label>
			<div class="col-sm-6">
				<input type="text" name="time" class="form-control" value="{{=it.time||''}}"/>
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
		<h2>投资组合管理</h2>
		<button type="button" class="btn btn-success btn-sm" id="addInvestment">添加</button>
		<table class="table">
			<thead>
				<th nowrap>标题</th>
				<th nowrap>简介</th>
				<th nowrap>详细内容</th>
				<th nowrap>图片</th>
				<th nowrap>时间</th>
				<th nowrap>位置</th>
				<th nowrap></th>
				<th nowrap></th>
			</thead>
			<c:forEach items="${investmentList }" var="item">
				<tr>
					<td>${item.title }</td>
					<td style="width:300px;">${item.introduction }</td>
					<td title="${item.content }" style="width:400px;">${item.content }</td>
					<td><img src="${item.imagePath}" width="100px" height="100px" /></td>
					<td>${item.time }</td>
					<td>${item.location }</td>
					<td><button type="button" data-id="${item.id }" class="btn btn-primary btn-sm editInvestment">编辑</button></td>
					<td><button type="button" data-name="${item.title }" data-id="${item.id }" class="btn btn-danger btn-sm deleteInvestment">删除</button></td>
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