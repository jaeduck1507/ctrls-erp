package com.project.erp.fm.model.dto;

import java.util.List;

import lombok.Data;

@Data
public class SalaryAlreadyAddDTO {
	private String yearMonth;
	private String lastMonth;
	private List<SalaryDTO> list;
}
