package com.project.erp.fm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.fm.model.dto.PurDeptDTO;
import com.project.erp.fm.model.vo.Purchase;

@Mapper
public interface PurchaseMapper {

	List<PurDeptDTO> showPurchase(PurDeptDTO pd);
	void purchaseRegister(List<Purchase> prList);
	
}
