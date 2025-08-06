package com.project.erp.qam.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.qam.mapper.SaleMapper;
import com.project.erp.qam.model.dto.SaleReadyDTO;
import com.project.erp.qam.model.vo.Sale;

@Service
public class SaleService {

	@Autowired
	private SaleMapper saleMapper;
	
	public List<Sale> showSale() { // QAM내에서는 활용 X, 필요하신 분들 위해 만들어둠
		return saleMapper.showSale();
	}
	
	public List<SaleReadyDTO> showSaleNull() {
		return saleMapper.showSaleNull();
	}
	
	public List<SaleReadyDTO> showSaleDone() {
		return saleMapper.showSaleDone();
	}
	
	public SaleReadyDTO findBySaleNo(int saleNo) {
		return saleMapper.findBySaleNo(saleNo);
	}

	public void registerSaleDate(List<SaleReadyDTO> sellList) {
		for (SaleReadyDTO dto : sellList) {
    		saleMapper.registerSaleDate(dto.getSaleNo(), dto.getSaleDate());
    	}
	}
	
	public List<SaleReadyDTO> dailySale(SaleReadyDTO dto) {
		return saleMapper.dailySale(dto);
	}
	
	public List<SaleReadyDTO> searchSaleDone(String productCategory) {
	    return saleMapper.searchSaleDone(productCategory);
	}
	
}
