package com.tbe.service;

import java.util.List;

import com.tbe.beans.Record;

public interface RecordsService {

	List<Record> findRecordsBySelection();
	
	boolean UpdateRecordBySelecttion(Record record);
}
