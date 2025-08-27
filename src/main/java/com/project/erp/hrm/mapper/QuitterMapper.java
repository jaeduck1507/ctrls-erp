package com.project.erp.hrm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;

import com.project.erp.hrm.model.dto.Quitter;
import com.project.erp.hrm.model.dto.QuitterPagingDTO;

@Mapper
public interface QuitterMapper {

	List<Quitter> quitShow(Quitter q);
	List<Quitter> quitShowPage(QuitterPagingDTO quitterPagingDTO);
	int totalQuit(Quitter q);
	void empQuit(Quitter q);
}
