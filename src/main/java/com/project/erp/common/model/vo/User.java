package com.project.erp.common.model.vo;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor @Data
public class User implements UserDetails {
	private String username;
	private String password;
	private String role;
	private int empNo;
	private String empName;
	private int deptNo;
	private int jobNo;
	private String jobTitle; // 직급명
	private String deptName;
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return List.of(new SimpleGrantedAuthority(this.role));
	}
	
	
}
