package com.project.erp.hrm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.hrm.mapper.DepartmentMapper;
import com.project.erp.hrm.model.vo.Department;

@Service
public class DepartmentService {

	@Autowired
	private DepartmentMapper departmentmapper;
	
	public List<Department> showDept() {
		
		return departmentmapper.showDept();
	}
}
