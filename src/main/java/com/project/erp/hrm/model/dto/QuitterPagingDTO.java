package com.project.erp.hrm.model.dto;

import java.util.List;

import com.project.erp.common.model.vo.Paging;

import lombok.Data;

@Data
public class QuitterPagingDTO extends Paging{

	private Quitter quitter;
	private List<Quitter> quitterList;
}
