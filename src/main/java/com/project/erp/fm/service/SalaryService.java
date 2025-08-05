package com.project.erp.fm.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.fm.mapper.SalaryMapper;
import com.project.erp.fm.model.dto.SalEmpDTO;
import com.project.erp.fm.model.dto.SalaryDTO;

@Service
public class SalaryService implements SalaryMapper {

	@Autowired
	private SalaryMapper mapper;

	@Override
	public List<SalEmpDTO> showSalary(SalEmpDTO se) {
		return mapper.showSalary(se);
	}

	@Override
	public List<SalaryDTO> salaryPayment(String yearMonth) {
		List<SalaryDTO> allList = new ArrayList<SalaryDTO>();
		List<SalaryDTO> existList = mapper.salaryPayment(yearMonth);
		List<SalaryDTO> noList = salaryPaymentNoBonus(existList);
		allList.addAll(existList);
		allList.addAll(noList);
		return allList;
	}

	@Override
	public List<SalaryDTO> salaryPaymentNoBonus(List<SalaryDTO> existList) {
		return mapper.salaryPaymentNoBonus(existList);
	}
}
