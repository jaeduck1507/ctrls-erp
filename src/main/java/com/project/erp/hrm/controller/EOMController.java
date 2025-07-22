package com.project.erp.hrm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.hrm.model.dto.Quitter;
import com.project.erp.hrm.service.QuitterService;

@Controller
public class EOMController {

	@Autowired
	private QuitterService quitterService;
	
	@ResponseBody
	@PostMapping("/quitShow")
	public List<Quitter> quitShow(Quitter q) {
//		System.out.println(q.getEmpName());
//		System.out.println(quitterService.quitShow(q).get(0).getEmpName());
		return quitterService.quitShow(q);
	}
}
