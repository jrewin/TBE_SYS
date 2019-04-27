package com.tbe.controllers;

import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tbe.beans.PUID;
import com.tbe.service.MachineService;
import com.tbe.service.PuidService;

@Controller
@RequestMapping("/puid")
public class PuidController {
	
	@Autowired
	private PuidService puidService;
	
	@Autowired
	private MachineService machineService ;
	
	@RequestMapping("/puidCheck.do")
	public void puidCheck(String zdcode , HttpServletResponse response) throws IOException {
		
		Map<String , String> resultMap = new HashMap<String , String>();
		
		//把接收到的User转为json,使用jackson工具库
		ObjectMapper mapper = new ObjectMapper();
		
		//通过应答对象输出数据给浏览器
		OutputStream out = response.getOutputStream();
		
		//[)>06$1P935314545518$30PSC516725CDWER$Q1000$9D1915$1TTZ36962.1$30T$30Q$31P-3/260$31TU-X-D$32TO371$30D$31D$33T04CT4LS15KFG00$34T
		
		String[] zdtimes = zdcode.split("");
		int total$ = 0;
		for(String s : zdtimes) {
			if("$".equals(s))
				total$ ++;
		}
		
		if(zdcode.length() != 127 || total$ != 14){
			resultMap.put("status", "ZcodErro");
		}else{
			String[] zdcodes =zdcode.split("\\$");
			for(String s : zdcodes) {
				String rs = s.substring(0, 3);
				if(rs.equals("33T")){
					String puidCode = s.substring(3);
					resultMap.put("puidCode", puidCode);
				}
			}
		}
		resultMap.put("zdCode", zdcode);
		
		mapper.writeValue(out, resultMap);
	}
	
	@RequestMapping("/puidSave.do")
	public void puidSave(PUID puid, HttpServletResponse response) throws IOException {
		
		Map<String , String> resultMap = new HashMap<String , String>();
		
		//把接收到的User转为json,使用jackson工具库
		ObjectMapper mapper = new ObjectMapper();
		
		//通过应答对象输出数据给浏览器
		OutputStream out = response.getOutputStream();
		
		//需要先用puid和machineid进行判断，库中没有符合条件的再进行添加
		if(puidService.isExistThisPUID(puid)) {
			resultMap.put("status", "exist");
		}else {
			if(puidService.addPUID(puid)) {
				resultMap.put("status", "good");
				resultMap.put("MachineId", puid.getMachineId());
				resultMap.put("MachineName", machineService.getMachineById(Integer.parseInt(puid.getMachineId())).getMaName());
			}else {
				resultMap.put("status", "erro");
			}
		}
		
		mapper.writeValue(out, resultMap);
	}
	
	@RequestMapping("/findByMachineId.do")
	public void findByMachineId(PUID puid , HttpServletResponse response ,HttpSession session) throws IOException {
		
		List<PUID> puids = puidService.findByMachineID(puid);
		
		Map<String , Object> resultMap = new HashMap<String , Object>();
		
		//把接收到的User转为json,使用jackson工具库
		ObjectMapper mapper = new ObjectMapper();
		
		//通过应答对象输出数据给浏览器
		OutputStream out = response.getOutputStream();
		
		resultMap.put("code", 0);
		resultMap.put("msg", "");
		resultMap.put("count", 29);
		resultMap.put("data", puids);
		
		mapper.writeValue(out, resultMap);
		
	}
	
	@RequestMapping("/findMachine.do")
	public void findMachine(PUID puid , HttpServletResponse response ,HttpSession session) throws IOException {
		
		Map<String , Object> resultMap = new HashMap<String , Object>();
		
		resultMap.put("MachineName", machineService.getMachineById(Integer.parseInt(puid.getMachineId())).getMaName());
		
		//把接收到的User转为json,使用jackson工具库
		ObjectMapper mapper = new ObjectMapper();
		//通过应答对象输出数据给浏览器
		OutputStream out = response.getOutputStream();
		
		mapper.writeValue(out, resultMap);
		
	}
}
