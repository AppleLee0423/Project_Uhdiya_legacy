<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="review_list" value="${reviewMap.review_list}" />
<c:set var="review_fileList" value="${reviewMap.review_fileList}" />
<c:set var="total_review" value="${reviewMap.total_review}" />
<c:set var="section" value="${reviewMap.section}" />
<c:set var="pageNum" value="${reviewMap.pageNum}" />
<c:set var="member_id" value="${member.member_id}" />
<c:set var="product_code" value="${param.product_code}" />
<!DOCTYPE html>
<html>
<head>
<script src="https://kit.fontawesome.com/96e0fede2d.js" crossorigin="anonymous"></script>
<script src="https://rawgit.com/jackmoore/autosize/master/dist/autosize.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
	.review{width:900px; margin:0 auto;}
	.review_header{display:flex; text-align: left; padding-bottom: 10px; justify-content: space-between;}
	.review_header_one{display: block;}
	.review_header_two{display: block; padding-right: 5px;}
	.review_header_title{font-size: large;}
	.review_body{margin: 20px auto; width:100%;}
	.review_product_table{border: 2px outset #D6DCD8; border-collapse: collapse; width:100%;}
	.review_product_table thead tr td {background-color: #FBFAFA;}
	.review_product_table tr{border-bottom: 1px solid #D6DCD8;}
	.review_product_table td {height:40px; vertical-align: middle;}
	.review_product_num{width:50px;}
	.review_product_star{width:100px;}
	.review_product_title{width:300px;}
	.review_product_writer{width:100px;}
	.review_product_writeDate{width:100px;}
	.product_review_image{width:100px; transition: all 1.0s;}
	.product_review_image:hover{transform:scale(3.0); overflow: hidden; z-index: 3;}
	.review_add{text-align:-webkit-right;	padding-top: 5px;}
	.review_add_button {width:100px; height: 25px; border-radius: 2px; background-color: #474948; color: white; text-align: center; padding:0; padding-top:8px; font-size:12pt;}
	.rate_in {color: rgb(248, 152, 29, 0.99);}
	.rate_out {color: rgb(108, 117, 125, 0.99);}
	[id ~= "content_"]{display: none;}
	button{border:0; background-color: transparent; color:white;}
	.review_modal {
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
	.review_modal-content {
		width: 800px;
		position: absolute;
		top: 15%;
		left: 25%;
		background-color: #fefefe;
		border: 1px solid #888;
	}
	.content_show{display: table-row;}
	.content_hide{display: none;}
</style>
<script>
	$(document).ready(function(){
		let review_modal = $('.review_modal');
		let review_open = $('#review_modal_btn');
		
		$('#review_modal_btn').click(function(){
			$('.review_modal').css("display","block");
			$('body').css("overflow","hidden");
		});
		
		$('.review_close').click(function(){
			$('.review_modal').css("display","none");
			$('body').css("overflow","unset");
		});
	});
	
	window.onclick = function(event){
		if(event.target.className == 'review_modal'){
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
</script>
</head>
<body>
	<div class="review">
		<div class="review_header">
			<div class="review_header_one">
				<div class="review_header_title"><b>REVIEW</b></div>
				<div class="review_header_subtitle"><font size="2">상품의 사용후기를 적어주세요.</font></div>
			</div>
			<div class="review_header_two">
				<div class="empty">&nbsp;</div>
				<div class="review_header_count"><font size="2">총 ${total_review} 건</font></div>
			</div>
		</div>

		<div class="review_body">
			<table class="review_product_table">
				<thead>
					<tr>
						<td class="review_product_num">번호</td>
						<td class="review_product_title" style="text-align: center;">제목</td>
						<td class="review_product_writer">작성자</td>
						<td class="review_product_writeDate">작성일</td>
						<td class="review_product_star">별점</td>
					</tr>
				</thead>
				<c:if test="${empty review_list}">
					<tr>
						<td align="center" colspan="5">작성된 문의가 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty review_list}">
					<c:forEach var="review" items="${review_list}" varStatus="num">
						<tr id="review_list" onclick="review_dropdown(this,${num.index})">
							<td class="review_product_num">${total_review - num.index}</td>
							<td class="review_product_title" style="text-align: left;">
								<a href="${path}/board/review_page?review_id=${review.review_id}">${review.review_title}</a> 
							</td>
							<td class="review_product_writer">
								<c:if test="${fn:length(review.review_writeId) < 5 || fn:length(review.review_writeId) == 5}">
									${fn:substring(review.review_writeId,0,2)}
									<c:forEach begin="3" end="${fn:length(review.review_writeId)}" step="1">
										*
									</c:forEach>
								</c:if>
								<c:if test="${fn:length(review.review_writeId) > 5}">
									${fn:substring(review.review_writeId,0,3)}
									<c:forEach begin="4" end="${fn:length(review.review_writeId)}" step="1">
										* 
									</c:forEach>
								</c:if>
							</td>
							<td class="review_product_writeDate">${review.review_regDate}</td>
							<td class="review_product_star">
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
						</tr>
						<tr id="review_content_${num.index}" class="content_hide">
							<td class="review_product_num">&nbsp;</td>
							<td class="review_product_content" colspan="4" style="text-align: left;">${review.review_content}</td>
						</tr>
						<c:forEach var="list" items="${review_fileList}">
							<c:if test="${list.review_id == review.review_id}">
								<tr id="review_image_${num.index}" class="content_hide">
									<td class="review_product_num">&nbsp;</td>
									<td class="review_product_content" colspan="4" style="text-align: left;">
										<div class="zoom">
											<img class="product_review_image" src="${path}/review_download?review_id=${review.review_id}&review_fileName=${list.review_fileName}" style="padding: 10px;"/>
										</div>
									</td>
								</tr>
							</c:if>
						</c:forEach>
					</c:forEach>
				</c:if>
			</table>
			
			<c:if test="${empty member_id}">
				<div class="review_add">
					<p class="review_add_button" align="right"><button onclick="req_login()">리뷰작성</button></p>
				</div>
			</c:if>
			<c:if test="${not empty member_id}">
				<div class="review_add">
					<p class="review_add_button" align="right"><button id="review_modal_btn">리뷰작성</button></p>
				</div>
				
				<!-- Modal의 내용 -->
				<div class="review_modal"> 
					<div class="review_modal-content">
						<!-- <span class="review_close">&times;</span>        -->                  
						<c:import url="/board/reviewForm">
							<c:param name="product_code" value="${product_code}" />
							<c:param name="product_cateL" value="${param.product_cateL}" />
							<c:param name="product_cateS" value="${param.product_cateS}" />
						</c:import>
					</div>
				</div>
			</c:if>

			<c:if test="${not empty total_review}">
			<div class="review_paging">
			<c:choose>
				<c:when test="${total_review > 50}">
					<c:forEach var="page" begin="1" end="5" step="1">
						<c:if test="${section > 1 && page == 1}">
							<a href="${path}/board/review_product?section=${section-1}&pageNum=${5}" class="prev"><i class="fa-solid fa-angle-left"></i></a>
						</c:if>
							<a href="${path}/board/review_product?section=${section}&pageNum=${page}" class="page">${(section-1)*10+page}</a>
						<c:if test="${page == 5}">
							<a href="${path}/board/review_product?section=${section+1}&pageNum=${1}" class="next"><i class="fa-solid fa-angle-right"></i></a>
						</c:if>
					</c:forEach>
				</c:when>
				<c:when test="${total_review == 50}">
					<c:forEach var="page" begin="1" end="5" step="1">
						<a href="#" class="page">${page}</a>
					</c:forEach>
				</c:when>
				<c:when test="${total_review < 50}">
					<c:forEach var="page" begin="1" end="${total_notice/5 + 1}" step="1">
						<c:choose>
							<c:when test="${page == pageNum}">
								<a href="${path}/board/review_product?section=${section}&pageNum=${page}" class="page">${page}</a>
							</c:when>
							<c:otherwise>
								<a href="${path}/board/review_product?section=${section}&pageNum=${page}" class="page">${page}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
			</c:choose>
			</div>
		</c:if>
		</div>
	</div>
	
<script>
//눌렀을때 드롭
function review_dropdown(obj,number){
	let type = $('#review_content_'+number).attr('class');
	
	if(type == 'content_hide'){
		$('#review_content_'+number).attr('class','content_show');
		$('#review_image_'+number).attr('class','content_show');
		obj.style.backgroundColor = 'rgba(139, 163, 167, 0.1)';
	} else if(type == 'content_show'){
		$('#review_content_'+number).attr('class','content_hide');
		$('#review_image_'+number).attr('class','content_hide');
		obj.style.backgroundColor = 'transparent';
	}
}</script>
</body>
</html>