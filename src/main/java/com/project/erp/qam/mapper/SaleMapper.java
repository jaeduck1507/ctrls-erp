package com.project.erp.qam.mapper;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.qam.model.dto.SaleReadyDTO;
import com.project.erp.qam.model.vo.Sale;

@Mapper
public interface SaleMapper {
    // Insert a new sale entry (used when QC passes)
    void insertSale(Sale sale);

	void deleteByProductNo(int productNo);
	
	List<Sale> showSale();
	
	List<SaleReadyDTO> showSaleNull();
	
	List<SaleReadyDTO> showSaleDone();	
	
	SaleReadyDTO findBySaleNo(int saleNo);
	
//	void registerSaleDate(SaleReadyDTO dto);

	void registerSaleDate(int saleNo, LocalDate saleDate);
	
	List<SaleReadyDTO> countSale(SaleReadyDTO dto);
	
}
