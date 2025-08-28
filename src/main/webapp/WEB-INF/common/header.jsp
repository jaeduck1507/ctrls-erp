<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<header class="top-header">
  <div class="breadcrumb"></div>
  <div class="right-area">
	<div>
		<b>
  <i class="fi fi-rr-circle-user"></i>&nbsp;&nbsp;<sec:authentication property="principal.username"/> | 
  <sec:authentication property="principal.empName"/>님 | 
  <sec:authentication property="principal.jobTitle"/>
	</b>
  </div>
	<sec:authorize access="isAuthenticated()">	
    <a href="/mypage" class="btn-mypage"><i class="fi fi-rr-review"></i>&nbsp;&nbsp;마이페이지</a>
    <a href="/logout" class="btn-logout"><i class="fi fi-rr-exit"></i>&nbsp;&nbsp;로그아웃</a>
	</sec:authorize>
	</div>
</header>