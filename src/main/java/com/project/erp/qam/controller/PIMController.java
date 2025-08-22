package com.project.erp.qam.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model; 
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam; 
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.qam.model.dto.ProductDetailDTO;
import com.project.erp.qam.model.dto.ProductNameDTO;
import com.project.erp.qam.model.vo.Brand;
import com.project.erp.qam.model.vo.ProductName;
import com.project.erp.qam.service.BrandService;
import com.project.erp.qam.service.ProductNameService;
import com.project.erp.qam.service.ProductService;

@Controller
public class PIMController {

	@Autowired
	private ProductService productService; // 제품 관련 서비스 주입
	
	@Autowired
	private ProductNameService productNameService; // 제품명 관련 서비스 주입
	
	@Autowired
	private BrandService brandService; // 브랜드 관련 서비스 주입

	// 제품 전체 목록 조회 (DTO 기반)
	// → AJAX로 호출되어 제품 목록을 JSON으로 반환
	@ResponseBody
	@GetMapping("/showProduct")
	public List<ProductDetailDTO> showProduct(Paging paging) {
	    return productService.showProductDetail(paging);
	}

	// 제품명 전체 목록 조회
	// → 제품 등록/수정 시 select option 동적 생성용
	@ResponseBody
	@GetMapping("/showProductName")
	public List<ProductNameDTO> showProductName(Paging paging) {
		return productNameService.showProductName(paging);
	}

	// 제품 수정 폼 페이지 호출
	// → 수정할 productNo를 받아 해당 DTO를 model에 담아 JSP로 전달
	@GetMapping("/productDetailFormUpdate")
	public String showUpdateForm(int productNo, Model model) {
//	    ProductDetailDTO product = productService.findProductDetailById(productNo);
//	    model.addAttribute("product", product); // Service로 비즈니스 로직 옮김
	    //return productService.findProductDetailById(productNo, model);
	    // productService.findProductDetailById(productNo, model);
	    // return "/qam/product etc." 같이 해도 되는지 알아보기 
	    model.addAttribute("component","../component/qam/productDetailFormUpdate.jsp");
	    return "common/layout";
	}

	// 제품 수정 처리
	// → form에서 전달된 DTO를 이용하여 product + product_name 정보 동시 업데이트
	@PostMapping("/updateProduct")
	public String updateProduct(ProductDetailDTO product) {
	    productService.updateProductDetail(product);
	    return "redirect:/qam/product"; // 수정 후 제품 목록으로 리다이렉트
	}

	// 제품 삭제 처리
	// → productNo를 기준으로 product 테이블에서 삭제
	@GetMapping("/deleteProduct")
	public String deleteProduct(int productNo) {
	    productService.deleteProduct(productNo);
	    return "redirect:/qam/product"; // 삭제 후 목록으로 리다이렉트
	}

	// 제품 검색 (제품명, 카테고리 기반)
	// → 조건 없이 호출 시 전체 반환, 조건 포함 시 LIKE/WHERE 절 처리
	@GetMapping("/searchProduct")
	@ResponseBody
	public List<ProductDetailDTO> searchProduct(
//			Model model, 
			Paging paging,
			@RequestParam(required = false) String productName,
	        @RequestParam(required = false) String productCategory) {
//		model.addAttribute("productList", productService.searchProductDetail(paging, productName, productCategory));
	    return productService.searchProductDetail(paging, productName, productCategory);
	}

	// 제품명 등록/수정 폼 호출
	// → productCode가 있으면 수정, 없으면 등록
//	@GetMapping("/productNameForm")
//	public String pnForm(@RequestParam(required = false) Integer productCode, Integer brandCode, Model model) {
//		if (productCode != null) {
//			ProductNameDTO productName = productNameService.findById(productCode);
//			Brand brand = brandService.findById(brandCode);
//			model.addAttribute("brand", brand);
//			model.addAttribute("productName", productName); // 수정용 데이터
//			model.addAttribute("action", "/updateProductName"); // 수정용 액션
//		} else {
//			Brand brand = brandService.findById(brandCode);
//			model.addAttribute("brand", brand);
//			model.addAttribute("productName", new ProductNameDTO()); // 빈 객체 전달
//			model.addAttribute("action", "/registerProductName"); // 등록용 액션
//		}
//		return "component/qam/productNameForm"; // JSP 경로 반환
//	}
	
	@GetMapping("/productNameForm")
	public String pnForm(@RequestParam(required = false) Integer productCode, Integer brandCode, Model model, Paging paging) {

	    // 카테고리 목록 추가 (DB단에서 하는게 나으려나)
		List<String> categoryList = new ArrayList<>();
		categoryList.add("상의");
		categoryList.add("하의");
		categoryList.add("악세사리");
		categoryList.add("신발");
	    model.addAttribute("categoryList", categoryList);

	    // 브랜드 목록 추가 (DB에서 모든 브랜드 가져오기)
	    List<Brand> brandList = brandService.findBrand(paging); // 이 메서드 필요
	    model.addAttribute("brandList", brandList);
	    System.out.println("findBrand() working");

	    if (productCode != null) {
	        ProductNameDTO productName = productNameService.findById(productCode);
	        model.addAttribute("productName", productName); // 수정용 데이터
	        model.addAttribute("action", "/updateProductName"); // 수정용 액션
	    } else {
	        model.addAttribute("productName", new ProductNameDTO()); // 빈 객체 전달
	        model.addAttribute("action", "/registerProductName"); // 등록용 액션
	    }
	    System.out.println("/productNameForm working");
	    model.addAttribute("component","../component/qam/productNameForm.jsp");
	    return "common/layout";
	}

	// 제품명 등록 처리
	@PostMapping("/registerProductName")
	public String register(ProductName productName) {
		productNameService.insertProductName(productName);
		return "redirect:/qam/productName"; // 등록 후 목록 페이지로 이동
	}

	// 제품명 수정 처리
	@PostMapping("/updateProductName")
	public String update(ProductName productName) {
		productNameService.updateProductName(productName);
		return "redirect:/qam/productName"; // 수정 후 목록 페이지로 이동
	}

	// 제품명 삭제 처리
	@GetMapping("/deleteProductName")
	public String deleteProductName(int productCode) {
		productNameService.deleteProductName(productCode);
		return "redirect:/qam/productName"; // 삭제 후 목록 페이지로 이동
	}

	// 제품명 검색 (제품명 or 카테고리)
	// → 제품명 리스트에서 필터링할 때 사용
	@GetMapping("/searchProductName")
	@ResponseBody
	public List<ProductNameDTO> searchProductName(Paging paging,
	        @RequestParam(required = false) String productName,
	        @RequestParam(required = false) String productCategory) {
	    return productNameService.searchProductName(paging, productName, productCategory);
	}
	
    // 컨트롤러에 productNo 존재 여부 확인 API 만들기
    @GetMapping("/checkProductNo")
    @ResponseBody
    public boolean checkProductNo(int productNo) {
    return productService.existsByProductNo(productNo);
        }
    
    @ResponseBody
    @PostMapping("/showProductNameByBrandFilter")
    public List<ProductNameDTO> showProductNameByBrandFilter(@RequestBody Brand brand) {
    	System.out.println(productNameService.showProductNameByBrandFilter(brand));
    	return productNameService.showProductNameByBrandFilter(brand);
    }
    
    @GetMapping("/showBrand")
    @ResponseBody
    public List<Brand> showBrand() {
    	return brandService.showBrand();
    }
    
    @GetMapping("/brandForm")
    public String brandForm(Model model) {
    	model.addAttribute("component","../component/qam/brandForm.jsp");
    	return "common/layout";
    }
    
    @PostMapping("/registerBrand")
    public String registerBrand(Brand brand) {
    	brandService.registerBrand(brand);
    	return "redirect:/qam/brand";
    }
    
    @GetMapping("/brandFormUpdate")
    public String brandFormUpdate(Model model, int brandCode) {
    	Brand brand = brandService.findById(brandCode);
    	model.addAttribute("brand", brand);
    	model.addAttribute("component","../component/qam/brandFormUpdate.jsp");
    	return "common/layout";
    }
    
    @PostMapping("/updateBrand")
    public String updateBrand(Brand brand) {
    	brandService.updateBrand(brand);
    	return "redirect:/qam/brand";
    }
    
	@GetMapping("/deleteBrand")
	public String deleteBrand(int brandCode) {
		brandService.deleteBrand(brandCode);
		return "redirect:/qam/brand";
	}

    @PostMapping("/selectCategory")
    public List<String> selectCategory() {
    	return productNameService.selectCategory();
    }

}


