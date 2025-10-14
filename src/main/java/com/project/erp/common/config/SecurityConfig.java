package com.project.erp.common.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.RegexRequestMatcher;

@EnableWebSecurity
@Configuration
public class SecurityConfig {
	
	@Bean
	public LoginFailureHandler loginFailureHandler(){
	    return  new LoginFailureHandler();
	}
	
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		return http
				.csrf(csrf -> csrf.disable())
				.authorizeHttpRequests(authorize -> 
					authorize
						.requestMatchers("/resources/**","/css/**","/js/**","/images/**").permitAll()
						.requestMatchers("/mypage").authenticated()
						.requestMatchers("/hrm/my*").authenticated()
						.requestMatchers("/hrm/empEval").authenticated()
						.requestMatchers(new RegexRequestMatcher("^/hrm/my[^/]+/.*$",null)).authenticated()
						.requestMatchers("/hrm/empAdd").hasAnyRole("ADMIN","HRM","MANAGEMENT")
						.requestMatchers("/hrm/**").hasAnyRole("ADMIN","HRM","MANAGEMENT")
						.requestMatchers("/qam/**").hasAnyRole("ADMIN","QAM","MANAGEMENT","HEADQUARTER","SALE")
						.requestMatchers("/fm/**").hasAnyRole("ADMIN","FM","MANAGEMENT")
						.anyRequest().permitAll()
				)
				.formLogin(form -> 
					form
						.loginPage("/login")
						.defaultSuccessUrl("/")
						.loginProcessingUrl("/login")
						.failureHandler(loginFailureHandler())
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
