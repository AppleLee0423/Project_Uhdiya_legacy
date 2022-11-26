<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="qnaDTO" value="${qnaMap.qnaDTO}" />
<c:set var="qnaFileList" value="${qnaMap.qnaFileList}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path}/resources/css/qna.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://rawgit.com/jackmoore/autosize/master/dist/autosize.min.js"></script>
<script>
	function delete_page(qna_id){
		if(confirm('삭제하시겠습니까?')){
			location.href='${path}/board/delete_qna?qna_id='+qna_id;
		} else{
			alert('취소되었습니다.');
		}
	}
</script>
<style>
	.qna{margin: 40px auto;}
	/* CSS 미완료 */
</style>
</head>
<body>
	<div class="qna">
		<div class="qna_header">
			<div class="qna_header_title">QNA / ${qnaDTO.qna_id}</div>
			<div class="qna_header_back"><input type="button" class="qna_page_button" onclick="history.back()" value="목록보기"/></div>
		</div>
		<div class="qna_content">
			<table class="qna_page_table">
				<tr>
					<td class="qna_page_td">제목</td>
					<td class="qna_page_title">${qnaDTO.qna_title}</td>
				</tr>
				<tr>
					<td class="qna_page_td">작성자</td>
					<td class="qna_page_writeId">${qnaDTO.qna_writeId}</td>
				</tr>
				<tr>
					<td class="qna_page_td">작성일</td>
					<td class="qna_page_regDate">${qnaDTO.qna_regDate}</td>
				</tr>
				<tr>
					<td class="qna_page_td">내용</td>
					<td class="qna_page_content">${qnaDTO.qna_title}</td>
				</tr>
				<c:if test="${not empty qnaFileList}">
					<tr>
						<td class="qna_page_td">첨부파일</td>
						<td class="qna_page_image">
							<ul>
								<c:forEach var="item" items="${qnaFileList}">
									<li>
										<img src="${path}/qna_download?qna_id=${qnaDTO.qna_id}&qna_fileName=${item.qna_fileName}" style="padding: 10px;"/><br>
									</li>
								</c:forEach>
							</ul>
						</td>
					</tr>
				</c:if>
			</table>
			<div class="qna_footer">
				<input type="button" class="qna_page_button" onclick="delete_page(${qnaDTO.qna_id})" value="삭제하기"/>
			</div>
		</div>
	</div>
</body>
</html>