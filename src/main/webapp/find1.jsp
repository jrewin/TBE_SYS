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
			<form class="layui-form layui-form-pane" action="">
			<div class="layui-card">
				<div class="layui-card-body" style="text-align:center;">
					<div class="layui-form-item">
					    <div class="layui-inline">
					    	<label class="layui-form-label">PUID</label>
					    	<div class="layui-input-inline">
					        	<input id="sourcePuid" type="text" name="sourcePuid" autocomplete="off" class="layui-input">
					    	</div>
					    </div>
					    <div class="layui-inline">
					    	<label class="layui-form-label">Check Time</label>
					    	<div class="layui-input-inline">
					        	<input id="checkDt" type="text" name="checkDt" autocomplete="off" class="layui-input">
					    	</div>
					    </div>
					    <div class="layui-inline">
					    	<label class="layui-form-label">Pass Or Fail</label>
					    	<div class="layui-input-inline">
						    	<select name="passFail" id="passFail">
									<option value="请选择"></option>
									<option value="Pass">Pass</option>
									<option value="Fail">Fail</option>
								</select>
							</div>
					    </div>
					    <div class="layui-inline">
					    	<button class="layui-btn layui-btn-fluid" lay-submit lay-filter="find">检索</button>
					    </div>
					    <div class="layui-inline">
					    	<button type="reset" class="layui-btn layui-btn-primary layui-btn-fluid">重置</button>
					    </div>
					    <div class="layui-inline">
					    	<button class="layui-btn layui-btn-normal" lay-submit lay-filter="findErro">异常处理记录</button>
					    </div>
					</div>
				</div>
			</div>
			</form>
			<div class="layui-card">
				<div class="layui-card-body">
					<table class="layui-hide" id="test1" lay-filter="test1"></table>
					
					<%-- 
					<script type="text/html" id="barDemo">
						<a class="layui-btn layui-btn-xs" lay-event="edit">点击处理</a>
					</script>	
					--%>
					
					<script type="text/html" id="barDemo">
						{{#  if(d.passFail == 'Fail'){ }}
							<a class="layui-btn layui-btn-xs" lay-event="edit">点击处理</a>
						{{#  } }}
					</script>
				</div>
			</div>
		</div>
	</div>
</div> 
<script src="layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
layui.use(['table','form','laydate','laytpl' , 'util'], function(){
	var table = layui.table
	, form = layui.form
	, laydate = layui.laydate
	, $ = layui.$
	, util = layui.util;
	
	//日期
	laydate.render({
		elem: '#checkDt'
	});
	
	function formdate(date){
	 	var unixTimestamp = new Date(sjc * 1000);
        var commonTime = unixTimestamp.toLocaleString()
        var s = commonTime.toLocaleString();
        var ss = s.replace(/年|月/g, "-").replace(/日/g, " ");
        return ss;
	}
	
	var tableIns = table.render({
	    elem: '#test1'
		,cellMinWidth: 140 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
	    ,cols: [[
	      {field:'id', title: '序号'}
	     ,{field:'sourcePuid', title: 'Source PUID'}
	     ,{field:'scanPuid', title: 'Scan Puid'}
	     ,{field:'scan2d', title: '二维码'}
	     ,{field:'machineName', title: '机器名'}
	     ,{field:'passFail', title: 'Pass或Fail'}
	     ,{field:'pR', title: 'P或R'}
	     ,{field:'checkDt', title: 'Check时间' ,templet:function(d){
    	 	if(d.checkDt != null){
    	 		//console.log(d.checkDt);
    	 		return layui.util.toDateString(d.checkDt, 'yyyy-MM-dd HH:mm:ss');
    	 	}else{
    	 		return "";
    	 	}
	     }}
	     ,{field:'checkId', title: 'Check人员ID'}
	     ,{field:'unlockDt', title: 'Unlock时间' ,templet:function(d){
    	 	if(d.unlockDt != null){
    	 		//console.log(d.unlockDt);
    	 		return layui.util.toDateString(d.unlockDt, 'yyyy-MM-dd HH:mm:ss');
    	 	}else{
    	 		return "";
    	 	}
		 }}
	     ,{field:'oReason', title: '问题描述'}
	     ,{field:'oHandle', title: '处理结果'}
	     ,{field:'oId', title: '处理人员ID'}
	     ,{field:'oDt', title: '处理时间',templet:function(d){
    	 	if(d.oDt != null){
    	 		//console.log(d.unlockDt);
    	 		return layui.util.toDateString(d.oDt, 'yyyy-MM-dd HH:mm:ss');
    	 	}else{
    	 		return "";
    	 	}
		  }}
	     ,{field:'right', title: '操作', width:100, align:'center', toolbar: '#barDemo'}
	    ]]
	});
	
	form.on('submit(find)', function(data){
		
	  //console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
	  
	  var sourcePuidstr = "";
	  var passFailstr = "";
	  var checkDtstr = "";
	  
	  if(data.field.sourcePuid == ""){
		  sourcePuidstr = "all";
	  }else{
		  sourcePuidstr = data.field.sourcePuid;
	  }
	  
	  if(data.field.passFail == "请选择"){
		  passFailstr = "all";
	  }else{
		  passFailstr = data.field.passFail;
	  }
	  
	  if(data.field.checkDt == ""){
		  checkDtstr = null;
	  }else{
		  checkDtstr = data.field.checkDt;
	  }
	  
	  tableIns.reload({
			method:'POST',
			contentType: 'application/json',
			url:'records/findRecordsBySelection.do',
			where: { //设定异步数据接口的额外参数，任意设
				sourcePuid: sourcePuidstr
				,passFail: passFailstr
				,checkDt: checkDtstr
				
				/*哪个字段？
				oDt: 
				passDt:
				*/
			}
	   });
	  
	  form.render();
	  
	  return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
	});
	
	form.on('submit(findErro)', function(data){
	  console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
	  
	  tableIns.reload({
		  	url:'records/findErroRecordsBySelection.do'
			,where: { //设定异步数据接口的额外参数，任意设
				puid: data.field.puid
				/*哪个字段？
				oDt: 
				passDt:
				*/
			}
	   });
	  
	  form.render();
	  
	  return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
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

});

</script>

</body>