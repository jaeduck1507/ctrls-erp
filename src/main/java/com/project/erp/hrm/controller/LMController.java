package com.project.erp.hrm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.hrm.model.dto.LeaveInfo;
import com.project.erp.hrm.service.LeaveInfoService;

@Controller
public class LMController {

    private final EOMController EOMController;

	@Autowired
	private LeaveInfoService leaveInfoService;

    LMController(EOMController EOMController) {
        this.EOMController = EOMController;
    }
	

	
}
