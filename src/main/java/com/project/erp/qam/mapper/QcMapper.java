package com.project.erp.qam.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.qam.model.vo.Qc;
import com.project.erp.qam.model.dto.QcResultDTO;

@Mapper
public interface QcMapper {

	// 전체 제품 조회 (검사 되었든 안되었든)
	List<QcResultDTO> showQc();
	
    // 품질검사 수정
    void updateQc(Qc qc);

    // 제품번호로 QC 결과 조회 (join 포함)
    QcResultDTO findByProductNo(int productNo);
    
    // 제품명으로 결과 조회
    List<QcResultDTO> searchQc(QcResultDTO dto);

    // QC 안된 제품만 조회
    List<QcResultDTO> findQcTargetProducts(); 
    
    // 품질검사 등록
    void registerQc(Qc qc);
    
    

}


