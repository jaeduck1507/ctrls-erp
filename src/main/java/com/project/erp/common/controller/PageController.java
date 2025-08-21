package com.project.erp.common.controller;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.erp.common.model.vo.User;
import com.project.erp.fm.service.SaleManageService;
import com.project.erp.hrm.model.dto.EmpInfo;
import com.project.erp.hrm.model.dto.LeaveInfo;
import com.project.erp.hrm.model.vo.AttendanceLog;
import com.project.erp.hrm.service.EmployeeInfoService;
import com.project.erp.hrm.service.LeaveInfoService;

import jakarta.servlet.http.HttpSession;

@Controller
public class PageController {
	
	@Autowired
	private EmployeeInfoService employeeInfoService;
	
	@Autowired
	private LeaveInfoService leaveInfoService;
	
	@Autowired
	private SaleManageService saleManageService;
	
	@GetMapping("/")
	public String index(Model model, HttpSession session) {
		Object auth = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		System.out.println(auth.toString().equals("anonymousUser"));
		if(auth.toString().equals("anonymousUser")) return "redirect:/login";
		//User user = (User) auth.getPrincipal();
		User user = (User) auth;
		EmpInfo empInfo = new EmpInfo();
		empInfo.setEmpNo(user.getEmpNo());
		System.out.println(employeeInfoService.infoShowOne(empInfo));
		model.addAttribute("user",employeeInfoService.infoShowOne(empInfo));
		model.addAttribute("component","../common/mypage.jsp");
		return "common/layout";
	}
	
	@GetMapping("/login")
	public String login() {
		return "common/login";
	}
	
	@GetMapping("/register") 
	public String register() {
		return "common/register";
	}
	
	@GetMapping("/mypage")
	public String mypage(Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) auth.getPrincipal();
		EmpInfo empInfo = new EmpInfo();
		empInfo.setEmpNo(user.getEmpNo());
		System.out.println(employeeInfoService.infoShowOne(empInfo));
		model.addAttribute("user",employeeInfoService.infoShowOne(empInfo));
		model.addAttribute("component","../common/mypage.jsp");
		return "common/layout";
		
	}
	
	@GetMapping("/findId")
	public String findId() {
		return "common/findId";
	};
	
	@GetMapping("/myLeavePage")
	public String myLeaveAdd(Model model, LeaveInfo li) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) auth.getPrincipal();
		EmpInfo empInfo = new EmpInfo();
		empInfo.setEmpNo(user.getEmpNo());
		model.addAttribute("user",employeeInfoService.infoShowOne(empInfo));
		model.addAttribute("leaveInfo", leaveInfoService.leaveInfo(li));
		model.addAttribute("leaveDays", leaveInfoService.leaveDays(li));
		model.addAttribute("component","../common/myLeavePage.jsp");
		return "common/layout";
	}
	
	@GetMapping("/myLeaveView")
	public String myLeaveView(Model model, LeaveInfo li) {
//		System.out.println(li);
		model.addAttribute("leaveInfoList", leaveInfoService.leaveInfoView(li));	
		model.addAttribute("component","../common/myLeaveView.jsp");
		return "common/layout";
	}
	@GetMapping("/myLeaveUpdate")
	public String myLeaveUpdate(LeaveInfo li) {
		leaveInfoService.leaveUpdate(li);
		return "common/myLeavePage";
	}
	
	@GetMapping("/myLeaveDelete")
	public String myLeaveDelete(int leaveId) {
		leaveInfoService.leaveDelete(leaveId);
		return "redirect:/myLeavePage";
	}
	
//	@GetMapping("/layout2")
//	public String layout2() {
//		
//		return "common/layout2";
//	}
	@GetMapping("/modifyMyInfo")
	public String modifyMyInfo(Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) auth.getPrincipal();
		EmpInfo empInfo = new EmpInfo();
		empInfo.setEmpNo(user.getEmpNo());
		model.addAttribute("user",employeeInfoService.infoShowOne(empInfo));
		model.addAttribute("component","../common/modifyMyInfo.jsp");
		return "common/layout";
	}
	
	@GetMapping("/myAttendance")
	public String myAttendance(Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) auth.getPrincipal();
		model.addAttribute("user",user);
		model.addAttribute("component","../common/myAttendance.jsp");
		return "common/layout";
	}
	
	// 모달창 테스트용
	@GetMapping("/modalTest")
	public String modalTest(Model model) {
		model.addAttribute("salesChart", saleManageService.salesChart());
		System.out.println(saleManageService.salesChart());
		model.addAttribute("component","../common/modalTest.jsp");
		return "common/layout";
	}
	
}
