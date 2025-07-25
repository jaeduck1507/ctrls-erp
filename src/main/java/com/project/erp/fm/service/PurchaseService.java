package com.project.erp.fm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.fm.mapper.PurchaseMapper;
import com.project.erp.fm.model.vo.Purchase;

@Service
public class PurchaseService implements PurchaseMapper {

	@Autowired
	private PurchaseMapper mapper;

	@Override
	public List<Purchase> showPurchase() {
		return mapper.showPurchase();
	}

	@Override
	public void purchaseRegister(List<Purchase> prList) {
		mapper.purchaseRegister(prList);
	}
	
}
