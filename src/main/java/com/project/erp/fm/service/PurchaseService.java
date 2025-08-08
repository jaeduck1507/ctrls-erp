package com.project.erp.fm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.fm.mapper.PurchaseMapper;
import com.project.erp.fm.model.dto.PurDeptDTO;
import com.project.erp.fm.model.vo.Purchase;

@Service
public class PurchaseService implements PurchaseMapper {

	@Autowired
	private PurchaseMapper purchaseMapper;

	@Override
	public List<PurDeptDTO> showPurchase(PurDeptDTO pd) {
		return purchaseMapper.showPurchase(pd);
	}

	@Override
	public void purchaseRegister(List<Purchase> prList) {
		purchaseMapper.purchaseRegister(prList);
	}

	@Override
	public List<PurDeptDTO> totalPurchase(PurDeptDTO pd) {
		return purchaseMapper.totalPurchase(pd);
	}

	
	
}
