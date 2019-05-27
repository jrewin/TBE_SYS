package com.tbe.service;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
	public List<Record> findErroRecordsBySelection() {
		
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

	@Override
	public List<Record> findRecordsBySelection(Record record) {

		RecordExample example = new RecordExample();
		Criteria criteria = example.createCriteria();
		
		if(!"all".equals(record.getSourcePuid())) {
			criteria.andSourcePuidEqualTo(record.getSourcePuid());
		}
		if(!"all".equals(record.getPassFail())) {
			criteria.andPassFailEqualTo(record.getPassFail());
		}

		if(record.getCheckDt() != null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String ckdt = sdf.format(record.getCheckDt());
			
			String startTimeStr = ckdt + " 00:00:00";
			String endTimeStr = ckdt + " 23:59:59";
			
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date startTime = null;
			Date endTime = null;
			
			try {   
				startTime = format.parse(startTimeStr); 
				endTime = format.parse(endTimeStr); 
			} catch (ParseException e) {   
			    e.printStackTrace();   
			}   
			
			criteria.andCheckDtBetween(startTime, endTime);
		}
		
		return mapper.selectByExample(example);
	}

}
