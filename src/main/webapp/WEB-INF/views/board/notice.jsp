<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path}/resources/css/reset.css" />
<link rel="stylesheet" href="${path}/resources/css/notice.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://kit.fontawesome.com/96e0fede2d.js" crossorigin="anonymous"></script>
</head>
<body>
	<div class="notice">
		<div class="notice_header">
			<div class="notice_header_title"><b>NOTICE</b></div>
		</div>
		<div class="notice_content">
			<table class="notice_table">
				<thead>
					<tr>
						<td class="notice_num">번호</td>
						<td class="notice_title" style="text-align: center;">제목</td>
						<td class="notice_writeDate">작성일</td>
						<td class="notice_count">조회수</td>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty notice_list}">
						<tr>
							<td colspan="4" style="text-align: center;">작성한 글이 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${not empty notice_list}">
						<c:forEach var="notice" items="${notice_list}" varStatus="num">
							<tr>
								<td class="notice_num">${num.count}</td>
								<td class="notice_title"><a href="${path}/board/notice_page?notice_id=${notice.notice_id}">${notice.notice_title}</a></td>
								<td class="notice_writeDate">${notice.notice_regDate}</td>
								<td class="notice_count">${notice.notice_count}</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>
		<c:if test="${member.member_id == 'admin'}"></c:if>
		<div class="notice_admin">
			<a href="${path}/board/noticeForm" id="notice_add">등록하기</a>
		</div>
		
		<div class="notice_paging">
			<a href="#" class="prev"><i class="fa-solid fa-angle-left"></i></a>
			<a href="#" class="page1">1</a>
			<a href="#" class="next"><i class="fa-solid fa-angle-right"></i></a>
		</div>
		<div class="notice_search">
			<input type="text" name="notice_search" id="search_box"/>
			<button id="search_button">검색</button>
		</div>
	</div>
</body>
</html>