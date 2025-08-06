package com.project.erp.fm.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.fm.mapper.SalaryMapper;
import com.project.erp.fm.model.dto.SalEmpDTO;
import com.project.erp.fm.model.dto.SalaryAlreadyAddDTO;
import com.project.erp.fm.model.dto.SalaryDTO;
import com.project.erp.fm.model.vo.Salary;

@Service
public class SalaryService implements SalaryMapper {

	@Autowired
	private SalaryMapper mapper;

	@Override
	public List<SalEmpDTO> showSalary(SalEmpDTO se) {
		return mapper.showSalary(se);
	}

	@Override
	public List<SalaryDTO> salaryPayment(SalaryAlreadyAddDTO saaDto) {
		List<SalaryDTO> allList = new ArrayList<SalaryDTO>();
		saaDto.setList(showSalaryAlreadyAdd(saaDto)); // 이미 급여 등록이된 사람 조회한 리스트
		
		List<SalaryDTO> existList = mapper.salaryPayment(saaDto); // 이미 급여 등록이 된 사람을 제외하고 보너스가 존재하는 사람 보너스 종합
		saaDto.getList().addAll(existList); // 급여등록 및 보너스 존재하는 사람 리스트
		List<SalaryDTO> noList = salaryPaymentNoBonus(saaDto.getList()); // 위의 리스트에 담긴 사람을 제외한 정보 들고오기
		
		// 합치기
		allList.addAll(existList);
		allList.addAll(noList);
		return allList;
	}

	@Override
	public List<SalaryDTO> salaryPaymentNoBonus(List<SalaryDTO> existList) {
		System.out.println(mapper.salaryPaymentNoBonus(existList));
		return mapper.salaryPaymentNoBonus(existList);
	}

	@Override
	public void addSalaryPayment(List<Salary> spList) {
		mapper.addSalaryPayment(spList);
		
	}

	@Override
	public List<SalaryDTO> showSalaryAlreadyAdd(SalaryAlreadyAddDTO saaDto) {
		System.out.println(mapper.showSalaryAlreadyAdd(saaDto));
		return mapper.showSalaryAlreadyAdd(saaDto);
	}

	

}
