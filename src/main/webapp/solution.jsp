<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>KESM</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="layui/css/layui.css"  media="all">
</head>
<body>
<%--
<c:if test="${sessionScope.user == null }">
	<script type="text/javascript">
		location.href = "login.jsp";
	</script>
</c:if>
 --%>
<div style="padding: 20px; background-color: #F2F2F2;">
	<div class="layui-row layui-col-space15">
		<div class="layui-col-md12">
			<div class="layui-card">
				 <div class="layui-card-body">
				   <form class="layui-form layui-form-pane" action="" id="changefileform">
						<input id="id" type="hidden" name="id" autocomplete="off" required>
						<div class="layui-form-item">
							<label class="layui-form-label">SourcePuid</label>
							<div class="layui-input-block">
								<!-- 上线后改为只读 -->
								<input id="sourcePuid" type="text" name="sourcePuid" autocomplete="off" class="layui-input" readonly="readonly">
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">ScanPuid</label>
							<div class="layui-input-block">
								<input id="scanPuid" type="text" name="scanPuid" autocomplete="off" class="layui-input" readonly="readonly">
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">问题描述</label>
							<div class="layui-input-block">
								<input type="text" id="oReason" name="oReason" autocomplete="off" class="layui-input" required="required">
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">处理结果</label>
							<div class="layui-input-block">
								<input type="text" id="oHandle" name="oHandle" autocomplete="off" class="layui-input" required="required">
							</div>
						</div>
					</form>
				 </div>
			</div>
		</div>
	</div>
</div> 
</body>