package com.tbe.controllers;

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tbe.beans.Machine;
import com.tbe.beans.User;
import com.tbe.service.MachineService;
import com.tbe.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserService userSerivce;
	
	@Autowired
	private MachineService machineService;

	@RequestMapping("/userlogin.do")
	/*
	 * 	Controller的void方法中一定要声明HttpServletResponse类型的方法入参！
	 * 	否则：Spring MVC会认为@RequestMapping注解中指定的路径就是要返回的视图name
	 */
	public void userLogin(User user , HttpServletResponse response , HttpSession session) throws IOException{
		
		Map<String , String> urlMap = new HashMap<String , String>();
		
		//把接收到的User转为json,使用jackson工具库
		ObjectMapper mapper = new ObjectMapper();
		
		//通过应答对象输出数据给浏览器
		OutputStream out = response.getOutputStream();
		
		user.setLv(3);
		
		User userByGet = userSerivce.getUser(user);
		
		List<Machine> machines = machineService.getMachines();
		
		if(userByGet != null) {
			session.setAttribute("user", userByGet);
			session.setAttribute("machines", machines);
			urlMap.put("status", "pass");
			urlMap.put("desUrl", "page1.jsp");
		}else {
			urlMap.put("status", "erro");
		}
		
		mapper.writeValue(out, urlMap);
	}
	
	@RequestMapping("/userlogout.do")
	public void userlogout(HttpServletResponse response , HttpSession session) throws IOException{
		
		session.removeAttribute("user");  
		
		Map<String , String> urlMap = new HashMap<String , String>();
		
		urlMap.put("desUrl", "login.jsp");
		
		//把接收到的User转为json,使用jackson工具库
		ObjectMapper mapper = new ObjectMapper();
		
		//通过应答对象输出数据给浏览器
		OutputStream out = response.getOutputStream();
		
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
