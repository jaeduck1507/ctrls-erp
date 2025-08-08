package com.project.erp.common.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.common.model.vo.User;
import com.project.erp.common.service.UserService;
import com.project.erp.hrm.model.dto.EmpInfo;
import com.project.erp.hrm.model.dto.LeaveInfo;
import com.project.erp.hrm.model.vo.AttendanceLog;
import com.project.erp.hrm.service.AttendanceLogService;
import com.project.erp.hrm.service.LeaveInfoService;

@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private AttendanceLogService attendanceLogService;
	
	@Autowired
	private LeaveInfoService leaveInfoService;
	
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
	@PostMapping("/findId")
	public String findId(int empNo) {
		return userService.findId(empNo);
	}

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
	
	@ResponseBody
	@PostMapping("/myLeavePage")
	public String myLeavePage(@RequestBody List<LeaveInfo> liList) {
//		System.out.println(liList.get(0).getEmpNo());
		leaveInfoService.leaveAdd(liList);
		return "redirect:/myLeavePage";
	}
	
	@PostMapping("/myLeaveUpdate")
	public String myLeaveUpdate(LeaveInfo li) {
		leaveInfoService.leaveUpdate(li);
		return "redirect:/myLeavePage";
	}
}
