package com.project.erp.hrm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.hrm.model.dto.EmpInfo;
import com.project.erp.hrm.model.dto.EmpInfoPagingDTO;
import com.project.erp.hrm.model.vo.EmployeeInfo;

@Mapper
public interface EmployeeInfoMapper {
	List<EmpInfo> infoShow(EmpInfo ei);
	List<EmpInfo> infoShowPage(EmpInfoPagingDTO empInfoPagingDTO);
	void empAdd(List<EmployeeInfo> eiList);
	List<EmpInfo> showEmployee(); // 윤의진 추가 qc 위함
	int totalEmp(EmpInfo ei);
}
