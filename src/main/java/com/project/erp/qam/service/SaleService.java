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
	
	public List<Sale> showSale() {
		return saleMapper.showSale();
	}
	
	public List<SaleReadyDTO> showSaleNull() {
		return saleMapper.showSaleNull();
	}
	
	public List<SaleReadyDTO> showSaleDone() {
		return saleMapper.showSaleDone();
	}
	
//	public void registerSaleDate(List<SaleReadyDTO> sellList) {
//		for (SaleReadyDTO dto : sellList)
//			saleMapper.registerSaleDate(dto);
//	}
	
	public SaleReadyDTO findBySaleNo(int saleNo) {
		return saleMapper.findBySaleNo(saleNo);
	}

	public void registerSaleDate(int saleNo, LocalDate saleDate) {
		saleMapper.registerSaleDate(saleNo, saleDate);
	}
	
	public List<SaleReadyDTO> countSale(SaleReadyDTO dto) {
		return saleMapper.countSale(dto);
	}
	
}
