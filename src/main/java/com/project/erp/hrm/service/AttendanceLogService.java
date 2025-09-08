package com.project.erp.hrm.service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import com.project.erp.hrm.mapper.AttendanceLogMapper;
import com.project.erp.hrm.model.dto.AttendanceStatsDTO;
import com.project.erp.hrm.model.dto.EmpInfo;
import com.project.erp.hrm.model.dto.attendanceMonth;
import com.project.erp.hrm.model.vo.AttendanceLog;

@Service
public class AttendanceLogService {

	@Autowired
	private AttendanceLogMapper attendanceLogMapper;

	@Autowired
	private EmployeeInfoService employeeInfoService;

	public void startWork(AttendanceLog al) {
		attendanceLogMapper.startWork(al);
	}

	public void finishWork(AttendanceLog al) {
		attendanceLogMapper.finishWork(al);
	}

	public List<AttendanceLog> showAttendance(attendanceMonth am) {
		EmpInfo ei = new EmpInfo();
		ei.setEmpNo(am.getEmpNo());
		ei = employeeInfoService.infoShowOne(ei);

		List<AttendanceLog> alList = attendanceLogMapper.showAttendance(am);
		List<AttendanceLog> list = new ArrayList<AttendanceLog>();
		YearMonth ym = YearMonth.parse(am.getYearMonth());
		LocalTime checkInStd = LocalTime.parse("09:00");
		LocalTime checkOutStd = LocalTime.parse("18:00");
		int lastDate = ym.lengthOfMonth();
		int count = 0;
		LocalDate today = LocalDate.now();

		if (alList.size() == 0) {
			AttendanceLog dummyLog = new AttendanceLog();
			dummyLog.setEmpNo(am.getEmpNo());
			alList.add(dummyLog);
		}

		for (int i = 1; i <= lastDate; i++) {
			if (ym.getYear() > today.getYear())
				break;
			if (ym.getYear() == today.getYear() && ym.getMonthValue() > today.getMonthValue())
				break;
			if (ym.getYear() == today.getYear() && ym.getMonthValue() == today.getMonthValue()
					&& today.getDayOfMonth() < i)
				break;

			if (ei.getQuitDate() != null) {
				if (ym.getYear() > ei.getQuitDate().getYear())
					break;
				if (ym.getYear() == ei.getQuitDate().getYear() && ym.getMonthValue() > ei.getQuitDate().getMonthValue())
					break;
				if (ym.getYear() == ei.getQuitDate().getYear() && ym.getMonthValue() == ei.getQuitDate().getMonthValue()
						&& ei.getQuitDate().getDayOfMonth() < i)
					break;
			}

			LocalDate date = ym.atDay(i);
			AttendanceLog al = new AttendanceLog();

			try {
				al = alList.get(count);
			} catch (IndexOutOfBoundsException e) {
				AttendanceLog dummyLog = new AttendanceLog();
				dummyLog.setEmpNo(am.getEmpNo());
				alList.add(dummyLog);
				al = alList.get(count);
			}

			if (date.getDayOfWeek() == DayOfWeek.SATURDAY || date.getDayOfWeek() == DayOfWeek.SUNDAY)
				continue;

			if (ym.getYear() < ei.getHireDate().getYear()) {
				continue;
			}
			if (ym.getYear() == ei.getHireDate().getYear() && ym.getMonthValue() < ei.getHireDate().getMonthValue()) {
				continue;
			}
			if (ym.getYear() == ei.getHireDate().getYear() && ym.getMonthValue() == ei.getHireDate().getMonthValue()
					&& ei.getHireDate().getDayOfMonth() > i) {
				continue;
			}

			if (!date.equals(al.getWorkDate())) { // 출근을 찍지 않아 누락되어있을때 결근 하나 추가하고 count++ 안하고 넘김
				AttendanceLog dismatchAl = new AttendanceLog();
				dismatchAl.setEmpNo(al.getEmpNo());
				dismatchAl.setWorkDate(date);
				dismatchAl.setStatus("결근");
				list.add(dismatchAl);
				continue;
			}

			if (al.getStatus() != null && al.getStatus().equals("휴가")) {
				list.add(al);
				count++;
				continue;
			}

			al.setStatus("출근");

			if (al.getCheckIn() == null) {
				al.setStatus("결근");
				list.add(al);
				count++;
				continue;
			}
			if (al.getCheckOut() == null) {
				al.setStatus("결근");
				list.add(al);
				count++;
				continue;
			}
			if (al.getCheckIn().isAfter(checkInStd)) {
				al.setStatus("지각");
			}
			if (al.getCheckOut().isBefore(checkOutStd)) {
				al.setStatus("조퇴");
			}
			list.add(al);
			count++;

		}

		return list;
	}

	public AttendanceStatsDTO attendanceStats(attendanceMonth am) {
		List<AttendanceLog> list = showAttendance(am);
		YearMonth ym = YearMonth.parse(am.getYearMonth());

		AttendanceStatsDTO asDto = new AttendanceStatsDTO();
		asDto.setMonth(ym.getMonthValue());
		asDto.setTotalCount(list.size());
		for (AttendanceLog al : list) {
			switch (al.getStatus()) {
			case "출근":
				asDto.setWorkCount(asDto.getWorkCount() + 1);
				break;
			case "지각":
				asDto.setLateCount(asDto.getLateCount() + 1);
				break;
			case "조퇴":
				asDto.setLeaveEarlyCount(asDto.getLeaveEarlyCount() + 1);
				break;
			case "휴가":
				asDto.setLeaveCount(asDto.getLeaveCount() + 1);
				break;
			case "결근":
				asDto.setAbsenceCount(asDto.getAbsenceCount() + 1);
				break;
			default:
				break;
			}
		}
		return asDto;
	}

	public AttendanceLog showAttendanceOneAtToday(AttendanceLog al) {
		return attendanceLogMapper.showAttendanceOneAtToday(al);

	}

	public void setAttendance(AttendanceLog al) {
		al.setCheckIn(LocalTime.parse("09:00"));
		al.setCheckOut(LocalTime.parse("18:00"));
		if (showAttendanceOneAtToday(al) == null) {
			attendanceLogMapper.setAttendanceNotExist(al);
		} else {
			attendanceLogMapper.setAttendanceExist(al);
		}
	}

}
