package com.project.erp.hrm.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.hrm.mapper.LeaveInfoMapper;
import com.project.erp.hrm.model.dto.LeaveInfo;
import com.project.erp.hrm.model.dto.LeaveInfoPagingDTO;


@Service
public class LeaveInfoService {

	@Autowired
	private LeaveInfoMapper leaveInfoMapper;
	
	public List<LeaveInfo> leaveInfo(LeaveInfo li) {
		return leaveInfoMapper.leaveInfo(li);
	}
	public void leaveAdd(List<LeaveInfo> liList) {
		//System.out.println("service!");
		//System.out.println(liList);
		//System.out.println("-------------");
		leaveInfoMapper.leaveAdd(liList);
	}
	
	public void leaveStatusUpdate(LeaveInfo leaveinfo) {
		leaveInfoMapper.leaveStatusUpdate(leaveinfo);
		//leaveInfoMapper.attendanceAddLeaveDay(lilist);
		//System.out.println(leaveinfo);
	}
	
	public List<LeaveInfo> leaveDays(LeaveInfo leaveInfo) {
		return leaveInfoMapper.leaveDays(leaveInfo);
		
	}
	
	public List<LeaveInfo> leaveTotalDays(LeaveInfo leaveInfo) {
		return leaveInfoMapper.leaveTotalDays(leaveInfo);
		
	}
	
	public List<LeaveInfo> leaveInfoView(LeaveInfo li){
		return leaveInfoMapper.leaveInfoView(li);
	};
	
	public void leaveUpdate(LeaveInfo li) {
		leaveInfoMapper.leaveUpdate(li);
	}
	
	public void leaveDelete(int leaveId) {
		leaveInfoMapper.leaveDelete(leaveId);
	};
	
	public List<LeaveInfo> leaveStatus(Paging paging) {
		paging.setOffset(paging.getLimit() * (paging.getPage() - 1));
		paging.setTotal(leaveInfoMapper.totalLeaveInfo());
		return leaveInfoMapper.leaveStatus(paging);
	}

	public int totalLeaveInfo() {
		return leaveInfoMapper.totalLeaveInfo();
	}
	// 전체 개수 조회
	public int totalMyLeaveInfo(LeaveInfoPagingDTO paging) {
		return leaveInfoMapper.totalMyLeaveInfo(paging);
	}
	// 페이징 목록 조회
	public List<LeaveInfo> myLeaveInfo(LeaveInfoPagingDTO paging) {
		//paging.setOffset(paging.getLimit() * (paging.getPage() - 1));
		if(paging.getTotal() == 0) {
			paging.setTotal(totalMyLeaveInfo(paging)); // offset/ 페이지 버튼 함게 계산
		}
		return leaveInfoMapper.leaveInfoPage(paging);
	}
	
	// 휴가 중복 체크 
	public boolean checkApprove(LeaveInfo li) {
		int count = leaveInfoMapper.checkApprove(li);
		return count > 0; // 0보다 크면 겹치는 휴가 존재
		
	}
	
	// 직원이 신청하려는 휴가일수가 남은 휴가일수를 초과하는지 체크
	public boolean canApplyLeave(int empNo, LeaveInfo leave) {
	    // 이번 신청 휴가 일수 계산 (종료일 - 시작일 + 1)
	    int requestedDays = (int) java.time.temporal.ChronoUnit.DAYS.between(
	            leave.getStartDate(), leave.getEndDate()) + 1;

	    // 이미 사용한 누적 휴가일수 조회
	    LeaveInfo li = new LeaveInfo();
	    li.setEmpNo(empNo);
	    List<LeaveInfo> totalList = leaveInfoMapper.leaveTotalDays(li);

	    int usedDays = 0;
	    if(totalList != null && !totalList.isEmpty() && totalList.get(0).getTotalDays() != null) {
	        usedDays = totalList.get(0).getTotalDays();
	    }

	    int remaining = 12 - usedDays;

	    return requestedDays <= remaining; // true: 신청 가능, false: 초과
	}


}
