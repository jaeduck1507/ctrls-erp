package com.project.erp.qam.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	
	public List<Brand> findBrand() {
	    return brandMapper.findBrand(); // assumes brandMapper exists and works
	}
	
	
}
