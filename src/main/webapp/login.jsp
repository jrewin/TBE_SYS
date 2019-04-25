<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap css file v2.2.1 -->
<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">

<!--[if lte IE 6]>
<!-- bsie css 补丁文件 -->
<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap-ie6.css">

<!-- bsie 额外的 css 补丁文件 -->
<link rel="stylesheet" type="text/css" href="bootstrap/css/ie.css">
<![endif]-->

<!-- 登录页样式文件 -->
<link href="public/css/base.css" rel="stylesheet" type="text/css">
<link href="public/css/login.css" rel="stylesheet" type="text/css">

<title>登录</title>
</head>
<body>
	<div class="login">
		<div class="logo"></div>
	    <div class="login_form">
	    	<div class="user">
	        	<input class="text_value" id="id" type="text">
	            <input class="text_value" id="password" type="password">
	        </div>
	        <button class="button" id="submit">登录</button>
	    </div>
	    <div id="tip"></div>
	    <div class="foot">
	    	Copyright © 2019 KESM(Tianjin) MIS
	    </div>
	</div>
	<!-- jQuery 1.7.2 or higher -->
	<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
	
	<!-- Optional, bootstrap javascript library -->
	<script type="text/javascript" src="bootstrap/js/bootstrap.js"></script>
	
	<!--[if lte IE 6]>
	<!-- bsie js 补丁只在IE6中才执行 -->
	<script type="text/javascript" src="js/bootstrap-ie.js"></script>
	<![endif]-->
	
	<script>
	$("#submit").click(function(){
		var id = $("#id").val();
		var password = $("#password").val();
		if(id!="" && password!=""){
			var sdata = {"id" : id, "password" : password};
			$.ajax({
				url:"user/userlogin.do",
				data:sdata,
				type:"post",
				dataType:"json",
				success:function(resp){
					if(resp.status == "pass"){
						location.href = resp.desUrl;
					}else{
						alert("用户名和密码错误！");			
					}
				}
			})
		}else{
			alert("请输入用户名和密码！");			
		}
	})
	</script>
</body>
</html>