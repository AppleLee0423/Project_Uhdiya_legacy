<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../css/reset.css" />
<link rel="stylesheet" href="../css/review.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
	<div class="review">
		<div class="review_header">
			<div class="review_header_title"><b>REVIEW</b> <span class="review_header_partition">I</span> 1 </div>
		</div>
		<div class="review_body">
			<form id="review_form" action="" method="post" enctype="multipart/form-data">
				<table class="review_form_table">
					<tr>
						<td class="review_form_td_title">별점</td>
						<td>
							<div class="review_form_star">
								<input type="radio" name="review_star" id="rate1" value="5"><label for="rate1">★</label>
								<input type="radio" name="review_star" id="rate2" value="4"><label for="rate2">★</label>
								<input type="radio" name="review_star" id="rate3" value="3"><label for="rate3">★</label>
								<input type="radio" name="review_star" id="rate4" value="2"><label for="rate4">★</label>
								<input type="radio" name="review_star" id="rate5" value="1"><label for="rate5">★</label>
							</div>
						</td>
					</tr>
					<tr>
						<td class="review_form_td_title">제목</td>
						<td><input type="text" name="review_title" id="review_form_title"/></td>
					</tr>
					<tr>
						<td class="review_form_td_title">내용</td>
						<td><textarea name="review_content" id="review_form_content" cols="30" rows="15" ></textarea></td>
					</tr>
					<tr>
						<td class="review_form_td_title">이미지 첨부</td>
						<td>
						<label for="file">
  						<div class="btn-upload">파일추가</div>
						</label>
						<input type="file" name="imageFileName" id="file">
						</td>
					</tr>
					<tr>
						<td class="review_form_td_title">미리보기</td>
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