package com.project.erp.fm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.fm.model.dto.SaleProductDTO;
import com.project.erp.fm.model.vo.SaleManage;

@Mapper
public interface SaleManageMapper {

	List<SaleProductDTO> showSaleManage(SaleProductDTO sp);
	void saleRegister(List<SaleManage> smList);
}
