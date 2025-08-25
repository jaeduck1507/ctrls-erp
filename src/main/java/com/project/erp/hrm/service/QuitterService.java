package com.project.erp.hrm.service;

import java.time.LocalDate;
import java.time.Period;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.common.service.UserService;
import com.project.erp.hrm.mapper.QuitterMapper;
import com.project.erp.hrm.model.dto.Quitter;

@Service
public class QuitterService {

	@Autowired
	private QuitterMapper quitterMapper;
	
	@Autowired
	private EmployeeInfoService employeeInfoService;
	
	@Autowired
	private UserService userService;
	
	public List<Quitter> quitShow(Quitter q) {
		return quitterMapper.quitShow(q);
	}
	
	public void empQuit(Quitter q) {
		q.setQuitPayDate(LocalDate.of(q.getQuitDate().getYear(), q.getQuitDate().getMonth().getValue()+1, 15));
		if(Period.between(q.getHireDate(), q.getQuitDate()).getYears() >= 1) {
			q.setQuitPay(q.getSalary()*3);
		}
		System.out.println(q);
		userService.deleteId(q);
		employeeInfoService.updateEmpQuit(q);
		quitterMapper.empQuit(q);
		
//		quitterMapper.empQuit(q);
	}
}
