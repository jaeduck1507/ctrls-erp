<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
    <h1>직원 정보 추가</h1>
    <div id = "test">
        <button id = "btn2">addRowTest</button>
        <button id = "btn3">removeRowTest</button>
        <table border="1" id = "result">
            <tr>
                <th>아이디</th>
                <th>비밀번호</th>
                <th>주민등록번호</th>
                <th>이름</th>
                <th>직급</th>
                <th>부서</th>
                <th>입사일</th>
                <th>급여</th>
                <th>주소</th>
                <th>연락처</th>
                <th>이메일</th>
            </tr>
            
        </table>
        <button id = "btn">rowToObjTest</button>
    </div>

    <script>

    function addRow() {
        $("#result").append('<tr></tr>');
        for(var i = 0; i < 11; i++) {
            $("#result tr").eq(-1).append('<td><input type="text"></td>');
        }
    }
    addRow();

    $("#btn2").click(() => {
        addRow();
    });
    $("#btn3").click(() => {
        if($("#result tr").length > 2) $("#result tr").eq(-1).remove();
    });

    $("#btn").click(() => {
        const table = $("#result tr");
        const list = [];
        for(var i = 1; i < table.length; i++){
            const obj ={};
            for(var j = 0; j <3; j++) {
                if(j === 0) obj.a = $("#result tr").eq(i).find("td").eq(j).find("input").val();
                if(j === 1) obj.b = $("#result tr").eq(i).find("td").eq(j).find("input").val();
                if(j === 2) obj.c = $("#result tr").eq(i).find("td").eq(j).find("input").val();
            }
            list.push(obj);
        }
    });


    </script>
</body>
</html>