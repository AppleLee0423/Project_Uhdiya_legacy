<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../css/reset.css" />
<link rel="stylesheet" href="../css/notice.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
	<div class="notice">
		<div class="notice_header">
			<div class="notice_header_title"><b>NOTICE</b> <span class="notice_header_partition">I</span> 1 </div>
			<a href="#" id="notice_detail_list">목록보기</a>
		</div>
		<div class="notice_content">
			<div class="notice_detail_table">
				<ul>
					<li class="notice_table_header">
						<h3 class="notice_detail_title">이디야커피, 카카오프렌즈와 연간 협업 진행</h3>
						<span class="notice_detail_writeDate">2022.11.13</span>
						<span class="notice_detail_partition">I</span>
						<span class="notice_detail_count">1999</span>
					</li>
					<li class="notice_table_body">
						<div class="notice_table_content">이디야커피, 카카오프렌즈와 연간 협업 진행<br>
						2019년 한 해 동안 시즌 음료·MD 상시 출시, 이벤트도<br>
						첫 협업 제품 ‘어피치 블라썸 라떼’·‘어피치 블라썸 티’ 12일 출시<br></div>
					</li>
					<li class="notice_table_image">
						<img src="../../../resources/file/notice_repo/2019030500136_0.jpg" alt="" />
					</li>
				</ul>
			</div>
		</div>
		<div class="notice_detail_button">
			<a href="#" id="notice_detail_update">수정하기</a>
			<a href="#" id="notice_detail_delete">삭제하기</a>
		</div>
	</div>
</body>
</html>