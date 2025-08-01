package com.project.erp.fm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.fm.mapper.BonusMapper;
import com.project.erp.fm.model.vo.Bonus;

@Service
public class BonusService {
	
	@Autowired
	private BonusMapper bonusMapper;
	
	public List<Bonus> showBonusAll() {
		return bonusMapper.showBonusAll();
	}
}
