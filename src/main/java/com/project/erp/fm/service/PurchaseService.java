package com.project.erp.fm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.fm.mapper.PurchaseMapper;

@Service
public class PurchaseService {

	@Autowired
	private PurchaseMapper mapper;
}
