package com.project.erp.common.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.erp.common.model.vo.User;
import com.project.erp.hrm.model.dto.EmpInfo;
import com.project.erp.hrm.service.EmployeeInfoService;

import jakarta.servlet.http.HttpSession;

@Controller
public class PageController {
	
	@Autowired
	private EmployeeInfoService employeeInfoService;
	
	@GetMapping("/")
	public String index(Model model, HttpSession session) {
		
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
		
		model.addAttribute("user",user);
		return "common/mypage";
		
	}
}
