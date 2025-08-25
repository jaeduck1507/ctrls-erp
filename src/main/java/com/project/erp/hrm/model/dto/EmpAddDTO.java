package com.project.erp.hrm.model.dto;

import java.util.List;

import com.project.erp.hrm.model.vo.EmployeeInfo;

import lombok.Data;

@Data
public class EmpAddDTO {
	List<EmpInfo> eiList;
}
