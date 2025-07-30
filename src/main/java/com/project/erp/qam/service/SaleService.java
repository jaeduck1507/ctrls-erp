package com.project.erp.qam.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.qam.mapper.SaleMapper;
import com.project.erp.qam.model.vo.Sale;

@Service
public class SaleService {

	@Autowired
	private SaleMapper saleMapper;
	
	public List<Sale> showSale() {
		return saleMapper.showSale();
	}

}
