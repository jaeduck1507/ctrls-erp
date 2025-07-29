package com.project.erp.qam.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.qam.mapper.QcMapper;
import com.project.erp.qam.model.vo.Qc;
import com.project.erp.qam.model.dto.QcResultDTO;

import java.time.LocalDate;

@Service
public class QcService {

    @Autowired
    private QcMapper qcMapper;

    // 전체 제품 조회 (검사 되었든 안되었든)
	public List<QcResultDTO> showQc() {
		return qcMapper.showQc();
	}
    
    // 품질검사 수정
    public void updateQc(Qc qc) {
        // 2. QC 업데이트
        qcMapper.updateQc(qc);
    }
    
    // 제품번호로 QC 결과 조회 (join 포함)
    public QcResultDTO findByProductNo(int productNo) {
        return qcMapper.findByProductNo(productNo);
    }

    // QC 안된 제품만 조회
    public List<QcResultDTO> findQcTargetProducts() {
        return qcMapper.findQcTargetProducts();
    }

    // QC 등록
    public void registerQc(Qc qc) {
        // 1. QC 등록
        qc.setQcDate(LocalDate.now());
        qcMapper.registerQc(qc);

        // 2. 판정 로직
//        boolean pass = "합격".equals(qc.getCheckMaterial()) &&
//                         "합격".equals(qc.getCheckColor()) &&
//                         "합격".equals(qc.getCheckDamage());

//        if (pass) {
//            // 합격 시: sale 테이블에 등록 (sale_date는 null)
//            Sale sale = new Sale();
//            sale.setProductNo(qc.getProductNo());
//            sale.setSaleDate(null);
//            saleMapper.insertSale(sale);
//        } else {
//            // 불합격 시: defective 테이블에 등록
//            Defective defective = new Defective();
//            defective.setProductNo(qc.getProductNo());
//            defective.setReason(qc.getQcDesc()); // qc_desc 복사
//            defectiveMapper.insertDefective(defective);
//        }
        
       // System.out.println("QC 등록 성공");
    }
}
