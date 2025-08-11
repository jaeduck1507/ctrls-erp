package com.project.erp.qam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.qam.service.BrandService;
import com.project.erp.qam.service.DefectiveService;
import com.project.erp.qam.service.ProductNameService;
import com.project.erp.qam.service.ProductService;
import com.project.erp.qam.service.SaleService;


@RequestMapping("/qam")
@Controller
public class QamPageController {
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private SaleService saleService;
	
	@Autowired
	private BrandService brandService;
	
	@Autowired
	private ProductNameService productNameService;
	
	@Autowired
	private DefectiveService defectiveService;
	
//	@GetMapping("/product")
//	public String product(Model model, Paging paging) {
//		model.addAttribute("productList", productService.showProductDetail(paging));
//		model.addAttribute("paging", paging);
//		return "component/qam/product";
//	}

	@GetMapping("/brand")
	public String brand(Model model, Paging paging) {
		model.addAttribute("paging", paging);
		model.addAttribute("brandList", brandService.findBrand(paging));
		return "component/qam/brand";
	}
	
	@GetMapping("/product")
	public String product(
		Model model,
		Paging paging,
		@RequestParam(required = false) String productName,
		@RequestParam(required = false) String productCategory) {
		model.addAttribute("productList", productService.searchProductDetail(paging, productName, productCategory));
		model.addAttribute("paging", paging);
		
		return "component/qam/product";
	}
	
	@GetMapping("/productName")
	public String productName(Model model, Paging paging) {
		model.addAttribute("productNameList", productNameService.showProductName(paging));
		model.addAttribute(paging);
		return "component/qam/productName";
	}

	@GetMapping("/saleReady")
	public String saleReady(Model model, Paging paging) {
		model.addAttribute("saleList", saleService.showSaleNull(paging));
		model.addAttribute("paging", paging);
		return "component/qam/saleReady";
	}
	
	@GetMapping("/saleDone")
	public String saleDone(Model model, Paging paging) {
		model.addAttribute("saleList", saleService.showSaleDone(paging));
		model.addAttribute("paging", paging);
		return "component/qam/saleDone";
	}
	
	@GetMapping("/defective")
	public String defective(Model model, Paging paging) {
		model.addAttribute("defectiveList", defectiveService.showDefective(paging));
		model.addAttribute("paging", paging);
		return "component/qam/defective";
	}
	
}