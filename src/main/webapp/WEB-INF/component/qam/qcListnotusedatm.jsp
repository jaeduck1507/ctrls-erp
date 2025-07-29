<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>품질검사 결과 목록</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>

<h2>품질검사 결과 목록</h2>

<!-- QC 등록 버튼 -->
<a href="/qam/qcForm"><button>신규 검사 등록</button></a>
<br/><br/>

<!-- 필터 드롭다운 -->
<label>검사 상태 필터:
    <select id="qcFilter">
        <option value="all">전체 보기</option>
        <option value="done">검사 완료</option>
        <option value="notyet">미검사</option>
    </select>
</label>
<br/><br/>

<!-- 테이블 -->
<table border="1" id="qcTable">
    <tr>
        <th>제품번호</th>
        <th>생산일</th>
        <th>제품코드</th>
        <th>색상</th>
        <th>제품명</th>
        <th>판매가</th>
        <th>QC 여부</th>
        <th>검사자</th>
        <th>검사일</th>
        <th>결과</th>
        <th>검사 설명</th>
        <th>수정</th>
    </tr>

    <c:forEach var="row" items="${qcList}">
        <c:set var="qcClass" value="${row.qcCode != null ? 'done' : 'notyet'}" />
        <tr class="qcRow ${qcClass}">
            <td>${row.productNo}</td>
            <td>${row.productionDate}</td>
            <td>${row.productCode}</td>
            <td>${row.productColor}</td>
            <td>${row.productName}</td>
            <td>${row.productPrice}</td>

            <td>
                <c:choose>
                    <c:when test="${row.qcCode != null}">완료</c:when>
                    <c:otherwise>미검사</c:otherwise>
                </c:choose>
            </td>

            <td><c:out value="${row.empNo != null ? row.empNo : '-'}"/></td>
            <td><c:out value="${row.qcDate != null ? row.qcDate : '-'}"/></td>

            <td>
                <c:choose>
                    <c:when test="${row.qcCode != null}">
                        <c:if test="${row.checkMaterial eq '합격' && row.checkColor eq '합격' && row.checkDamage eq '합격'}">합격</c:if>
                        <c:if test="${!(row.checkMaterial eq '합격' && row.checkColor eq '합격' && row.checkDamage eq '합격')}">불합격</c:if>
                    </c:when>
                    <c:otherwise> - </c:otherwise>
                </c:choose>
            </td>

            <td><c:out value="${row.qcDesc != null ? row.qcDesc : '-'}"/></td>

            <!-- 수정 버튼: QC가 존재하는 경우만 노출 -->
            <td>
                <c:if test="${row.qcCode != null}">
                    <a href="/qam/qcFormUpdate?productNo=${row.productNo}">수정</a>
                </c:if>
            </td>
        </tr>
    </c:forEach>
</table>

<script>
$(document).ready(function () {
    $("#qcFilter").change(function () {
        const selected = $(this).val();
        $(".qcRow").show();

        if (selected === "done") {
            $(".qcRow").not(".done").hide();
        } else if (selected === "notyet") {
            $(".qcRow").not(".notyet").hide();
        }
    });
});
</script>

</body>
</html>
