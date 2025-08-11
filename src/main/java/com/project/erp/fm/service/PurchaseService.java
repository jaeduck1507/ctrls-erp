package com.project.erp.fm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.fm.mapper.PurchaseMapper;
import com.project.erp.fm.model.dto.PurDeptDTO;
import com.project.erp.fm.model.dto.PurchasePagingDTO;
import com.project.erp.fm.model.vo.Purchase;

@Service
public class PurchaseService {

	@Autowired
	private PurchaseMapper purchaseMapper;
	
	public List<PurDeptDTO> showPurchase(PurDeptDTO pd) {
		return purchaseMapper.showPurchase(pd);
	}
	
	public List<PurDeptDTO> showPurchasePage(PurchasePagingDTO purchasePaging) {
		return purchaseMapper.showPurchasePage(purchasePaging);
	}
	
	public int totalPurchasePage(PurDeptDTO pd) {
		return purchaseMapper.totalPurchasePage(pd);
	}
	
	public PurchasePagingDTO showPurchasePaging(PurDeptDTO pd, Paging paging) {
		PurchasePagingDTO purchasePagingDTO = new PurchasePagingDTO();
		purchasePagingDTO.setPurDeptDTO(pd);
		purchasePagingDTO.setOffset(paging.getLimit() * (paging.getPage() - 1));
		purchasePagingDTO.setPurchaseList(showPurchasePage(purchasePagingDTO));
		purchasePagingDTO.setPage(paging.getPage());
		purchasePagingDTO.setTotal(totalPurchasePage(pd));
		return purchasePagingDTO;
	}
	
	public void purchaseRegister(List<Purchase> prList) {
		purchaseMapper.purchaseRegister(prList);
	}
	
	public List<PurDeptDTO> totalPurchase(PurDeptDTO pd) {
		return purchaseMapper.totalPurchase(pd);
	}
	
}
