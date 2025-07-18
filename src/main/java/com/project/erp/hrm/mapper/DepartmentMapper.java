package com.project.erp.hrm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.hrm.model.vo.Department;

@Mapper
public interface DepartmentMapper {
	List<Department> showDept();
}
