<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="review_list" value="${reviewMap.review_list}" />
<c:set var="total_review" value="${reviewMap.total_review}" />
<c:set var="section" value="${reviewMap.section}" />
<c:set var="pageNum" value="${reviewMap.pageNum}" />
<c:set var="member_id" value="${param.member_id}" />
<c:set var="product_code" value="${param.product_code}" />
<!DOCTYPE html>
<html>
<head>
<script src="https://kit.fontawesome.com/96e0fede2d.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
	.review{width:900px; margin:0 auto;}
	.review_header{display:flex; text-align: left; padding-bottom: 10px; justify-content: space-between;}
	.review_header_one{display: block;}
	.review_header_two{display: block; padding-right: 5px;}
	.review_header_title{font-size: large;}
	.review_body{margin: 20px auto; width:100%;}
	.review_product_table{border: 2px outset #D6DCD8; border-collapse: collapse; width:100%;}
	.review_product_table thead tr td {background-color: #FBFAFA;}
	.review_product_table tr{border-bottom: 1px solid #D6DCD8;}
	.review_product_table td {height:40px; vertical-align: middle;}
	.review_product_num{width:50px;}
	.review_product_star{width:100px;}
	.review_product_title{width:300px;}
	.review_product_writer{width:100px;}
	.review_product_writeDate{width:100px;}
	.review_add{text-align: right;	padding-top: 5px;}
	.review_add_button {height: 30px; border-radius: 2px; background-color: #474948; color: white;}
	.rate_in {color: rgba(91, 44, 54, 0.99);}
	.rate_out {color: rgb(108, 117, 125, 0.99);}
</style>
<script>
	function review_add(){
		location.href='${path}/board/reviewForm?review_writeId=${member_id}&product_code=${product_code}&product_cateL=${param.product_cateL}&product_cateS=${param.product_cateS}';
	}
</script>
</head>
<body>
	<div class="review">
		<div class="review_header">
			<div class="review_header_one">
				<div class="review_header_title"><b>REVIEW</b></div>
				<div class="review_header_subtitle"><font size="2">상품의 사용후기를 적어주세요.</font></div>
			</div>
			<div class="review_header_two">
				<div class="empty">&nbsp;</div>
				<div class="review_header_count"><font size="2">총 ${total_review} 건</font></div>
			</div>
		</div>

		<div class="review_body">
			<table class="review_product_table">
				<thead>
					<tr>
						<td class="review_product_num">번호</td>
						<td class="review_product_title" style="text-align: center;">제목</td>
						<td class="review_product_writer">작성자</td>
						<td class="review_product_writeDate">작성일</td>
						<td class="review_product_star">별점</td>
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
							<td class="review_product_title" style="text-align: left;">
								<a href="${path}/board/review_page?review_id=${review.review_id}&review_writeId=${review.review_writeId}">
								<i class="fa-solid fa-lock"></i>&nbsp;&nbsp;${review.review_title}</a>
							</td>
							<td class="review_product_writer">
								<c:if test="${fn:length(review.review_writeId) < 5}">
									${fn:substring(review.review_writeId,0,2)}
									<c:forEach begin="3" end="${fn:length(review.review_writeId)}" step="1">
										*
									</c:forEach>
								</c:if>
								<c:if test="${fn:length(review.review_writeId) > 5}">
									${fn:substring(review.review_writeId,0,3)}
									<c:forEach begin="4" end="${fn:length(review.review_writeId)}" step="1">
										*
									</c:forEach>
								</c:if>
							</td>
							<td class="review_product_writeDate">${review.review_regDate}</td>
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
						</tr>
					</c:forEach>
				</c:if>
			</table>
			<div class="review_add">
				<input type="button" class="review_add_button" onclick="review_add()" value="후기 작성하기"/>
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