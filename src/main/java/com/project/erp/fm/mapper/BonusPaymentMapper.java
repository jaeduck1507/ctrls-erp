package com.project.erp.fm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.fm.model.dto.BonusPaymentDTO;
import com.project.erp.fm.model.dto.BonusPaymentPagingDTO;
import com.project.erp.fm.model.vo.BonusPayment;
import com.project.erp.hrm.model.dto.EmpInfo;

@Mapper
public interface BonusPaymentMapper {
	void addBonusPayment(List<BonusPayment> bList);
	List<BonusPaymentDTO> showBonusPayment(EmpInfo empInfo);
	List<BonusPaymentDTO> showBonusPaymentPage(BonusPaymentPagingDTO bonusPaymentPaging);
	int totalBonusPaymentPage(EmpInfo empinfo);
}