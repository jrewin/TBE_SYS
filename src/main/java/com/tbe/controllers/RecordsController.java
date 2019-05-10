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

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tbe.beans.Record;
import com.tbe.service.RecordsService;

@Controller
@RequestMapping("/records")
public class RecordsController {
	
	@Autowired
	private RecordsService recordsService;
		
	@RequestMapping("/findRecordsBySelection.do")
	public void findRecordsBySelection(HttpServletResponse response ,HttpSession session) throws IOException {
		
		List<Record> puids = recordsService.findRecordsBySelection();
		
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
}
