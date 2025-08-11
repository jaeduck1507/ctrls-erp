package com.project.erp.fm.model.dto;

import java.util.List;

import com.project.erp.common.model.vo.Paging;

import lombok.Data;

@Data
public class SalaryPagingDTO extends Paging {

	private SalEmpDTO salEmpDTO;
	private List<SalEmpDTO> salaryList;
	
}