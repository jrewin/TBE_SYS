package com.tbe.service;

import java.util.List;

import com.tbe.beans.Local;

public interface LocalService {

	Local findLocalByLN(String localLN);

	List<Local> getLocals();
}
