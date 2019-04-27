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

	@Override
	public List<PUID> findByMachineID(PUID pd) {

		PUIDExample example = new PUIDExample();
		Criteria criteria = example.createCriteria();
		criteria.andMachineIdEqualTo(pd.getMachineId());
		
		return puidMapper.selectByExample(example);
	}

	@Override
	public boolean isExistThisPUID(PUID pd) {
		
		PUIDExample example = new PUIDExample();
		Criteria criteria = example.createCriteria();
		criteria.andMachineIdEqualTo(pd.getMachineId());
		criteria.andPuidEqualTo(pd.getPuid());
		
		return puidMapper.selectByExample(example).size()!=0?true:false;
	}

}
