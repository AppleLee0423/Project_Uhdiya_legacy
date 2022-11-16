<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../css/reset.css" />
<link rel="stylesheet" href="../css/review.css" />
<script src="https://kit.fontawesome.com/96e0fede2d.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
	<div class="review">
		<div class="review_header">
			<div class="review_header_title">REVIEW</div>
			<div class="review_count">총 1건</div>
		</div>
		<div class="review_body">
			<table class="review_table">
				<tr>
					<td class="review_num">번호</td>
					<td class="review_product_code"><font size="3">상품</font></td>
					<td class="review_title">제목</td>
					<td class="review_star">별점</td>
					<td class="review_writer">작성자</td>
					<td class="review_writeDate">작성일</td>
					<td class="review_delete_button">삭제</td>
				</tr>
				<tr>
					<td class="review_num">1</td>
					<td class="review_product_code">홀빈커피 페르소나 블렌드 200g X 2개</td>
					<td class="review_title">커피는 맛있는데</td>
					<td class="review_star"><span class="rate_in">★★★★</span><span class="rate_out">★</span></td>
					<td class="review_writer">hong</td>
					<td class="review_writeDate">2022-11-14</td>
					<td class="review_delete_button"><a href="#">삭제</a></td>
				</tr>
			</table>
		</div>
		<div class="review_paging">
				<a href="#" class="prev"><i class="fa-solid fa-angle-left"></i></a>
				<a href="#" class="page1">1</a>
				<a href="#" class="next"><i class="fa-solid fa-angle-right"></i></a>
		</div>
		<div class="review_search">
			<input type="text" name="review_search" id="search_box"/>
			<button id="search_button">검색</button>
		</div>
	</div>
</body>
</html>