package com.project.erp.qam.model.vo;

import lombok.Data;

@Data
public class Brand {

	private int brandCode; // 명시용 코드
	private String brandName; // 브랜드 이름
	private int brandPhone; // 전화번호
	private int brandAccount; // 계좌번호
	private String brandBank; // 어떤은행인지
	
}
