package com.project.erp.fm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.fm.mapper.SaleManageMapper;
import com.project.erp.fm.model.vo.SaleManage;

@Service
public class SaleManageService implements SaleManageMapper {

	@Autowired
	private SaleManageMapper mapper;

	@Override
	public List<SaleManage> showSaleManage(SaleManage sm) {
		return mapper.showSaleManage(sm);
	}
	
}
