<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="review_list" value="${reviewMap.review_list}" />
<c:set var="total_review" value="${reviewMap.total_review}" />
<c:set var="section" value="${reviewMap.section}" />
<c:set var="pageNum" value="${reviewMap.pageNum}" />
<%-- 
<c:set var="member_id" value="${member.member_id}" />
<c:set var="product_code" value="${reviewMap.product_code}" />
 --%>
<c:set var="member_id" value="hong" />
<c:set var="product_code" value="001" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path}/resources/css/reset.css" />
<link rel="stylesheet" href="${path}/resources/css/review.css" />
<script src="https://kit.fontawesome.com/96e0fede2d.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
	.review_header{display: block; text-align: left;}
	
</style>
<script>
	function go_review(){
		//if(${member_id} != null || ${member_id} != ''){
			//let url = '${path}/board/reviewForm?member_id="${member_id}"&product_code="${product_code}"';
			let url = '${path}/board/reviewForm?member_id='+"hong"+'&product_code='+"001";
			let option = 'width=650px, height=550px, top=300px, left=300px scrollbars=yes';
			window.open(url,'pop',option);
		/* 
		} else {
			alert('로그인 후 이용가능합니다.');
			location.href='${path}/board/login';
		}
		*/
	}
</script>
</head>
<body>
<div class="review">
		<div class="review_header">
			<div class="review_header_title"><b>review</b></div>
			<div class="review_header_subtitle"><font size="2">상품에 대해 궁금한점을 해결해 드립니다.</font></div>
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
				<c:if test="${empty review_list}">
					<tr>
						<td align="center" colspan="5">작성된 문의가 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty review_list}">
					<c:forEach var="review" items="${review_list}" varStatus="num">
						<tr>
							<td class="review_product_num">${total_review - num.index}</td>
							<td class="review_product_star">
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
							<td class="review_product_title" style="text-align: left;"><a href="${path}/board/review_page?review_id=${review.review_id}&review_writeId=${review.review_writeId}"><i class="fa-solid fa-lock"></i>&nbsp;${review.review_title}</a></td>
							<td class="review_product_writer">${review.review_writeId}</td>
							<td class="review_product_writeDate">${review.review_regDate}</td>
						</tr>
					</c:forEach>
				</c:if>
			</table>
			<div class="review_add">
				<a href="${path}/board/reviewForm?review_writeId=${member_id}&product_code=${product_code}" class="review_add_button">상품 문의하기</a>
			</div>
			<c:if test="${not empty total_review}">
			<div class="review_paging">
			<c:choose>
				<c:when test="${total_review > 50}">
					<c:forEach var="page" begin="1" end="5" step="1">
						<c:if test="${section > 1 && page == 1}">
							<a href="${path}/board/review_product?section=${section-1}&pageNum=${5}" class="prev"><i class="fa-solid fa-angle-left"></i></a>
						</c:if>
							<a href="${path}/board/review_product?section=${section}&pageNum=${page}" class="page">${(section-1)*10+page}</a>
						<c:if test="${page == 5}">
							<a href="${path}/board/review_product?section=${section+1}&pageNum=${1}" class="next"><i class="fa-solid fa-angle-right"></i></a>
						</c:if>
					</c:forEach>
				</c:when>
				<c:when test="${total_review == 50}">
					<c:forEach var="page" begin="1" end="5" step="1">
						<a href="#" class="page">${page}</a>
					</c:forEach>
				</c:when>
				<c:when test="${total_review < 50}">
					<c:forEach var="page" begin="1" end="${total_notice/5 + 1}" step="1">
						<c:choose>
							<c:when test="${page == pageNum}">
								<a href="${path}/board/review_product?section=${section}&pageNum=${page}" class="page">${page}</a>
							</c:when>
							<c:otherwise>
								<a href="${path}/board/review_product?section=${section}&pageNum=${page}" class="page">${page}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
			</c:choose>
			</div>
		</c:if>
		</div>
	</div>
</body>
</html>