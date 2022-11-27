<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="qna_list" value="${qnaMap.qna_list}" />
<c:set var="total_qna" value="${qnaMap.total_qna}" />
<c:set var="section" value="${qnaMap.section}" />
<c:set var="pageNum" value="${qnaMap.pageNum}" />
<c:set var="member_id" value="${param.member_id}" />
<c:set var="product_code" value="${param.product_code}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path}/resources/css/reset.css" />
<link rel="stylesheet" href="${path}/resources/css/qna.css" />
<script src="https://kit.fontawesome.com/96e0fede2d.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
	.qna_header{display: block; text-align: left;}
	
</style>
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
				<c:if test="${empty qna_list}">
					<tr>
						<td align="center" colspan="5">작성된 문의가 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty qna_list}">
					<c:forEach var="qna" items="${qna_list}" varStatus="num">
						<tr>
							<td class="qna_product_num">${total_qna - num.index}</td>
							<td class="qna_product_title" style="text-align: left;"><a href="${path}/board/qna_page?qna_id=${qna.qna_id}&qna_writeId=${qna.qna_writeId}"><i class="fa-solid fa-lock"></i>&nbsp;${qna.qna_title}</a></td>
							<td class="qna_product_writer">
								<c:if test="${fn:length(qna.qna_writeId) < 5}">
									${fn:substring(qna.qna_writeId,0,2)}
									<c:forEach begin="3" end="${fn:length(qna.qna_writeId)}" step="1">
										*
									</c:forEach>
								</c:if>
								<c:if test="${fn:length(qna.qna_writeId) > 5}">
									${fn:substring(qna.qna_writeId,0,3)}
									<c:forEach begin="4" end="${fn:length(qna.qna_writeId)}" step="1">
										*
									</c:forEach>
								</c:if>
							</td>
							<td class="qna_product_writeDate">${qna.qna_regDate}</td>
							<c:if test="${qna.qna_status == 0}">
								<td class="qna_product_status">답변대기</td>
							</c:if>
							<c:if test="${qna.qna_status == 1}">
								<td class="qna_product_status">답변완료</td>
							</c:if>
						</tr>
					</c:forEach>
				</c:if>
			</table>
			<div class="qna_add">
				<a href="${path}/board/qnaForm?qna_writeId=${member_id}&product_code=${product_code}&product_cateL=${param.product_cateL}&product_cateS=${param.product_cateS}" class="qna_add_button" >상품 문의하기</a>
			</div>
			<c:if test="${not empty total_qna}">
			<div class="qna_paging">
			<c:choose>
				<c:when test="${total_qna > 50}">
					<c:forEach var="page" begin="1" end="5" step="1">
						<c:if test="${section > 1 && page == 1}">
							<a href="${path}/board/qna_product?section=${section-1}&pageNum=${5}" class="prev"><i class="fa-solid fa-angle-left"></i></a>
						</c:if>
							<a href="${path}/board/qna_product?section=${section}&pageNum=${page}" class="page">${(section-1)*10+page}</a>
						<c:if test="${page == 5}">
							<a href="${path}/board/qna_product?section=${section+1}&pageNum=${1}" class="next"><i class="fa-solid fa-angle-right"></i></a>
						</c:if>
					</c:forEach>
				</c:when>
				<c:when test="${total_qna == 50}">
					<c:forEach var="page" begin="1" end="5" step="1">
						<a href="#" class="page">${page}</a>
					</c:forEach>
				</c:when>
				<c:when test="${total_qna < 50}">
					<c:forEach var="page" begin="1" end="${total_qna/5 + 1}" step="1">
						<c:choose>
							<c:when test="${page == pageNum}">
								<a href="${path}/board/qna_product?section=${section}&pageNum=${page}" class="page">${page}</a>
							</c:when>
							<c:otherwise>
								<a href="${path}/board/qna_product?section=${section}&pageNum=${page}" class="page">${page}</a>
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