package com.project.erp.common.controller;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class CustomErrorController implements ErrorController {
	@RequestMapping("/error")
	public String handlerError(HttpServletRequest request, Model model) {
		Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
		int statusCode = Integer.parseInt(status.toString());
		String errorMessage = "알수없는 오류가 발생하였습니다";
		if(statusCode == 403) errorMessage = "접근권한이 없습니다";
		else if(statusCode == 400) errorMessage = "잘못된 요청입니다";
		else if(statusCode == 404) errorMessage = "요청하신 페이지를 찾을 수 없습니다";
		else if(statusCode == 500) errorMessage = "서버에 오류가 발생했습니다. 잠시 후 다시 시도해주세요";
		else if(statusCode == 503) errorMessage = "현재 서비스가 불가능합니다. 잠시 후 다시 시도해주세요.";
		else if(statusCode == 504) errorMessage = "서버 응답 시간이 초과되었습니다.";
		
		
		model.addAttribute("statusCode", statusCode);
		model.addAttribute("errorMessage", errorMessage);
		
		return "common/error";
	}
}
