package com.project.erp.fm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.fm.mapper.BonusPaymentMapper;
import com.project.erp.fm.model.dto.BonusPaymentDTO;
import com.project.erp.fm.model.dto.BonusPaymentPagingDTO;
import com.project.erp.fm.model.vo.BonusPayment;
import com.project.erp.hrm.model.dto.EmpInfo;

@Service
public class BonusPaymentService {
	
	@Autowired
	private BonusPaymentMapper bonusPaymentMapper;
	
	public void addBonusPayment(List<BonusPayment> bList) {
		bonusPaymentMapper.addBonusPayment(bList);
	}
	
	public List<BonusPaymentDTO> showBonusPayment(EmpInfo empInfo) {
		if(empInfo.getEmpName() != null && empInfo.getEmpName().isEmpty()) empInfo.setEmpName(null);
		if(empInfo.getDate() != null && empInfo.getDate().isEmpty()) empInfo.setDate(null);
		return bonusPaymentMapper.showBonusPayment(empInfo);
	}
	
	public List<BonusPaymentDTO> showBonusPaymentPage(BonusPaymentPagingDTO bonusPaymentPaging) {
		return bonusPaymentMapper.showBonusPaymentPage(bonusPaymentPaging);
	}
	
	public int totalBonusPaymentPage(EmpInfo empInfo) {
		return bonusPaymentMapper.totalBonusPaymentPage(empInfo);
	}
	
	public BonusPaymentPagingDTO showBonusPaymentPaging(EmpInfo empInfo, Paging paging) {
		BonusPaymentPagingDTO bonusPaymentPagingDTO = new BonusPaymentPagingDTO();
		bonusPaymentPagingDTO.setEmpInfo(empInfo);
		bonusPaymentPagingDTO.setOffset(paging.getLimit() * (paging.getPage() - 1));
		bonusPaymentPagingDTO.setBonusPaymentList(showBonusPaymentPage(bonusPaymentPagingDTO));
		bonusPaymentPagingDTO.setPage(paging.getPage());
		bonusPaymentPagingDTO.setTotal(totalBonusPaymentPage(empInfo));
		return bonusPaymentPagingDTO;
	}

}
