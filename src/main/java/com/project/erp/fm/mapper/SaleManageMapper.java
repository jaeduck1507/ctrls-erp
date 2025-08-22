package com.project.erp.fm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.fm.model.dto.SaleManagePagingDTO;
import com.project.erp.fm.model.dto.SaleProductDTO;
import com.project.erp.fm.model.vo.SaleManage;

@Mapper
public interface SaleManageMapper {

	List<SaleProductDTO> showSaleManage(SaleProductDTO sp);
	List<SaleProductDTO> showSaleManagePage(SaleManagePagingDTO saleManagePaging);
	int totalSaleManagePage(SaleProductDTO sp);
	void saleRegister(List<SaleManage> smList);
	List<SaleProductDTO> totalSales(SaleProductDTO sp);
	List<SaleProductDTO> weekSalesChart();
	List<SaleProductDTO> monthSalesChart();
	List<SaleProductDTO> monthQuantityChart(SaleProductDTO sp);
	
}
