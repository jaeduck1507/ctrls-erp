package com.project.erp.fm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.fm.model.vo.BonusPayment;

@Mapper
public interface BonusPaymentMapper {
	void addBonusPayment(List<BonusPayment> bList);
}
