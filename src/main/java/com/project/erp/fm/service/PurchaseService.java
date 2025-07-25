package com.project.erp.fm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.fm.mapper.PurchaseMapper;
import com.project.erp.fm.model.dto.PurDeptDTO;

@Service
public class PurchaseService implements PurchaseMapper {

	@Autowired
	private PurchaseMapper mapper;

	@Override
	public List<PurDeptDTO> showPurchase(PurDeptDTO pd) {
		return mapper.showPurchase(pd);
	}

	@Override
	public void purchaseRegister(List<Purchase> prList) {
		mapper.purchaseRegister(prList);
	}
	
}
