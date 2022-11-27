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
<link rel="stylesheet" href="${path}/resources/css/review.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://rawgit.com/jackmoore/autosize/master/dist/autosize.min.js"></script>
<script>
	function delete_page(review_id){
		if(confirm('삭제하시겠습니까?')){
			location.href='${path}/board/delete_review?review_id='+review_id;
		} else{
			alert('취소되었습니다.');
		}
	}
</script>
<style>
	.review{margin: 40px auto;}
	/* CSS 미완료 */
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
					<td class="review_page_title">${reviewDTO.review_title}</td>
				</tr>
				<tr>
					<td class="review_page_td">작성자</td>
					<td class="review_page_writeId">${reviewDTO.review_writeId}</td>
				</tr>
				<tr>
					<td class="review_page_td">작성일</td>
					<td class="review_page_regDate">${reviewDTO.review_regDate}</td>
				</tr>
				<tr>
					<td class="review_page_td">내용</td>
					<td class="review_page_content">${reviewDTO.review_content}</td>
				</tr>
				<c:if test="${not empty reviewFileList}">
					<tr>
						<td class="review_page_td">첨부파일</td>
						<td class="review_page_image">
							<ul>
								<c:forEach var="item" items="${reviewFileList}">
									<li>
										<img src="${path}/review_download?review_id=${reviewDTO.review_id}&review_fileName=${item.review_fileName}" style="padding: 10px;"/><br>
									</li>
								</c:forEach>
							</ul>
						</td>
					</tr>
				</c:if>
			</table>
			<div class="review_footer">
				<input type="button" class="review_page_button" onclick="delete_page(${reviewDTO.review_id})" value="삭제하기"/>
			</div>
		</div>
	</div>
</body>
</html>