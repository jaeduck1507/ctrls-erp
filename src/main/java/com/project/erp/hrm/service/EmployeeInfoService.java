package com.project.erp.hrm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.hrm.mapper.EmployeeInfoMapper;
import com.project.erp.hrm.model.dto.EmpInfo;

@Service
public class EmployeeInfoService implements EmployeeInfoMapper {
	
	@Autowired
	private EmployeeInfoMapper employeeInfoMapper;
	
	public List<EmpInfo> infoShow(EmpInfo ei) {
//		if(ei.getEmpName().isBlank()) ei.setEmpName(null);
		return employeeInfoMapper.infoShow(ei);
	};
}
