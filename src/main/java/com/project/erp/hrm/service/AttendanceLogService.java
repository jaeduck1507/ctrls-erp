package com.project.erp.hrm.service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.hrm.mapper.AttendanceLogMapper;
import com.project.erp.hrm.model.dto.attendanceMonth;
import com.project.erp.hrm.model.vo.AttendanceLog;

@Service
public class AttendanceLogService {

	@Autowired
	private AttendanceLogMapper attendanceLogMapper; 
	
	public void startWork(AttendanceLog al) {
		attendanceLogMapper.startWork(al);
	}
	
	public void finishWork(AttendanceLog al) {
		attendanceLogMapper.finishWork(al);
	}
	public List<AttendanceLog> showAttendance(attendanceMonth am) {
		List<AttendanceLog> alList = attendanceLogMapper.showAttendance(am);
		List<AttendanceLog> list = new ArrayList<AttendanceLog>();
		YearMonth ym = YearMonth.parse(am.getYearMonth());
		LocalTime checkInStd = LocalTime.parse("09:00");
		LocalTime checkOutStd = LocalTime.parse("18:00");
		int lastDate =ym.lengthOfMonth();
		int count = 0; // 리스트 번호대로
		for(int i =1; i<=lastDate; i++) {
			LocalDate date = ym.atDay(i);
			AttendanceLog al = alList.get(count);
			if(al.getStatus() != null && al.getStatus().equals("휴가")) { // 휴가 일때
				list.add(al);
				count++;
				continue;
			}
			if(date.getDayOfWeek() ==DayOfWeek.SATURDAY || date.getDayOfWeek() == DayOfWeek.SUNDAY) continue; // 휴일일때 스킵
			if(!date.equals(al.getWorkDate())) { // 출근을 찍지 않아 누락되어있을때 결근 하나 추가하고  count++ 안하고 넘김
				AttendanceLog dismatchAl = new AttendanceLog();
				dismatchAl.setEmpNo(al.getEmpNo());
				dismatchAl.setWorkDate(date);
				dismatchAl.setStatus("결근");
				list.add(dismatchAl);
				continue;
			}
			al.setStatus("출근"); // 일단 출근으로 변경
			
			// 만약 출근시간이나 퇴근시간이 null이 나오면 isAfter,isBefore에서 에러발생하므로 null 먼저 처리하기
			if(al.getCheckIn() == null) { // 출근 누락 -> 결근
				al.setStatus("결근");
				list.add(al);
				count++;
				continue;
			}
			if(al.getCheckOut() == null) { // 퇴근 누락 -> 결근
				al.setStatus("결근");
				list.add(al);
				count++;
				continue;
			}
			if(al.getCheckIn().isAfter(checkInStd)) { // 출근시간이 출근기준시각보다 후인 경우 지각
				al.setStatus("지각");
			}
			if(al.getCheckOut().isBefore(checkOutStd)) { // 퇴근 시간이 퇴근기준시각보다 전인 경우 조퇴 (우선 순위 조퇴 > 지각)
				al.setStatus("조퇴");
			}
			list.add(al); // 출근이나 지각,조퇴시에 추가
			count++;
			
		}
		for(AttendanceLog a : list) {
			System.out.println(a);
		}
		return list;
	}
}
