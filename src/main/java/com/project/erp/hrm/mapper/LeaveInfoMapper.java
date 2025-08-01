package com.project.erp.hrm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.hrm.model.dto.LeaveInfo;

@Mapper
public interface LeaveInfoMapper {

	// 휴가 조회
	List<LeaveInfo> leaveInfo(LeaveInfo li);
	// 휴가 신청
	void leaveAdd(List<LeaveInfo> liList);
	// 휴가 상태
	List<LeaveInfo> leaveStatus();
	// 휴가 상태 변경(대기-> 승인 or 반려)
	void leaveStatusUpdate(LeaveInfo leaveinfo);
	// 누적 휴가 일수 조회
	List<LeaveInfo> leaveDays(LeaveInfo leaveInfo);
	
	List<LeaveInfo> leaveTotalDays(int empNo);
	// 휴가 수정을 위한 조회
	List<LeaveInfo> leaveInfoView(LeaveInfo li);
	// 휴가 수정
	void leaveUpdate(LeaveInfo li);
	// 휴가 삭제
	void leaveDelete(int leaveId);

	
}
