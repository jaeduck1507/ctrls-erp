package com.project.erp.hrm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.hrm.model.dto.EmpInfo;
import com.project.erp.hrm.model.vo.EmployeeInfo;

@Mapper
public interface EmployeeInfoMapper {
	List<EmpInfo> infoShow(EmpInfo ei);
	void empAdd(List<EmployeeInfo> eiList);
}
