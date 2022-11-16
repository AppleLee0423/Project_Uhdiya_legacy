<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../css/reset.css" />
<link rel="stylesheet" href="../css/qna.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
	<div class="qna">
		<div class="qna_header">
			<div class="qna_header_title"><b>QnA</b> <span class="qna_header_partition">I</span> 1 </div>
		</div>
		<div class="qna_body">
			<form id="qna_form" action="" method="post" enctype="multipart/form-data">
				<table class="qna_form_table">
					<tr>
						<td class="qna_form_td_title">제목</td>
						<td><input type="text" name="qna_title" id="qna_form_title"/></td>
					</tr>
					<tr>
						<td class="qna_form_td_title">내용</td>
						<td><textarea name="qna_content" id="qna_form_content" cols="30" rows="15" ></textarea></td>
					</tr>
					<tr>
						<td class="qna_form_td_title">이미지 첨부</td>
						<td>
						<label for="file">
  						<div class="btn-upload">파일추가</div>
						</label>
						<input type="file" name="imageFileName" id="file">
						</td>
					</tr>
					<tr>
						<td class="qna_form_td_title">미리보기</td>
						<td><img src="#" id="preview" /></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td align="right">
							<input type="submit" value=" 등록하기"/>
							<input type="reset" value="취소하기"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>