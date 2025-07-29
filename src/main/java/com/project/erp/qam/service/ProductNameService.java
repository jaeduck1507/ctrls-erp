package com.project.erp.qam.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.qam.mapper.ProductNameMapper;
import com.project.erp.qam.model.vo.ProductName;

@Service
public class ProductNameService {

	@Autowired
	private ProductNameMapper productNameMapper; // 실제 DB 처리를 담당하는 Mapper 주입

	// 전체 제품명 조회
	// → SELECT * FROM product_name
	public List<ProductName> showProductName() {
		return productNameMapper.showProductName();
	}

	// 제품명 등록
	// → INSERT INTO product_name (...) VALUES (...)
	public void insertProductName(ProductName pn) {
		productNameMapper.insertProductName(pn);
	}

	// 제품명 수정
	// → UPDATE product_name SET ... WHERE product_code = ?
	public void updateProductName(ProductName pn) {
		productNameMapper.updateProductName(pn);
	}

	// 특정 제품명 단건 조회
	// → 수정폼 진입 시 기존 정보 조회용
	public ProductName findById(int productCode) {
		return productNameMapper.findById(productCode);
	}

	// 제품명 삭제
	// → product_code 기준 삭제
	public void deleteProductName(int productCode) {
		productNameMapper.deleteProductName(productCode);
	}

	// 제품명 검색
	// → product_name LIKE '%keyword%' AND category 조건 조회
	public List<ProductName> searchProductName(String productName, String productCategory) {
	    return productNameMapper.searchProductName(productName, productCategory);
	}
}