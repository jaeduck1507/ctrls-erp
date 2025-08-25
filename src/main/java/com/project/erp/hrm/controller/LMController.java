package com.project.erp.hrm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.hrm.model.dto.LeaveInfo;
import com.project.erp.hrm.model.dto.Quitter;
import com.project.erp.hrm.service.LeaveInfoService;
import com.project.erp.hrm.service.QuitterService;

@Controller
public class LMController {

	@Autowired
	private LeaveInfoService leaveInfoService;
	
	@ResponseBody
	@PostMapping("/leaveInfo")
	public List<LeaveInfo> leaveInfo(LeaveInfo li) {
		return leaveInfoService.leaveInfo(li);
	}
	
	@ResponseBody
	@PostMapping("/leaveAdd")
	public boolean leaveAdd(@RequestBody List<LeaveInfo> liList) {
//		System.out.println("Controller");
//		System.out.println(liList);
//		System.out.println("-----------");
//		System.out.println(liList.get(0).getEmpNo());
		leaveInfoService.leaveAdd(liList);
		return true;
	}
//	common UserController로 이동
//	@ResponseBody
//	@PostMapping("/myLeavePage")
//	public String myLeavePage(@RequestBody List<LeaveInfo> liList) {
//		System.out.println(liList.get(0).getEmpNo());
//		leaveInfoService.leaveAdd(liList);
//		return "redirect:/component/hrm/myLeavePage";
//	}
	
	@ResponseBody
	@PostMapping("/leaveStatusUpdate")
	public void leaveStatusUpdate(LeaveInfo leaveinfo) {
//		System.out.println(leaveinfo);
		leaveInfoService.leaveStatusUpdate(leaveinfo);
	}
	
	@ResponseBody
	@PostMapping("/leaveDays")
	public List<LeaveInfo> leaveDays(LeaveInfo leaveInfo) {
//		System.out.println(leaveInfo);
		return leaveInfoService.leaveDays(leaveInfo);
	}
	
	@ResponseBody
	@PostMapping("/leaveTotalDays")
	public List<LeaveInfo> leaveTotalDays(LeaveInfo leaveInfo) {
//		System.out.println(leaveInfo);
		return leaveInfoService.leaveTotalDays(leaveInfo);
	}
	
	@PostMapping("/leaveUpdate")
	public String leaveUpdate(LeaveInfo li, Model model) {
//		System.out.println(li);
		// "component/hrm/leaveView?leaveId="+ li.getLeaveId()
		leaveInfoService.leaveUpdate(li);
		model.addAttribute("component","../component/hrm/leaveInfo.jsp");
		return "common/layout";
	}
	

}
