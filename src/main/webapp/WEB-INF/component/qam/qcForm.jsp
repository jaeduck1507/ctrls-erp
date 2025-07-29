<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>품질검사 등록</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>

<h2>품질검사 등록</h2>

<!-- QC 등록 폼 -->
<form action="/qam/registerQc" method="post">

    <!-- QC 대상: 검사되지 않은 제품만 표시 -->
    <label>제품 선택:
        <select name="productNo" required>
            <option value="">검사할 제품 선택</option>
            <c:forEach var="p" items="${list}">
                <option value="${p.productNo}">
                    [${p.productNo}] ${p.productName} - ${p.productColor}
                </option>
            </c:forEach>
        </select>
    </label><br/>

    <!-- 검사자 사번 -->
    <label>검사자 사번:
        <input type="number" name="empNo" min="1" required />
    </label><br/>

    <!-- 검사 항목 -->
    <label>부자재 검사:
        <select name="checkMaterial" required>
            <option value="">선택</option>
            <option value="합격">합격</option>
            <option value="불합격">불합격</option>
        </select>
    </label><br/>

    <label>색상 검사:
        <select name="checkColor" required>
            <option value="">선택</option>
            <option value="합격">합격</option>
            <option value="불합격">불합격</option>
        </select>
    </label><br/>

    <label>손상 검사:
        <select name="checkDamage" required>
            <option value="">선택</option>
            <option value="합격">합격</option>
            <option value="불합격">불합격</option>
        </select>
    </label><br/>

    <!-- 검사 설명 -->
    <label>검사 설명:
        <textarea name="qcDesc" rows="3" cols="40" placeholder="불량 관련 메모 입력"></textarea>
    </label><br/><br/>

    <button type="submit">검사 등록</button>
</form>

<!-- 목록으로 이동 -->
<button><a href="/qam/qc">검사 목록으로</a></button>

</body>
</html>
