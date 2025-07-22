package com.project.erp.qam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.qam.mapper.ProductMapper;
import com.project.erp.qam.model.vo.Product;

import java.util.List;

@Service
public class ProductService implements ProductMapper {

	@Autowired
    private ProductMapper productMapper;

    
    public List<Product> showProduct() { // 전체 제품 목록 조회
        return productMapper.showProduct();      
    }


	@Override
	public void insertProduct(Product p) {
		productMapper.insertProduct(p);
		
	}


	@Override
	public void updateProduct(Product p) {
		productMapper.updateProduct(p);
		
	}


	@Override
	public void deleteProduct(int productNo) {
		productMapper.deleteProduct(productNo);
		
	}
    
    
    
}