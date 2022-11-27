<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%-- 
<c:set var="review_writeId" value="${reviewMap.member_id}" />
<c:set var="product_code" value="${reviewMap.product_code}" />
--%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path}/resources/css/reset.css" />
<link rel="stylesheet" href="${path}/resources/css/review.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	let cnt = 1;
	function fn_addFile(){
		$("#d_file").append("<br><input type='file' name='notice_fileName"+cnt+"' onchange='readURL(this)'>'");
		$(".image_preview").append("<img src='#' id='preview"+cnt+"' width='100px' height='100px' style='padding-top:10px;'>");
		cnt++;
	}
	function readURL(input){
		if(input.files && input.files[0]){
			let reader = new FileReader();
			reader.onload = function(e) {
				$("#preview"+(cnt-1)).attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	function cleandiv(){
		$('#d_file').empty();
		$('.image_preview').empty();
	}
	function review_submit(obj){
		let form = document.review_form;
		let review_star = $('input[name=review_star]:checked').val();
		let review_title = $('input[name=review_title]').val();
		if(review_star == null){
			alert('별점을 체크해주세요');
			return;
		} else if (review_title == "" || review_title == null){
			alert('제목을 입력해주세요.');
			review_title.select();
			return;
		} else {
			form.action = '${path}/board/addReview';
			form.submit();
		}
	}
</script>
</head>
<body>
	<div class="review">
		<div class="review_header">
			<div class="review_header_title"><b>REVIEW</b> <span class="review_header_partition">I</span> 1 </div>
		</div>
		<div class="review_body">
			<form id="review_form" name="review_form" action="" method="post" enctype="multipart/form-data">
				<input type="hidden" name="review_writeId" value="${review_writeId}"/>
				<input type="hidden" name="product_code" value="${product_code}"/>
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
						<input type="button" id="file" value="파일추가" onclick="fn_addFile()"/>
						<div id="d_file"></div>	
						</td>
					</tr>
					<tr>
						<td class="review_form_td_title">첨부파일</td>
						<td>
							<div class="image_preview">
							</div>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td align="right">
							<input type="button" onclick="review_submit(this)" value=" 등록하기"/>
							<input type="reset" value="취소하기"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>