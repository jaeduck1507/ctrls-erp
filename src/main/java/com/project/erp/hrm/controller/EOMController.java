package com.project.erp.hrm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.hrm.model.dto.Quitter;
import com.project.erp.hrm.model.dto.QuitterPagingDTO;
import com.project.erp.hrm.service.QuitterService;

@Controller
public class EOMController {

	@Autowired
	private QuitterService quitterService;
	
	@ResponseBody
	@PostMapping("/quitShow")
	public QuitterPagingDTO quitShow(Quitter q, Paging paging) {
//		System.out.println(q.getEmpName());
//		System.out.println(quitterService.quitShow(q).get(0).getEmpName());
		return quitterService.pagingQuitShow(q, paging);
	}
	
	@PostMapping("/empQuit")
	public String empQuit(Quitter q, Model model) {
		System.out.println(q);
		quitterService.empQuit(q);
		return "redirect:/hrm/empInfoDetails?empNo=" + q.getEmpNo();
	}
}
