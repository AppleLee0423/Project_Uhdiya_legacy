<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path}/resources/css/reset.css" />
<link rel="stylesheet" href="${path}/resources/css/footer.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
	<div class="footer_bar">
        <ul class="footer_firstmention">
            <a href="#">이용안내</a>
            <a href="#">이용약관</a>
            <a href="#">개인정보처리방침</a>
            <a href="#">회사소개</a>
        </ul>

        <ul class="footer_secondmention">
            <div>
                <p>UHDIYA COFFEE</p><br><br>
                <span>대표이사 : 에이콘 | 사업자등록번호 : 0001 | 통신판매업 신고 : 홍대 제 0002HD</span>
                <span>주소 : 서울특별시 마포구 양화로 122 3층~4층 (서교동/ LAB7)</span><br>
                <span>ⓒ 2020 UHDIYA COFFEE STORE. ALL RIGHTS RESERVED.</span>
            </div>
            <div class="cssize">
                <p>C/S</p><br><br>
                <span>02-000-0000</span>
                <span>FAX : 0003</span>
                <span>TIME : AM 10:00 ~ PM 05:00</sapn>
                <span>(주말,공휴일 제외)</span>
            </div>
        </ul>
   </div>
</body>
</html>