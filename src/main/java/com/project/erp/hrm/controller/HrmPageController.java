package com.project.erp.hrm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.hrm.service.DepartmentService;
import com.project.erp.hrm.service.JobPositionService;

@RequestMapping("/hrm")
@Controller
public class HrmPageController {

	
	
	@GetMapping("/empInfo")
	public String empInfo() {
		
		return "component/hrm/empInfo";
	}
	
	
}
