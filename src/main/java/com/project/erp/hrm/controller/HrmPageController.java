package com.project.erp.hrm.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.common.model.vo.User;
import com.project.erp.hrm.model.dto.EmpInfo;
import com.project.erp.hrm.model.dto.LeaveInfo;
import com.project.erp.hrm.model.vo.Department;
import com.project.erp.hrm.service.DepartmentService;
import com.project.erp.hrm.service.EmployeeInfoService;
import com.project.erp.hrm.service.JobPositionService;
import com.project.erp.hrm.service.LeaveInfoService;
import com.project.erp.hrm.service.PerformanceReviewService;

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
	
	@Autowired
	private PerformanceReviewService performanceReviewService;

    HrmPageController(EOMController EOMController) {
        this.EOMController = EOMController;
    } 
	
	@GetMapping("/empInfo")
	public String empInfo(Model model) {
		model.addAttribute("component","../component/hrm/empInfo.jsp");
		return "common/layout";
	}
	
	@GetMapping("/empAdd")
	public String empAdd(Model model) {
//		List<Department> saleDept = new ArrayList<>();
//		List<Department> deptList = departmentService.showDept();
//		for(Department d : deptList) {
//			if(d.getDeptName().contains("지점")) saleDept.add(d);
//		}
//		System.out.println(saleDept);
		model.addAttribute("department", departmentService.showDept());
		model.addAttribute("jobPosition", jobPositionService.showJob());
		model.addAttribute("component","../component/hrm/empAdd.jsp");
		return "common/layout";
	}
	
	@GetMapping("/quitShow")
	public String quitter(Model model) {
		model.addAttribute("component","../component/hrm/quitShow.jsp");
		return "common/layout";
	}
	
	@GetMapping("/leaveInfo")
	public String leaveInfo(Model model) {
		model.addAttribute("component","../component/hrm/leaveInfo.jsp");
		return "common/layout";
	}
	@GetMapping("/empEval")
	public String empEval(Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) auth.getPrincipal();
		EmpInfo empinfo = new EmpInfo();
		empinfo.setEmpNo(user.getEmpNo());
		empinfo.setDeptNo(user.getDeptNo());
		performanceReviewService.showEvalEmp(empinfo);
		model.addAttribute("empInfo", performanceReviewService.showEvalEmp(empinfo));
		model.addAttribute("user", user);
		model.addAttribute("component","../component/hrm/empEval.jsp");
		return "common/layout";
	}
	
	@GetMapping("/leaveStatus")
	public String leaveStatus(Model model, Paging paging) {
		//System.out.println("test    " + leaveInfoService.leaveStatus());
		//System.out.println(paging);
		model.addAttribute("paging", paging);
		model.addAttribute("leaveInfoList",leaveInfoService.leaveStatus(paging));
		//model.addAttribute("paging", new Paging(paging.getPage(), leaveInfoService.totalLeaveInfo()));
		model.addAttribute("component","../component/hrm/leaveStatus.jsp");
		return "common/layout";
	}
	
	@GetMapping("/attendanceRecord")
	public String attendaceRecord(Model model) {
		model.addAttribute("empInfo", employeeInfoservice.infoShow(new EmpInfo()));
		model.addAttribute("component","../component/hrm/attendanceRecord.jsp");
		return "common/layout";
	}
	
	@GetMapping("/showAttendance")
	public String showAttendance(Model model) {
		model.addAttribute("empInfo", employeeInfoservice.infoShow(new EmpInfo()));
		model.addAttribute("component","../component/hrm/showAttendance.jsp");
		return "common/layout";
	}
	@GetMapping("/leaveAdd")
	public String leaveAdd(Model model) {
		model.addAttribute("component","../component/hrm/leaveAdd.jsp");
		return "common/layout";
	}
//	common PageController로 이동
//	@GetMapping("/myLeavePage")
//	public String myLeaveAdd(Model model, LeaveInfo li) {
//		model.addAttribute("leaveInfo", leaveInfoService.leaveInfo(li));
//		model.addAttribute("leaveDays", leaveInfoService.leaveDays(li));
//		
//		return "component/hrm/myLeavePage";
//	}
	
	
	
	@GetMapping("/leaveDays")
	public String leaveDays(Model model) {
		model.addAttribute("component","../component/hrm/leaveDays.jsp");
		return "common/layout";
	}
	
	@GetMapping("/leaveView")
	public String leaveView(Model model, LeaveInfo li) {
//		System.out.println(li);
		model.addAttribute("leaveInfoList", leaveInfoService.leaveInfoView(li));
		model.addAttribute("component","../component/hrm/leaveView.jsp");
		return "common/layout";
	}
	
	@GetMapping("/empModify")
	public String empModify(Model model,EmpInfo ei) {
		model.addAttribute("empInfo", employeeInfoservice.infoShowOne(ei));
		model.addAttribute("component","../component/hrm/empModify.jsp");
		return "common/layout";
	}
	@GetMapping("/empInfoDetails")
	public String empInfoDetails(Model model,EmpInfo ei) {
		model.addAttribute("empInfo", employeeInfoservice.infoShowOne(ei));
		model.addAttribute("component","../component/hrm/empInfoDetails.jsp");
		return "common/layout";
	}
	
	@GetMapping("/attendanceStats")
	public String attendanceStats(Model model) {
		model.addAttribute("empInfo", employeeInfoservice.infoShow(new EmpInfo()));
		model.addAttribute("component","../component/hrm/attendanceStats.jsp");
		return "common/layout";
	}
	
	@GetMapping("/leaveDelete")
	public String leaveDelete(int leaveId,Model model) {
		leaveInfoService.leaveDelete(leaveId);
		model.addAttribute("component","../component/hrm/leaveInfo.jsp");
		return "common/layout";
	}
	
	@GetMapping("/leaveUpdate")
	public String leaveUpdate(LeaveInfo li,Model model) {
		leaveInfoService.leaveUpdate(li);
		model.addAttribute("component","../component/hrm/leaveView.jsp");
		return "common/layout";
	}

}

