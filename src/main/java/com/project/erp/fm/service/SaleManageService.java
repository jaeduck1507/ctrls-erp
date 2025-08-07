package com.project.erp.fm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.fm.mapper.SaleManageMapper;
import com.project.erp.fm.model.dto.SaleProductDTO;
import com.project.erp.fm.model.vo.SaleManage;

@Service
public class SaleManageService implements SaleManageMapper {

	@Autowired
	private SaleManageMapper saleManageMapper;

	@Override
	public List<SaleProductDTO> showSaleManage(SaleProductDTO sp) {
		return saleManageMapper.showSaleManage(sp);
	}

	@Override
	public void saleRegister(List<SaleManage> smList) {
		saleManageMapper.saleRegister(smList);
	}

	@Override
	public List<SaleProductDTO> totalSales(SaleProductDTO sp) {
		return saleManageMapper.totalSales(sp);
	}
	
}
