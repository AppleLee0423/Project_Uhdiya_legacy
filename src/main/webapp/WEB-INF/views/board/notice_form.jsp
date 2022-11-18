<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path}/resources/css/reset.css" />
<link rel="stylesheet" href="${path}/resources/css/notice.css" />
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
</script>
<style>
#file {display: none;}
.notice_form_td_title{word-break: keep-all;}
</style>
</head>
<body>
	<div class="notice">
		<div class="notice_header">
			<div class="notice_header_title"><b>NOTICE</b></div>
		</div>
		<div class="notice_content">
			<form id="notice_form" action="${path}/board/addNotice" method="post" enctype="multipart/form-data">
				<table class="notice_form_table">
					<tr>
						<td class="notice_form_td_title">제목</td>
						<td><input type="text" name="notice_title" id="notice_form_title"/></td>
					</tr>
					<tr>
						<td class="notice_form_td_title">내용</td>
						<td><textarea name="notice_content" id="notice_form_content" cols="30" rows="15" ></textarea></td>
					</tr>
					<tr>
						<td class="notice_form_td_title">이미지 첨부</td>
						<td>
						<!-- <input type="file" name="notice_imageFileName"/> -->
						<label for="file">
  						<div class="btn-upload">파일추가</div>
						</label>
						<input type="button" id="file" value="파일추가" onclick="fn_addFile()"/>
						<%-- <input type="file" name="notice_fileName" id="file" onchange="readURL(this)"> --%>
						<div id="d_file"></div>	
						</td>
					</tr>
					<tr>
						<td class="notice_form_td_title">첨부파일</td>
						<td>
							<div class="image_preview">
								<%-- <img src="#" id="preview" width="100px" style="padding-top:10px;"/> --%>
							</div>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td align="right">
							<input type="submit" value=" 등록하기"/>
							<input type="reset" value="취소하기" onclick="cleandiv()"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>