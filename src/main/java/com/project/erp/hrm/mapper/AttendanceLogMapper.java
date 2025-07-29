package com.project.erp.hrm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.hrm.model.dto.attendanceMonth;
import com.project.erp.hrm.model.vo.AttendanceLog;

@Mapper
public interface AttendanceLogMapper {
	void startWork(AttendanceLog al);
	void finishWork(AttendanceLog al);
	List<AttendanceLog> showAttendance(attendanceMonth am);
}
