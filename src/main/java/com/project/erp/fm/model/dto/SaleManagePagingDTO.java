package com.project.erp.fm.model.dto;

import java.util.List;

import com.project.erp.common.model.vo.Paging;

import lombok.Data;

@Data
public class SaleManagePagingDTO extends Paging {

	private SaleProductDTO saleProductDTO;
	private List<SaleProductDTO> salesList;
	
}
