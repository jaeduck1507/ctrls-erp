package com.project.erp.qam.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class Brand {

	private int brandCode; // 명시용 코드
	private String brandName; // 브랜드 이름
	private String brandPhone; // 전화번호
	private String brandAccount; // 계좌번호
	private String brandBank; // 어떤은행인지
	
	
}
