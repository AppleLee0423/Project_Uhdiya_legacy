<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%
	request.setCharacterEncoding("utf-8");
%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path}/resources/css/reset.css" />
<link rel="stylesheet" href="${path}/resources/css/main.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
	<div>
        <a href="${path}/product/productList?product_cateL=커피&product_cateS=""><div class="imgSlider"></div></a>
    </div>

    <section class="coffee"> 
        <h2 class="coffee-category">BEST ITEM</h2>
        <h1 class="coffee-category2">인기제품</h1>
        <button class="pre-btn"><img src="resources/img/arrow.png" alt=""></button>
        <button class="nxt-btn"><img src="resources/img/arrow.png" alt=""></button>
        <div class="coffee-container">
        	<c:forEach items="${productsMap.productsList }" var="list">
	            <div class="coffee-card">
	                <div class="coffee-image">
	                    <img src="${path }/product_download?product_fileName=${list.product_fileName }&product_code=${list.product_code}" class="coffee-thumb" alt="">
	                    <button class="card-btn" onclick="location.href='${path}/product/productDetail?product_cateL=${list.product_cateL }&product_cateS=${list.product_cateS }&product_code=${list.product_code }'">상세보기</button>
	                </div>
	                <div class="coffee-info">
	                    </h2>
	                    <p class="coffee-short-description" style="font-size:14px !important;">${list.product_name}</p>
	                    <span class="price" style="font-size:16px !important;">
		                   	<fmt:formatNumber  value="${list.product_price}" type="number" var="product_price" />
							${product_price }원
	                    </span>
	                </div>
	            </div>
	       </c:forEach>

        </div>
    </section>

    <div class="coffee-noticeevent">
        <a href="#"><img src="resources/img/noticeimg.jpg" /></a>
        <a href="#"><img src="resources/img/eventimg.jpg" /></a>
    </div>

    <section class="coffee"> 
        <h2 class="coffee-category">NEW ARRIVAL</h2>
        <h1 class="coffee-category2">신제품</h1>
        <button class="pre-btn"><img src="resources/img/arrow.png" alt=""></button>
        <button class="nxt-btn"><img src="resources/img/arrow.png" alt=""></button>
        <div class="coffee-container">
        	<c:forEach items="${productsMap2.productsList }" var="list">
	            <div class="coffee-card">
	                <div class="coffee-image">
	                    <img src="${path }/product_download?product_fileName=${list.product_fileName }&product_code=${list.product_code}" class="coffee-thumb" alt="">
	                    <button class="card-btn" onclick="location.href='${path}/product/productDetail?product_cateL=${list.product_cateL }&product_cateS=${list.product_cateS }&product_code=${list.product_code }'">상세보기</button>
	                </div>
	                <div class="coffee-info">
	                    </h2>
	                    <p class="coffee-short-description" style="font-size:14px !important;">${list.product_name}</p>
	                    <span class="price" style="font-size:16px !important;">
		                   	<fmt:formatNumber  value="${list.product_price}" type="number" var="product_price" />
							${product_price }원
	                    </span>
	                </div>
	            </div>
	       </c:forEach>
        </div>
    </section>

    <div class="binist">
        <a href="${path}/product/productList?product_cateL=스틱커피&product_cateS="><img src="resources/img/binist.jpg" /></a>
    </div>

    <section class="coffee"> 
        <h2 class="coffee-category">PRESENT FOR YOU</h2>
        <h1 class="coffee-category2">선물하고 싶을 때</h1>
        <button class="pre-btn"><img src="resources/img/arrow.png" alt=""></button>
        <button class="nxt-btn"><img src="resources/img/arrow.png" alt=""></button>
        <div class="coffee-container">
        	<c:forEach items="${productsMap3.productsList }" var="list">
	            <div class="coffee-card">
	                <div class="coffee-image">
	                    <img src="${path }/product_download?product_fileName=${list.product_fileName }&product_code=${list.product_code}" class="coffee-thumb" alt="">
	                    <button class="card-btn" onclick="location.href='${path}/product/productDetail?product_cateL=${list.product_cateL }&product_cateS=${list.product_cateS }&product_code=${list.product_code }'">상세보기</button>
	                </div>
	                <div class="coffee-info">
	                    </h2>
	                    <p class="coffee-short-description" style="font-size:14px !important;">${list.product_name}</p>
	                    <span class="price" style="font-size:16px !important;">
		                   	<fmt:formatNumber  value="${list.product_price}" type="number" var="product_price" />
							${product_price }원
	                    </span>
	                </div>
	            </div>
	       </c:forEach>
        </div>
    </section>
    <!-- 자바스크립트 불러오기 -->
    <script src="resources/js/main.js"></script>
</body>
</html>