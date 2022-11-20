<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path}/resources/css/reset.css" />
<link rel="stylesheet" href="${path}/resources/css/header.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<!-- header  --> 
    <div class="header_bar">
        <div class="header_padding">

            <div class="first_section">
                <p id="one">로그인</p>&nbsp;&nbsp;
                <p id="two">회원가입</p>&nbsp;&nbsp;
                <p>장바구니</p>&nbsp;&nbsp;
                <p>마이페이지</p>&nbsp;&nbsp;
                <div class="second_section">
                    <a href="#"><img src="../img/top_sns01.gif"></a>
                    <a href="#"><img src="../img/top_sns02.gif"></a>
                    <a href="#"><img src="../img/top_sns03.gif"></a>
                    <a href="#"><img src="../img/top_sns04.gif"></a>
                </div>
            </div>
            <div class="search_mode">
                <input type="text" class="searchbar" placeholder="#커피랩  #스페셜" maxlength="11" size="23" />
                <img src="../img/topserch_b.png" class="searchimg"/>
            </div>


        </div>

        <div class="input_rogo">
            <span class="sizecontroll">UHDIYA COFFEE</span>
        </div>

        <div class="himg">
            <img src="../img/iced-coffee-hot-brew.gif" id="headimg" />
        </div>

    </div>

    <div class="categori">
        <span><a href="#">About</span></a>&nbsp;
        <span><a href="#">쇼핑</span></a>&nbsp;
        <span><a href="#">커피</span></a>&nbsp;
        <span><a href="#">스틱커피</span></a>&nbsp;
        <span><a href="#">음료</span></a>&nbsp;
        <span><a href="#">티</span></a>&nbsp;
        <span><a href="#">선물세트</span></a>&nbsp;
        <span><a href="#">케이크</span></a>&nbsp;
        <span><a href="#">게시판</span></a>&nbsp;
    </div>
<!-- 주문내역 -->  
<form>
	<button type="button" onclick="location.href='http://localhost:8080/Uhdiya/mypage/shoppingList?day=1'">하루</button>
	<button type="button" onclick="location.href='http://localhost:8080/Uhdiya/mypage/shoppingList?day=7'">일주일</button>
	<button type="button" onclick="location.href='http://localhost:8080/Uhdiya/mypage/shoppingList?day=30'">한달</button>
	<button type="button" onclick="location.href='http://localhost:8080/Uhdiya/mypage/shoppingList?day=90'">세달</button>
	<button type="button" onclick="location.href='http://localhost:8080/Uhdiya/mypage/shoppingList?day=all'">전체</button>
</form>


<!-- footer  -->
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