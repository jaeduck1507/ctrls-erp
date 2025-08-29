package com.project.erp.fm.service;

import java.time.YearMonth;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.fm.mapper.SalaryMapper;
import com.project.erp.fm.model.dto.SalEmpDTO;
import com.project.erp.fm.model.dto.SalaryAlreadyAddDTO;
import com.project.erp.fm.model.dto.SalaryDTO;
import com.project.erp.fm.model.dto.SalaryPagingDTO;
import com.project.erp.fm.model.vo.Salary;

@Service
public class SalaryService {

	@Autowired
	private SalaryMapper salaryMapper;
	
	public List<SalEmpDTO> showSalary(SalEmpDTO se) {
		return salaryMapper.showSalary(se);
	}
	
	public List<SalEmpDTO> showSalaryPage(SalaryPagingDTO salaryPaging) {
		return salaryMapper.showSalaryPage(salaryPaging);
	}
	
	public int totalSalaryPage(SalEmpDTO se) {
		return salaryMapper.totalSalaryPage(se);
	}
	
	public SalaryPagingDTO showSalaryPaging(SalEmpDTO se, Paging paging) {
		SalaryPagingDTO salaryPagingDTO = new SalaryPagingDTO();
		salaryPagingDTO.setSalEmpDTO(se);
		salaryPagingDTO.setOffset(paging.getLimit() * (paging.getPage() - 1));
		salaryPagingDTO.setSalaryList(showSalaryPage(salaryPagingDTO));
		salaryPagingDTO.setPage(paging.getPage());
		salaryPagingDTO.setTotal(totalSalaryPage(se));
		return salaryPagingDTO;
	}
	
	public List<SalaryDTO> salaryPayment(SalaryAlreadyAddDTO saaDto) {
		List<SalaryDTO> allList = new ArrayList<SalaryDTO>();
		YearMonth ym = YearMonth.parse(saaDto.getYearMonth());        // 문자열 → YearMonth
        System.out.println(ym.minusMonths(1).toString());
		saaDto.setLastMonth(ym.minusMonths(1).toString());
		saaDto.setList(showSalaryAlreadyAdd(saaDto)); // 이미 급여 등록이된 사람 조회한 리스트
		
		List<SalaryDTO> existList = salaryMapper.salaryPayment(saaDto); // 이미 급여 등록이 된 사람을 제외하고 보너스가 존재하는 사람 보너스 종합
		System.out.println(existList);
		saaDto.getList().addAll(existList); // 급여등록 및 보너스 존재하는 사람 리스트
		System.out.println(saaDto.getList());
		List<SalaryDTO> noList = salaryPaymentNoBonus(saaDto); // 위의 리스트에 담긴 사람을 제외한 정보 들고오기
		
		// 합치기
		allList.addAll(existList);
		allList.addAll(noList);
		return allList;
	}
	
	public List<SalaryDTO> salaryPaymentNoBonus(SalaryAlreadyAddDTO saaDto) {
//		System.out.println(salaryMapper.salaryPaymentNoBonus(saaDto));
		return salaryMapper.salaryPaymentNoBonus(saaDto);
	}
	
	public void addSalaryPayment(List<Salary> spList) {
		salaryMapper.addSalaryPayment(spList);
		
	}
	
	public List<SalaryDTO> showSalaryAlreadyAdd(SalaryAlreadyAddDTO saaDto) {
		System.out.println(salaryMapper.showSalaryAlreadyAdd(saaDto));
		return salaryMapper.showSalaryAlreadyAdd(saaDto);
	}
	
	public List<SalEmpDTO> totalSalary(SalEmpDTO se) {
		System.out.println(salaryMapper.totalSalary(se));
		return salaryMapper.totalSalary(se);
	}
	
}
