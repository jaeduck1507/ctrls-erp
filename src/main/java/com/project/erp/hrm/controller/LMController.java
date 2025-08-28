package com.project.erp.hrm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
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
	public String leaveAdd(@RequestBody List<LeaveInfo> liList) {
		// 첫 번째 휴가 정보 가져오기 (여러 개 신청 가능하면 반복 처리 필요)
	    LeaveInfo leave = liList.get(0);
	    int empNo =leave.getEmpNo();
	    // 남은 휴가일수 체크
	    if(!leaveInfoService.canApplyLeave(empNo, leave)) {
	    	return "exceed";
	    }
	    // 겹치는 휴가 있는지 체크
	    boolean check = leaveInfoService.checkApprove(leave);
	    
	    if(check) {
	        // 겹치면 신청 불가 알림
	        return "overlap"; // JS에서 이 문자열로 처리
	    }
	    
	    // 겹치지 않으면 신청 진행
	    leaveInfoService.leaveAdd(liList);
	    
	    return "success"; // JS에서 이 문자열로 처리
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
		//System.out.println("시작 : " + leaveinfo.getStartDate() + "끝 : " + leaveinfo.getEndDate());
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
