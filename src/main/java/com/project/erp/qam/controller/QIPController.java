package com.project.erp.qam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.project.erp.qam.model.vo.Qc;
import com.project.erp.common.model.vo.Paging;
import com.project.erp.hrm.model.dto.EmpInfo;
import com.project.erp.hrm.service.EmployeeInfoService;
import com.project.erp.qam.model.dto.ProductNameDTO;
import com.project.erp.qam.model.dto.QcResultDTO;
import com.project.erp.qam.service.ProductNameService;
import com.project.erp.qam.service.QcService;

@Controller
@RequestMapping("/qam")
public class QIPController {

    @Autowired
    private QcService qcService;
    
    @Autowired
    private EmployeeInfoService employeeInfoService;
    
    @Autowired
    private ProductNameService productNameService;

	@ResponseBody
	@GetMapping("/showProductName")
	public List<ProductNameDTO> showProductName(Paging paging) {
		return productNameService.showProductName(paging);
	}
    
    @ResponseBody
    @GetMapping("/showQc")
    public List<QcResultDTO> showQc(Paging paging) {
    	return qcService.showQc(paging);
    }
    
    @ResponseBody
    @GetMapping("/searchQc")
    public QcResultDTO searchQc(QcResultDTO dto, Paging paging) {
    	return qcService.searchQc(dto, paging);
    }
    
    @GetMapping("/qcFormUpdate")
    public String showUpdateForm(int productNo, Model model) {
        QcResultDTO qc = qcService.findByProductNo(productNo);

        if (qc == null) {
            qc = new QcResultDTO();
            qc.setProductNo(productNo);
        }
        model.addAttribute("qc", qc);
        
        List<EmpInfo> empList = employeeInfoService.showEmployee();
        model.addAttribute("empList", empList);
        
        model.addAttribute("component","../component/qam/qcFormUpdate.jsp");
	    return "common/layout";
    }

    @PostMapping("/updateQc")
    public String updateQc(Qc qc) {
        qcService.updateQc(qc);
        return "redirect:/qam/qc";
    }

    @GetMapping("/qcForm")
    public String showQcForm(Model model) {
        List<QcResultDTO> list = qcService.findQcTargetProducts(); // QC 미등록 제품만
        List<EmpInfo> empList = employeeInfoService.showEmployee();
        model.addAttribute("list", list);
        model.addAttribute("empList", empList);
        model.addAttribute("component","../component/qam/qcForm.jsp");
        return "common/layout";
    }
    
    @PostMapping("/registerQc")
    public String registerQc(Qc qc) {
        qcService.registerQc(qc);
        return "redirect:/qam/qc";
    }
    
}