package com.project.erp.qam.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.qam.mapper.DefectiveMapper;
import com.project.erp.qam.mapper.QcMapper;
import com.project.erp.qam.mapper.SaleMapper;
import com.project.erp.qam.model.vo.Defective;
import com.project.erp.qam.model.vo.Qc;
import com.project.erp.qam.model.vo.Sale;
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

    // 전체 제품 조회 (검사 되었든 안되었든)
	public List<QcResultDTO> showQc(Paging paging) {
		paging.setOffset(paging.getLimit() * (paging.getPage() - 1));
		paging.setTotal(qcMapper.showQcTotal());
		return qcMapper.showQc(paging);
	}
	
	public int showQcTotal(QcResultDTO dto) {
		return qcMapper.searchQcTotal(dto);
	}
	
    // 제품명/카테고리 조회 
	public QcResultDTO searchQc(QcResultDTO dto, Paging paging) {
		dto.setOffset(paging.getLimit() * (paging.getPage() - 1));
		dto.setList(qcMapper.searchQc(dto));
		dto.setPage(paging.getPage());
//		dto.setLimit(paging.getLimit());
		dto.setTotal(searchQcTotal(dto));
		return dto;
	}
	
	public int searchQcTotal(QcResultDTO dto) {
		return qcMapper.searchQcTotal(dto);
	}
	
    // 품질검사 수정
    public void updateQc(Qc qc) {
    	// 1. 기존 판정 삭제 (합격/불합격 상관없이 둘 다 삭제 시도)
        saleMapper.deleteByProductNo(qc.getProductNo());
        defectiveMapper.deleteByProductNo(qc.getProductNo());
    	
        // 2. QC 업데이트
        qc.setQcDate(LocalDate.now());
        qcMapper.updateQc(qc);
        
        // 3. 판정 로직
        boolean pass = "합격".equals(qc.getCheckMaterial()) &&
                         "합격".equals(qc.getCheckColor()) &&
                         "합격".equals(qc.getCheckDamage());
        
        // 4. 합격 여부
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
        boolean pass = "합격".equals(qc.getCheckMaterial()) &&
                         "합격".equals(qc.getCheckColor()) &&
                         "합격".equals(qc.getCheckDamage());

        // 3. 합격 여부
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
        
    }
}
