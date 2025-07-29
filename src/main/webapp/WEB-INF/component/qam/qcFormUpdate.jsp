<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>품질검사 수정</title>
</head>
<body>

<h2>품질검사 수정</h2>

<form action="/qam/updateQc" method="post">

    <!-- productNo (변경 불가능!) -->
    <label>제품 번호:
        <input type="number" name="productNo" value="${qc.productNo}" readonly />
    </label><br/>

    <!-- empNo (변경 가능) -->
    <label>검사자 사번:
        <input type="number" name="empNo" value="${qc.empNo}" min="1" required />
    </label><br/>

    <!-- 검사 항목들 (select with selected value) -->
    <label>부자재 검사:
        <select name="checkMaterial" required>
			<option value="선택" ${qc.checkMaterial == '선택' ? 'selected' : ''}>선택</option>
            <option value="합격" ${qc.checkMaterial == '합격' ? 'selected' : ''}>합격</option>
            <option value="불합격" ${qc.checkMaterial == '불합격' ? 'selected' : ''}>불합격</option>
        </select>
    </label><br/>

    <label>색상 검사:
        <select name="checkColor" required>
			<option value="선택" ${qc.checkColor == '선택' ? 'selected' : ''}>선택</option>
            <option value="합격" ${qc.checkColor == '합격' ? 'selected' : ''}>합격</option>
            <option value="불합격" ${qc.checkColor == '불합격' ? 'selected' : ''}>불합격</option>
        </select>
    </label><br/>

    <label>손상 검사:
        <select name="checkDamage" required>
			<option value="선택" ${qc.checkDamage == '선택' ? 'selected' : ''}>선택</option>
            <option value="합격" ${qc.checkDamage == '합격' ? 'selected' : ''}>합격</option>
            <option value="불합격" ${qc.checkDamage == '불합격' ? 'selected' : ''}>불합격</option>
        </select>
    </label><br/>

    <!-- qcDesc -->
    <label>검사 설명:
        <textarea name="qcDesc">${qc.qcDesc}</textarea>
    </label><br/><br/>

    <button type="submit">수정</button>
</form>

<button><a href="/qam/qc">목록으로</a></button>

</body>
</html>
