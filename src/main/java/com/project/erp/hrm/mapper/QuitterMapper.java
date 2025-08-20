package com.project.erp.hrm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;

import com.project.erp.hrm.model.dto.Quitter;

@Mapper
public interface QuitterMapper {

	List<Quitter> quitShow(Quitter q);
	void empQuit(Quitter q);
}
