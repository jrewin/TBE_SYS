package com.tbe.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tbe.beans.Record;
import com.tbe.beans.RecordExample;
import com.tbe.beans.RecordExample.Criteria;
import com.tbe.dao.RecordMapper;

@Service(value="recordsService")
public class RecordsServiceImpl implements RecordsService {
	
	@Autowired
	private RecordMapper mapper;

	@Transactional
	@Override
	public List<Record> findRecordsBySelection() {
		
		RecordExample example = new RecordExample();
		Criteria criteria = example.createCriteria();
		//select * from tbe_step.records where Pass_Fail='Fail' and P_R='N' and isnull(O_ID)
		criteria.andPassFailEqualTo("Fail");
		criteria.andPREqualTo("N");
		criteria.andOIdIsNull();
		
		return mapper.selectByExample(example);
	}

	@Transactional
	@Override
	public boolean UpdateRecordBySelecttion(Record record) {

		RecordExample example = new RecordExample();
		Criteria criteria = example.createCriteria();
		criteria.andIdEqualTo(record.getId());
		return mapper.updateByExampleSelective(record, example)==1?true:false;
	}

}
