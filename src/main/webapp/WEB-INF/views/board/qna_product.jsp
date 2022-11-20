<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path}/resources/css/reset.css" />
<link rel="stylesheet" href="${path}/resources/css/qna.css" />
<script src="https://kit.fontawesome.com/96e0fede2d.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<div class="qna">
		<div class="qna_header">
			<div class="qna_header_title"><b>QnA</b></div>
			<div class="qna_header_subtitle"><font size="2">상품에 대해 궁금한점을 해결해 드립니다.</font></div>
		</div>
		<div class="qna_body">
			<table class="qna_product_table">
				<thead>
					<tr>
						<td class="qna_product_num">번호</td>
						<td class="qna_product_title" style="text-align: center;">제목</td>
						<td class="qna_product_writer">작성자</td>
						<td class="qna_product_writeDate">작성일</td>
						<td class="qna_product_status">답변상태</td>
					</tr>
				</thead>
				<tr>
					<td class="qna_product_num">1</td>
					<td class="qna_product_title"><a href="#"><i class="fa-solid fa-lock"></i>&nbsp;문의드립니다</a></td>
					<td class="qna_product_writer">ho**</td>
					<td class="qna_product_writeDate">2022-11-13</td>
					<td class="qna_product_status">답변대기</td>
				</tr>
			</table>
			<div class="qna_add">
				<button class="qna_add_button">상품 문의하기</button>
			</div>
			<div class="qna_paging">
				<a href="#" class="prev"><i class="fa-solid fa-angle-left"></i></a>
				<a href="#" class="page1">1</a>
				<a href="#" class="next"><i class="fa-solid fa-angle-right"></i></a>
			</div>
		</div>
	</div>
</body>
</html>