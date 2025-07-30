package com.project.erp.hrm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.hrm.mapper.EmployeeInfoMapper;
import com.project.erp.hrm.model.dto.EmpInfo;
import com.project.erp.hrm.model.vo.EmployeeInfo;

@Service
public class EmployeeInfoService implements EmployeeInfoMapper {
	
	@Autowired
	private EmployeeInfoMapper employeeInfoMapper;
	
	public List<EmpInfo> infoShow(EmpInfo ei) {
//		if(ei.getEmpName().isBlank()) ei.setEmpName(null);
		return employeeInfoMapper.infoShow(ei);
	};
	
	public void empAdd(List<EmployeeInfo> eiList) {
		employeeInfoMapper.empAdd(eiList);
	};
	
	public List<EmpInfo> showEmployee() { // 윤의진 추가 qc 위함
		return employeeInfoMapper.showEmployee();
	}
}
