package com.project.erp.fm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.fm.model.dto.SalEmpDTO;
import com.project.erp.fm.model.dto.SalaryAlreadyAddDTO;
import com.project.erp.fm.model.dto.SalaryDTO;
import com.project.erp.fm.model.dto.SalaryPagingDTO;
import com.project.erp.fm.model.vo.Salary;

@Mapper
public interface SalaryMapper {

	List<SalEmpDTO> showSalary(SalEmpDTO se);
	List<SalEmpDTO> showSalaryPage(SalaryPagingDTO salaryPaging);
	int totalSalaryPage(SalEmpDTO se);
	List<SalaryDTO> salaryPayment(SalaryAlreadyAddDTO saaDto);
	List<SalaryDTO> salaryPaymentNoBonus(SalaryAlreadyAddDTO saaDto);
	void addSalaryPayment(List<Salary> spList);
	List<SalaryDTO> showSalaryAlreadyAdd(SalaryAlreadyAddDTO saaDto);
	List<SalEmpDTO> totalSalary(SalEmpDTO se);
	
}
