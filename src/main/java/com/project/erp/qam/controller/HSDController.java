// 불량품 처리 및 사후 조치(HD)

package com.project.erp.qam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	@ResponseBody
    @GetMapping("/showDefective")
    public List<Defective> showDefective() {
    	return defectiveService.showDefective();
    }
}
