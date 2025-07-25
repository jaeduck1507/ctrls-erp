package com.project.erp.qam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.fm.model.vo.Purchase;
import com.project.erp.qam.mapper.ProductMapper;
import com.project.erp.qam.model.dto.ProductDetailDTO;
import com.project.erp.qam.model.vo.Product;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class ProductService {

    @Autowired
    private ProductMapper productMapper; // ✅ MyBatis Mapper 주입 (DB 연동용)

    // ✅ 전체 제품 리스트 조회
    // → product + product_name 조인 결과 (DTO) 반환
    public List<ProductDetailDTO> showProductDetail() {
        return productMapper.showProductDetail();
    }

    // ✅ 단일 제품 상세 조회
    // → 수정 페이지 진입 시 해당 제품 정보 불러오기
    public ProductDetailDTO findProductDetailById(int productNo) {
        return productMapper.findProductDetailById(productNo);
    }

    // ✅ 제품 정보 수정
    // → product_name 정보 먼저 수정, 그 다음 product 정보 수정 (두 테이블 분리 업데이트)
    public void updateProductDetail(ProductDetailDTO product) {
        productMapper.updateProductNameFromDetail(product); // 제품명/색상/가격 등
        productMapper.updateProductFromDetail(product);     // 생산일 등
    }

    // ✅ 제품 삭제
    // → product 테이블에서 productNo 기준으로 삭제
    public void deleteProduct(int productNo) {
        productMapper.deleteProduct(productNo);
    }

    // ✅ 제품 검색
    // → 제품명 및 카테고리 기준 필터링 (LIKE + WHERE 조건 조합)
    public List<ProductDetailDTO> searchProductDetail(String productName, String productCategory) {
        return productMapper.searchProductDetail(productName, productCategory);
    }
    
    public boolean existsByProductNo(int productNo) {
        return productMapper.findProductDetailById(productNo) != null;
    }

    public void productBatchRegister(List<Product> productList) {
    	productMapper.productBatchRegister(productList);
    }
    
    // 제품 등록 수량에서 리스트로 변환
    public void productBatchSetter(List<Purchase> prList) {
    	List<Product> productList = new ArrayList<Product>();
    	for(Purchase pr : prList) {
    		for(int i = 0; i<pr.getQuantity(); i++) {
    			
    			Product product = new Product();
    			product.setProductionDate(pr.getPurchaseDate());
    			product.setProductCode(pr.getProductNo());
    			productList.add(product);
    		}
    	}
    	productBatchRegister(productList);
    }
}