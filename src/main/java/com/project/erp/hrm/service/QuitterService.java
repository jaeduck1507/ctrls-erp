package com.project.erp.hrm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.hrm.mapper.QuitterMapper;
import com.project.erp.hrm.model.dto.Quitter;

@Service
public class QuitterService {

	@Autowired
	private QuitterMapper quitterMapper;
	
	public List<Quitter> quitShow(Quitter q) {
		return quitterMapper.quitShow(q);
	}
}
