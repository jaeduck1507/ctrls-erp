package com.project.erp.qam.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.qam.mapper.DefectiveMapper;
import com.project.erp.qam.model.vo.Defective;

@Service
public class DefectiveService {

	@Autowired
	private DefectiveMapper defectiveMapper;
	
	public List<Defective> showDefective() {
		return defectiveMapper.showDefective();
	}

}
