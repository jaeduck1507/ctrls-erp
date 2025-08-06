package com.project.erp.common.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		return http
				.csrf(csrf -> csrf.disable()) // 웹 보안 토큰 설정 (비활성화)
				.authorizeHttpRequests(authorize -> authorize
						.requestMatchers("/mypage").authenticated() 
						.requestMatchers("/hrm/empAdd").hasRole("ADMIN") // 그전에 먼저 지정하면 특정 경로 차단 가능!!
						.requestMatchers("/hrm/**").hasAnyRole("ADMIN","HRM") // ** 을 통해 모두 접근가능한가
						.requestMatchers("/qam/**").hasAnyRole("ADMIN","QAM")
						.requestMatchers("/fm/**").hasAnyRole("ADMIN","FM")
						.anyRequest().permitAll()
				)
				.formLogin(form -> 
				form.loginPage("/login")
					.defaultSuccessUrl("/")
					.failureUrl("/login")
					
					
					
					
				)
				.logout(logout -> 
					logout.logoutUrl("/logout")
						.logoutSuccessUrl("/")
				)
				.build();
	}
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
}
