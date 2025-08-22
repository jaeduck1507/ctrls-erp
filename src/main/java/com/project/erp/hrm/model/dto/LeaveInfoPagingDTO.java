package com.project.erp.hrm.model.dto;

import java.util.List;

import com.project.erp.common.model.vo.MyLeaveInfoPaging;

import lombok.Data;

@Data
public class LeaveInfoPagingDTO extends MyLeaveInfoPaging {
	private LeaveInfo leaveInfo;
	private List<LeaveInfo> leaveInfoList;
}
