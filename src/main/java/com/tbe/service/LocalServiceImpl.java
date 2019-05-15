package com.tbe.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tbe.beans.Local;
import com.tbe.beans.LocalExample;
import com.tbe.beans.LocalExample.Criteria;
import com.tbe.dao.LocalMapper;

@Service(value="LocalService")
public class LocalServiceImpl implements LocalService {
	
	@Autowired
	private LocalMapper mapper;

	@Override
	public Local findLocalByLN(String localLN) {

		LocalExample example = new LocalExample();
		Criteria criteria = example.createCriteria();
		criteria.andLNEqualTo(localLN);
		List<Local> locals = mapper.selectByExample(example);
		
		return locals.size()==0?null:locals.get(0);
	}

	@Override
	public List<Local> getLocals() {

		return mapper.selectByExample(null);
	}

}
