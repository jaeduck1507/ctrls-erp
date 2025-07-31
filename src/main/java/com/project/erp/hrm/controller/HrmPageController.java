package com.project.erp.hrm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.hrm.model.dto.EmpInfo;
import com.project.erp.hrm.service.DepartmentService;
import com.project.erp.hrm.service.EmployeeInfoService;
import com.project.erp.hrm.service.JobPositionService;
import com.project.erp.hrm.service.LeaveInfoService;

@RequestMapping("/hrm")
@Controller
public class HrmPageController {

    private final EOMController EOMController;

	@Autowired
	private EmployeeInfoService employeeInfoservice;
	
	@Autowired
	private DepartmentService departmentService;
	
	@Autowired
	private JobPositionService jobPositionService;
	
	@Autowired
	private LeaveInfoService leaveInfoService;

    HrmPageController(EOMController EOMController) {
        this.EOMController = EOMController;
    } 
	
	@GetMapping("/empInfo")
	public String empInfo() {
		
		return "component/hrm/empInfo";
	}
	
	@GetMapping("/empAdd")
	public String empAdd(Model model) {
		model.addAttribute("department", departmentService.showDept());
		model.addAttribute("jobPosition", jobPositionService.showJob());
		return "component/hrm/empAdd";
	}
	
	@GetMapping("/quitShow")
	public String quitter() {
		return "component/hrm/quitShow";
	}
	
	@GetMapping("/leaveInfo")
	public String leaveInfo() {
		return "component/hrm/leaveInfo";
	}
	@GetMapping("/empEval")
	public String empEval(Model model) {
		model.addAttribute("empInfo", employeeInfoservice.infoShow(new EmpInfo()));
		return "component/hrm/empEval";
	}
	
	@GetMapping("/leaveStatus")
	public String leaveStatus(Model model) {
		model.addAttribute("leaveInfoList",leaveInfoService.leaveStatus() );
		return "component/hrm/leaveStatus"; 
	}
	
	@GetMapping("/attendanceRecord")
	public String attendaceRecord(Model model) {
		model.addAttribute("empInfo", employeeInfoservice.infoShow(new EmpInfo()));
		return "component/hrm/attendanceRecord";
	}
	
	@GetMapping("/showAttendance")
	public String showAttendance(Model model) {
		model.addAttribute("empInfo", employeeInfoservice.infoShow(new EmpInfo()));
		return "component/hrm/showAttendance";
	}
	@GetMapping("/leaveAdd")
	public String leaveAdd() {
		return "component/hrm/leaveAdd";
	}
	
	@GetMapping("/leaveDays")
	public String leaveDays() {
		return "component/hrm/leaveDays";
	}
	
	@GetMapping("/leaveUpdate")
	public String leaveUpdate() {
		return "component/hrm/leaveUpdate";
	}
	
	@GetMapping("/empModify")
	public String empModify(Model model,EmpInfo ei) {
		model.addAttribute("empInfo", employeeInfoservice.infoShowOne(ei));
		return "component/hrm/empModify";
	}
	
	@GetMapping("/attendanceStats")
	public String attendanceStats(Model model) {
		model.addAttribute("empInfo", employeeInfoservice.infoShow(new EmpInfo()));
		return "component/hrm/attendanceStats";
	}

}

