<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../css/reset.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://kit.fontawesome.com/96e0fede2d.js" crossorigin="anonymous"></script>
<style>
 /* table,tr,td,th{border:1px solid black; border-collapse: collapse;} */
 #notice_tbl{border: 1px solid black;}
</style>
</head>
<body >
	<div class="notice">
		<div class="notice_header">
			<span class="title">NOTICE</span>
		</div>
		<div class="notice_table" align="center">
			<table id="notice_tbl">
				<tr>
					<td>번호</td>
					<td>제목</td>
					<td>작성자</td>
					<td>작성일</td>
					<td>조회수</td>
				</tr>
 			<c:if test="${empty noticeList}">
					<tr>
						<td colspan="5"> 작성된 글이 없습니다.</td>
					</tr>
				</c:if>
				<%-- <c:if test="${not empty noticeList}">
					<c:forEach var="notice" items="${noticeList}" varStatus="num">
					<tr>
						<td>${noticeList.size - num.index}</td>
						<td>${notice.title}</td>
						<td>${notice.writer}</td>
						<td>${notice.writeDate}</td>
						<td>${notice.cnt}</td>
					</tr>
					</c:forEach>
				</c:if> --%>
			</table>
		</div>
		<div class="pageingBar">
			<button class="preview"><i class="fa-solid fa-angle-left"></i></button>
			 1
			<button class="next"><i class="fa-solid fa-angle-right"></i></button>
		</div>
	</div>
</body>
</html>