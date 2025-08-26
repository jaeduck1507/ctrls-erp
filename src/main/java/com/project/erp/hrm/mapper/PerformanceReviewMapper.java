package com.project.erp.hrm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.hrm.model.dto.EmpInfo;
import com.project.erp.hrm.model.dto.PerformanceReviewDTO;
import com.project.erp.hrm.model.vo.PerformanceReview;

@Mapper
public interface PerformanceReviewMapper {
	
	void empEval(PerformanceReview pr);
	List<EmpInfo> showEvalEmp(EmpInfo empinfo);
	PerformanceReviewDTO showEval(PerformanceReviewDTO prDto);
	List<PerformanceReviewDTO> showCommnetsList(PerformanceReviewDTO prDto);
}
