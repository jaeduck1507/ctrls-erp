package com.project.erp.common.controller;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.common.model.vo.User;
import com.project.erp.common.service.UserService;
import com.project.erp.hrm.model.dto.EmpInfo;
import com.project.erp.hrm.model.vo.AttendanceLog;
import com.project.erp.hrm.service.AttendanceLogService;

@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private AttendanceLogService attendanceLogService;
	
	@ResponseBody
	@PostMapping("/noCheck")
	public int noCheck(int empNo) {
		System.out.println(userService.noCheck(empNo));
		return userService.noCheck(empNo);
	}
	
	@PostMapping("/register")
	public String register(User vo) {
		userService.register(vo);
		return"redirect:/register";
	}
	
	@ResponseBody
	@PostMapping("/showAttendanceOneAtToday")
	public AttendanceLog showAttendanceOneAtToday() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) auth.getPrincipal();
		AttendanceLog al = new AttendanceLog();
		al.setEmpNo(user.getEmpNo());
		al.setWorkDate(LocalDate.now());
		System.out.println(attendanceLogService.showAttendanceOneAtToday(al));
		return attendanceLogService.showAttendanceOneAtToday(al);
	}
}
