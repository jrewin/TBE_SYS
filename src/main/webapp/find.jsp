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
<c:if test="${sessionScope.user == null }">
	<script type="text/javascript">
		location.href = "login.jsp";
	</script>
</c:if>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>KESM TBE DATA</legend>
</fieldset>   
<div style="padding: 20px; background-color: #F2F2F2;">
	<div class="layui-row layui-col-space15">
		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-body" style="text-align: right;">
					你好！${sessionScope.user.username }
					&nbsp;&nbsp;
					|
					&nbsp;&nbsp;
					<a href="<%=request.getContextPath()%>/switch.jsp">切换到主页</a>
					&nbsp;&nbsp;
					<%-- 
					<a href="<%=request.getContextPath()%>/page2.jsp">切换到回料</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					|
					
					&nbsp;&nbsp;
					<a href="<%=request.getContextPath()%>/find1.jsp">检索</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					|
					--%>
					|
					&nbsp;&nbsp;
					<a href="#" id="logout">注销</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
			</div>
		</div>
		<form class="layui-form layui-form-pane" action="">
		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-body" style="text-align:center;">
					<div class="layui-form-item">
					    <div class="layui-inline">
					    	<label class="layui-form-label">PUID</label>
					    	<div class="layui-input-inline">
					        	<input id="pid_num" type="text" name="puid" autocomplete="off" class="layui-input">
					    	</div>
					    </div>
					    <div class="layui-inline">
					    	<button class="layui-btn layui-btn-fluid" lay-submit lay-filter="find">检索</button>
					    </div>
					    <div class="layui-inline">
					    	<button type="reset" class="layui-btn layui-btn-primary layui-btn-fluid">重置</button>
					    </div>
					</div>
				</div>
			</div>
		</div>
		</form>
		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-body">
					<table class="layui-hide" id="test1"></table>
				</div>
			</div>
		</div>
	</div>
</div> 
<script src="layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
layui.use(['table','form','laydate','laytpl','util'], function(){
	var table = layui.table
	, form = layui.form
	, laydate = layui.laydate
	, $ = layui.$
	, util = layui.util;
	
    var tableIns = table.render({
	    elem: '#test1'
	    ,cols: [[
	      {field:'puid', title: 'PUID'}
	      ,{field:'zdCode', title: '二维码'}
	      ,{field:'machineId', title: '机器名'}
	      ,{field:'oDt', title: 'Operate时间', templet: function(d){
    	 	if(d.oDt != null){
    	 		//console.log(d.checkDt);
    	 		return layui.util.toDateString(d.oDt, 'yyyy-MM-dd HH:mm:ss');
    	 	}else{
    	 		return "";
    	 	}
		  }}
	      ,{field:'operatorId', title: 'Operator ID'}
	      ,{field:'passDt', title: 'Pass时间', templet: function(d){
	    	 	if(d.passDt != null){
	    	 		//console.log(d.checkDt);
	    	 		return layui.util.toDateString(d.passDt, 'yyyy-MM-dd HH:mm:ss');
	    	 	}else{
	    	 		return "";
	    	 	}
		  }}
	      ,{field:'checkId', title: 'Check ID'}
	      ,{field:'rDt', title: 'Return时间', templet: function(d){
	    	 	if(d.rDt != null){
	    	 		//console.log(d.checkDt);
	    	 		return layui.util.toDateString(d.rDt, 'yyyy-MM-dd HH:mm:ss');
	    	 	}else{
	    	 		return "";
	    	 	}
		  }}
	      ,{field:'rId', title: 'Return ID'}
	      ,{field:'local', title: 'Location'}
	    ]]
	});

    form.on('submit(find)', function(data){
	  console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
	  
	  if(data.field.puid == ""){
		  layer.alert("请输入PUID...", {icon: 7});
	  }else{
		  tableIns.reload({
				url:'puid/findPuidCheckByPUID.do'
				,where: { //设定异步数据接口的额外参数，任意设
					puid: data.field.puid
					/*哪个字段？
					oDt: 
					passDt:
					*/
				}
			});
	  }
	  
	  form.render();
	  
	  return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
	});

	$("#logout").click(function(){
		layer.confirm('确定注销并切换用户？', {
			btn: ['确认','取消'] //按钮
		}, function(index){
			//location.href = 'user/userlogout.do';
			$.ajax({
				url:'user/userlogout.do',
				type:"post",
				dataType:"json",
				success:function(resp){
					location.href = resp.desUrl;
				}
			})
		});
		return false;
	})
	
	form.render();
});
</script>
</body>