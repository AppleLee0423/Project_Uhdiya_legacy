<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="qna_list" value="${qnaMap.qna_list}" />
<c:set var="reply_list" value="${qnaMap.reply_list}" />
<c:set var="total_qna" value="${qnaMap.total_qna}" />
<c:set var="section" value="${qnaMap.section}" />
<c:set var="pageNum" value="${qnaMap.pageNum}" />
<!DOCTYPE html>
<html>
<head>
<script src="https://kit.fontawesome.com/96e0fede2d.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
	*{margin:0; padding:0;}
	.qna{margin:45px auto; width:1200px;}
	.qna_header{display:flex; text-align: left; padding-bottom: 10px; justify-content: space-between;}
	.qna_header_one{display: flex;}
	.qna_header_title{font-size: xx-large; font-weight: 600;}
	.qna_header_title>font {vertical-align: bottom;}
	.qna_header_two{display: block; padding-right: 5px;}
	.qna_button{height: 30px; border-radius: 2px; background-color: #474948; color: white; cursor: pointer; width:90px;}
	.qna_body{border-top: 2px solid black; border-bottom: 2px solid black;}
	.list_header{display:flex; justify-content:space-between; height:50px; border-bottom: 2px solid #A6A7AB;}
	.list_header span{text-align: center; font-weight: bold; padding-top:13px; }
	.list_content {min-height:50px;}
	.list_content span{margin-top:13px;}
	summary{display: flex; justify-content: space-between; text-align: center;height:50px;}
	#num{width:80px; text-align: center;}
	#product{width:250px; overflow: hidden; white-space: nowrap; text-align: center;}
	#title{width:600px;}
	#writer{width:90px; text-align: center;}
	#date{width:100px; text-align: center;}
	#status{width:90px; text-align: center;}
	#delete{width:50px;}
	summary>#title{text-align: left;}
	.content_inner{border-top:1px solid #A6A7AB; border-bottom:1px solid #A6A7AB; background-color: #F7F8FA; margin-top:20px; padding-left: 100px;}
	.user_content{min-height: 50px; display: flex;}
	.reply_content{display: flex; min-height: 50px; justify-content: space-between; border-top:1px solid #A6A7AB;}
	#reply_front{color:#525253; width:20px;}
	#reply_second{background-color:#525253; color:white; border-radius: 3px; height:100%; width:35px;}
	#reply_content{width:795px;}
	.qna_paging {width: 10%; margin: 0 auto; display: flex; padding-top: 20px; justify-content: space-evenly;}
	.prev, .next {text-align: center; width: 30px; cursor: pointer; }
	.prev {margin-right: 10px;}
	.next {margin-left: 10px;}
	a {text-decoration: none; color: black;}
	.qna_search {padding-top: 20px;}
	#search_box {border: 2px solid #474948; border-radius: 2px; height: 20px; padding-left: 5px;}
	#search_button {border-radius: 2px; width:90px; height: 25px; background-color: #474948; color: white;}
	.delete_icon{font-size: large; cursor: pointer;}
	label.delete_icon:hover{color:red;}
	.qna_my_button{display: none;}
</style>
<script>

	function search(){
		let keyword = document.getElementById('search_box').value;
		location.href='${path}/board/qna_my?keyword='+keyword;
	}
</script>
</head>
<body>
 	<div class="qna">
		<div class="qna_header">
			<div class="qna_header_one">
				<div class="qna_header_title"><h1>QnA</h1></div>
				&nbsp;&nbsp;&nbsp;
				<div class="qna_header_count" style="padding-top:20px;">총 ${total_qna}건</div>
			</div>
			<div class="qna_header_two">
				<div class="empty">&nbsp;</div>
				<div class="qna_header_back"><input type="button" class="qna_button" onclick="history.back()" value="목록보기"/></div>
			</div>
		</div>
		
		<div class="qna_body">
			<div class="list_header">
				<span id="num">번호</span>
				<span id="product">상품명</span>
				<span id="title">제목</span>
				<span id="date">작성일</span>
				<span id="status">답변상태</span>
				<span id="delete">삭제</span>
			</div>
			<c:if test="${empty qna_list}">
			<div class="list_content" style="border-bottom: 1px solid #A6A7AB; display: block;">
				<p id="empty_content" align="center" style="padding-top:13px;">작성된 문의가 없습니다.</p>
			</div>
			</c:if>
			<c:if test="${not empty qna_list}">
			<div class="list_content">
			<c:forEach var="qna" items="${qna_list}" varStatus="num">
				<details>
					<summary>
						<span id="num">${total_qna - num.index}</span>
						<span id="product">${qna.product_name}</span>
						<span id="title">&nbsp;&nbsp;${qna.qna_title}</span>
						<span id="date">${qna.qna_regDate}</span>
						<c:if test="${qna.qna_status == 0}">
							<span id="status">답변대기</span>
						</c:if>
						<c:if test="${qna.qna_status == 1}">
							<span id="status" style="color:blue;">답변완료</span>
						</c:if>
						<span id="delete">
							<label class="delete_icon" for="delete_qna_btn${num.index}"><i class="fa-solid fa-xmark"></i></label>
							<button id="delete_qna_btn${num.index}" class="qna_my_button" onclick="delete_qna(${qna.qna_id})" ></button>
						</span>
					</summary>
						<div class="content_inner">
							<div class="user_content">
								<span>${qna.qna_content}</span>
							</div>
							<c:forEach var="reply" items="${reply_list}">
								<c:if test="${reply.qna_parentId eq qna.qna_id}">
									<div class="reply_content">
										<span id="reply_front">└</span>
										<span id="reply_second">답변</span>
										<span id="reply_content">${reply.qna_content}</span>
										<span id="date" >${reply.qna_regDate}</span>
										<span id="writer">관리자</span>
									</div>
								</c:if>
							</c:forEach>
						</div>
				</details>
			</c:forEach>
			</div>
			</c:if>
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
	
<script>
function delete_qna(qna_id){
	if(confirm('삭제하시겠습니까?')){
		location.href='${path}/board/delete_qna?qna_id='+qna_id;
	} else{
		alert('취소되었습니다.');
	}
}
</script>
</body>
</html>