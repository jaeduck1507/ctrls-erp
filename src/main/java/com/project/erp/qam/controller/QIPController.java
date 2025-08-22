package com.project.erp.qam.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.project.erp.qam.model.vo.ProductName;
import com.project.erp.qam.model.vo.Qc;
import com.project.erp.common.model.vo.Paging;
import com.project.erp.hrm.model.dto.EmpInfo;
import com.project.erp.hrm.model.vo.Department;
import com.project.erp.hrm.service.EmployeeInfoService;
import com.project.erp.qam.model.dto.ProductNameDTO;
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
    	System.out.println(dto);
    	return qcService.searchQc(dto, paging);
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
        
        model.addAttribute("component","../component/qam/qcFormUpdate.jsp");
	    return "common/layout";
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
        model.addAttribute("component","../component/qam/qcForm.jsp");
        return "common/layout";
    }
    
    // QC 등록 처리
    @PostMapping("/registerQc")
    public String registerQc(Qc qc) {
        qcService.registerQc(qc);
        return "redirect:/qam/qc";
    }
    
    // 삭제 필요 X? 자동 매입 연결이기에 수정, 등록 항목만 고려
}

//List<Department> saleDept = new ArrayList<>();
//List<Department> deptList = departmentService.showDept();
//for(Department d : deptList) {
//	if(d.getDeptName().contains("지점")) saleDept.add(d);
//}
//System.out.println(saleDept);




