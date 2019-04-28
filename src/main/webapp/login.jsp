<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>登录</title>
    <link rel="stylesheet" href="layui/css/layui.css"  media="all">
    <link rel="stylesheet" href="style/admin.css">
    <link rel="stylesheet" href="style/login.css">
    <link id="layuicss-layer" rel="stylesheet" href="style/layer.css" media="all">

</head>
<body layadmin-themealias="default">
<div class="layadmin-user-login layadmin-user-display-show" id="LAY-user-login" style="display: none;">
	<form class="layui-form layui-form-pane" action="">
    <div class="layadmin-user-login-main">
        <div class="layadmin-user-login-box layadmin-user-login-header">
            <h2>KESM TBE SYSTEM</h2>
            <p>KESM Industries (Tianjin) Co.,Ltd</p>
        </div>
        <div class="layadmin-user-login-box layadmin-user-login-body layui-form">
            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-username" for="LAY-user-login-username"></label>
                <input value="19261" type="text" name="coreid" id="LAY-user-login-username" lay-verify="nikename" placeholder="EMPLOYEE ID" class="layui-input">
            </div>
            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-password" for="LAY-user-login-password"></label>
                <input value="123456" type="password" name="pw" id="LAY-user-login-password" lay-verify="pass" placeholder="PASSWORD" class="layui-input">
            </div>
            <div class="layui-form-item">
            	<select name="LV" lay-filter="selectMachine">
					<option value="1">模块1（加）</option>
					<option value="2">模块2（回）</option>
				</select>
			</div>
            <div class="layui-form-item">
                <a href="javascript:void(0);">
                    <button class="layui-btn layui-btn-fluid" lay-submit="" lay-filter="loginFrom">LOGIN</button>
                </a>
            </div>
        </div>
    </div>
    </form>
    <div class="layui-trans layadmin-user-login-footer">
        <p>Copyright © 2019 KESM(Tianjin) MIS</p>
    </div>
</div>
<script src="layui/layui.all.js"></script>
<script>
	layui.use(['form','layer'], function(){
		var form = layui.form
		,layer = layui.layer
		,$ = layui.jquery;
		
		//自定义验证规则
    	form.verify({
            nikename: function(value){
              if(value.length < 5){
                return '登录名至少5位以上！';
              }
            }
            ,pass: [/(.+){5,12}$/, '密码必须5到12位']
            ,repass: function(value){
                if($('#L_pass').val()!=$('#L_repass').val()){
                    return '两次密码不一致';
                }
            }
     	});

		//监听提交
        form.on('submit(loginFrom)', function(data){
			console.log(data);
		    $.ajax({
				url:"user/userlogin.do",
				data : data.field,
				type:"post",
				dataType:"json",
				success:function(resp){
					if(resp.status == "pass"){
						location.href = resp.desUrl;
					}else{
						layer.alert("登录失败!", {icon: 5});
					}
				}
			})
			return false;
        });
        form.render();
	});
</script>
</body>

</html>