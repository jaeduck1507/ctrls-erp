package com.project.erp.qam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.qam.service.BrandService;
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
	
//	@GetMapping("/product")
//	public String product(Model model, Paging paging) {
//		model.addAttribute("productList", productService.showProductDetail(paging));
//		model.addAttribute("paging", paging);
//		return "component/qam/product";
//	}

	@GetMapping("/brand")
	public String brand(Model model) {
		model.addAttribute("brandList", brandService.findBrand());
		return "component/qam/brand";
	}
	
	@GetMapping("/product")
	public String product(
		Model model,
		Paging paging,
		@RequestParam(required = false) String productName,
		@RequestParam(required = false) String productCategory) {

		// 검색 조건을 paging에 담음
		paging.setProductName(productName);
		paging.setProductCategory(productCategory);

		// 전체 데이터 수 조회 (검색 조건 반영)
		int total = productService.totalSearchProduct(paging); // 반드시 이 메서드 사용
		paging.setTotal(total);

		// 현재 페이지의 데이터 조회
		model.addAttribute("productList", productService.searchProductDetail(paging, productName, productCategory));
		model.addAttribute("paging", paging);
		
		return "component/qam/product";
	}
	
	@GetMapping("/productName")
	public String productName() {
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
	public String defective() {
		return "component/qam/defective";
	}
	
}