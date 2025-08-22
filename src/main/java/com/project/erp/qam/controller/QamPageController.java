package com.project.erp.qam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.hrm.model.dto.EmpInfo;
import com.project.erp.hrm.service.EmployeeInfoService;
import com.project.erp.qam.model.vo.ProductName;
import com.project.erp.qam.service.BrandService;
import com.project.erp.qam.service.DefectiveService;
import com.project.erp.qam.service.ProductNameService;
import com.project.erp.qam.service.ProductService;
import com.project.erp.qam.service.QcService;
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
	
    @Autowired
    private QcService qcService;
    
    @Autowired
    private EmployeeInfoService employeeInfoService;
	
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
		model.addAttribute("component","../component/qam/brand.jsp");
		return "common/layout";
	}
	
	@GetMapping("/product")
	public String product(
		Model model,
		Paging paging,ProductName productname
		) {
		System.out.println(productname);
		model.addAttribute("productList", productService.searchProductDetail(paging, productname.getProductName(), productname.getProductCategory()));
		model.addAttribute("paging", paging);
		System.out.println(paging);
		model.addAttribute("productName", productname.getProductName());
		model.addAttribute("productCategory", productname.getProductCategory());
		model.addAttribute("component","../component/qam/product.jsp");
		return "common/layout";
	}
	
	@GetMapping("/productName")
	public String productName(Model model, Paging paging, ProductName productName) {
		System.out.println(productName);
		model.addAttribute("productNameList", productNameService.searchProductName(paging, productName.getProductName(), productName.getProductCategory()));
		model.addAttribute("paging",paging);
		model.addAttribute("productName", productName.getProductName());
		model.addAttribute("productCategory", productName.getProductCategory());
		model.addAttribute("component","../component/qam/productName.jsp");
		return "common/layout";
	}
	
    @GetMapping("/qc")
    public String QcPage(Model model, Paging paging) {
        List<EmpInfo> empList = employeeInfoService.showEmployee();
        model.addAttribute("paging",paging);
        model.addAttribute("empList", empList);
        model.addAttribute("component","../component/qam/qc.jsp");
		return "common/layout"; // qc.jsp 경로
    }

	@GetMapping("/saleReady")
	public String saleReady(Model model, Paging paging) {
		model.addAttribute("saleList", saleService.showSaleNull());
		model.addAttribute("paging", paging);
		model.addAttribute("component","../component/qam/saleReady.jsp");
		return "common/layout";
	}
	
	@GetMapping("/saleDone")
	public String saleDone(Model model, Paging paging) {
		model.addAttribute("saleList", saleService.showSaleDone(paging));
		model.addAttribute("paging", paging);
		model.addAttribute("component","../component/qam/saleDone.jsp");
		return "common/layout";
	}
	
	@GetMapping("/defective")
	public String defective(Model model, Paging paging) {
		model.addAttribute("defectiveList", defectiveService.showDefective(paging));
		model.addAttribute("paging", paging);
		model.addAttribute("component","../component/qam/defective.jsp");
		return "common/layout";
	}
	
}