package com.project.erp.hrm.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.hrm.mapper.EmployeeInfoMapper;
import com.project.erp.hrm.model.dto.EmpAddDTO;
import com.project.erp.hrm.model.dto.EmpInfo;
import com.project.erp.hrm.model.dto.EmpInfoPagingDTO;
import com.project.erp.hrm.model.dto.PerformanceReviewDTO;
import com.project.erp.hrm.model.dto.Quitter;
import com.project.erp.hrm.model.vo.EmployeeInfo;

@Service
public class EmployeeInfoService {
	
	@Autowired
	private EmployeeInfoMapper employeeInfoMapper;
	
	public List<EmpInfo> infoShow(EmpInfo ei) {
		ei.setDeptNo(-1);
		ei.setJobNo(-1);
		return employeeInfoMapper.infoShow(ei);
	};
	
	List<EmpInfo> infoShowPage(EmpInfoPagingDTO empInfoPagingDTO) {
		return employeeInfoMapper.infoShowPage(empInfoPagingDTO);
	};
	
	public void empAdd(EmpAddDTO eiList) {
		List<EmployeeInfo> empList = new ArrayList<EmployeeInfo>();
		for(EmpInfo emp : eiList.getEiList()) {
			EmployeeInfo e = new EmployeeInfo();
			e.setEmpName(emp.getEmpName());
			e.setEmpIn(emp.getEmpIn());
			e.setJobNo(emp.getJobNo());
			e.setDeptNo(emp.getDeptNo());
			e.setHireDate(emp.getHireDate());
			e.setSalary(emp.getSalary());
			e.setAddr(emp.getAddr());
			e.setPhone(emp.getPhone());
			e.setEmail(emp.getEmail());
			if(emp.getFile() != null) e.setUrl(fileUpload(emp.getFile()));
			empList.add(e);
		}
		employeeInfoMapper.empAdd(empList);
	};
	
	public List<EmpInfo> showEmployee() { // 윤의진 추가 qc 위함
		return employeeInfoMapper.showEmployee();
	}
		
	public int totalEmp(EmpInfo ei) {
		return employeeInfoMapper.totalEmp(ei);
	}
	
	public EmpInfoPagingDTO pagingInfoShow(EmpInfo ei, Paging paging) {
		EmpInfoPagingDTO empInfoPagingDTO = new EmpInfoPagingDTO();
		
		empInfoPagingDTO.setEmpInfo(ei);
		empInfoPagingDTO.setOffset(paging.getLimit() * (paging.getPage() - 1));
		empInfoPagingDTO.setEmpInfoList(infoShowPage(empInfoPagingDTO));
		empInfoPagingDTO.setPage(paging.getPage());
		empInfoPagingDTO.setTotal(totalEmp(ei));
		return empInfoPagingDTO;
	}
	
	public EmpInfo infoShowOne(EmpInfo ei) {
		return employeeInfoMapper.infoShowOne(ei);
	}
	
	public void empModify(EmpInfo ei) {
		employeeInfoMapper.empModify(ei);
	}
	
	public List<EmpInfo> showNotEvalEmp(PerformanceReviewDTO prDto) {
		return employeeInfoMapper.showNotEvalEmp(prDto);
	}
	
	public void updateEmpQuit(Quitter q) {
		employeeInfoMapper.updateEmpQuit(q);
	}
	
	public void modifyJobDept(EmpInfo ei) {
		employeeInfoMapper.modifyJobDept(ei);
	}
	
	public void modifySalary(EmpInfo ei) {
		employeeInfoMapper.modifySalary(ei);
	}
	
	public void modifyImg(EmpInfo ei) {
		
		if(ei.getUrl() ==null || ei.getUrl().isBlank()) {
			if(!ei.getFile().getOriginalFilename().isBlank()) {
				ei.setUrl(fileUpload(ei.getFile()));
			}
		} else if(!ei.getFile().getOriginalFilename().isBlank()) {
			File delFile = new File("D:\\ctrls-erp\\src\\main\\resources\\static\\images\\" + ei.getUrl());
			delFile.delete();
			ei.setUrl(fileUpload(ei.getFile()));
		}
		employeeInfoMapper.modifyImg(ei);
	}
	
	public void deleteImg(EmpInfo ei) {
		if(ei.getUrl() ==null || ei.getUrl().isBlank()) {
			return;
		}
		File delFile = new File("D:\\ctrls-erp\\src\\main\\resources\\static\\images\\" + ei.getUrl());
		delFile.delete();
		
		employeeInfoMapper.deleteImg(ei);
	}
	
	public String fileUpload(MultipartFile file) {
		// 중복 방지를 위한 UUID 적용
		UUID uuid = UUID.randomUUID();
		String fileName = uuid.toString() + "_" + file.getOriginalFilename();
		File copyFile = new File("D:\\ctrls-erp\\src\\main\\resources\\static\\images\\" + fileName);

		try {
			file.transferTo(copyFile);
		
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		return fileName;
	}
}
