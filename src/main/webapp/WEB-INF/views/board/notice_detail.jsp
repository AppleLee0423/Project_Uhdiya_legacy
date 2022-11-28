<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="noticeDTO" value="${noticeMap.noticeDTO}" />
<c:set var="noticeFileList" value="${noticeMap.noticeFileList}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path}/resources/css/notice.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://rawgit.com/jackmoore/autosize/master/dist/autosize.min.js"></script>
<style>
	.notice_header {display: flex; justify-content: space-between; }
	.notice_header_title {
	padding-bottom: 10px;
	font-weight: bold;
	}
	#notice_form_content_view{
		width: 100%;
		overflow: hidden;
		display: block;
		background-color: transparent;
		border: none;
		text-align: center;
		font-size: large;
		resize: none;
	}
	.notice_table_image {
		text-align: center;
	}
	.notice{margin: 35px 0;}
	
	#notice_detail_button_on,#notice_detail_button_off {
	text-align: right;
	padding-top: 5px;
	}
	.notice_detail_button{
		background-color: transparent; border: none;
		font-size: medium;
	}
	.update_set{display: none;}
</style>
<script>
	let cnt = 1;
	// 내용 오토사이징
	$(function(){
		autosize(document.querySelector('textarea'));
	});
	
	// 파일추가 버튼
	function fn_addFile(){
		$("#d_file").append("<br><input type='file' name='notice_fileName"+cnt+"' onchange='readURL(this)'>'");
		$(".image_preview").append("<img src='#' id='preview"+cnt+"' width='100px' height='100px' style='padding-top:10px;'>");
		cnt++;
	}
	// 미리보기
	function readURL(input){
		if(input.files && input.files[0]){
			let reader = new FileReader();
			reader.onload = function(e) {
				$("#preview"+(cnt-1)).attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	// 취소
	function form_reset(notice_id){
		location.href='${path}/board/notice_page?notice_id='+notice_id;
	}
	// 수정하기 활성화
	function update_set(obj){
		for(let i=0; i<4; i++){
			document.getElementsByClassName("view_set")[i].style.display='none';
			document.getElementsByClassName("update_set")[i].style.display='block';
		}
		document.getElementsByClassName("notice_table_image")[0].style.display='none';
	}
	// 수정하기
	function update_notice(obj){
		//유효성 검사
		let form = document.update_form;
		let title = form.notice_title.value;
		if(title==''){
			alert('제목은 빈 칸일 수 없습니다.');
			form.title.select();
			return;
		} else {
			// 변경사항 전송
			obj.action='${path}/board/update_notice';
			obj.submit();
		}
	}
	// 삭제하기
	function delete_notice(url,notice_id){
		if(confirm('삭제하시겠습니까?')){
			let form = document.createElement("form");
			form.method = "post";
			form.action = url;
			
			let notice_idInput = document.createElement("input");
			notice_idInput.setAttribute("type", "hidden");
			notice_idInput.setAttribute("name", "notice_id");
			notice_idInput.setAttribute("value", notice_id);
			
			form.appendChild(notice_idInput);
			document.body.appendChild(form);
			
			form.submit();
		} else {
			alert("삭제가 취소 되었습니다.");
		}
	}
</script>
</head>
<body>
	<div class="notice">
		<div class="notice_header">
			<div class="notice_header_title"><b>NOTICE</b> <span class="notice_header_partition">I</span> ${noticeDTO.notice_id} </div>
			<a href="${path}/board/notice" id="notice_detail_list">목록보기</a>
		</div>
		<div class="notice_content">
			<form name="update_form" action="" method="post" enctype="multipart/form-data">
				<input type="hidden" name="notice_id" value="${noticeDTO.notice_id}"/>
				<div class="notice_detail_table">
					<ul>
						<li class="notice_table_header">
							<div class="view_set">
								<h2 class="notice_detail_title">${noticeDTO.notice_title}</h2>
								<span class="notice_detail_writeDate">${noticeDTO.notice_regDate}</span>
								<span class="notice_detail_partition">I</span>
								<span class="notice_detail_count">${noticeDTO.notice_count}</span>
							</div>
							<div class="update_set">
								<h3 class="notice_detail_title"><input type="text" name="notice_title" value="${noticeDTO.notice_title}"/></h3>
								<span class="notice_detail_writeDate">${noticeDTO.notice_regDate}</span>
								<span class="notice_detail_partition">I</span>
								<span class="notice_detail_count">${noticeDTO.notice_count}</span>
							</div>
						</li>
						<li class="notice_table_body">
							<div class="view_set">
								<textarea id="notice_form_content_view" disabled="disabled">${noticeDTO.notice_content}</textarea>
							</div>
							<div class="update_set">
								<textarea name="notice_content" id="notice_form_content" cols="30" rows="15">${noticeDTO.notice_content}</textarea>
							</div>
							<div class="view_set">
								<c:if test="${not empty noticeFileList}">
									<li class="notice_table_image">
										<c:forEach var="item" items="${noticeFileList}">
											<img src="${path}/notice_download?notice_id=${noticeDTO.notice_id}&notice_fileName=${item.notice_fileName}" style="padding-bottom: 10px;"/><br>
										</c:forEach>
									</li>
								</c:if>
							</div>
							<div class="update_set">
								<label for="file">
  									<div class="btn-upload">파일추가</div>
								</label>
								<input type="button" id="file" value="파일추가" onclick="fn_addFile()"/>
								<div id="d_file"></div>	
								<hr />
								<div class="image_preview">
								</div>
							</div>
						</li>
					</ul>
				</div>
				<%-- <c:if test="${member.member_id == 'admin'}"></c:if> --%>
				<div class="view_set" id="notice_detail_button_on">
					<input type="button" class="notice_detail_button" onclick="update_set(this.form)" value="수정하기"/>
					<input type="button" class="notice_detail_button" onclick="delete_notice('${path}/board/delete_notice',${noticeDTO.notice_id})" value="삭제하기"/>
					
				</div>
				<div class="update_set" id="notice_detail_button_off" >
					<input type="button" class="notice_detail_button" onclick="update_notice(this.form)" value="수정하기"/>
					<input type="button" class="notice_detail_button" onclick="form_reset(${noticeDTO.notice_id})" value="취소"/>
					
				</div>
			</form>
		</div>
	</div>
</body>
</html>