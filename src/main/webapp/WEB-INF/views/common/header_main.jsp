<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/css/reset.css" />
<link rel="stylesheet" href="resources/css/header.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <div class="header_bar">
        <div class="header_padding">

            <div class="first_section">
                <p id="one">로그인</p>&nbsp;&nbsp;
                <p id="two">회원가입</p>&nbsp;&nbsp;
                <p>장바구니</p>&nbsp;&nbsp;
                <p>마이페이지</p>&nbsp;&nbsp;
                <div class="second_section">
                    <a href="#"><img src="resources/img/top_sns01.gif"></a>
                    <a href="#"><img src="resources/img/top_sns02.gif"></a>
                    <a href="#"><img src="resources/img/top_sns03.gif"></a>
                    <a href="#"><img src="resources/img/top_sns04.gif"></a>
                </div>
            </div>
            <div class="search_mode">
                <input type="text" class="searchbar" placeholder="#커피랩  #스페셜" maxlength="11" size="23" />
                <img src="resources/img/topserch_b.png" class="searchimg"/>
            </div>


        </div>

        <div class="input_rogo">
            <span class="sizecontroll">UHDIYA COFFEE</span>
        </div>

        <div class="himg">
            <img src="resources/img/iced-coffee-hot-brew.gif" id="headimg" />
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
</body>
</html>