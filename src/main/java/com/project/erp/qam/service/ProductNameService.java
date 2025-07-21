package com.project.erp.qam.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.qam.mapper.ProductNameMapper;
import com.project.erp.qam.model.vo.ProductName;

@Service
public class ProductNameService {

	@Autowired
	private ProductNameMapper productNameMapper;
	
	public List<ProductName> showProductName() {
		System.out.println("이것도? productNameService");
		return productNameMapper.showProductName();
	}
	
}

