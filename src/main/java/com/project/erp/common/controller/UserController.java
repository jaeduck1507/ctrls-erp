package com.project.erp.common.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.common.model.vo.User;
import com.project.erp.common.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	
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
}
