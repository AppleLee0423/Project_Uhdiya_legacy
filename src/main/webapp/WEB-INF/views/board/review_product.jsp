<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path}/resources/css/reset.css" />
<link rel="stylesheet" href="${path}/resources/css/review.css" />
<script src="https://kit.fontawesome.com/96e0fede2d.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
	<div class="review">
		<div class="review_header">
			<div class="review_header_title"><b>REVIEW</b></div>
			<div class="review_header_subtitle"><font size="2">상품의 사용후기를 적어주세요.</font></div>
		</div>
		<div class="review_body">
			<table class="review_product_table">
				<thead>
					<tr>
						<td class="review_product_num">번호</td>
						<td class="review_product_star">별점</td>
						<td class="review_product_title" style="text-align: center;">제목</td>
						<td class="review_product_writer">작성자</td>
						<td class="review_product_writeDate">작성일</td>
					</tr>
				</thead>
				<tr>
					<td class="review_product_num">1</td>
					<td class="review_product_star"><span class="rate_in">★★★★</span><span class="rate_out">★</span></td>
					<td class="review_product_title"><a href="#">커피는 맛있는데 그렇다구요</a></td>
					<td class="review_product_writer">ho**</td>
					<td class="review_product_writeDate">2022-11-13</td>
				</tr>
			</table>
			<div class="review_paging">
				<a href="#" class="prev"><i class="fa-solid fa-angle-left"></i></a>
				<a href="#" class="page1">1</a>
				<a href="#" class="next"><i class="fa-solid fa-angle-right"></i></a>
			</div>
		</div>
	</div>
</body>
</html>