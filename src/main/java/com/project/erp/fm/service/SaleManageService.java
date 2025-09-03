package com.project.erp.fm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.fm.mapper.SaleManageMapper;
import com.project.erp.fm.model.dto.SaleManagePagingDTO;
import com.project.erp.fm.model.dto.SaleProductDTO;
import com.project.erp.fm.model.vo.SaleManage;

@Service
public class SaleManageService {

	@Autowired
	private SaleManageMapper saleManageMapper;

	public List<SaleProductDTO> showSaleManage(SaleProductDTO sp) {
		return saleManageMapper.showSaleManage(sp);
	}

	public List<SaleProductDTO> showSaleManagePage(SaleManagePagingDTO saleManagePaging) {
		return saleManageMapper.showSaleManagePage(saleManagePaging);
	}
	
	public int totalSaleManagePage(SaleProductDTO sp) {
		return saleManageMapper.totalSaleManagePage(sp);
	}
	
	public SaleManagePagingDTO showSalesPaging(SaleProductDTO sp, Paging paging) {
		SaleManagePagingDTO saleManagePagingDTO = new SaleManagePagingDTO();
		saleManagePagingDTO.setSaleProductDTO(sp);
		saleManagePagingDTO.setOffset(paging.getLimit() * (paging.getPage() - 1));
		saleManagePagingDTO.setSalesList(showSaleManagePage(saleManagePagingDTO));
		saleManagePagingDTO.setPage(paging.getPage());
		saleManagePagingDTO.setTotal(totalSaleManagePage(sp));
		return saleManagePagingDTO;
	}
	
	public void saleRegister(List<SaleManage> smList) {
		saleManageMapper.saleRegister(smList);
	}

	public List<SaleProductDTO> totalSales(SaleProductDTO sp) {
		return saleManageMapper.totalSales(sp);
	}
	
	public List<SaleProductDTO> weekSalesChart() {
		return saleManageMapper.weekSalesChart();
	}
	
	public List<SaleProductDTO> monthSalesChart() {
		return saleManageMapper.monthSalesChart();
	}
	
	public List<SaleProductDTO> monthQuantityChart(SaleProductDTO sp) {
		return saleManageMapper.monthQuantityChart(sp);
	}
 	
}
