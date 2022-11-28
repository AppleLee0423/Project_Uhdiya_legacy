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
<%-- <link rel="stylesheet" href="${path}/resources/css/qna.css" /> --%>
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
	$(function(){
		autosize(document.querySelector('textarea'));
	});
</script>
<style>
	.qna{width:1200px; margin:40px auto;}
	.qna_header{display:flex; text-align: left; padding-bottom: 10px; justify-content: space-between;}
	.qna_header_title{font-size: large;}
	.qna_header_back{height:30px;}
	.qna_page_button{height: 30px; border-radius: 2px; background-color: #474948; color: white;}
	.qna_body{margin: 20px auto; width:100%;}
	.qna_page_table{border: 2px outset #D6DCD8; border-collapse: collapse; width:100%;}
	.qna_page_table tr{border-bottom: 1px solid #D6DCD8;}
	.qna_page_table td {vertical-align: middle;}
	.qna_page_td {background-color: #FBFAFA; width:15%; text-align: center; border-right:1px solid #D6DCD8;}
	.qna_page_content{min-height: 300px;}
	.qna_footer{text-align: right;	padding-top: 5px;}
	#qna_form_content_view {
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
	.qna_page_image img {width:70px; height:70px;}
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
					<td class="qna_page_title" height="50px">&nbsp;&nbsp;${qnaDTO.qna_title}</td>
				</tr>
				<tr>
					<td class="qna_page_td">상품</td>
					<td class="qna_page_product_name" height="50px">&nbsp;&nbsp;${qnaDTO.product_name}</td>
				</tr>
				<tr>
					<td class="qna_page_td">작성자</td>
					<td class="qna_page_writeId" height="50px">&nbsp;&nbsp;${qnaDTO.qna_writeId}</td>
				</tr>
				<tr>
					<td class="qna_page_td">작성일</td>
					<td class="qna_page_regDate" height="50px">&nbsp;&nbsp;${qnaDTO.qna_regDate}</td>
				</tr>
				<tr style="min-height: 300px;">
					<td class="qna_page_td">내용</td>
					<td class="qna_page_content">
						<textarea id="qna_form_content_view" disabled="disabled">${qnaDTO.qna_content}</textarea>
					</td>
				</tr>
				<c:if test="${not empty qnaFileList}">
					<tr>
						<td class="qna_page_td">첨부파일</td>
						<td class="qna_page_image" height="100px">
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