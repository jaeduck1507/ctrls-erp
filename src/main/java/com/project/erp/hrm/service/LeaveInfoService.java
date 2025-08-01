package com.project.erp.hrm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.hrm.mapper.LeaveInfoMapper;
import com.project.erp.hrm.model.dto.LeaveInfo;

@Service
public class LeaveInfoService {

	@Autowired
	private LeaveInfoMapper leaveInfoMapper;
	
	public List<LeaveInfo> leaveInfo(LeaveInfo li) {
		return leaveInfoMapper.leaveInfo(li);
	}
	public void leaveAdd(List<LeaveInfo> liList) {
		leaveInfoMapper.leaveAdd(liList);
	}
	
	public List<LeaveInfo> leaveStatus() {
		return leaveInfoMapper.leaveStatus();
	}
	
	public void leaveStatusUpdate(LeaveInfo leaveinfo) {
		leaveInfoMapper.leaveStatusUpdate(leaveinfo);
	}
	
	public List<LeaveInfo> leaveDays(LeaveInfo leaveInfo) {
		return leaveInfoMapper.leaveDays(leaveInfo);
		
	}
	
	public List<LeaveInfo> leaveTotalDays(int empNo) {
		return leaveInfoMapper.leaveTotalDays(empNo);
		
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
}
