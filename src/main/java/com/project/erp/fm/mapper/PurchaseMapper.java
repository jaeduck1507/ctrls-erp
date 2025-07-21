package com.project.erp.fm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.fm.model.vo.Purchase;

@Mapper
public interface PurchaseMapper {

	List<Purchase> showPurchase();
	
}
