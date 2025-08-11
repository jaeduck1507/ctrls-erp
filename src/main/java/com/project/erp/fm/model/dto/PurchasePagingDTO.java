package com.project.erp.fm.model.dto;

import java.util.List;

import com.project.erp.common.model.vo.Paging;

import lombok.Data;

@Data
public class PurchasePagingDTO extends Paging {

	private PurDeptDTO purDeptDTO;
	private List<PurDeptDTO> purchaseList;
	
}
