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
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tbe.beans.Local;
import com.tbe.beans.PUID;
import com.tbe.beans.User;
import com.tbe.service.LocalService;
import com.tbe.service.PuidService;

@Controller
@RequestMapping("/puid")
public class PuidController {
	
	@Autowired
	private PuidService puidService;
	
	@Autowired
	private LocalService localService;

	@RequestMapping("/puidCheck.do")
	public void puidCheck(String zdcode , HttpServletResponse response) throws IOException {
		
		Map<String , String> resultMap = new HashMap<String , String>();
		
		//把接收到的User转为json,使用jackson工具库
		ObjectMapper mapper = new ObjectMapper();
		
		//通过应答对象输出数据给浏览器
		OutputStream out = response.getOutputStream();
		
		//[)>06$1P935314545518$30PSC516725CDWER$Q1000$9D1915$1TTZ36962.1$30T$30Q$31P-3/260$31TU-X-D$32TO371$30D$31D$33T04CT4LS15KFG00$34T
		
		String[] zdtimes = zdcode.split("");
		
		/*
		int total$ = 0;
		for(String s : zdtimes) {
			if("$".equals(s))
				total$ ++;
		}
		
		if(zdcode.length() != 127 || total$ != 14){
			resultMap.put("status", "ZcodErro");
		}else{
			
		}
		*/
		
		String[] zdcodes =zdcode.split("\\$");
		for(String s : zdcodes) {
			
			String rs1 = s.substring(0, 1);
			String rs2 = s.substring(0, 2);
			String rs3 = s.substring(0, 3);
			
			if(rs1.equals("Q")){
				String qty = s.substring(1);
				resultMap.put("qty", qty);
			}
			
			if(rs2.equals("1T")){
				String lot = s.substring(2);
				resultMap.put("lot", lot);
			}
			if(rs2.equals("1P")){
				String condeno = s.substring(2);
				resultMap.put("condeno", condeno);
			}
			
			if(rs3.equals("33T")){
				String puidCode = s.substring(3);
				resultMap.put("puidCode", puidCode);
			}
			if(rs3.equals("30P")){
				String type = s.substring(3);
				resultMap.put("type", type);
			}
			
		}
		
		PUID puid = puidService.findOneBy2DCodeAndStoreck(zdcode);
		
		if(puid==null) {
			resultMap.put("local", "库中无记录");
			resultMap.put("localcolor", "#F2F2F2"); //第一次入库，灰色
		}else {
			Local local = localService.findLocalByLN(puid.getLocal());
			resultMap.put("local", local.getlN());
			resultMap.put("localcolor", local.getColor());
		}
		
		resultMap.put("zdCode", zdcode);
		
		mapper.writeValue(out, resultMap);
	}
	
	@RequestMapping("/puidCheckForEnter.do")
	public void puidCheckForEnter(PUID puid , HttpServletResponse response) throws IOException {
		
		Map<String , String> resultMap = new HashMap<String , String>();
		
		//把接收到的User转为json,使用jackson工具库
		ObjectMapper mapper = new ObjectMapper();
		
		//通过应答对象输出数据给浏览器
		OutputStream out = response.getOutputStream();
		
		//[)>06$1P935314545518$30PSC516725CDWER$Q1000$9D1915$1TTZ36962.1$30T$30Q$31P-3/260$31TU-X-D$32TO371$30D$31D$33T04CT4LS15KFG00$34T
		
		String zdcode = puid.getZdCode();
		
		/*
		String[] zdtimes = zdcode.split("");
		int total$ = 0;
		for(String s : zdtimes) {
			if("$".equals(s))
				total$ ++;
		}
		
		if(zdcode.length() != 127 || total$ != 14){
			resultMap.put("status", "ZcodErro");
		}else{
			
		}
		*/
		
		String[] zdcodes =zdcode.split("\\$");
		for(String s : zdcodes) {
			
			String rs1 = s.substring(0, 1);
			String rs2 = s.substring(0, 2);
			String rs3 = s.substring(0, 3);
			
			if(rs1.equals("Q")){
				String qty = s.substring(1);
				resultMap.put("qty", qty);
			}
			
			if(rs2.equals("1T")){
				String lot = s.substring(2);
				resultMap.put("lot", lot);
			}
			if(rs2.equals("1P")){
				String condeno = s.substring(2);
				resultMap.put("condeno", condeno);
			}
			
			if(rs3.equals("33T")){
				String puidCode = s.substring(3);
				resultMap.put("puidCode", puidCode);

				//是否存在这一批料（PUID除去前两位）
				String puidstr = puidCode.substring(2);
				List<PUID> ps = puidService.findSameBoxPUID(puidstr , puid.getMachineId());
				
				//如果存在
				if(ps.size()!=0) {
					
					String localStr = null;
					
					for(PUID pd : ps) {
						if(pd.getLocal() != null) {
							localStr = pd.getLocal();
							break;
						}
					}
					
					//如果这盒料已经在库中有位置，则后面录入的料只能存在相同的位置
					if(localStr != null) {
						resultMap.put("local", localStr);
					}else {
						resultMap.put("local", "none");
					}
				}else {
					resultMap.put("local", "none");
				}
				
			}
			if(rs3.equals("30P")){
				String type = s.substring(3);
				resultMap.put("type", type);
			}
		}
		
		resultMap.put("zdCode", zdcode);
		
		PUID p = puidService.findOneByMachineIDAndRDt(puid);
		
		if(p!=null) {
			resultMap.put("id", p.getId()+"");
			resultMap.put("match", "match");
			
		}else {
			resultMap.put("match", "nomatch");
		}
		
		
		
		mapper.writeValue(out, resultMap);
	}
	@RequestMapping("/puidSave.do")
	public void puidSave(PUID puid, HttpServletResponse response , HttpSession session) throws IOException {
		
		Map<String , String> resultMap = new HashMap<String , String>();
		
		//把接收到的User转为json,使用jackson工具库
		ObjectMapper mapper = new ObjectMapper();
		
		//通过应答对象输出数据给浏览器
		OutputStream out = response.getOutputStream();
		
		User user = (User)session.getAttribute("user");
		Date date = new Date();
		puid.setoDt(date);
		puid.setOperatorId(user.getCoreid());
		
		//是否存在这一批料（PUID除去前两位）
		String puidstr = puid.getPuid();
		puidstr = puidstr.substring(2);
		List<PUID> ps = puidService.findSameBoxPUID(puidstr, puid.getMachineId());
		
		puid.setLocal(null);
		puid.setStoreck(0);
		
		//如果不存在，则进入添加环节
		if(ps.size()==0) {
			//需要先用puid和machineid进行判断，库中没有符合条件的再进行添加
			if(puidService.addPUID(puid)) {
				resultMap.put("status", "good");
				resultMap.put("MachineId", puid.getMachineId());
				resultMap.put("MachineName", puid.getMachineId());
			}else {
				resultMap.put("status", "erro");
			}
		}else{ //如果存在，则比对录入的批次和数据库存在的批次是否相同，如果相同则添加，如果不同则提示，【不能同时派两批料】
			String psPuidStr = ps.get(0).getPuid();
			psPuidStr = psPuidStr.substring(2);
			if(psPuidStr.equals(puidstr)) {//批次相同，进行添加
				//先用puid和machineid进行判断，库中没有符合条件的再进行添加
				if(puidService.isExistThisPUID(puid)) {
					resultMap.put("status", "exist");
				}else {
					if(puidService.addPUID(puid)) {
						resultMap.put("status", "good");
						resultMap.put("MachineId", puid.getMachineId());
						resultMap.put("MachineName", puid.getMachineId());
					}else {
						resultMap.put("status", "erro");
					}
				}
			}else {//批次不相同，不能添加
				resultMap.put("status", "badbox");
			}
		}
		
		PUID p = puidService.findOneBy2DCodeAndStoreck(puid.getZdCode());
		
		if(p != null) {
			//更新 p 的 storeck字段为0
		}
		
		mapper.writeValue(out, resultMap);
	}
	
	@RequestMapping("/puidEnter.do")
	public void puidEnter(PUID puid, HttpServletResponse response , HttpSession session) throws IOException {
		
		Map<String , String> resultMap = new HashMap<String , String>();
		
		//把接收到的User转为json,使用jackson工具库
		ObjectMapper mapper = new ObjectMapper();
		
		//通过应答对象输出数据给浏览器
		OutputStream out = response.getOutputStream();
		
		PUID p = puidService.findPUIDByID(puid);
		User user = (User)session.getAttribute("user");
		Date date = new Date();
		p.setrDt(date);
		p.setrId(user.getCoreid());
		p.setLocal(puid.getLocal());
		p.setStoreck(1);
		
		//先检索此PUID在库中是否存在storeck为1的记录
		PUID pp = puidService.findOneBy2DCodeAndStoreck(p.getZdCode());
		if(null != pp) {
			//如果存在，先将其storeck更新为0
			pp.setStoreck(0);
			puidService.updatePUID(pp);
		}
		//需要先用puid和machineid进行判断，库中没有符合条件的再进行添加
		if(puidService.updatePUID(p)) {
			resultMap.put("status", "good");
			resultMap.put("MachineId", puid.getMachineId());
			resultMap.put("MachineName",puid.getMachineId());
		}else {
			resultMap.put("status", "false");
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
		
		resultMap.put("MachineName", puid.getMachineId());
		
		//把接收到的User转为json,使用jackson工具库
		ObjectMapper mapper = new ObjectMapper();
		//通过应答对象输出数据给浏览器
		OutputStream out = response.getOutputStream();
		
		mapper.writeValue(out, resultMap);
		
	}
	
	@RequestMapping("/findPuidCheckByPUID.do")
	public void findPuidCheckByPUID(PUID puid , HttpServletResponse response ,HttpSession session) throws IOException {
		
		List<PUID> puids = puidService.findPuidCheckByPUID(puid);

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
