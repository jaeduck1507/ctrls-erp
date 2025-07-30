package com.project.erp.qam.mapper;

import java.util.List;

import com.project.erp.qam.model.vo.Sale;

public interface SaleMapper {
    // Insert a new sale entry (used when QC passes)
    void insertSale(Sale sale);

	void deleteByProductNo(int productNo);
	
	List<Sale> showSale();
}
