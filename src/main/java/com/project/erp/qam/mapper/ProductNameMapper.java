package com.project.erp.qam.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.qam.model.dto.ProductNameDTO;
import com.project.erp.qam.model.vo.Brand;
import com.project.erp.qam.model.vo.ProductName;

@Mapper // MyBatis 매퍼로 인식시켜 Spring에서 자동 주입 가능하게 함
public interface ProductNameMapper {

    // 전체 제품명 목록 조회
    // → 제품 등록/수정 시 드롭다운용 select list 데이터
	List<ProductNameDTO> showProductName(Paging paging);

    // 제품명 등록
    // → 새 제품 카테고리, 이름, 가격 등 DB에 추가
	void insertProductName(ProductName productName);

    // 제품명 수정
    // → product_code 기준으로 정보 업데이트
    void updateProductName(ProductName productName);

    // 특정 제품명 단건 조회
    // → 수정 폼 진입 시 productCode로 조회
    ProductNameDTO findById(int productCode);

    // 제품명 삭제
    // → product_code로 해당 행 삭제
    void deleteProductName(int productCode);

    // 제품명 검색
    // → 이름 or 카테고리 조건으로 필터링 (LIKE, WHERE)
    List<ProductNameDTO> searchProductName(Paging paging, String productName, String productCategory);
    
    List<ProductNameDTO> showProductNameByBrandFilter(Brand brand);
    
    List<String> selectCategory();

	Integer totalProductName();
	
	Integer totalSearchProductName(String productName, String productCategory);

}
