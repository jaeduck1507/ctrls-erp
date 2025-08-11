package com.project.erp.qam.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.qam.model.vo.Brand;

@Mapper
public interface BrandMapper {

	List<Brand> showBrand();
	
	void registerBrand(Brand brand);
	
	Brand findById(Integer brandCode);
	
	List<Brand> findBrand(Paging paging);

	void updateBrand(Brand brand);

	void deleteBrand(Integer brandCode);

	Integer totalBrand();
	
}
