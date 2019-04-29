package com.tbe.service;

import java.util.List;

import com.tbe.beans.PUID;

public interface PuidService {

	boolean addPUID(PUID pd);
	
	List<PUID> findByMachineID(PUID pd);
	
	boolean isExistThisPUID(PUID pd);
	
	PUID findOneByMachineIDAndRDt(PUID pd);
	
	boolean updatePUID(PUID puid);
}
