package com.project.erp.fm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.fm.mapper.BonusPaymentMapper;
import com.project.erp.fm.model.dto.BonusPaymentDTO;
import com.project.erp.fm.model.vo.BonusPayment;
import com.project.erp.hrm.model.dto.EmpInfo;

@Service
public class BonusPaymentService {
	
	@Autowired
	private BonusPaymentMapper bonusPaymentMapper;
	
	public void addBonusPayment(List<BonusPayment> bList) {
		bonusPaymentMapper.addBonusPayment(bList);
	}
	
	public List<BonusPaymentDTO> showBonusPayment(EmpInfo empinfo) {
		if(empinfo.getEmpName() != null && empinfo.getEmpName().isEmpty()) empinfo.setEmpName(null);
		if(empinfo.getDate() != null && empinfo.getDate().isEmpty()) empinfo.setDate(null);
		return bonusPaymentMapper.showBonusPayment(empinfo);
		
	}
}
