package com.project.erp.hrm.mapper;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.hrm.model.dto.LeaveInfo;
import com.project.erp.hrm.model.dto.LeaveInfoPagingDTO;


@Mapper
public interface LeaveInfoMapper {

	// 휴가 조회
	List<LeaveInfo> leaveInfo(LeaveInfo li);
	// 휴가 신청
	void leaveAdd(List<LeaveInfo> liList);
	// 휴가 상태
	List<LeaveInfo> leaveStatus(Paging paging);
	// 휴가 상태 변경(대기-> 승인 or 반려)
	void leaveStatusUpdate(LeaveInfo leaveinfo);
	// 누적 휴가 일수 중 사원 정보 조회
	List<LeaveInfo> leaveDays(LeaveInfo leaveInfo);
	// 누적 휴가 일수
	List<LeaveInfo> leaveTotalDays(LeaveInfo leaveInfo);
	// 휴가 수정을 위한 조회
	List<LeaveInfo> leaveInfoView(LeaveInfo li);
	// 휴가 수정
	void leaveUpdate(LeaveInfo li);
	// 휴가 삭제
	void leaveDelete(int leaveId);

	// 마이페이지 처리상태에 따른 휴가 조회
	List<LeaveInfo> leaveInfoPage(LeaveInfoPagingDTO paging);
	int totalLeaveInfo();
	int totalMyLeaveInfo(LeaveInfoPagingDTO paging);
	
	// 휴가 중복 체크 
	int checkApprove(LeaveInfo li);
	

}
