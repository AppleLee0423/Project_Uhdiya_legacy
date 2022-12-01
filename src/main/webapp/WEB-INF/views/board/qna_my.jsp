<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="qna_list" value="${qnaMap.qna_list}" />
<c:set var="total_qna" value="${qnaMap.total_qna}" />
<c:set var="section" value="${qnaMap.section}" />
<c:set var="pageNum" value="${qnaMap.pageNum}" />
<!DOCTYPE html>
<html>
<head>
<script src="https://kit.fontawesome.com/96e0fede2d.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script>
	function search(){
		let keyword = document.getElementById('search_box').value;
		location.href='${path}/board/qna_my?keyword='+keyword;
	}
</script>
<style>
	.qna{margin:50px auto; padding:0 350px;}
	.qna_header{display:flex; text-align: left; padding-bottom: 10px; justify-content: space-between;}
	.qna_header_one{display: block;}
	.qna_header_two{display: block; padding-right: 5px;}
	.qna_header_title{font-size: large;}
	.qna_my_table {
	border: 2px outset #D6DCD8;
	border-collapse: collapse;
}
.qna_my_table td{vertical-align: middle;}
.qna_my_table tr, td {
	border: 1px solid #D6DCD8;
	border-collapse: collapse;
	height: 40px;
}

.qna_my_table thead tr td {
	background-color: #FBFAFA;
}

.qna_my_num {
	width: 3%;
	text-align: center;
	min-width: 30px;
}

.qna_my_product_code {
	width: 10%;
	text-align: center;
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
	max-width: 100px;
	font-size: small;
	padding-left: 5px;
}

.qna_my_title {
	width: 20%;
	padding-left: 10px;
	min-width: 300px;
}

.qna_my_writeDate {
	width: 5%;
	text-align: center;
	min-width: 90px;
}

.qna_my_status {
	width: 5%;
	text-align: center;
	min-width: 90px;
}
.qna_paging {
	width: 10%;
	margin: 0 auto;
	display: flex;
	padding-top: 20px;
	justify-content: space-evenly;
}

.prev, .next {
	text-align: center;
	width: 30px;
	cursor: pointer;
}

.prev {
	margin-right: 10px;
}

.next {
	margin-left: 10px;
}

a {
	text-decoration: none;
	color: black;
}

.qna_search {
	padding-top: 20px;
}

#search_box {
	border: 2px solid #474948;
	border-radius: 2px;
	height: 20px;
	padding-left: 5px;
}

#search_button {
	border-radius: 2px;
	width: 50px;
	height: 25px;
	background-color: #474948;
	color: white;
}
.qna_button{height: 30px; border-radius: 2px; background-color: #474948; color: white; cursor: pointer;}
</style>
</head>
<body>
 	<div class="qna">
		<div class="qna_header">
			<div class="qna_header_one">
				<div class="qna_header_title"><b>QnA / <font style="font-weight: bolder;">${sessionScope.member.member_id}님</font></b></div>
				<div class="qna_header_count" style="padding-top:10px;">총 ${total_qna}건</div>
			</div>
			<div class="qna_header_two">
				<div class="empty">&nbsp;</div>
				<div class="qna_header_back"><input type="button" class="qna_button" onclick="history.back()" value="목록보기"/></div>
			</div>
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
					<c:if test="${empty qna_list}">
						<tr>
							<td align="center" colspan="5">작성된 문의가 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${not empty qna_list}">
						<c:forEach var="qna" items="${qna_list}" varStatus="num">
							<tr>
								<td class="qna_my_num">${(total_qna) - (num.index)}</td>
								<td class="qna_my_product_code">${qna.product_name}</td>
								<td class="qna_my_title"><a href="${path}/board/qna_page?qna_id=${qna.qna_id}&qna_writeId=${qna.qna_writeId}">${qna.qna_title}</a></td>
								<td class="qna_my_writeDate">${qna.qna_regDate}</td>
								<c:if test="${qna.qna_status == 0}">
									<td class="qna_my_status">답변대기</td>
								</c:if>
								<c:if test="${qna.qna_status == 1}">
									<td class="qna_my_status">답변완료</td>
								</c:if>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>
		<c:if test="${not empty total_qna}">
			<div class="qna_paging">
			<c:choose>
				<c:when test="${total_qna > 50}">
					<c:forEach var="page" begin="1" end="5" step="1">
						<c:if test="${section > 1 && page == 1}">
							<a href="${path}/board/qna_my?section=${section-1}&pageNum=${5}" class="prev"><i class="fa-solid fa-angle-left"></i></a>
						</c:if>
							<a href="${path}/board/qna_my?section=${section}&pageNum=${page}" class="page">${(section-1)*10+page}</a>
						<c:if test="${page == 5}">
							<a href="${path}/board/qna_my?section=${section+1}&pageNum=${1}" class="next"><i class="fa-solid fa-angle-right"></i></a>
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
								<a href="${path}/board/qna_my?section=${section}&pageNum=${page}" class="page">${page}</a>
							</c:when>
							<c:otherwise>
								<a href="${path}/board/qna_my?section=${section}&pageNum=${page}" class="page">${page}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
			</c:choose>
			</div>
		</c:if>
		<c:if test="${not empty keyword}">
			<div class="qna_search">
				<input type="text" name="qna_search" id="search_box" value="${keyword}"/>
				<button id="search_button" onclick="search()">검색</button>
			</div>
		</c:if>
		<c:if test="${empty keyword}">
			<div class="qna_search">
				<input type="text" name="qna_search" id="search_box" />
				<button id="search_button" onclick="search()">검색</button>
			</div>
		</c:if>
	</div>
</body>
</html>