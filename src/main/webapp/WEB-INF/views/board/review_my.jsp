<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="review_list" value="${reviewMap.review_list}" />
<c:set var="total_review" value="${reviewMap.total_review}" />
<c:set var="section" value="${reviewMap.section}" />
<c:set var="pageNum" value="${reviewMap.pageNum}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path}/resources/css/reset.css" />
<link rel="stylesheet" href="${path}/resources/css/review.css" />
<script src="https://kit.fontawesome.com/96e0fede2d.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
	.review{margin:50px auto; padding:0 350px;}
</style>
<script>
	function search(){
		let keyword = document.getElementById('search_box').value;
		location.href='${path}/board/review_my?keyword='+keyword;
	}
</script>
</head>
<body>
	<div class="review">
		<div class="review_header">
			<div class="review_header_title"><b>MY REVIEW</b></div>
			<div class="review_header_count">총 ${total_review}건</div>
		</div>
		<div class="review_body">
			<table class="review_my_table">
				<thead>
					<tr>
						<td class="review_my_num">번호</td>
						<td class="review_my_product_code" width="100px">상품</td>
						<td class="review_my_title">제목</td>
						<td class="review_my_star">별점</td>
						<td class="review_my_writeDate">작성일</td>
					</tr>
				</thead>
				<tbody>
				<c:if test="${empty review_list}">
					<tr>
						<td align="center" colspan="5">작성된 문의가 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty review_list}">
					<c:forEach var="review" items="${review_list}" varStatus="num">
						<tr>
						<td class="review_my_num">${total_review - num.index}</td>
						<td class="review_my_product_code">${review.product_code}</td>
						<td class="review_my_title"><a href="${path}/board/review_page?review_writeId=${review.review_writeId}&review_id=${review.review_id}">${review.review_title}</a></td>
						<td class="review_my_star">
							<span class="rate_in">
								<c:forEach	var="★" begin="1" end="${review.review_star}" step="1">
									★
								</c:forEach>
							</span>
							<span class="rate_out">
								<c:forEach	var="★" begin="1" end="${5-(review.review_star)}" step="1">
									★
								</c:forEach>
							</span>
						</td>
						<td class="review_my_writeDate">${review.review_regDate}</td>
					</tr>
					</c:forEach>
				</c:if>
				</tbody>
			</table>
		</div>
		<c:if test="${not empty total_review}">
			<div class="review_paging">
			<c:choose>
				<c:when test="${total_review > 50}">
					<c:forEach var="page" begin="1" end="5" step="1">
						<c:if test="${section > 1 && page == 1}">
							<a href="${path}/board/review_my?section=${section-1}&pageNum=${5}" class="prev"><i class="fa-solid fa-angle-left"></i></a>
						</c:if>
							<a href="${path}/board/review_my?section=${section}&pageNum=${page}" class="page">${(section-1)*10+page}</a>
						<c:if test="${page == 5}">
							<a href="${path}/board/review_my?section=${section+1}&pageNum=${1}" class="next"><i class="fa-solid fa-angle-right"></i></a>
						</c:if>
					</c:forEach>
				</c:when>
				<c:when test="${total_review == 50}">
					<c:forEach var="page" begin="1" end="5" step="1">
						<a href="#" class="page">${page}</a>
					</c:forEach>
				</c:when>
				<c:when test="${total_review < 50}">
					<c:forEach var="page" begin="1" end="${total_review/5 + 1}" step="1">
						<c:choose>
							<c:when test="${page == pageNum}">
								<a href="${path}/board/review_my?section=${section}&pageNum=${page}" class="page">${page}</a>
							</c:when>
							<c:otherwise>
								<a href="${path}/board/review_my?section=${section}&pageNum=${page}" class="page">${page}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
			</c:choose>
			</div>
		</c:if>
		<c:if test="${not empty keyword}">
			<div class="review_search">
				<input type="text" name="qna_search" id="search_box" value="${keyword}"/>
				<button id="search_button" onclick="search()">검색</button>
			</div>
		</c:if>
		<c:if test="${empty keyword}">
			<div class="review_search">
				<input type="text" name="qna_search" id="search_box" />
				<button id="search_button" onclick="search()">검색</button>
			</div>
		</c:if>
	</div>
</body>
</html>