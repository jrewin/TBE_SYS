package com.tbe.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tbe.beans.PUID;
import com.tbe.beans.PUIDExample;
import com.tbe.beans.PUIDExample.Criteria;
import com.tbe.dao.PUIDMapper;

@Service(value="puidService")
public class PuidServiceImpl implements PuidService {
	
	@Autowired
	private PUIDMapper puidMapper;

	@Override
	public boolean addPUID(PUID pd) {
		
		return puidMapper.insert(pd)>0?true:false;
	}

	/**
	 * 	检索指定机器号的所有数据
	 * 	条件：机器号（MachineID） and RDT（回料时间）不能为空
	 * 	注：如果为空，则说明这是新添加的料，还没有回料
	 */
	@Override
	public List<PUID> findByMachineID(PUID pd) {

		PUIDExample example = new PUIDExample();
		Criteria criteria = example.createCriteria();
		criteria.andMachineIdEqualTo(pd.getMachineId());
		criteria.andRDtIsNull();
		
		return puidMapper.selectByExample(example);
	}

	/**
	 * 	检索指定机器号下是否存在相应的PUID
	 * 	条件：机器号（MachineID） and PUID
	 */
	@Override
	public boolean isExistThisPUID(PUID pd) {
		
		PUIDExample example = new PUIDExample();
		Criteria criteria = example.createCriteria();
		criteria.andMachineIdEqualTo(pd.getMachineId());
		criteria.andPuidEqualTo(pd.getPuid());
		
		return puidMapper.selectByExample(example).size()!=0?true:false;
	}
	
	/**
	 * 	根据机器号和没有入库信息进行检索
	 */
	@Override
	public PUID findOneByMachineIDAndRDt(PUID pd) {

		PUIDExample example = new PUIDExample();
		Criteria criteria = example.createCriteria();
		criteria.andMachineIdEqualTo(pd.getMachineId());
		criteria.andZdCodeEqualTo(pd.getZdCode());
		criteria.andCheckIdIsNotNull();
		criteria.andRDtIsNull();
		
		List<PUID> p = puidMapper.selectByExample(example);
		
		return p.size()!=0?p.get(0):null;
	}

	@Override
	public boolean updatePUID(PUID puid) {

		return puidMapper.updateByPrimaryKey(puid)>0?true:false;
	}

	@Override
	public PUID findPUIDByID(PUID pd) {
		
		return puidMapper.selectByPrimaryKey(pd.getId());
	}

	@Override
	public List<PUID> findSameBoxPUID() {
		
		PUIDExample example = new PUIDExample();
		Criteria criteria = example.createCriteria();
		criteria.andRDtIsNull();
	
		List<PUID> p = puidMapper.selectByExample(example);
		
		return p;
	}

	@Override
	public PUID findOneBy2DCodeAndStoreck(String zdcode) {
		
		PUIDExample example = new PUIDExample();
		Criteria criteria = example.createCriteria();
		criteria.andZdCodeEqualTo(zdcode);
		criteria.andStoreckEqualTo(1);
		
		List<PUID> p = puidMapper.selectByExample(example);
		
		return p.size()==0?null:p.get(0);
	}

}
