<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% request.setCharacterEncoding("UTF-8"); %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="notice_list" value="${noticeMap.notice_list}" />
<c:set var="total_notice" value="${noticeMap.total_notice}" />
<c:set var="section" value="${noticeMap.section}" />
<c:set var="pageNum" value="${noticeMap.pageNum}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path}/resources/css/reset.css" />
<link rel="stylesheet" href="${path}/resources/css/notice.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://kit.fontawesome.com/96e0fede2d.js" crossorigin="anonymous"></script>
</head>
<style>
	.notice{margin:40px auto;}
</style>
<script>
	function search(){
		let keyword = document.getElementById('search_box').value;
		location.href='${path}/board/notice?keyword='+keyword;
	}
</script>
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
								<td class="notice_num">${notice.notice_id}</td>
								<td class="notice_title"><a href="${path}/board/notice_page?notice_id=${notice.notice_id}">${notice.notice_title}</a></td>
								<td class="notice_writeDate">${notice.notice_regDate}</td>
								<td class="notice_count">${notice.notice_count}</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>
		<c:if test="${member.member_id == 'admin'}">
		<div class="notice_admin">
			<a href="${path}/board/noticeForm" id="notice_add">등록하기</a>
		</div>
		</c:if>
		
		<c:if test="${not empty total_notice}">
			<div class="notice_paging">
			<c:choose>
				<c:when test="${total_notice > 50}">
					<c:forEach var="page" begin="1" end="5" step="1">
						<c:if test="${section > 1 && page == 1}">
							<a href="${path}/board/notice?section=${section-1}&pageNum=${5}" class="prev"><i class="fa-solid fa-angle-left"></i></a>
						</c:if>
							<a href="${path}/board/notice?section=${section}&pageNum=${page}" class="page">${(section-1)*10+page}</a>
						<c:if test="${page == 5}">
							<a href="${path}/board/notice?section=${section+1}&pageNum=${1}" class="next"><i class="fa-solid fa-angle-right"></i></a>
						</c:if>
					</c:forEach>
				</c:when>
				<c:when test="${total_notice == 50}">
					<c:forEach var="page" begin="1" end="5" step="1">
						<a href="#" class="page">${page}</a>
					</c:forEach>
				</c:when>
				<c:when test="${total_notice < 50}">
					<c:forEach var="page" begin="1" end="${total_notice/5 + 1}" step="1">
						<c:choose>
							<c:when test="${page == pageNum}">
								<a href="${path}/board/notice?section=${section}&pageNum=${page}" class="page">${page}</a>
							</c:when>
							<c:otherwise>
								<a href="${path}/board/notice?section=${section}&pageNum=${page}" class="page">${page}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
			</c:choose>
			</div>
		</c:if>
		<c:if test="${not empty keyword}">
			<div class="notice_search">
				<input type="text" name="notice_search" id="search_box" value="${keyword}"/>
				<button id="search_button" onclick="search()">검색</button>
			</div>
		</c:if>
		<c:if test="${empty keyword}">
			<div class="notice_search">
				<input type="text" name="keyword" id="search_box" />
				<button id="search_button" onclick="search()">검색</button>
			</div>
		</c:if>
	</div>
</body>
</html>