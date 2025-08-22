package com.project.erp.qam.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.qam.mapper.DefectiveMapper;
import com.project.erp.qam.model.dto.DefectiveDTO;
import com.project.erp.qam.model.vo.Defective;

@Service
public class DefectiveService {

	@Autowired
	private DefectiveMapper defectiveMapper;
	
	public List<DefectiveDTO> showDefective(Paging paging) {
		paging.setOffset(paging.getLimit() * (paging.getPage() - 1));
		paging.setTotal(defectiveMapper.totalDefective());
		System.out.println("showDefective 넘어감");
		return defectiveMapper.showDefective(paging);
	}

	public DefectiveDTO searchDefective(DefectiveDTO dto,Paging paging) {
		dto.setOffset(paging.getLimit() * (paging.getPage() - 1));
		dto.setTotal(defectiveMapper.searchDefectiveTotal(dto));
		System.out.println("searchDefective 넘어감");
		dto.setList(defectiveMapper.searchDefective(dto));
		return dto;
	}
	
	public int searchDefectiveTotal(DefectiveDTO dto) {
		return defectiveMapper.searchDefectiveTotal(dto);
	}

}
