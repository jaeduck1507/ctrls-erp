package com.project.erp.hrm.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.hrm.model.vo.PerformanceReview;

@Mapper
public interface PerformanceReviewMapper {
	
	void empEval(PerformanceReview pr);
}
