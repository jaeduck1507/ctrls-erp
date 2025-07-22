package com.project.erp.qam.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.qam.model.vo.ProductName;

@Mapper
public interface ProductNameMapper {
	List<ProductName> showProductName();
	void insertProductName(ProductName pn);
    void updateProductName(ProductName pn);
    ProductName findById(int productCode);
   	void deleteProductName(int productCode);
   	List<ProductName> searchProductName(String productName, String productCategory);

}
