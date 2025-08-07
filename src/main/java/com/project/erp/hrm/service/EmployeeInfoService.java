package com.project.erp.hrm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.hrm.mapper.EmployeeInfoMapper;
import com.project.erp.hrm.model.dto.EmpInfo;
import com.project.erp.hrm.model.dto.EmpInfoPagingDTO;
import com.project.erp.hrm.model.vo.EmployeeInfo;

@Service
public class EmployeeInfoService {
	
	@Autowired
	private EmployeeInfoMapper employeeInfoMapper;
	
	public List<EmpInfo> infoShow(EmpInfo ei) {
		ei.setDeptNo(-1);
		ei.setJobNo(-1);
//		if(ei.getEmpName().isBlank()) ei.setEmpName(null);
		return employeeInfoMapper.infoShow(ei);
	};
	
	List<EmpInfo> infoShowPage(EmpInfoPagingDTO empInfoPagingDTO) {
		
		return employeeInfoMapper.infoShowPage(empInfoPagingDTO);
	};
	
	public void empAdd(List<EmployeeInfo> eiList) {
		employeeInfoMapper.empAdd(eiList);
	};
	
	public List<EmpInfo> showEmployee() { // 윤의진 추가 qc 위함
		return employeeInfoMapper.showEmployee();
	}
		
	public int totalEmp(EmpInfo ei) {
		return employeeInfoMapper.totalEmp(ei);
	}
	
	public EmpInfoPagingDTO pagingInfoShow(EmpInfo ei, Paging paging) {
		EmpInfoPagingDTO empInfoPagingDTO = new EmpInfoPagingDTO();
		empInfoPagingDTO.setEmpInfo(ei);
		empInfoPagingDTO.setOffset(paging.getLimit() * (paging.getPage() - 1));
		empInfoPagingDTO.setEmpInfoList(infoShowPage(empInfoPagingDTO));
		empInfoPagingDTO.setPage(paging.getPage());
		empInfoPagingDTO.setTotal(totalEmp(ei));
		return empInfoPagingDTO;
	}
	
	public EmpInfo infoShowOne(EmpInfo ei) {
		return employeeInfoMapper.infoShowOne(ei);
	}
	
	public void empModify(EmpInfo ei) {
		employeeInfoMapper.empModify(ei);
	}
}
