package com.project.erp.fm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.fm.mapper.BonusPaymentMapper;
import com.project.erp.fm.model.vo.BonusPayment;

@Service
public class BonusPaymentService {
	
	@Autowired
	private BonusPaymentMapper bonusPaymentMapper;
	
	public void addBonusPayment(List<BonusPayment> bList) {
		bonusPaymentMapper.addBonusPayment(bList);
	}
}
