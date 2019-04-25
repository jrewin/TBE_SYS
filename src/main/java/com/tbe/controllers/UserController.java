package com.tbe.controllers;


import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tbe.beans.User;

@Controller
@RequestMapping("/user")
public class UserController {

	@RequestMapping("/userlogin.do")
	/*
	 * 	Controller的void方法中一定要声明HttpServletResponse类型的方法入参！
	 * 	否则：Spring MVC会认为@RequestMapping注解中指定的路径就是要返回的视图name
	 */
	public void userLogin(User user , HttpServletResponse response) throws IOException{
		
		Map<String , String> urlMap = new HashMap<String , String>();
		
		//把接收到的User转为json,使用jackson工具库
		ObjectMapper mapper = new ObjectMapper();
		
		//通过应答对象输出数据给浏览器
		OutputStream out = response.getOutputStream();
		
		/*
		 *	此处添加调用service验证用户名和密码代码
		 */
		
		if(user.getId().equals("1") && user.getPassword().equals("1")) {
			urlMap.put("status", "pass");
			urlMap.put("desUrl", "index.jsp");
		}else {
			urlMap.put("status", "erro");
		}
		
		mapper.writeValue(out, urlMap);
	}
	
	/*
	//ModelAndView实际上是通过request.setAttribute(modelName, modelValue)放入的
	public ModelAndView userLogin(User user) {
		
		ModelAndView mv = new ModelAndView();
		mv.addObject(user);
		
		mv.setViewName("login");
		
		return mv;
	}*/
}
