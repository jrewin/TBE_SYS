package com.tbe.service;

import java.util.List;

import com.tbe.beans.Machine;

public interface MachineService {

	List<Machine> getMachines();
	
	Machine getMachineById(int id);
}
