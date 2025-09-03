package com.project.erp.common.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.common.model.vo.User;
import com.project.erp.common.service.UserService;
import com.project.erp.hrm.model.dto.EmpInfo;
import com.project.erp.hrm.model.dto.LeaveInfo;
import com.project.erp.hrm.model.vo.AttendanceLog;
import com.project.erp.hrm.service.AttendanceLogService;
import com.project.erp.hrm.service.LeaveInfoService;

import ch.qos.logback.core.model.Model;

@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private AttendanceLogService attendanceLogService;
	
	@Autowired
	private LeaveInfoService leaveInfoService;
	
	@ResponseBody
	@PostMapping("/noCheck")
	public int noCheck(int empNo) {
		return userService.noCheck(empNo);
	}
	
	@PostMapping("/register")
	public String register(User vo) {
		userService.register(vo);
		return"redirect:/login";
	}
	
	@ResponseBody
	@PostMapping("/findId")
	public String findId(int empNo) {
		return userService.findId(empNo);
	}

	@ResponseBody
	@PostMapping("/showAttendanceOneAtToday")
	public AttendanceLog showAttendanceOneAtToday() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) auth.getPrincipal();
		AttendanceLog al = new AttendanceLog();
		al.setEmpNo(user.getEmpNo());
		al.setWorkDate(LocalDate.now());
		return attendanceLogService.showAttendanceOneAtToday(al);
	}
	
	@ResponseBody
	@PostMapping("/myLeaveAdd")
	public String myLeavePage(@RequestBody List<LeaveInfo> liList) {
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
	
	@PostMapping("/myLeaveUpdate")
	public String myLeaveUpdate(LeaveInfo li) {
		leaveInfoService.leaveUpdate(li);
		return "redirect:/myLeavePage";
	}
	
	@ResponseBody
	@PostMapping("/resetMyPwd")
	public boolean resetMyPwd(@RequestBody User vo) {
		userService.resetMyPwd(vo);
		return true;
	}
	
	@ResponseBody
	@PostMapping("/resetPwd")
	public void resetPwd(User vo) {
		userService.resetPwd(vo);
	}
	
	@ResponseBody
	@PostMapping("/idCheck")
	public int idCheck(User vo) {
		return userService.idCheck(vo);
	}

}
