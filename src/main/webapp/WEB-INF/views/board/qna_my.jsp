<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../css/reset.css" />
<link rel="stylesheet" href="../css/qna.css" />
<script src="https://kit.fontawesome.com/96e0fede2d.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
 	<div class="qna">
		<div class="qna_header">
			<div class="qna_header_title"><b>QnA</b></div>
			<div class="qna_header_count">총 1건</div>
		</div>
		<div class="qna_body">
			<table class="qna_my_table">
				<thead>
					<tr>
						<td class="qna_my_num">번호</td>
						<td class="qna_my_product_code" width="100px">상품</td>
						<td class="qna_my_title">제목</td>
						<td class="qna_my_writeDate">작성일</td>
						<td class="qna_my_status">답변상태</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="qna_my_num">1</td>
						<td class="qna_my_product_code">홀빈커피 페르소나 블렌드 200g X 2개</td>
						<td class="qna_my_title"><a href="#">홀가득커피는 없나요? 키키키</a></td>
						<td class="qna_my_writeDate">2022-11-13</td>
						<td class="qna_my_status">답변대기</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="qna_paging">
			<a href="#" class="prev"><i class="fa-solid fa-angle-left"></i></a>
			<a href="#" class="page1">1</a>
			<a href="#" class="next"><i class="fa-solid fa-angle-right"></i></a>
		</div>
		<div class="qna_search">
			<input type="text" name="qna_search" id="search_box"/>
			<button id="search_button">검색</button>
		</div>
	</div>
</body>
</html>