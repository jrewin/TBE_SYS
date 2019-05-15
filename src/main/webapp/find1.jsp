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
		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-body">
					<table class="layui-hide" id="test1" lay-filter="test1"></table>
					<script type="text/html" id="barDemo">
						<a class="layui-btn layui-btn-xs" lay-event="edit">点击处理</a>
					</script>	
				</div>
			</div>
		</div>
	</div>
</div> 
<script src="layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
layui.use(['table','form','laydate','laytpl'], function(){
	var table = layui.table
	, form = layui.form
	, laydate = layui.laydate
	, $ = layui.$;
	
    table.render({
	    elem: '#test1'
		,url:'records/findRecordsBySelection.do'
		,cellMinWidth: 100 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
	    ,cols: [[
	      {field:'id', title: 'id'}
	     ,{field:'sourcePuid', title: 'Source_PUID'}
	     ,{field:'scanPuid', title: 'Scan_Puid'}
	     ,{field:'scan2d', title: 'Scan_2D'}
	     ,{field:'machineName', title: 'Machine_Name'}
	     ,{field:'passFail', title: 'Pass_Fail'}
	     ,{field:'pR', title: 'P_R'}
	     ,{field:'checkDt', title: 'Check_DT', templet: '<div>{{ layui.laytpl.toDateString(d.time) }}</div>'}
	     ,{field:'checkId', title: 'Check_ID'}
	     ,{field:'unlockDt', title: 'Unlock_DT',templet: '<div>{{ layui.laytpl.toDateString(d.time) }}</div>'}
	     //,{field:'oReason', title: 'oReason'}
	     //,{field:'oHandle', title: 'oHandle'}
	     //,{field:'oId', title: 'oId'}
	     //,{field:'oDt', title: 'oDt'}
	     ,{field:'right', title: '操作', width:100, align:'center', toolbar: '#barDemo'}
	    ]]
	});
    
	//监听工具条
    table.on('tool(test1)', function(obj){
      var data = obj.data;
      //layer.alert('编辑行：<br>'+ JSON.stringify(data));
      if(obj.event === 'edit'){
		layer.open({
   	      type: 2
   	      ,title: '处理'
   	      ,maxmin: true //开启最大化最小化按钮
   	      ,area: ['900px', '400px']
   	      ,content: 'solution.jsp'
   	      ,btn: ['确认', '取消']
		  ,success: function(layero, index){
			  let body = layer.getChildFrame('body', index);
			  body.find("#id").val(data.id);
			  body.find("#sourcePuid").val(data.sourcePuid);
			  body.find("#scanPuid").val(data.scanPuid);
			  //body.find("#oReason").val(data.oReason);
			  //body.find("#oHandle").val(data.oHandle);
			  
			  layui.form.render();
		  }
		  ,yes: function(index, layero){
			  let body = layer.getChildFrame("body", index);
			  let data1 = {};
			  body.find("#changefileform").serializeArray().forEach(function (item) { 
            	data1[item.name] = item.value;   //根据表单元素的name属性来获取数据
              });
			  
			  console.log(data1);
			  
			  if(data1.oReason == "" || data1.oHandle == ""){
				  alert("请填写【问题描述】和【处理结果】之后再次提交！");
				  return false;
			  }else{
				  $.ajax({
						url:'records/solutionRecord.do',
						type:"post",
						data:data1,
						dataType:"json",
						success:function(result){
							console.log(result);
			                if (result.status == "success") {
			                    layer.alert("操作成功！", {icon: 6},function(){
			                    	layer.close(index);
				                    parent.location.reload();
			                    });
			                }else{
			                	layer.alert("操作失败！", {icon: 5},function(){
			                    	layer.close(index);
				                    parent.location.reload();
			                    });
			                }
			                /*
			                setTimeout(function () {
			                	layer.close(index);
			                    parent.location.reload();
			                }, 600);
			                */
						}
				  	})
			  }
			  
			 layer.close(index); //关闭弹出层
			 //刷新父页面
		  }
		  ,btnAlign: 'c'
   	    });
      }
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

	//时间戳的处理
	layui.laytpl.toDateString = function(d, format){
		//console.log(d);
	  var date = new Date(d || new Date())
	  ,ymd = [
	    this.digit(date.getFullYear(), 4)
	    ,this.digit(date.getMonth() + 1)
	    ,this.digit(date.getDate())
	  ]
	  ,hms = [
	    this.digit(date.getHours())
	    ,this.digit(date.getMinutes())
	    ,this.digit(date.getSeconds())
	  ];
	
	  format = format || 'yyyy-MM-dd HH:mm:ss';
	
	  return format.replace(/yyyy/g, ymd[0])
	  .replace(/MM/g, ymd[1])
	  .replace(/dd/g, ymd[2])
	  .replace(/HH/g, hms[0])
	  .replace(/mm/g, hms[1])
	  .replace(/ss/g, hms[2]);
	};
	 
	//数字前置补零
	layui.laytpl.digit = function(num, length, end){
	  var str = '';
	  num = String(num);
	  length = length || 2;
	  for(var i = num.length; i < length; i++){
	    str += '0';
	  }
	  return num < Math.pow(10, length) ? str + (num|0) : num;
	};
	
	form.render();
});

</script>
</body>