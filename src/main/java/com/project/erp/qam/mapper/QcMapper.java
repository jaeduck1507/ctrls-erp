package com.project.erp.qam.mapper;

import java.util.List;

import com.project.erp.qam.model.vo.Qc;
import com.project.erp.qam.model.dto.QcResultDTO;

public interface QcMapper {

    // 품질검사 등록
    void insertQc(Qc qc);

    // 제품번호로 QC 결과 조회 (join 포함)
    QcResultDTO findQcResultByProductNo(int productNo);

    // 검사자별 처리 건수/목록
    List<QcResultDTO> findQcByEmpNo(int empNo);
    
    // 전체 제품 + QC JOIN 목록
    List<QcResultDTO> findAllQcResults(); 
    
    // QC 안된 제품만 조회
    List<QcResultDTO> findQcTargetProducts(); 

    // 품질검사 수정
    void updateQc(Qc qc);

 // Optional but recommended for 판정 재처리
 //   void deleteByProductNo(int productNo); // in SaleMapper + DefectiveMapper


}
