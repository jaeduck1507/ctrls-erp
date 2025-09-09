<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>품질검사 등록</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<link rel="stylesheet" href="../resources/css/qam/qamForm.css"/>
</head>
<body>
	<h5>[품질 관리] > [품질 검사 결과 목록] > [신규 검사 등록]</h5>
	<h3>신규 검사 등록</h3>

<form id="qcForm" class="filter-bar">
	<div class="box">
		<table>
			<tr>
		    <th><i class="fi fi-rr-gift-card"></i>&nbsp;&nbsp;상품 선택</th>
		        <td>
					<select name="productNo" id="productNo">
			            <option value="" disabled selected>검사할 상품 선택</option>
			            <c:forEach var="p" items="${list}">
			                <option value="${p.productNo}">
			                    [${p.productNo}] ${p.productName} - ${p.productColor}
			                </option>
			            </c:forEach>
		        	</select>
				</td>
			</tr>
		
			<tr>
			<th><i class="fi fi-rr-id-badge"></i>&nbsp;&nbsp;검사자 사번</th>
				<td>
				    <select name="empNo" id="empNo">
				        <option value="" disabled selected>사번 선택</option>
				        <c:forEach var="e" items="${empList}">
				            <option value="${e.empNo}">[${e.empNo}] ${e.empName}</option>
				        </c:forEach>
				    </select>
				</td>
			</tr>
		
			<tr>
		    <th><i class="fi fi-rr-mockup"></i> &nbsp;&nbsp;부자재 검사</th>
				<td>
			        <select name="checkMaterial" id="checkMaterial">
						<option value="" disabled selected>선택</option>
			            <option value="합격">합격</option>
			            <option value="불합격">불합격</option>
			        </select>
		    	</td>
			</tr>
		
			<tr>
		    <th><i class="fi fi-rr-fill"></i> &nbsp;&nbsp;색상 검사</th>
				<td>
			        <select name="checkColor" id="checkColor">
						<option value="" disabled selected>선택</option>
			            <option value="합격">합격</option>
			            <option value="불합격">불합격</option>
			        </select>
		    	</td>
			</tr>
			
			<tr>
		    <th><i class="fi fi-rr-damage"></i> &nbsp;&nbsp;손상 검사</th>
				<td>
			        <select name="checkDamage" id="checkDamage">
						<option value="" disabled selected>선택</option>
			            <option value="합격">합격</option>
			            <option value="불합격">불합격</option>
			        </select>
		    	</td>
			</tr>

			<tr>
		    <th><i class="fi fi-rr-description-alt"></i>&nbsp;&nbsp;검사 설명</th>
				<td>
		        	<textarea name="qcDesc" id="qcDesc" rows="3" cols="40" placeholder="불량 관련 메모 입력"></textarea>
		    	</td>
			</tr>
		</table>
	</div>
	
	<div>
		<button type="submit" class="btn">검사 등록</button>
		<a href="/qam/qc" class="btn">검사 목록으로</a>
	</div>
</form>

  <script src="../resources/js/qam/qcForm.js"></script>

</body>
</html>
