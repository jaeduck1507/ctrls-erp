package com.project.erp.fm.model.dto;

import java.util.List;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.hrm.model.dto.EmpInfo;

import lombok.Data;

@Data
public class BonusPaymentPagingDTO extends Paging {

	private EmpInfo empInfo;
	private List<BonusPaymentDTO> bonusPaymentList;
	
}
