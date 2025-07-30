package com.project.erp.hrm.model.dto;

import java.util.List;

import lombok.Data;

@Data
public class EmpInfoPagingDTO {
	private EmpInfo empInfo;
	private List<EmpInfo> empInfoList;
	private HRMPagingDTO hrmPagingDTO;
}
