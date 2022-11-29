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
	.review_form_header{background-color:#353B4C; height:45px; }
	.review_form_header_title{font-size:large; color:white; padding-left:20px; padding-top:10px;}
	.review_form_body{padding: 20px; padding-bottom: 20px;}
	.review_form_ul{list-style: none; padding: 0;}
	.review_form_li{padding-bottom: 10px;}
	.review_form_li_seceond{padding: 10px 0;}
	.review_form_title{width:100%; height:30px;}
	.review_form_content{width:100%; resize: none;}
	#file {display: none;}
	.btn-upload {width: 100px; height: 30px; background: #474948; color: #fff; border: 1px solid rgb(77,77,77); border-radius: 10px; 
				font-weight: 500; cursor: pointer; display: flex; align-items: center; justify-content: center;}
	.btn-upload:hover {background: #fff; color: black;}
	.ctrl_btn {text-align: center; display: flex; justify-content: space-between; padding: 0 200px;}
	.ctrl_btn input[type=button] {width: 150px; height: 50px; border-radius: 2px; background-color: #474948; color: white; font-size: large;}
	.ctrl_btn input[type=reset] {width: 150px; height: 50px; border-radius: 1px; background-color: transparent; color: black; border-width: 1px; font-size: large;}
</style>
<script>
	let review_cnt = 1;
	function fn_addFile(){
		$("#d_file").append("<br><input type='file' name='review_fileName"+review_cnt+"' onchange='readURL(this)'>'");
		$(".image_preview").append("<img src='#' id='preview"+review_cnt+"' width='100px' height='100px' style='padding-top:10px;'>");
		cnt++;
	}
	function readURL(input){
		if(input.files && input.files[0]){
			let reader = new FileReader();
			reader.onload = function(e) {
				$("#preview"+(review_cnt-1)).attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	function cleandiv(){
		let reset_btn = document.querySelector('input[type=reset]');
		reset_btn.addEventListener('click',function(){
		$('#d_file').empty();
		$('.image_preview').empty();
	});
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
			review_cnt = 1;
		}
	}
</script>
</head>
<body>
	<div class="review_form">
		<div class="review_form_header">
			<div class="review_form_header_title"><b>리뷰 남기기</b></div>
		</div>
		<div class="review_form_body">
			<form name="review_form" action="" method="post" enctype="multipart/form-data">
				<ul class="review_form_ul">
					<li class="review_form li">
					
					</li>
					<li class="review_form_li"><input type="text" name="review_title" class="review_form_title" placeholder="제품 후기의 제목을 입력해주세요."/></li>
					
					<li class="review_form_li" style="border-bottom: 1px solid #6C757D">
						<textarea name="review_content" class="review_form_content" cols="30" rows="15" placeholder="제품 후기의 내용을 입력해주세요."></textarea>
					</li>
					
					<li class="review_form_li_seceond">
						<label for="file">
  							<div class="btn-upload">파일추가</div>
						</label>
						<input type="button" id="file" value="파일추가" onclick="fn_addFile()"/>
						<div id="d_file"></div>	
					</li>
					
					<li class="review_form_li" style="border-bottom: 1px solid #6C757D">
						<div class="image_preview"></div>
					</li>
					
					<li class="review_form_li">
						<span style="font-size: small; color: #DD0912">상품과 무관한 내용 혹 사진을 첨부한 리뷰는 <font color="red" style="font-weight: bold;">통보없이 삭제</font> 될 수 있습니다.</span>
					</li>
				</ul>
				
				<div class="ctrl_btn">
					<input type="reset" value="취소"/>
					<input type="button" onclick="review_submit(this)" value="등록"/>
				</div>
				<input type="hidden" name="review_writeId" value="${param.review_writeId}"/>
				<input type="hidden" name="product_code" value="${param.product_code}"/>
				<input type="hidden" name="product_cateL" value="${product_cateL}"/>
				<input type="hidden" name="product_cateS" value="${product_cateS}"/>
			</form>
		</div>
	</div>
</body>
</html>