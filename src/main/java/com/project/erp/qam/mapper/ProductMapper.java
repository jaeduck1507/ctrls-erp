package com.project.erp.qam.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.project.erp.qam.model.vo.Product;

import java.util.List;

@Mapper
public interface ProductMapper {
    // 전체 제품 목록 조회
    List<Product> showProduct();
    void insertProduct(Product p);
    void updateProduct(Product p);
    void deleteProduct(int productNo);

}
