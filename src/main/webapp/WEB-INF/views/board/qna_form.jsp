<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
	.qna_form_header{background-color:#353B4C; height:45px; }
	.qna_form_header_title{font-size:large; color:white; padding-left:20px; padding-top:10px; text-align: left;}
	.qna_form_body{padding: 20px; padding-bottom: 20px;}
	.qna_form_ul{list-style: none; padding: 0;}
	.qna_form_li{padding-bottom: 10px;}
	.qna_form_li_seceond{padding: 10px 0;}
	.qna_form_title{width:100%; height:30px;}
	.qna_form_content{width:100%; resize: none;}
	#file {display: none;}
	.btn-upload {width: 100px; height: 30px; background: #474948; color: #fff; border: 1px solid rgb(77,77,77); border-radius: 10px; 
				font-weight: 500; cursor: pointer; display: flex; align-items: center; justify-content: center;}
	.btn-upload:hover {background: #fff; color: black;}
	.ctrl_btn {text-align: center; display: flex; justify-content: space-between; padding: 0 200px;}
	#qna_insert_btn {width: 150px; height: 50px; border-radius: 2px; background-color: #474948; color: white; font-size: large;}
	#qna_close_btn {width: 150px; height: 50px; border-radius: 1px; background-color: transparent; color: black; border-width: 1px; font-size: large;}
</style>
<script>
	let qna_cnt = 1;
	function fn_addFile(){
		$("#d_file").append("<br><input type='file' name='qna_fileName"+qna_cnt+"' onchange='readURL(this)'>'");
		$(".image_preview").append("<img src='#' id='preview"+qna_cnt+"' width='100px' height='100px' style='padding-top:10px;'>");
		qna_cnt++;
	}
	function readURL(input){
		if(input.files && input.files[0]){
			let reader = new FileReader();
			reader.onload = function(e) {
				$("#preview"+(qna_cnt-1)).attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	function fn_qna_close(){
		$('.qna_modal').css("display","none");
		$('body').css("overflow","unset");
	}
	
	window.onclick = function(event1){
		if(event1.target.className == 'qna_modal'){
			event1.target.style.display = "none";
			console.log(event1.target);
			$('.review_modal').css("display","none");
			$('.qna_modal').css("display","none");
			$('body').css("overflow","unset");
		};
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
			qna_cnt = 1;
			$('body').css("overflow","unset");
		}
	}
</script>
</head>
<body>
	<div class="qna_form">
		<div class="qna_form_header">
			<div class="qna_form_header_title"><b>문의하기</b></div>
		</div>
		<div class="qna_form_body">
			<form name="qna_form" action="" method="post" enctype="multipart/form-data">
				<ul class="qna_form_ul">
					<li class="qna_form_li"><input type="text" name="qna_title" class="qna_form_title" placeholder="문의글의 제목을 입력해주세요."/></li>
					
					<li class="qna_form_li" style="border-bottom: 1px solid #6C757D">
						<textarea name="qna_content" class="qna_form_content" cols="30" rows="15" placeholder="문의하실 내용을 입력해주세요."></textarea>
					</li>
					
					<li class="qna_form_li_seceond">
						<label for="file">
  							<div class="btn-upload">파일추가</div>
						</label>
						<input type="button" id="file" value="파일추가" onclick="fn_addFile()"/>
						<div id="d_file"></div>	
					</li>
					
					<li class="qna_form_li" style="border-bottom: 1px solid #6C757D">
						<div class="image_preview"></div>
					</li>
					
					<li class="qna_form_li" style="text-align: left;">
						<span style="font-size: small; color: #6C757D">문의하신 내용에 대한 답변은 <font color="black" style="font-weight: bold;">마이페이지>문의내역</font> 에서 확인가능합니다.</span>
						<br><br>
					</li>
				</ul>
				
				<div class="ctrl_btn">
					<input id="qna_close_btn" type="button" onclick="fn_qna_close()" value="취소"/>
					<input id="qna_insert_btn" type="button" onclick="insert_qna(this.form)" value="등록"/>
				</div>
				<input type="hidden" name="qna_writeId" value="${qna_writeId}"/>
				<input type="hidden" name="product_code" value="${param.product_code}"/>
				<input type="hidden" name="product_cateL" value="${product_cateL}"/>
				<input type="hidden" name="product_cateS" value="${product_cateS}"/>
			</form>
		</div>
	</div>
</body>
</html>