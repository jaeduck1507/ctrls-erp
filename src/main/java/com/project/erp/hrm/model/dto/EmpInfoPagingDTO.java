package com.project.erp.hrm.model.dto;

import java.util.List;

import com.project.erp.common.model.vo.Paging;

import lombok.Data;

@Data
public class EmpInfoPagingDTO extends Paging {
	private EmpInfo empInfo;
	private List<EmpInfo> empInfoList;
}
