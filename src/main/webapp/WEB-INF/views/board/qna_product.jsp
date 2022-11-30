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
<c:set var="member_id" value="${member.member_id}" />
<c:set var="product_code" value="${param.product_code}" />
<!DOCTYPE html>
<html>
<head>
<!-- Remember to include jQuery :) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>

<!-- jQuery Modal -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<script src="https://kit.fontawesome.com/96e0fede2d.js" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
	.qna{width:900px; margin:0 auto;}
	.modal{max-width: 800px; padding: 0;}
	.blocker{rgba(0,0,0,0.5);}
	.qna_header{display:flex; text-align: left; padding-bottom: 10px; justify-content: space-between;}
	.qna_header_one{display: block;}
	.qna_header_two{display: block; padding-right: 5px;}
	.qna_header_title{font-size: large;}
	.qna_body{margin: 20px auto; width:100%;}
	.qna_product_table{border: 2px outset #D6DCD8; border-collapse: collapse; width:100%;}
	.qna_product_table thead tr td {background-color: #FBFAFA;}
	.qna_product_table tr{border-bottom: 1px solid #D6DCD8;}
	.qna_product_table td {height:40px; vertical-align: middle;}
	.qna_product_num{width:50px;}
	.qna_product_title{width:300px;}
	.qna_product_writer{width:100px;}
	.qna_product_writeDate{width:100px;}
	.qna_product_status{width:100px;}
	.qna_add{text-align:-webkit-right;	padding-top: 5px;}
	.qna_add_button {width:100px; height: 25px; border-radius: 2px; background-color: #474948; color: white; text-align: center; padding:0; padding-top:8px; font-size:12pt;}
	button{border:0; background-color: transparent; color:white;}
	.qna_modal {
		display: none;
		position: fixed;
		z-index: 999;
		left: 0;
		top: 0;
		width: 100%;
		height: 100%;
		overflow: auto;
		background-color: rgb(0,0,0);
		background-color: rgba(0,0,0,0.4);
	}
	.qna_modal-content {
		width: 800px;
		position: absolute;
		top: 15%;
		left: 25%;
		background-color: #fefefe;
		border: 1px solid #888;
	}
</style>
<script>
	$(document).ready(function(){
		let qna_modal = $('.qna_modal');
		let qna_open = $('#qna_modal_btn');
		
		$('#qna_modal_btn').click(function(){
			$('.qna_modal').css("display","block");
			$('body').css("overflow","hidden");
		});
		
		$('.qna_close').click(function(){
			$('.qna_modal').css("display","none");
			$('body').css("overflow","unset");
		});
	});
	
	window.onclick = function(event){
		if(event.target.className == 'qna_modal'){
			event.target.style.display = "none";
			$('.review_modal').css("display","none");
			$('.qna_modal').css("display","none");
			$('body').css("overflow","unset");
		};
	}

	function req_login(){
		alert('로그인이 필요한 서비스입니다.');
		location.href='${path}/member/login';
	}
	
	function modal_set(){
		let qna_modal_btn = document.querySelect('#qna_modal_btn');
		let qna_form = document.querySelect('#qna_form');
		let review_form = document.querySelect('#review_form');
		qna_modal_btn.addEventListener('click', function(){
			qna_form.css("display","block");
			review_form.css("display","none");
		});
	}
</script>
</head>
<body>
<div class="qna">
		<div class="qna_header">
			<div class="qna_header_one">
				<div class="qna_header_title"><b>QnA</b></div>
				<div class="qna_header_subtitle"><font size="2">상품에 대해 궁금한점을 해결해 드립니다.</font></div>
			</div>
			<div class="qna_header_two">
				<div class="empty">&nbsp;</div>
				<div class="qna_header_count"><font size="2">총 ${total_qna} 건</font></div>
			</div>
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
							<td class="qna_product_title" style="text-align: left;"><a href="${path}/board/qna_page?qna_id=${qna.qna_id}&qna_writeId=${qna.qna_writeId}"><i class="fa-solid fa-lock"></i>&nbsp;&nbsp;${qna.qna_title}</a></td>
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
								<td class="qna_product_status"><b>답변완료</b></td>
							</c:if>
						</tr>
					</c:forEach>
				</c:if>
			</table>
			
			<c:if test="${empty member_id}">
				<div class="qna_add">
					<p class="qna_add_button" align="right"><button onclick="req_login()">문의하기</button></p>
				</div>
			</c:if>
			
			<c:if test="${not empty member_id}">
				<div class="qna_add">
					<p class="qna_add_button" align="right"><button id="qna_modal_btn">문의하기</button></p>
				</div>
				
				<!-- Modal의 내용 -->
				<div class="qna_modal"> 
					<div class="qna_modal-content">
						<!-- <span class="review_close">&times;</span>        -->                  
						<c:import url="/board/qnaForm">
							<c:param name="product_code" value="${product_code}" />
							<c:param name="product_cateL" value="${param.product_cateL}" />
							<c:param name="product_cateS" value="${param.product_cateS}" />
						</c:import>
					</div>
				</div>
			</c:if>
			
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