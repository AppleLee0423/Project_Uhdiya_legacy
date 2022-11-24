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
<style>
a{text-decoration:none; color:black;}
</style>
</head>
<body>
    <div class="header_bar">
        <div class="header_padding">

            <div class="first_section">
                <p id="one"><a href="${path}/memJ/loginJ">로그인</a></p>&nbsp;&nbsp;
                <p id="two"><a href="${path}/memJ/memberFormJ">회원가입</a></p>&nbsp;&nbsp;
                <p>장바구니</p>&nbsp;&nbsp;
                <p><a href="${path}/mypage">마이페이지</a></p>&nbsp;&nbsp;
                <div class="second_section">
                    <a href="#"><img src="${path}/resources/img/top_sns01.gif"></a>
                    <a href="#"><img src="${path}/resources/img/top_sns02.gif"></a>
                    <a href="#"><img src="${path}/resources/img/top_sns03.gif"></a>
                    <a href="#"><img src="${path}/resources/img/top_sns04.gif"></a>
                </div>
            </div>
            <div class="search_mode">
                <input type="text" class="searchbar" placeholder="#커피랩  #스페셜" maxlength="11" size="23" />
                <img src="${path}/resources/img/topserch_b.png" class="searchimg"/>
            </div>


        </div>

        <div class="input_rogo">
            <span class="sizecontroll"><a href="${path}">UHDIYA COFFEE</a></span>
        </div>

        <div class="himg">
            <img src="${path}/resources/img/iced-coffee-hot-brew.gif" id="headimg" />
        </div>

    </div>

    <div class="categori">
        <span><a href="${path}/about">About</span></a>&nbsp;
        <span><a href="#">쇼핑</span></a>&nbsp;
        <span><a href="${path}/product/productList?product_cateL=커피&product_cateS=">커피</span></a>&nbsp;
        <span><a href="${path}/product/productList?product_cateL=스틱커피&product_cateS=">스틱커피</span></a>&nbsp;
        <span><a href="${path}/product/productList?product_cateL=음료&product_cateS=">음료</span></a>&nbsp;
        <span><a href="${path}/product/productList?product_cateL=티&product_cateS=">티</span></a>&nbsp;
        <span><a href="#">선물세트</span></a>&nbsp;
        <span><a href="#">케이크</span></a>&nbsp;
        <span><a href="${path}/board/notice">공지사항</span></a>&nbsp;
    </div>
</body>
</html>