package com.project.erp.fm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.fm.mapper.SalaryMapper;
import com.project.erp.fm.model.dto.SalEmpDTO;

@Service
public class SalaryService implements SalaryMapper {

	@Autowired
	private SalaryMapper mapper;

	@Override
	public List<SalEmpDTO> showSalary(SalEmpDTO se) {
		return mapper.showSalary(se);
	}
}
