package com.project.erp.fm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.fm.model.dto.SalEmpDTO;
import com.project.erp.fm.model.dto.SalaryDTO;
import com.project.erp.fm.model.vo.Salary;

@Mapper
public interface SalaryMapper {

	List<SalEmpDTO> showSalary(SalEmpDTO se);
	List<SalaryDTO> salaryPayment(String yearMonth);
	List<SalaryDTO> salaryPaymentNoBonus(List<SalaryDTO> existList);
	void addSalaryPayment(List<Salary> spList);
	
}
