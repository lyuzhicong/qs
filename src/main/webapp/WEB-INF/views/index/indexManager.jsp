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
<title>编辑首页数据</title>
<script type="text/javascript">
	$(function() {
		$('.editData').click(function() {
			var id = $(this).data('id');
			$.getJSON('${pageContext.request.contextPath}/getIndexDataById?id=' + id, function(data){
				var html = doT.template($('#editTmpl').text())(data);
				$.Pop(html,{
					Title:'编辑',
					Btn:{
						yes:{
							vla:"确定",
							class:"btn btn-success",
							ope:function(){
								$('#editForm').ajaxSubmit({
									url: '${pageContext.request.contextPath}/edit/saveIndexData',
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
		
		$('.addData').on('click', function() {
			var html = doT.template($('#editTmpl').text());
			$.Pop(html,{
				Title:'编辑',
				Btn:{
					yes:{
						vla:"确定",
						class:"btn btn-success",
						ope:function(){
							$('#editForm').ajaxSubmit({
								url: '${pageContext.request.contextPath}/edit/saveIndexData',
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
		
		$('.deleteData').on('click', function(){
			var id = $(this).data('id');
			$.Pop("是否确认删除?",{
				Title:'删除确认',
				Btn:{
					yes:{
						vla:"确定",
						class:"btn btn-success",
						ope:function(){
							$.ajax({
								url : '${pageContext.request.contextPath}/edit/index/' + id,
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
	});
</script>
<script id="editTmpl" type="text/x-dot-template">
	<form id="editForm" class="form-horizontal">
		<input type="hidden" name="id" value="{{=it.id||''}}"/>
		<div class="form-group">
			<label class="col-sm-2 control-label">数据：</label>
			<div class="col-sm-10">
				<input type="text" name="number" class="form-control" value="{{=it.number||''}}" />
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">内容：</label>
			<div class="col-sm-10">
				<input type="text" name="content" class="form-control" value="{{=it.content||''}}"/>
			</div>
		</div>
	</form>
</script>
</head>
<style type="text/css">
</style>
<body>
	<div class="main-block">
		<h2>首页数据修改</h2>
		<p>
			<b>帮助：</b>首页只有三组数据，为保证数据正常显示请勿于三条记录，多条记录去取前三条记录
		</p>
		<td><button type="button" class="btn btn-success btn-sm addData">添加</button></td>
		<table class="table">
			<thead>
				<th>数据</th>
				<th>内容</th>
				<th></th>
			</thead>
			<c:forEach items="${indexVoList }" var="item">
				<tr>
					<td style="text-align: left">${item.number }</td>
					<td style="text-align: left">${item.content }</td>
					<td><button type="button" data-id="${item.id }" class="btn btn-primary btn-sm editData">编辑</button></td>
					<td><button type="button" data-id="${item.id }" class="btn btn-danger btn-sm deleteData">删除</button></td>
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