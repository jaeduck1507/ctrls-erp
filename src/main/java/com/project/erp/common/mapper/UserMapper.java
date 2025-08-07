package com.project.erp.common.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.common.model.vo.User;

@Mapper
public interface UserMapper {
	void register(User vo);
	User login(String username);
	int noCheck(int empNo);
	String findId(int empNo); // 로그인에서 아이디 찾기
}
