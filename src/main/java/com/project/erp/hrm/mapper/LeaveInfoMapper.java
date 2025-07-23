package com.project.erp.hrm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.hrm.model.dto.LeaveInfo;

@Mapper
public interface LeaveInfoMapper {

	List<LeaveInfo> leaveInfo(LeaveInfo li);
	void leaveAdd(List<LeaveInfo> liList);

}
