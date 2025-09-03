package com.project.erp.hrm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.hrm.mapper.JobPositionMapper;
import com.project.erp.hrm.model.vo.JobPosition;

@Service
public class JobPositionService {

	@Autowired
	private JobPositionMapper jobpositionMapper;

	public List<JobPosition> showJob() {
		return jobpositionMapper.showJob();
	}
}
