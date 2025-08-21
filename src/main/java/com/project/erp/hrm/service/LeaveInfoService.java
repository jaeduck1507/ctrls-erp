package com.project.erp.hrm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.common.model.vo.Paging;
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
		//System.out.println("service!");
		//System.out.println(liList);
		//System.out.println("-------------");
		leaveInfoMapper.leaveAdd(liList);
	}
	
	public void leaveStatusUpdate(LeaveInfo leaveinfo) {
		leaveInfoMapper.leaveStatusUpdate(leaveinfo);
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
}
