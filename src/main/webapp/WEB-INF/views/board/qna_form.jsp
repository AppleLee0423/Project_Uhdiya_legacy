<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path}/resources/css/reset.css" />
<link rel="stylesheet" href="${path}/resources/css/qna.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
	.qna{margin: 40px auto;}
	.qna_form_td_title{width:15%;}
</style>
<script>
	let cnt = 1;
	function fn_addFile(){
		$("#d_file").append("<br><input type='file' name='qna_fileName"+cnt+"' onchange='readURL(this)'>'");
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
	function insert_qna(obj){
		let form = document.qna_form;
		let title = form.qna_title.value;
		if(title==''){
			alert('제목은 빈 칸일 수 없습니다.');
			form.title.select();
			return;
		} else {
			obj.action='${path}/board/addQna';
			obj.submit();
		}
	}
</script>
</head>
<body>
	<div class="qna">
		<div class="qna_header">
			<div class="qna_header_title"><b>QnA</b> <span class="qna_header_partition">I</span> 1 </div>
		</div>
		<div class="qna_body">
			<form name="qna_form" action="" method="post" enctype="multipart/form-data">
				<input type="hidden" name="qna_writeId" value="${param.qna_writeId}"/>
				<input type="hidden" name="product_code" value="${param.product_code}"/>	
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
						<input type="button" id="file" value="파일추가" onclick="fn_addFile()"/>
						<div id="d_file"></div>	
						</td>
					</tr>
					<tr>
						<td class="notice_form_td_title">첨부파일</td>
						<td>
							<div class="image_preview">
							</div>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td align="right">
							<input type="button" class="qna_add" onclick="insert_qna(this.form)" value="등록하기"/>
							<input type="reset" value="취소하기"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>