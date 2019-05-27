package com.tbe.service;

import java.util.List;

import com.tbe.beans.PUID;

public interface PuidService {

	boolean addPUID(PUID pd);
	
	List<PUID> findByMachineID(PUID pd);
	
	boolean isExistThisPUID(PUID pd);
	
	PUID findOneByMachineIDAndRDt(PUID pd);
	
	boolean updatePUID(PUID puid);
	
	PUID findPUIDByID(PUID pd);
	
	List<PUID> findSameBoxPUID(String puidstr , String machineId);
	
	PUID findOneBy2DCodeAndStoreck(String zdcode);
	
	List<PUID> findPuidCheckByPUID(PUID puid);
}
