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
<c:set var="member_id" value="${param.member_id}" />
<c:set var="product_code" value="${param.product_code}" />
<!DOCTYPE html>
<html>
<head>
<script src="https://kit.fontawesome.com/96e0fede2d.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
	.qna{width:900px; margin:0 auto;}
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
	.qna_add{text-align: right;	padding-top: 5px;}
	.qna_add_button {height: 30px; border-radius: 2px; background-color: #474948; color: white;}
	[id ~= "qna_content_"]{margin:0; padding:0;}
</style>
<script>
	function qna_add(){
		location.href='${path}/board/qnaForm?product_code=${product_code}&product_cateL=${param.product_cateL}&product_cateS=${param.product_cateS}';
	}
	// 눌렀을때 드롭
	function qna_dropdown(qna_list,number){
		qna_list.style.backgroundColor = 'rgba(139, 163, 167, 0.1)';
		
		for(let i=0; i<${total_qna}; i++){
			let qna_content = $('tr#qna_content_'+i);
			qna_content.css("display","none");
		}
		
		let qna_content = $('tr#qna_content_'+number); 
		qna_content.css("display","table-row");
	}
	function delete_go(qna_id){
		if(confirm('삭제하시겠습니까?')){
			location.href='${path}/board/delete_qna?qna_id='+qna_id;
		} else {
			alert("삭제가 취소 되었습니다.");
		}
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
						<tr id="qna_list" onclick="qna_dropdown(this,${num.index})">
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
						<tr id="qna_content_${num.index}" style="display:none;">
							<td class="qna_product_num">&nbsp;</td>
							<td class="qna_product_content" colspan="4" style="text-align: left;">${qna.qna_content}</td>
						</tr>
						<c:if test="${sessionScope.member.member_id == qna.qna_writeId}">
						<tr id="qna_content_${num.index}" style="display:none;">
							<td class="qna_product_button" colspan="5" style="text-align: right;">
								<input type="button" id="delete_btn" onclick="delete_go(${qna.qna_id})" value="삭제하기"/>
							</td>
						</tr>
						</c:if>
					</c:forEach>
				</c:if>
			</table>
			<div class="qna_add">
				<input type="button" class="qna_add_button" onclick="qna_add()" value="상품 문의하기">
			</div>
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