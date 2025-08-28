package com.project.erp.hrm.controller;


import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.common.model.vo.User;
import com.project.erp.hrm.model.dto.AttendanceStatsDTO;
import com.project.erp.hrm.model.dto.attendanceMonth;
import com.project.erp.hrm.model.vo.AttendanceLog;
import com.project.erp.hrm.service.AttendanceLogService;

@Controller
public class AMController {

	
	@Autowired
	private AttendanceLogService attendanceLogService;
	
	@ResponseBody
	@PostMapping("/startWork")
	public void startWork(@RequestBody AttendanceLog al) {
		System.out.println(al);
		attendanceLogService.startWork(al);
		
	}
	
	@ResponseBody
	@PostMapping("/finishWork")
	public void finishWork(@RequestBody AttendanceLog al) {
		attendanceLogService.finishWork(al);
	}
	
	@ResponseBody
	@PostMapping("/showAttendance")
	public List<AttendanceLog> showAttendance(@RequestBody attendanceMonth am) {
		return attendanceLogService.showAttendance(am);
	}
	
	@ResponseBody
	@PostMapping("/attendanceStats")
	public AttendanceStatsDTO attendanceStats(@RequestBody attendanceMonth am) {
		
		return attendanceLogService.attendanceStats(am);
	}
	
	@ResponseBody
	@PostMapping("/startWorking")
	public boolean startWorking(@RequestBody AttendanceLog al) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) auth.getPrincipal();
		al.setEmpNo(user.getEmpNo());
		al.setWorkDate(LocalDate.now());
		attendanceLogService.startWork(al);
		return true;
		
	}
	
	@ResponseBody
	@PostMapping("/finishWorking")
	public boolean finishWorking(@RequestBody AttendanceLog al) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) auth.getPrincipal();
		al.setEmpNo(user.getEmpNo());
		al.setWorkDate(LocalDate.now());
		attendanceLogService.finishWork(al);
		return true;
	}
	
	@ResponseBody
	@PostMapping("/showMyAttendance")
	public List<AttendanceLog> showMyAttendance(@RequestBody attendanceMonth am) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) auth.getPrincipal();
		am.setEmpNo(user.getEmpNo());
		return attendanceLogService.showAttendance(am);
	}
	
	@ResponseBody
	@PostMapping("/setAttendance")
	public boolean setAttendance(@RequestBody AttendanceLog al) {
		System.out.println(al);
		attendanceLogService.setAttendance(al);
		return true;
	}
}
