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
<title>手机首页数据管理</title>
<script type="text/javascript">
	$(function() {
		$('.editCompany').click(function() {
			var id = $(this).data('id');
			$.getJSON('${pageContext.request.contextPath}/company/' + id, function(data){
				var html = doT.template($('#editTmpl').text())(data);
				$.Pop(html,{
					Title:'编辑',
					Btn:{
						yes:{
							vla:"确定",
							class:"btn btn-success",
							ope:function(){
								if($('#hidImagePath').val() && $('#hidLogoImagePath').val()){
									$('#editForm').ajaxSubmit({
										url: '${pageContext.request.contextPath}/edit/saveCompany',
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
		});
		
		$('.addCompany').on('click', function() {
			var html = doT.template($('#editTmpl').text());
			$.Pop(html,{
				Title:'编辑',
				Btn:{
					yes:{
						vla:"确定",
						class:"btn btn-success",
						ope:function(){
							if($('#hidImagePath').val() && $('#hidLogoImagePath').val() && $('#hidLittleLogoImagePath').val()){
								$('#editForm').ajaxSubmit({
									url: '${pageContext.request.contextPath}/edit/saveCompany',
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
		
		$('.deleteCompany').on('click', function(){
			var id = $(this).data('id');
			var title = $(this).data('name');
			$.Pop("是否确认删除：" + title + "?",{
				Title:'删除确认',
				Btn:{
					yes:{
						vla:"确定",
						class:"btn btn-success",
						ope:function(){
							$.ajax({
								url : '${pageContext.request.contextPath}/edit/company/' + id,
								type: 'DELETE',
								dataType: 'json',
								success: function(data){
									if (data.Status == 'OK') {
										location.reload();
									} else {
										alert("服务器异常，请稍后再试！");
									}
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
			if($('#imageInput').val()){
				$('#imageForm').ajaxSubmit({
					dataType:'json',
					url:'${pageContext.request.contextPath}/investment/uploadImage',
					type:'post',
					success: function(data){
						if(data.Status == "OK"){
							$('#hidImagePath').val(data.fileId);
							$('#uploadStatus').append('<p>上传成功！</p>')
						} else{
							$('#imageForm').append('<p>' + data.errorMsg + '</p>');
						}
					}
				});
			} else{
				alert('请先选择要上传的图片！');
			}
		});
		
		$(document).on('click', '#uploadLogoImage', function(){
			if($('#logoInput').val()){
				$('#imageLogoForm').ajaxSubmit({
					dataType:'json',
					url:'${pageContext.request.contextPath}/investment/uploadImage',
					type:'post',
					success: function(data){
						if(data.Status == "OK"){
							$('#hidLogoImagePath').val(data.fileId);
							$('#uploadLogoStatus').append('<p>上传成功！</p>')
						} else{
							$('#imageLogoForm').append('<p>' + data.errorMsg + '</p>');
						}
					}
				});
			} else{
				alert('请先选择要上传的图片！');
			}
		});
		
		
		$(document).on('click', '#uploadLittleLogoImage', function(){
			if($('#littleLogoInput').val()){
				$('#imageLittleLogoForm').ajaxSubmit({
					dataType:'json',
					url:'${pageContext.request.contextPath}/investment/uploadImage',
					type:'post',
					success: function(data){
						if(data.Status == "OK"){
							$('#hidLittleLogoImagePath').val(data.fileId);
							$('#uploadLittleLogoStatus').append('<p>上传成功！</p>')
						} else{
							$('#imageLittleLogoForm').append('<p>' + data.errorMsg + '</p>');
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
		<input type="hidden" name="imagePath" id="hidImagePath" value="{{=it.imagePath||''}}"/>
		<input type="hidden" name="logoImagePath" id="hidLogoImagePath" value="{{=it.logoImagePath||''}}"/>
		<input type="hidden" name="littleLogoImagePath" id="hidLittleLogoImagePath" value="{{=it.littleLogoImagePath||''}}"/>
		<input type="hidden" name="id" value="{{=it.id||''}}"/>
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
				<input type="text" name="location" onkeyup="value=value.replace(/[^\d]/g,'')" class="form-control" value="{{=it.location||''}}" placeholder="请输入数字"/>
			</div>
		</div>
	</form>
	<form id="imageForm" class="form-horizontal" enctype="multipart/form-data"">
		<div class="form-group">
			<label class="col-sm-3 control-label">人物图片：</label>
			<div class="col-sm-4">
				<input id="imageInput" type="file" name="file">	
			</div>
			<div class="col-sm-2">
				<button type="button" class="btn btn-success btn-sm" id="uploadImage">上传
			</div>
			<div class="col-sm-2" id="uploadStatus"></div>
		</div>
	</form>
	<form id="imageLogoForm" class="form-horizontal" enctype="multipart/form-data">
		<div class="form-group">
			<label class="col-sm-3 control-label">详情大图：</label>
			<div class="col-sm-4">
				<input id="logoInput" type="file" name="file">	
			</div>
			<div class="col-sm-2">
				<button type="button" class="btn btn-success btn-sm" id="uploadLogoImage">上传
			</div>
			<div class="col-sm-2" id="uploadLogoStatus"></div>
		</div>
	</form>
<div>
</script>
<!-- <form id="imageLittleLogoForm" class="form-horizontal" enctype="multipart/form-data">
		<div class="form-group">
			<label class="col-sm-3 control-label">公司小logo：</label>
			<div class="col-sm-4">
				<input id="littleLogoInput" type="file" name="file">	
			</div>
			<div class="col-sm-2">
				<button type="button" class="btn btn-success btn-sm" id="uploadLittleLogoImage">上传</button>
			</div>
			<div class="col-sm-2" id="uploadLittleLogoStatus"></div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-3 col-sm-9">
				[大小：5M；文件格式：jpg,png]
			</div>
		</div>
	</form> -->
</head>
<style type="text/css">
</style>
<body>
	<div class="main-block">
		<h2>手机首页数据管理</h2>
		<td><button type="button" class="btn btn-success btn-sm addCompany">添加</button></td>
		<table class="table">
			<thead>
				<th nowrap>简介</th>
				<th nowrap>详细内容</th>
				<th nowrap>位置</th>
				<th nowrap>人物图片</th>
				<th nowrap>详情大图</th>
				<th nowrap></th>
				<th nowrap></th>
			</thead>
			<c:forEach items="${companyList }" var="item">
				<tr>
					<td style="width:300px;">${item.introduction }</td>
					<td title="${item.content }" style="width:400px;">${item.content }</td>
					<td>${item.location }</td>
					<td><img src="${item.imagePath}" width="100px" height="100px" /></td>
					<td><img src="${item.logoImagePath }" width="100px" height="100px" /></td>
					<td><button type="button" data-id="${item.id }" class="btn btn-primary btn-sm editCompany">编辑</button></td>
					<td><button type="button" data-id="${item.id }" class="btn btn-danger btn-sm deleteCompany">删除</button></td>
				</tr>
			</c:forEach>
		</table>
		<div id="foot">
			<nav>
				<a href="${pageContext.request.contextPath }/qsManager/edit/console">管理员首页</a> <a href="${pageContext.request.contextPath }/">进入青松</a>
			</nav>
		</div>
	</div>
</body>
</html>