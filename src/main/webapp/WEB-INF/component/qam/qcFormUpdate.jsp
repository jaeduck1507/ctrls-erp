<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>품질검사 수정</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<link rel="stylesheet" href="../resources/css/qam/qamForm.css"/>
</head>
<body>
	<h5>[품질 관리] > [품질검사 결과 목록] > [품질 검사 수정]</h5>
	<h3>품질 검사 수정</h3>

<form id="qcFormUpdate" class="filter-bar">
	<div class="box">
		<table>
			<tr>
				<th><i class="fi fi-rr-gift-card"></i>&nbsp;&nbsp;상품 번호</th>
				<td><input type="number" name="productNo"  id="productNo" value="${qc.productNo}" readonly /></td>
			</tr>
			<tr>
				<th><i class="fi fi-rr-id-badge"></i>&nbsp;&nbsp;검사자 사번</th>
				<td>
					<select name="empNo" id="empNo">
						<option value="" disabled selected>사번 선택</option> 
						  <c:forEach var="e" items="${empList}">
						    <option value="${e.empNo}" <c:if test="${qc.empNo == e.empNo}">selected</c:if>>
						      [${e.empNo}] ${e.empName}
						    </option>
						  </c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th><i class="fi fi-rr-mockup"></i> &nbsp;&nbsp;부자재 검사</th>
				<td>
			        <select name="checkMaterial" id="checkMaterial">
			            <option value="합격" ${qc.checkMaterial == '합격' ? 'selected' : ''}>합격</option>
			            <option value="불합격" ${qc.checkMaterial == '불합격' ? 'selected' : ''}>불합격</option>
			        </select>
				</td>
			</tr>
			<tr>
				<th><i class="fi fi-rr-fill"></i> &nbsp;&nbsp;색상 검사</th>
				<td>
			        <select name="checkColor" id="checkColor">
			            <option value="합격" ${qc.checkColor == '합격' ? 'selected' : ''}>합격</option>
			            <option value="불합격" ${qc.checkColor == '불합격' ? 'selected' : ''}>불합격</option>
			        </select>
				</td>
			</tr>
			<tr>
				<th><i class="fi fi-rr-damage"></i> &nbsp;&nbsp;손상 검사</th>
				<td>
			        <select name="checkDamage" id="checkDamage">
			            <option value="합격" ${qc.checkDamage == '합격' ? 'selected' : ''}>합격</option>
			            <option value="불합격" ${qc.checkDamage == '불합격' ? 'selected' : ''}>불합격</option>
			        </select>
				</td>
			</tr>
			<tr>
				<th><i class="fi fi-rr-description-alt"></i>&nbsp;&nbsp;검사 설명</th>
				<td>
					<textarea name="qcDesc" id="qcDesc">${qc.qcDesc}</textarea>
				</td>
			</tr>
		</table>
	</div>
	
	<div>
    	<button type="submit" class="btn">수정</button>
		<a href="/qam/qc" class="btn">목록으로</a>
	</div>
</form>

<script src="../resources/js/qam/qcFormUpdate.js"></script>

</body>
</html>
