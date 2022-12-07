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
<script src="https://kit.fontawesome.com/96e0fede2d.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
	.review{margin:50px auto; padding: 0 350px;}
	.review_header{display:flex; text-align: left; padding-bottom: 10px; justify-content: space-between;}
	.review_header_one{display: block;}
	.review_header_two{display: block; padding-right: 5px;}
	.review_header_title{font-size: large;}
	.review_body{margin: 20px auto; width:100%;}
	.review_my_table{border: 2px outset #D6DCD8; border-collapse: collapse; width:100%;}
	.review_my_table thead tr td {background-color: #FBFAFA;}
	.review_my_table tr{border-bottom: 1px solid #D6DCD8; text-align: center;}
	.review_my_table td {height:40px; vertical-align: middle;}
	.review_my_num{width:50px;}
	.review_my_product_code{width:100px; font-size: small; white-space: nowrap; text-overflow: ellipsis; overflow: hidden;}
	.review_my_title{width:300px;}
	.review_my_star{width:100px;}
	.review_my_writeDate{width:100px;}
	.my_review_image{width:100px; transition: all 1.0s;}
	.my_review_image:hover{transform:scale(3.0); overflow: hidden; z-index: 3;}
	.review_add{text-align:-webkit-right;	padding-top: 5px;}
	.review_add_button {width:100px; height: 25px; border-radius: 2px; background-color: #474948; color: white; text-align: center; padding:0; padding-top:8px; font-size:12pt;}
	.rate_in {color: rgb(248, 152, 29, 0.99);}
	.rate_out {color: rgb(108, 117, 125, 0.99);}
	.review_page_button{height: 30px; border-radius: 2px; background-color: #474948; color: white; cursor: pointer;}
	button{border:0; background-color: transparent; color:white;}
	.review_paging {
	width: 10%;
	margin: 0 auto;
	display: flex;
	padding-top: 20px;
	justify-content: space-evenly;
}

.review_search {
	padding-top: 20px;
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
	.review_my_delete{width:65px;}
	.delete_icon{font-size: large; cursor: pointer;}
	.fa-solid fa-xmark:hover {transform: scale(1.2); color:#2F2F2F;}
	.review_my_button{display: none;}
</style>
<script>
	function search(){
		let keyword = document.getElementById('search_box').value;
		location.href='${path}/board/review_my?keyword='+keyword;
	}
	function delete_review(review_id){
		if(confirm('삭제하시겠습니까?')){
			location.href='${path}/board/delete_review?review_id='+review_id;
		} else{
			alert('취소되었습니다.');
		}
	}
</script>
</head>
<body>
	<div class="review">
		<div class="review_header">
			<div class="review_header_one">
				<div class="review_header_title"><b>MY REVIEW / <font style="font-weight: bolder;">${sessionScope.member.member_id}님</font></b></div>
				<div class="review_header_count" style="padding-top:10px;">총 ${total_review}건</div>
			</div>
			<div class="review_header_two">
				<div class="empty">&nbsp;</div>
				<div class="review_header_back"><input type="button" class="review_page_button" onclick="history.back()" value="목록보기"/></div>
			</div>
		</div>
		<div class="review_body">
			<table class="review_my_table">
				<thead>
					<tr>
						<td class="review_my_num">번호</td>
						<td class="review_my_product_code">상품</td>
						<td class="review_my_title">제목</td>
						<td class="review_my_star">별점</td>
						<td class="review_my_writeDate">작성일</td>
						<td class="review_my_delete">삭제</td>
					</tr>
				</thead>
				<tbody>
				<c:if test="${empty review_list}">
					<tr>
						<td align="center" colspan="6">작성된 문의가 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty review_list}">
					<c:forEach var="review" items="${review_list}" varStatus="num">
						<tr>
						<td class="review_my_num">${total_review - num.index}</td>
						<td class="review_my_product_code">${review.product_name}</td>
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
						<td class="review_my_delete">
							<label class="delete_icon" for="delete_review_btn${num.index}"><i class="fa-solid fa-xmark"></i></label>
							<button id="delete_review_btn${num.index}" class="review_my_button" onclick="delete_review(${review.review_id})" ></button>
						</td>
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