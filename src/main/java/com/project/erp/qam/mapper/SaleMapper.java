package com.project.erp.qam.mapper;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.qam.model.dto.SaleReadyDTO;
import com.project.erp.qam.model.dto.SaleReadyForListDTO;
import com.project.erp.qam.model.vo.Sale;

@Mapper
public interface SaleMapper {
    // Insert a new sale entry (used when QC passes)
    void insertSale(Sale sale);

	void deleteByProductNo(int productNo);
	
	List<Sale> showSale(); // QAM내에서는 활용 X, 필요하신 분들 위해 만들어둠
	
	List<SaleReadyDTO> showSaleNull();
	
	Integer totalSaleReady(); // saleReady.jsp의 total
	
	List<SaleReadyDTO> showSaleDone(Paging paging);	
	
	Integer totalSaleDone(); // saleDone.jsp의 total
	
	SaleReadyDTO findBySaleNo(int saleNo);
	
	void registerSaleDate(SaleReadyDTO dto);

	void registerSaleDate(int saleNo, LocalDate saleDate);
	
	List<SaleReadyDTO> dailySale(SaleReadyDTO dto);
	
	void updateSaleRegistered(LocalDate saleDate);
	
	//List<SaleReadyDTO> searchSaleDone(SaleReadyDTO dto);
	List<SaleReadyForListDTO> searchSaleDone(SaleReadyDTO dto);
	
	int serachSaleDoneTotal(SaleReadyDTO dto);
	
}
