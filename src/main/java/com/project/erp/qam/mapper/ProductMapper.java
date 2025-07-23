package com.project.erp.qam.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.project.erp.qam.model.dto.ProductDetailDTO;

import java.util.List;

@Mapper // ✅ MyBatis Mapper 인터페이스로 등록 (자동 매핑 활성화)
public interface ProductMapper {

    // ✅ 전체 제품 목록 조회 (product + product_name JOIN 결과 DTO로 반환)
    List<ProductDetailDTO> showProductDetail();

    // ✅ 제품 상세 조회 (수정 페이지 진입 시 사용 - productNo 기준)
    ProductDetailDTO findProductDetailById(int productNo);

    // ✅ 제품명 정보 수정 (product_name 테이블 업데이트용)
    // → 색상, 이름, 가격, 단가, 카테고리 등 수정
    void updateProductNameFromDetail(ProductDetailDTO product);

    // ✅ 제품 생산일 정보 수정 (product 테이블 업데이트용)
    void updateProductFromDetail(ProductDetailDTO product);

    // ✅ 제품 삭제 (product 테이블에서 productNo 기준 삭제)
    void deleteProduct(int productNo);

    // ✅ 제품 검색 (제품명, 카테고리 조건 기반 LIKE 필터 검색)
    List<ProductDetailDTO> searchProductDetail(String productName, String productCategory);
}
