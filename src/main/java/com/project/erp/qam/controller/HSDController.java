// 불량품 처리 및 사후 조치(HD)
package com.project.erp.qam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.qam.model.dto.DefectiveDTO;
import com.project.erp.qam.model.dto.SaleReadyDTO;
import com.project.erp.qam.model.vo.Defective;
import com.project.erp.qam.model.vo.Sale;
import com.project.erp.qam.service.DefectiveService;
import com.project.erp.qam.service.SaleService;

@Controller
@RequestMapping("/qam") // 모든 매핑 이제 /qam로 시작
public class HSDController {

	@Autowired
	private SaleService saleService;
	
	@Autowired
	private DefectiveService defectiveService;
	
	@ResponseBody
	@GetMapping("/showSale")
	public List<Sale> showSale() {
		return saleService.showSale();
    }
	
	/*
	@ResponseBody
    @GetMapping("/showSaleNull")
    public List<SaleReadyDTO> showSaleNull() {
    	return saleService.showSaleNull();
    }*/
    
    @PostMapping("/registerSaleDate")
    public String registerSaleDate(@RequestBody List<SaleReadyDTO> sellList) { // @RequestBody는 HTTP 요청(/qam/saleReady)의 Body에 담겨 있는 JSON 데이터를 Java 객체로 자동 변환해주는 역할
    	saleService.registerSaleDate(sellList);
		return "redirect:/qam/saleReady";
    }
    
	@ResponseBody
    @GetMapping("/showSaleDone")
    public List<SaleReadyDTO> showSaleDone() {
    	return saleService.showSaleDone();
    }
	
	@ResponseBody
    @GetMapping("/showDefective")
    public List<DefectiveDTO> showDefective() {
    	return defectiveService.showDefective();
    }
	
	@ResponseBody
    @GetMapping("/searchDefective")
    public List<DefectiveDTO> searchDefective(DefectiveDTO dto) {
    	return defectiveService.searchDefective(dto);
    }
	
	@GetMapping("/searchSaleDone")
	@ResponseBody
	public List<SaleReadyDTO> searchSaleDone(SaleReadyDTO dto) {
	    return saleService.searchSaleDone(dto);
	}
}
