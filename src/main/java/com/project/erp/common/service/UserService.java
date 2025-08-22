package com.project.erp.common.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.project.erp.common.mapper.UserMapper;
import com.project.erp.common.model.vo.User;
import com.project.erp.hrm.model.dto.EmpInfo;
import com.project.erp.hrm.service.EmployeeInfoService;

@Service
public class UserService implements UserDetailsService{
	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private PasswordEncoder bcpe;
	
	@Autowired
	private EmployeeInfoService employeeInfoService; 
	
	public void register(User vo) {
		System.out.println(vo);
		vo.setPassword(bcpe.encode(vo.getPassword()));
		EmpInfo empInfo = new EmpInfo();
		empInfo.setEmpNo(vo.getEmpNo());
		int deptNo = employeeInfoService.infoShowOne(empInfo).getDeptNo();
		
		if(vo.getUsername().equals("admin")) {
			vo.setRole("ROLE_ADMIN");
			System.out.println(vo);
			userMapper.register(vo);
			return;
		}
		
		switch(deptNo) {
		case 1:
			vo.setRole("ROLE_MANAGEMENT");
			break;
		case 2:
			vo.setRole("ROLE_HRM");
			break;
		case 3:
			vo.setRole("ROLE_QAM");
			break;
		case 4:
			vo.setRole("ROLE_FM");
			break;
		case 5:
			vo.setRole("ROLE_HEADQUARTER");
			break;
		case 6:
			vo.setRole("ROLE_SALE");
			break;
		case 7:
			vo.setRole("ROLE_SALE");
			break;
		case 8:
			vo.setRole("ROLE_SALE");
			break;
		}
		System.out.println(vo);
		userMapper.register(vo);
		
		
	}

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User user = userMapper.login(username);
		System.out.println("로그인" + user);
		return user;
	}
	
	public int noCheck(int empNo) {
		return userMapper.noCheck(empNo);
	}
	
	public String findId(int empNo) {
		System.out.println("service");
		return userMapper.findId(empNo);
	}
	
	public void resetMyPwd(User vo) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) auth.getPrincipal();
		
		vo.setPassword(bcpe.encode(vo.getPassword()));
		vo.setUsername(user.getUsername());
		System.out.println("재설정된 비밀번호 : " + vo);
		userMapper.resetMyPwd(vo);
	}
	
	public int idCheck(User vo) {
		return 0;
	}
	

}
