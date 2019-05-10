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
					<a href="<%=request.getContextPath()%>/page2.jsp">切换到回料</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					|
					<%-- 
					&nbsp;&nbsp;
					<a href="<%=request.getContextPath()%>/find1.jsp">检索</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					|
					--%>
					&nbsp;&nbsp;
					<a href="#" id="logout">注销</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
			</div>
		</div>
		<div class="layui-col-md6">
			<div class="layui-card">
				 <div class="layui-card-body">
				   <form class="layui-form layui-form-pane" action="">
				   		<div class="layui-form-item">
							<label class="layui-form-label">选择机器</label>
							<div class="layui-input-block">
								<select name="machineId" id="machine" lay-filter="selectMachine">
									<option value="请选择"></option>
									<c:forEach var="machine" items="${sessionScope.machines}">
										<option value="${machine.maName }">${machine.maName}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">扫描二维码</label>
							<div class="layui-input-block">
								<!-- 上线后改为只读 -->
								<input id="lot_num" type="text" name="zdCode" autocomplete="off" placeholder="请扫描二维码..." class="layui-input" required>
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">PUID</label>
							<div class="layui-input-block">
								<input id="pid_num" type="text" name="puid" autocomplete="off" readonly="readonly" class="layui-input" required>
							</div>
						</div>
						<div class="layui-form-item">
							<div class="layui-inline">
								<label class="layui-form-label">LOT</label>
								<div class="layui-input-block">
									<input type="text" readonly="readonly" id="lot" name="lot" autocomplete="off" class="layui-input">
								</div>
							</div>
							<div class="layui-inline">
								<label class="layui-form-label">QTY</label>
								<div class="layui-input-inline">
									<input type="text" readonly="readonly" id="qty" name="qty" autocomplete="off" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-form-item">
							<div class="layui-inline">
								<label class="layui-form-label">TYPE</label>
								<div class="layui-input-block">
									<input type="text" readonly="readonly" id="type" name="type" autocomplete="off" class="layui-input">
								</div>
							</div>
							<div class="layui-inline">
								<label class="layui-form-label">CODENO</label>
								<div class="layui-input-inline">
									<input type="text" readonly="readonly" id="condeno" name="condeno" autocomplete="off" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-form-item">
							<button class="layui-btn layui-btn-fluid" lay-submit lay-filter="save">确认</button>
						</div>
						<div class="layui-form-item">
							<button type="reset" class="layui-btn layui-btn-primary layui-btn-fluid">重置</button>
						</div>
					</form>
				 </div>
			</div>
		</div>
		<div class="layui-col-md6">
			<div class="layui-card">
				<div class="layui-card-body">
				<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
					<legend id="MachineName"></legend>
				</fieldset>   
					<table class="layui-hide" id="test"></table>
				</div>
			</div>
		</div>
	</div>
</div> 
<script src="layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
layui.use(['table','form'], function(){
	var table = layui.table
	, form = layui.form
	, $ = layui.$;
	
	form.on('submit(save)', function(data){
	  console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
	  
	  if(data.field.machineId == "请选择"){
		  layer.alert("请选择机器...", {icon: 7});
	  }else if(data.field.puid == ""){
		  layer.alert("请扫描二维码...", {icon: 7});
	  }else{
		  $.ajax({
			url:"puid/puidSave.do",
			data:data.field,
			type:"post",
			dataType:"json",
			success:function(resp){
				if(resp.status == "exist"){
					layer.alert("已经存在！", {icon: 7});
				}else if(resp.status == "good"){
					layer.alert("添加成功！", {icon: 6});
					$("#lot_num").val('');
					$("#pid_num").val('');
					$("#lot").val('');
					$("#qty").val('');
					$("#condeno").val('');
					$("#type").val('');
				 	$("#machine").find("option[value='请选择']").attr("selected",true);
				 	tableIns.reload({
						url:'puid/findByMachineId.do'
						,where: { //设定异步数据接口的额外参数，任意设
							machineId: resp.MachineId
						}
					});
				 	$("#MachineName").html(resp.MachineName);
				 	form.render();
				}else if(resp.status == "badbox"){
					layer.alert("添加失败，不能同时添加两批料！", {icon: 7});
				}else{
					layer.alert("添加失败！", {icon: 5});
				}
			}
		})
	  }
	  
	  return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
	});
	
	$("#lot_num").keypress(function (e) {
		if (e.keyCode == 13) {
			var lnn = $("#lot_num").val();
			if(lnn==""){
				layer.alert("不能为空！", {icon: 7});
			}else{
				var sdata = {"zdcode" : lnn};
				$.ajax({
					url:"puid/puidCheck.do",
					data:sdata,
					type:"post",
					dataType:"json",
					success:function(resp){
						if(resp.status=="ZcodErro"){
							layer.alert("二维码不正确，请再次扫描！", {icon: 5});
							$("#lot_num").val('');
						}else{
							$("#pid_num").val(resp.puidCode);
							$("#lot").val(resp.lot);
							$("#qty").val(resp.qty);
							$("#condeno").val(resp.condeno);
							$("#type").val(resp.type);
						}
					}
				})
			}
            return false;
        }
	});
	
	var tableIns = table.render({
	    elem: '#test'
	    ,cellMinWidth: 100 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
	    ,cols: [[
	      {field:'puid', title: 'PUID列表'}
	    ]]
	});
	
	form.on('select(selectMachine)', function(data){ 
		tableIns.reload({
			url:'puid/findByMachineId.do'
			,where: { //设定异步数据接口的额外参数，任意设
				machineId: data.value
			}
		});
		var sdata = {"machineId" : data.value};
		$.ajax({
			url:"puid/findMachine.do",
			data:sdata,
			type:"post",
			dataType:"json",
			success:function(resp){
				$("#MachineName").html(resp.MachineName);
			}
		})
		$("#lot_num").focus();
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