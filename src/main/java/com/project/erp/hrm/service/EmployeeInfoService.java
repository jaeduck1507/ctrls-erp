package com.project.erp.hrm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.hrm.mapper.EmployeeInfoMapper;
import com.project.erp.hrm.model.dto.EmpInfo;
import com.project.erp.hrm.model.dto.EmpInfoPagingDTO;
import com.project.erp.hrm.model.dto.HRMPagingDTO;
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
	
	public EmpInfoPagingDTO pagingInfoShow(EmpInfo ei,HRMPagingDTO hrmPagingDTO) {
		EmpInfoPagingDTO empInfoPagingDTO = new EmpInfoPagingDTO();
		empInfoPagingDTO.setEmpInfo(ei);
		hrmPagingDTO.setOffset(hrmPagingDTO.getLimit() * (hrmPagingDTO.getPage()-1));
		empInfoPagingDTO.setHrmPagingDTO(hrmPagingDTO);
		empInfoPagingDTO.setEmpInfoList(infoShowPage(empInfoPagingDTO));
		empInfoPagingDTO.setHrmPagingDTO(new HRMPagingDTO(hrmPagingDTO.getPage(),totalEmp(ei)));
		return empInfoPagingDTO;
	}
}
