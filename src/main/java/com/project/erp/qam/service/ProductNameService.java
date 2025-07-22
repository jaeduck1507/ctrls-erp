package com.project.erp.qam.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.qam.mapper.ProductNameMapper;
import com.project.erp.qam.model.vo.ProductName;

@Service
public class ProductNameService implements ProductNameMapper {

	@Autowired
	private ProductNameMapper productNameMapper;
	
	@Override
	public List<ProductName> showProductName() {
		return productNameMapper.showProductName();
	}

	@Override
	public void insertProductName(ProductName pn) {
		productNameMapper.insertProductName(pn);
		
	}

	@Override
	public void updateProductName(ProductName pn) {
		productNameMapper.updateProductName(pn);
		
	}

	@Override
	public ProductName findById(int productCode) {
		return productNameMapper.findById(productCode);
	}
	
	@Override
	public void deleteProductName(int productCode) {
		productNameMapper.deleteProductName(productCode);
	}
	
}

