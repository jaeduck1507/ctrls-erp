package com.project.erp.qam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.project.erp.qam.model.vo.ProductName;
import com.project.erp.qam.model.vo.Qc;
import com.project.erp.hrm.model.dto.EmpInfo;
import com.project.erp.hrm.service.EmployeeInfoService;
import com.project.erp.qam.model.dto.QcResultDTO;
import com.project.erp.qam.service.ProductNameService;
import com.project.erp.qam.service.QcService;

@Controller
@RequestMapping("/qam") // 모든 매핑 이제 /qam로 시작
public class QIPController {

    @Autowired
    private QcService qcService;
    
    @Autowired
    private EmployeeInfoService employeeInfoService;
    
    @Autowired
    private ProductNameService productNameService;

	@ResponseBody
	@GetMapping("/showProductName")
	public List<ProductName> showProductName() {
		return productNameService.showProductName();
	}
    
    @ResponseBody
    @GetMapping("/showQc")
    public List<QcResultDTO> showQc() {
    	return qcService.showQc();
    }
    
    @GetMapping("/qc")
    public String QcPage(Model model) {
        List<EmpInfo> empList = employeeInfoService.showEmployee();
        model.addAttribute("empList", empList);
        return "component/qam/qc"; // qc.jsp 경로
    }
    
    @ResponseBody
    @GetMapping("/searchQc")
    public List<QcResultDTO> searchQc(QcResultDTO dto) {
    	return qcService.searchQc(dto);
    }
    
    // QC 수정 폼 진입
    @GetMapping("/qcFormUpdate")
    public String showUpdateForm(int productNo, Model model) {
        QcResultDTO qc = qcService.findByProductNo(productNo);

        // 만약 qc가 null이면 새 DTO 생성해서 productNo만 세팅!
        if (qc == null) {
            qc = new QcResultDTO();
            qc.setProductNo(productNo);
        }
        model.addAttribute("qc", qc);
        
        List<EmpInfo> empList = employeeInfoService.showEmployee();
        model.addAttribute("empList", empList);

        return "component/qam/qcFormUpdate";
    }

    // QC 수정 처리
    @PostMapping("/updateQc")
    public String updateQc(Qc qc) {
        qcService.updateQc(qc);
        return "redirect:/qam/qc";
    }

    // QC 등록 폼 진입
    @GetMapping("/qcForm")
    public String showQcForm(Model model) {
        List<QcResultDTO> list = qcService.findQcTargetProducts(); // QC 미등록 제품만
        List<EmpInfo> empList = employeeInfoService.showEmployee();
        model.addAttribute("list", list);
        model.addAttribute("empList", empList);
        return "component/qam/qcForm";
    }
    
    // QC 등록 처리
    @PostMapping("/registerQc")
    public String registerQc(Qc qc) {
        qcService.registerQc(qc);
        return "redirect:/qam/qc";
    }
    
    // 삭제 필요 X? 자동 매입 연결이기에 수정, 등록 항목만 고려
}






