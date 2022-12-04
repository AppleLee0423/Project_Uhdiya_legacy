<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="total_qna" value="${qnaMap.total_qna }" />
<c:set var="qna_list" value="${qnaMap.qna_list}" />
<c:set var="reply_list" value="${qnaMap.reply_list}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://kit.fontawesome.com/96e0fede2d.js" crossorigin="anonymous"></script>
<style>
	.list_header{display:flex; justify-content:space-between; height:50px; border-bottom: 2px solid #A6A7AB; background-color: #F8F9FD;}
	.list_header span{text-align: center; font-weight: bold; padding-top:13px; margin-right:10px;}
	.list_content {min-height:50px;}
	.list_content span{margin-top:13px; margin-right:10px;}
	summary{display: flex; justify-content: space-between; text-align: center; min-height:50px;}
	#num{width:5%; text-align: center;}
	#product{width:15%; overflow: hidden; white-space: nowrap; text-align: center;}
	.list_content #product {font-size: small; white-space: nowrap; text-align: center; display: block;}
	#title{width:40%;}
	#writer{width:10%; text-align: center;}
	#date{width:10%; text-align: center;}
	#status{width:10%; text-align: center;}
	#delete{width:10%; text-align: center; margin-right:0;}
	summary>#title{text-align: left;}
	.content_inner{border-top:1px solid #A6A7AB; border-bottom:1px solid #A6A7AB; background-color: #F7F8FA; padding-left: 100px;}
	.user_content{min-height: 50px; display: flex;}
	.reply_content{display: flex; min-height: 50px; justify-content: space-between;}
	#reply_front{color:#525253; width:20px;}
	#reply_second{background-color:#525253; color:white; border-radius: 3px; height:100%; width:35px;}
	#reply_content{width:795px; border-bottom:1px solid #A6A7AB;}
	#reply_btn, #delete_btn {height: 30px; border-radius: 2px; border:1px solid #474948; cursor: pointer; width:75px; background-color: #F8F9FD;}
	#reply_btn:hover, #delete_btn:hover {background-color: #474948; color:white;}

	.reply_modal {display: none; position: fixed; z-index: 999; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgb(0,0,0); 
		background-color: rgba(0,0,0,0.4);}
	.reply_modal-content {width: 800px; position: absolute; top: 15%; left: 25%; background-color: #fefefe; border: 1px solid #888;}
</style>
<script>
	$(function(){
		let reply_modal = $('.reply_modal');
		let reply_open = $('#reply_btn');
		
		$('#reply_btn').click(function(){
			$('.reply_modal').css("display","block");
			$('body').css("overflow","hidden");
		});
		
		$('#reply_close_btn').click(function(){
			$('.reply_modal').css("display","none");
			$('body').css("overflow","unset");
		});
	});

	function modal_set(){
		let reply_modal_btn = document.querySelect('#reply_btn');
		let reply = document.querySelect('.reply');
		reply_modal_btn.addEventListener('click', function(){
			reply.css("display","block");
		});
	}
</script>
</head>
<body>
	<div class="input_content">
		<div class="list_header">
			<span id="num">번호</span>
			<span id="product">상품명</span>
			<span id="title">제목</span>
			<span id="writer">작성자</span>
			<span id="date">작성일</span>
			<span id="status">답변상태</span>
			<span id="delete">삭제</span>
		</div>
		<c:if test="${empty qna_list}">
	<div class="list_content" style="border-bottom: 1px solid #A6A7AB; display: block;">
	<p id="empty_content" align="center" style="padding-top:13px;">작성된 문의가 없습니다.</p>
	<p id="empty_content" align="center" style="padding-top:13px;">${qna_list}</p>
	<p id="empty_content" align="center" style="padding-top:13px;">${reply_list}</p>
	</div>
	</c:if>
	<c:if test="${not empty qna_list}"></c:if>
	<div class="list_content">
	<c:forEach var="qna" items="${qna_list}" varStatus="qna_num">
	<details>
		<summary>
			<span id="num">${total_qna - qna_num.index}</span>
	<span id="product">${qna.product_name}</span>
	<span id="title">&nbsp;&nbsp;${qna.qna_title}</span>
	<span id="writer">${qna.qna_writeId}</span>
	<span id="date">${qna.qna_regDate}</span>
	<c:if test="${qna.qna_status == 0}">
	<span id="status"><button id="reply_btn">답변하기</button></span>
	</c:if>
	<c:if test="${qna.qna_status == 1}">
	<span id="status">답변완료</span>
	</c:if>
		<span id="delete"><button id="delete_btn">삭제</button></span>
	</summary>
		<div class="content_inner">
			<div class="user_content">
				<span id="content">${qna.qna_content}</span>
	</div>
	<c:forEach var="reply" items="${reply_list}">
	<c:if test="${reply.qna_parentId == qna.qna_id}">
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
	
	<!-- Modal의 내용 -->
	<div class="reply_modal"> 
		<div class="reply_modal-content">             
			<c:import url="/board/reply">
	<c:param name="qna_id" value="${qna.qna_id}"></c:param>
	</c:import>
		</div>
	</div>
	</c:forEach>
		</div>
	</div>
</body>
</html>