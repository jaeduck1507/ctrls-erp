package com.project.erp.qam.mapper;

import java.util.List;

import com.project.erp.qam.model.dto.DefectiveDTO;
import com.project.erp.qam.model.vo.Defective;

public interface DefectiveMapper {
    // Insert a new defective record (used when QC fails)
    void insertDefective(Defective defective);

	void deleteByProductNo(int productNo);

	List<DefectiveDTO> showDefective();

	List<DefectiveDTO> searchDefective(DefectiveDTO dto);
}
