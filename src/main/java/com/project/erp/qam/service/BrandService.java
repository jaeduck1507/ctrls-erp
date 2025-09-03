package com.project.erp.qam.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.qam.mapper.BrandMapper;
import com.project.erp.qam.model.vo.Brand;

@Service
public class BrandService {

	@Autowired
	private BrandMapper brandMapper;

	public List<Brand> showBrand() {
		return brandMapper.showBrand();
	}

	public void registerBrand(Brand brand) {
		brandMapper.registerBrand(brand);
	}
	
	public Brand findById(Integer brandCode) {
		return brandMapper.findById(brandCode);
	}
	
	public List<Brand> findBrand(Paging paging) {
		paging.setOffset(paging.getLimit() * (paging.getPage() - 1));
		paging.setTotal(brandMapper.totalBrand());
	    return brandMapper.findBrand(paging); 
	}

	public void updateBrand(Brand brand) {
		brandMapper.updateBrand(brand);
	}
	
	public void deleteBrand(Integer brandCode) {
		brandMapper.deleteBrand(brandCode);
	}
	
	
}
