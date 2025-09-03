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
import com.project.erp.common.service.UserService;
import com.project.erp.hrm.model.dto.EmpAddDTO;
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
	
	@Autowired
	private UserService userService;
	
	@ResponseBody
	@PostMapping("/infoShow")
	public EmpInfoPagingDTO infoShow(EmpInfo ei, Paging hrmPagingDTO) {
		return employeeInfoservice.pagingInfoShow(ei,hrmPagingDTO);
	}
	
	@ResponseBody
	@GetMapping("/showDept")
	public List<Department> showDept() {
		return departmentService.showDept();
	}
	@ResponseBody
	@GetMapping("/showJob")
	public List<JobPosition> showJob() {
		return jobPositionService.showJob();
	}
	
	@ResponseBody
	@PostMapping("/empAdd")
	public void empAdd(EmpAddDTO eiList) {
		employeeInfoservice.empAdd(eiList);
	}
	
	@ResponseBody
	@PostMapping("/empModify")
	public boolean empModify(@RequestBody EmpInfo ei) {
		employeeInfoservice.empModify(ei);
		return true;
	}
	
	@PostMapping("/modifyMyInfo")
	public String modifyMyInfo(EmpInfo ei) {
		System.out.println(ei);
		employeeInfoservice.empModify(ei);
		
		return "redirect:/mypage";
	}
	
	@ResponseBody
	@PostMapping("/modifyJobDept")
	public boolean modifyJobDept(@RequestBody EmpInfo ei) {
		employeeInfoservice.modifyJobDept(ei);
		userService.updatePermissions(ei);
		return true;
	}
	
	@ResponseBody
	@PostMapping("/modifySalary")
	public boolean modifySalary(@RequestBody EmpInfo ei) {
		employeeInfoservice.modifySalary(ei);
		return true;
	}
	
	@ResponseBody
	@PostMapping("/modifyImg")
	public boolean modifyImg(EmpInfo ei) {
		employeeInfoservice.modifyImg(ei);
		return true;
	}
	
	@ResponseBody
	@PostMapping("/deleteImg")
	public boolean deleteImg(EmpInfo ei) {
		employeeInfoservice.deleteImg(ei);
		return true;
	}
}
