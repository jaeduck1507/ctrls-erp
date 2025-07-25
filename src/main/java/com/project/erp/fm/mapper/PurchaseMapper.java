package com.project.erp.fm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.fm.model.dto.PurDeptDTO;

@Mapper
public interface PurchaseMapper {

	List<PurDeptDTO> showPurchase(PurDeptDTO pd);
	List<Purchase> showPurchase();
	void purchaseRegister(List<Purchase> prList);
	
}
