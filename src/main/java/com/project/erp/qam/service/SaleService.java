package com.project.erp.qam.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.qam.mapper.SaleMapper;
import com.project.erp.qam.model.dto.SaleReadyDTO;
import com.project.erp.qam.model.dto.SaleReadyForListDTO;
import com.project.erp.qam.model.vo.Sale;

@Service
public class SaleService {

	@Autowired
	private SaleMapper saleMapper;
	
	public List<Sale> showSale() { // QAM내에서는 활용 X, 필요하신 분들 위해 만들어둠
		return saleMapper.showSale();
	}
	
	public List<SaleReadyDTO> showSaleNull() {
//		paging.setOffset(paging.getLimit() * (paging.getPage() - 1));
//		paging.setTotal(saleMapper.totalSaleReady());
		System.out.println("showSaleNull 넘어감");
		return saleMapper.showSaleNull();
	}
	
	public List<SaleReadyDTO> showSaleDone(Paging paging) {
		paging.setOffset(paging.getLimit() * (paging.getPage() - 1));
		paging.setTotal(saleMapper.totalSaleDone());
		return saleMapper.showSaleDone(paging);
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
	
	public SaleReadyDTO searchSaleDone(SaleReadyDTO dto, Paging paging) {
		dto.setOffset(paging.getLimit() * (paging.getPage() - 1));
		dto.setList(saleMapper.searchSaleDone(dto));
		dto.setPage(paging.getPage());
		dto.setTotal(serachSaleDoneTotal(dto));
	    return dto;
	}
	
	public int serachSaleDoneTotal(SaleReadyDTO dto) {
		return saleMapper.serachSaleDoneTotal(dto);
	}

//	public Integer totalSaleDone() { // ajax saleDone paging용
//		return saleMapper.totalSaleDone();
//	}
	
}
