<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>품질검사 등록</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<link rel="stylesheet" href="../resources/css/qamForm.css"/>
</head>
<body>
	<h5>[품질 관리] > [품질검사 결과 목록] > [신규 검사 등록]</h5>
	<h3>신규 검사 등록</h3>

<!-- QC 등록 폼 -->
<form action="/qam/registerQc" method="post" class="filter-bar">
	<div class="box">
		<table>
			<tr>
		    <th>제품 선택</th>
		        <td>
					<select name="productNo" required>
			            <option value="">검사할 제품 선택</option>
			            <c:forEach var="p" items="${list}">
			                <option value="${p.productNo}">
			                    [${p.productNo}] ${p.productName} - ${p.productColor}
			                </option>
			            </c:forEach>
		        	</select>
				</td>
			</tr>
		
			<tr>
			<th>검사자 사번</th>
				<td>
				    <select name="empNo" required>
				        <option value="">사번 선택</option>
				        <c:forEach var="e" items="${empList}">
				            <option value="${e.empNo}">[${e.empNo}] ${e.empName}</option>
				        </c:forEach>
				    </select>
				</td>
			</tr>
		
			<tr>
		    <th>부자재 검사</th>
				<td>
			        <select name="checkMaterial" required>
			            <option value="합격">합격</option>
			            <option value="불합격">불합격</option>
			        </select>
		    	</td>
			</tr>
		
			<tr>
		    <th>색상 검사</th>
				<td>
			        <select name="checkColor" required>
			            <option value="합격">합격</option>
			            <option value="불합격">불합격</option>
			        </select>
		    	</td>
			</tr>
			
			<tr>
		    <th>손상 검사</th>
				<td>
			        <select name="checkDamage" required>
			            <option value="합격">합격</option>
			            <option value="불합격">불합격</option>
			        </select>
		    	</td>
			</tr>

			<tr>
		    <th>검사 설명</th>
				<td>
		        	<textarea name="qcDesc" rows="3" cols="40" placeholder="불량 관련 메모 입력"></textarea>
		    	</td>
			</tr>
		</table>
	</div>
	
	<div>
		<button type="submit" class="btn">검사 등록</button>
		<a href="/qam/qc" class="btn">검사 목록으로</a>
	</div>
	
</form>

</body>
</html>
