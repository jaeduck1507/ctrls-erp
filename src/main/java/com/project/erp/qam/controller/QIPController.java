package com.project.erp.qam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.project.erp.qam.model.vo.Qc;
import com.project.erp.qam.model.dto.QcResultDTO;
import com.project.erp.qam.service.QcService;

@Controller
@RequestMapping("/qam") // All routes are now under /qam
public class QIPController {

    @Autowired
    private QcService qcService;

    // QC 등록 폼 진입
    @GetMapping("/qcForm")
    public String showQcForm(Model model) {
        List<QcResultDTO> list = qcService.findQcTargetProducts(); // QC 미등록 제품만
        model.addAttribute("productList", list);
        return "component/qam/qcForm";
    }

    // QC 등록 처리
    @PostMapping("/registerQc")
    public String registerQc(@ModelAttribute Qc qc) {
        qcService.registerQc(qc);
        return "redirect:/qam/qcList";
    }

    // QC 결과 목록 페이지 렌더링 (JSP)
////    @GetMapping("/qcList")
//    public String showQcList(Model model) {
//        List<QcResultDTO> list = qcService.showAllQcResults(); // 모든 제품 + QC 결과 포함
//        model.addAttribute("qcList", list);
//        return "component/qam/qcList";
//    }

    // QC 결과 목록 데이터 (AJAX용 JSON 응답)
    @ResponseBody
    @GetMapping("/qcData")
    public List<QcResultDTO> showQcData() {
        return qcService.showAllQcResults();
    }

    // QC 상세 조회 (수정용 or 상세보기용)
    @ResponseBody
    @GetMapping("/qcDetailByProduct")
    public QcResultDTO getQcDetailByProduct(@RequestParam int productNo) {
        return qcService.findByProductNo(productNo);
    }

    // 검사자별 이력 조회 (통계용 등)
    @ResponseBody
    @GetMapping("/qcByEmp")
    public List<QcResultDTO> getQcByEmp(@RequestParam int empNo) {
        return qcService.findByEmpNo(empNo);
    }

    // QC 수정 폼 진입
    @GetMapping("/qcFormUpdate")
    public String showUpdateForm(@RequestParam("productNo") int productNo, Model model) {
        QcResultDTO qc = qcService.findByProductNo(productNo);
        if (qc == null) {
            return "redirect:/qam/qcList"; // 잘못된 접근 시 목록으로
        }
        model.addAttribute("qc", qc);
        model.addAttribute("action", "updateQc"); // ✅ 경로 일관성
        return "component/qam/qcFormUpdate";
    }

    // QC 수정 처리
    @PostMapping("/updateQc")
    public String updateQc(@ModelAttribute Qc qc) {
        qcService.updateQc(qc);
        return "redirect:/qam/qcList";
    }
}
