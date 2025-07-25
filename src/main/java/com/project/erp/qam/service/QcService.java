package com.project.erp.qam.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.qam.mapper.QcMapper;
import com.project.erp.qam.mapper.SaleMapper;
import com.project.erp.qam.mapper.DefectiveMapper;
import com.project.erp.qam.model.vo.Qc;
import com.project.erp.qam.model.vo.Sale;
import com.project.erp.qam.model.vo.Defective;
import com.project.erp.qam.model.dto.QcResultDTO;

import java.time.LocalDate;

@Service
public class QcService {

    @Autowired
    private QcMapper qcMapper;

    @Autowired
    private SaleMapper saleMapper;

    @Autowired
    private DefectiveMapper defectiveMapper;

    // QC 등록
    public void registerQc(Qc qc) {
        // 1. QC 등록
        qc.setQcDate(LocalDate.now());
        qcMapper.insertQc(qc);

        // 2. 판정 로직
        boolean pass = "합격".equals(qc.getCheckMaterial()) &&
                         "합격".equals(qc.getCheckColor()) &&
                         "합격".equals(qc.getCheckDamage());

        if (pass) {
            // 합격 시: sale 테이블에 등록 (sale_date는 null)
            Sale sale = new Sale();
            sale.setProductNo(qc.getProductNo());
            sale.setSaleDate(null);
            saleMapper.insertSale(sale);
        } else {
            // 불합격 시: defective 테이블에 등록
            Defective defective = new Defective();
            defective.setProductNo(qc.getProductNo());
            defective.setReason(qc.getQcDesc()); // qc_desc 복사
            defectiveMapper.insertDefective(defective);
        }
        
        System.out.println("QC 등록 성공");
    }

    // 제품번호로 결과 조회
    public QcResultDTO findByProductNo(int productNo) {
        return qcMapper.findQcResultByProductNo(productNo);
    }

    // 검사자별 조회
    public List<QcResultDTO> findByEmpNo(int empNo) {
        return qcMapper.findQcByEmpNo(empNo);
    }
    
    // 전체 제품 조회 (검사 되었든 안되었든)
    public List<QcResultDTO> showAllQcResults() {
        return qcMapper.findAllQcResults();
    }
    
    //  Qc해야하는 제품들만 리스트
    public List<QcResultDTO> findQcTargetProducts() {
        return qcMapper.findQcTargetProducts();
    }
    
    public void updateQc(Qc qc) {
        // 1. 기존 판정 삭제 (sale, defective)
        saleMapper.deleteByProductNo(qc.getProductNo());
        defectiveMapper.deleteByProductNo(qc.getProductNo());

        // 2. QC 업데이트
        qcMapper.updateQc(qc);

        // 3. 판정 다시 수행
        boolean pass = "합격".equals(qc.getCheckMaterial()) &&
                       "합격".equals(qc.getCheckColor()) &&
                       "합격".equals(qc.getCheckDamage());

        if (pass) {
            Sale sale = new Sale();
            sale.setProductNo(qc.getProductNo());
            sale.setSaleDate(null);
            saleMapper.insertSale(sale);
        } else {
            Defective defective = new Defective();
            defective.setProductNo(qc.getProductNo());
            defective.setReason(qc.getQcDesc());
            defectiveMapper.insertDefective(defective);
        }

        System.out.println("QC 수정 성공");
    }

}
