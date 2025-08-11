<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="top-header">
  <div class="breadcrumb">상단바</div>
  <div class="right-area">
    <span>id</span>
    <span>이름</span>
	<sec:authorize access="isAuthenticated()">
    <a href="/mypage" class="btn-mypage">마이페이지</a>
    <a href="/logout" class="btn-logout">로그아웃</a>
	<sec:authorize>
  </div>
</header>