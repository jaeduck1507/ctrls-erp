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
		LocalDate today = LocalDate.now();
		if(alList.size() ==0) {
			AttendanceLog dummyLog= new AttendanceLog();
			dummyLog.setEmpNo(am.getEmpNo());
			alList.add(dummyLog);
		}
		for(int i =1; i<=lastDate; i++) {
			if(ym.getYear() > today.getYear()) break;
			if( ym.getYear() == today.getYear()&& ym.getMonthValue() > today.getMonthValue()) break;
			if(ym.getYear() == today.getYear()&& ym.getMonthValue() == today.getMonthValue() && today.getDayOfMonth() < i) break;
			LocalDate date = ym.atDay(i);
			AttendanceLog al = new AttendanceLog();
			
			
			try { // 카운트가 리스트 크기 넘을때 더미데이터 생성으로 오류 차단
				al = alList.get(count);
			} catch(IndexOutOfBoundsException e) {
				AttendanceLog dummyLog= new AttendanceLog();
				dummyLog.setEmpNo(am.getEmpNo());
				alList.add(dummyLog);
				al = alList.get(count);
			} 
			
			if(al.getStatus() != null && al.getStatus().equals("휴가")) { // 휴가 일때
				list.add(al);
				System.out.println("휴휴휴휴흏휴휴휴휴가가가각가가가가");
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
	
		return list;
	}
	
	public AttendanceStatsDTO attendanceStats(attendanceMonth am) {
		List<AttendanceLog> list = showAttendance(am);
		YearMonth ym = YearMonth.parse(am.getYearMonth());
		
		AttendanceStatsDTO asDto = new AttendanceStatsDTO();
		asDto.setMonth(ym.getMonthValue());
		asDto.setTotalCount(list.size());
		for(AttendanceLog al : list) {
			switch(al.getStatus()) {
			case "출근":
				asDto.setWorkCount(asDto.getWorkCount()+1);
				break;
			case "지각":
				asDto.setLateCount(asDto.getLateCount()+1);
				break;
			case "조퇴":
				asDto.setLeaveEarlyCount(asDto.getLeaveEarlyCount()+1);
				break;
			case "휴가":
				asDto.setLeaveCount(asDto.getLeaveCount()+1);
				break;
			case "결근":
				asDto.setAbsenceCount(asDto.getAbsenceCount()+1);
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
		System.out.println(showAttendanceOneAtToday(al));
		al.setCheckIn(LocalTime.parse("09:00"));
		al.setCheckOut(LocalTime.parse("18:00"));
		if(showAttendanceOneAtToday(al) == null) {
			attendanceLogMapper.setAttendanceNotExist(al);
		} else {
			attendanceLogMapper.setAttendanceExist(al);
		}
	}
	
	
}
