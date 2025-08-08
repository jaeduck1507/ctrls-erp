package com.project.erp.hrm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.hrm.model.dto.EmpInfo;
import com.project.erp.hrm.model.dto.EmpInfoPagingDTO;
import com.project.erp.hrm.model.vo.Department;
import com.project.erp.hrm.model.vo.EmployeeInfo;
import com.project.erp.hrm.model.vo.JobPosition;
import com.project.erp.hrm.service.DepartmentService;
import com.project.erp.hrm.service.EmployeeInfoService;
import com.project.erp.hrm.service.JobPositionService;

@Controller
public class EIMController {
	
	@Autowired
	private EmployeeInfoService employeeInfoservice;
	
	@Autowired
	private DepartmentService departmentService;
	
	@Autowired
	private JobPositionService jobPositionService;
	
	@ResponseBody
	@PostMapping("/infoShow")
	public EmpInfoPagingDTO infoShow(EmpInfo ei, Paging hrmPagingDTO) {
		System.out.println(hrmPagingDTO);
		return employeeInfoservice.pagingInfoShow(ei,hrmPagingDTO);
	}
	
	@ResponseBody
	@GetMapping("/showDept")
	public List<Department> showDept() {
//		System.out.println(departmentService.showDept().get(0).getDeptName());
		return departmentService.showDept();
	}
	@ResponseBody
	@GetMapping("/showJob")
	public List<JobPosition> showJob() {
//		System.out.println(jobPositionService.showJob().get(0).getJobTitle());
		return jobPositionService.showJob();
	}
	
	@ResponseBody
	@PostMapping("/empAdd")
	public void empAdd(@RequestBody List<EmployeeInfo> eiList) {
//		System.out.println(eiList);
		employeeInfoservice.empAdd(eiList);
	}
	
	@PostMapping("/empModify")
	public String empModify(EmpInfo ei) {
		employeeInfoservice.empModify(ei);
		return "redirect:/hrm/empInfo";
	}
}
