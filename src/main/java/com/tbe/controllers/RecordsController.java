package com.tbe.controllers;

import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tbe.beans.Record;
import com.tbe.beans.User;
import com.tbe.service.RecordsService;

@Controller
@RequestMapping("/records")
public class RecordsController {
	
	@Autowired
	private RecordsService recordsService;
	
	@RequestMapping(value = "/findRecordsBySelection.do" ,method = RequestMethod.POST)
	public void findRecordsBySelection(@RequestBody Record record ,HttpServletResponse response ,HttpSession session) throws IOException {

		List<Record> puids = recordsService.findRecordsBySelection(record);
		
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
		
	@RequestMapping("/findErroRecordsBySelection.do")
	public void findErroRecordsBySelection(HttpServletResponse response ,HttpSession session) throws IOException {
		
		List<Record> puids = recordsService.findErroRecordsBySelection();
		
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
	
	@RequestMapping("/solutionRecord.do")
	public void solutionRecord(Record record , HttpServletResponse response ,HttpSession session) throws IOException {

		Map<String , Object> resultMap = new HashMap<String , Object>();
		
		if("".equals(record.getoReason())) {
			record.setoReason(null);
		}
		if("".equals(record.getoHandle())) {
			record.setoHandle(null);
		}
		
		User user = (User)session.getAttribute("user");	
		record.setoId(user.getCoreid());
		Date date = new Date();
		record.setoDt(date);
		
		if(recordsService.UpdateRecordBySelecttion(record)) {
			resultMap.put("status", "success");
		}else {
			resultMap.put("status", "fail");
		}
		
		//把接收到的User转为json,使用jackson工具库
		ObjectMapper mapper = new ObjectMapper();
		//通过应答对象输出数据给浏览器
		OutputStream out = response.getOutputStream();
		
		mapper.writeValue(out, resultMap);
	}
}
