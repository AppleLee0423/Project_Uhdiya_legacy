<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="reviewDTO" value="${reviewMap.reviewDTO}" />
<c:set var="reviewFileList" value="${reviewMap.reviewFileList}" />
<!DOCTYPE html>
<html>
<head>
<%-- <link rel="stylesheet" href="${path}/resources/css/review.css" /> --%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://rawgit.com/jackmoore/autosize/master/dist/autosize.min.js"></script>
<script>
	function delete_review(review_id){
		if(confirm('삭제하시겠습니까?')){
			location.href='${path}/board/delete_review?review_id='+review_id;
		} else{
			alert('취소되었습니다.');
		}
	}
	$(function(){
		autosize(document.querySelector('textarea'));
	});
</script>
<style>
	.review{width:1200px; margin:40px auto;}
	.review_header{display:flex; text-align: left; padding-bottom: 10px; justify-content: space-between;}
	.review_header_title{font-size: large;}
	.review_header_back{height:30px;}
	.review_page_button{height: 30px; border-radius: 2px; background-color: #474948; color: white; cursor: pointer;}
	.review_body{margin: 20px auto; width:100%;}
	.review_page_table{border: 2px outset #D6DCD8; border-collapse: collapse; width:100%;}
	.review_page_table tr{border-bottom: 1px solid #D6DCD8; min-height:60px;}
	.review_page_table td {vertical-align: middle;}
	.review_page_td {background-color: #FBFAFA; width:15%; text-align: center; border-right:1px solid #D6DCD8;}
	.review_page_content{min-height: 300px;}
	.review_footer{text-align: right;	padding-top: 5px;}
	#review_form_content_view {
		width: 100%;
		overflow: hidden;
		display: block;
		background-color: transparent;
		border: none;
		text-align: left;
		font-size: large;
		resize: none;
		padding-left: 5px;
		}
	.review_detail_image {width:70px; height:70px; transition: all 1.0s;}
	.review_detail_image:hover {transform:scale(3.0); overflow: hidden; z-index: 3;}
	tr{height:60px;}
	
	
	.review_page_star {display: inline-block; direction: rtl; width:100%; text-align: left; vertical-align: middle;}
	.rate_in {font-size: 2.5em; color: transparent; text-shadow: 0 0 0 rgb(248, 152, 29, 0.99);}
	.rate_out {font-size: 2.5em; color: transparent; text-shadow: 0 0 0 #f0f0f0;}
</style>
</head>
<body>
	<div class="review">
		<div class="review_header">
			<div class="review_header_title">review / ${reviewDTO.review_id}</div>
			<div class="review_header_back"><input type="button" class="review_page_button" onclick="history.back()" value="목록보기"/></div>
		</div>
		<div class="review_content">
			<table class="review_page_table">
				<tr>
					<td class="review_page_td">제목</td>
					<td class="review_page_title">&nbsp;&nbsp;${reviewDTO.review_title}</td>
				</tr>
				<tr>
					<td class="review_page_td">별점</td>
					<td class="review_page_star" style="padding-left:10px;">
						<span class="rate_in">
							<c:forEach	var="★" begin="1" end="${reviewDTO.review_star}" step="1">
								★
							</c:forEach>
						</span>
						<span class="rate_out">
							<c:forEach	var="★" begin="1" end="${5-(reviewDTO.review_star)}" step="1">
								★
							</c:forEach>
						</span>					
					</td>
				</tr>
				<tr>
					<td class="review_page_td">작성자</td>
					<td class="review_page_writeId">&nbsp;&nbsp;${reviewDTO.review_writeId}</td>
				</tr>
				<tr>
					<td class="review_page_td">작성일</td>
					<td class="review_page_regDate">&nbsp;&nbsp;${reviewDTO.review_regDate}</td>
				</tr>
				<tr>
					<td class="review_page_td">내용</td>
					<td class="review_page_content" style="padding-left:10px;">${reviewDTO.review_content}</td>
				</tr>
				<c:if test="${not empty reviewFileList}">
					<tr>
						<td class="review_page_td">첨부파일</td>
						<td class="review_page_image">
							<ul>
								<c:forEach var="item" items="${reviewFileList}">
									<li>
									<div class="zoom">
										<img class="review_detail_image" src="${path}/review_download?review_id=${reviewDTO.review_id}&review_fileName=${item.review_fileName}" style="padding: 10px;"/><br>
									</div>
									</li>
								</c:forEach>
							</ul>
						</td>
					</tr>
				</c:if>
			</table>
			<c:if test="${member_id == reviewDTO.review_writeId}">
				<div class="review_footer">
					<input type="button" class="review_page_button" onclick="delete_review(${reviewDTO.review_id})" value="삭제하기"/>
					<br><br>
				</div>
			</c:if>
			<c:if test="${member_id != reviewDTO.review_writeId}">
				<br><br><br>
			</c:if>
		</div>
	</div>
</body>
</html>