package com.project.erp.qam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.qam.mapper.ProductMapper;
import com.project.erp.qam.model.vo.Product;

import java.util.List;

@Service
public class ProductService {

	@Autowired
    private ProductMapper productMapper;

    
    public List<Product> showProduct(Product p) { // 전체 제품 목록 조회
    	List<Product> list = productMapper.showProduct(p);
    	 System.out.println("제품: " + p);
        return list;
        
    }
}