package com.tbe.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tbe.beans.Machine;
import com.tbe.beans.MachineExample;
import com.tbe.beans.MachineExample.Criteria;
import com.tbe.dao.MachineMapper;

@Service(value="machineService")
public class MachineServiceImpl implements MachineService {

	@Autowired
	MachineMapper machineMapper;
	
	@Override
	public List<Machine> getMachines() {
		
		return machineMapper.selectByExample(null);
	}

	@Override
	public Machine getMachineById(int id) {
		
		MachineExample example = new MachineExample();
		Criteria criteria = example.createCriteria();
		criteria.andIdEqualTo(id);

		return machineMapper.selectByExample(example).get(0);
	}

}
