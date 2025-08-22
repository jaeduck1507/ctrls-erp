package com.project.erp.qam.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.qam.model.dto.DefectiveDTO;
import com.project.erp.qam.model.dto.DefectiveForListDTO;
import com.project.erp.qam.model.vo.Defective;

@Mapper
public interface DefectiveMapper {
    // Insert a new defective record (used when QC fails)
    void insertDefective(Defective defective);

	void deleteByProductNo(int productNo);

	List<DefectiveDTO> showDefective(Paging paging);

	List<DefectiveForListDTO> searchDefective(DefectiveDTO dto);
	
	Integer totalDefective();
	
	Integer totalSearchDefective();
	
	int searchDefectiveTotal(DefectiveDTO dto);
	
}
