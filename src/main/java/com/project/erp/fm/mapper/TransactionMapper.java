package com.project.erp.fm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.fm.model.dto.TransDTO;

@Mapper
public interface TransactionMapper {

	List<TransDTO> showtrans(TransDTO trans);
	
}
