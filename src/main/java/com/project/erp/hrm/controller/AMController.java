package com.project.erp.hrm.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
}
