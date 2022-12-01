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
	.review_form_header_title{font-size:large; color:white; padding-left:20px; padding-top:10px; text-align: left;}
	.review_form_body{padding: 20px; padding-bottom: 20px;}
	.review_form_ul{list-style: none; padding: 0;}
	.review_form_li{padding-bottom: 10px;}
	.review_form_li_seceond{padding: 10px 0;}
	.review_form_star {display: inline-block; direction: rtl; width:100%; text-align: left;}
	.review_form_star input[type=radio] {display: none;	cursor: pointer;}
	.review_form_star label {font-size: 2.5em; color: transparent; text-shadow: 0 0 0 #f0f0f0;}
	.review_form_star label:hover, .review_form_star label:hover ~ label {text-shadow: 0 0 0 rgb(248, 152, 29, 0.99);}
	.review_form_star input[type=radio]:checked ~ label {text-shadow: 0 0 0 rgb(248, 152, 29, 0.99);}
	.review_form_title{width:100%; height:30px;}
	.review_form_content{width:100%; resize: none;}
	#file_review {display: none;}
	.btn-upload {width: 100px; height: 30px; background: #474948; color: #fff; border: 1px solid rgb(77,77,77); border-radius: 10px; 
				font-weight: 500; cursor: pointer; display: flex; align-items: center; justify-content: center;}
	.btn-upload:hover {background: #fff; color: black;}
	.ctrl_btn {text-align: center; display: flex; justify-content: space-between; padding: 0 200px;}
	#review_insert_btn {width: 150px; height: 50px; border-radius: 2px; background-color: #474948; color: white; font-size: large;}
	#review_close_btn {width: 150px; height: 50px; border-radius: 1px; background-color: transparent; color: black; border-width: 1px; font-size: large;}
</style>
<script>
	let review_cnt = 1;
	function review_addFile(){
		$("#d_file").append("<br><input type='file' name='review_fileName"+review_cnt+"' onchange='r_readURL(this)'>");
		$(".image_r_preview").append("<img src='#' id='r_preview"+review_cnt+"' width='100px' height='100px' style='padding-top:10px;'>");
		review_cnt++;
	}
	function r_readURL(input){
		if(input.files && input.files[0]){
			let reader = new FileReader();
			reader.onload = function(e) {
				$("#r_preview"+(review_cnt-1)).attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	function fn_review_close(){
		$('.review_modal').css("display","none");
		$('body').css("overflow","unset");
		
		$('#d_file').empty();
		$('.image_r_preview').empty();
		$('.review_form_title').val('');
		$('.review_form_content').val('');
	}
	
	window.onclick = function(event2){
		if(event2.target.className == 'review_modal'){
			event2.target.style.display = "none";
			console.log(event2.target);
			$('.review_modal').css("display","none");
			$('.qna_modal').css("display","none");
			$('body').css("overflow","unset");
			
			$('#d_file').empty();
			$('.image_r_preview').empty();
			$('.review_form_title').val('');
			$('.review_form_content').val('');
		};
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
			$('body').css("overflow","unset");
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
					<li class="review_form_li">
						<div class="review_form_star">
							<input type="radio" name="review_star" id="rate1" value="5"><label for="rate1">★</label>
							<input type="radio" name="review_star" id="rate2" value="4"><label for="rate2">★</label>
							<input type="radio" name="review_star" id="rate3" value="3"><label for="rate3">★</label>
							<input type="radio" name="review_star" id="rate4" value="2"><label for="rate4">★</label>
							<input type="radio" name="review_star" id="rate5" value="1"><label for="rate5">★</label>
						</div>
					</li>
					
					<li class="review_form_li"><input type="text" name="review_title" class="review_form_title" placeholder="제품 후기의 제목을 입력해주세요."/></li>
					
					<li class="review_form_li" style="border-bottom: 1px solid #6C757D">
						<textarea name="review_content" class="review_form_content" cols="30" rows="15" placeholder="제품 후기의 내용을 입력해주세요."></textarea>
					</li>
					
					<li class="review_form_li_seceond">
						<label for="file_review">
  							<div class="btn-upload">파일추가</div>
						</label>
						<input type="button" id="file_review" value="파일추가" onclick="review_addFile()"/>
						<div id="d_file" style="text-align: left;"></div>	
					</li>
					
					<li class="review_form_li" style="border-bottom: 1px solid #6C757D">
						<div class="image_r_preview" style="text-align: left;"></div>
					</li>
					
					<li class="review_form_li" style="text-align: left;">
						<span style="font-size: small; color: #DD0912">상품과 무관한 내용 혹 사진을 첨부한 리뷰는 <font color="red" style="font-weight: bold;">통보없이 삭제</font> 될 수 있습니다.</span>
					</li>
				</ul>
				
				<div class="ctrl_btn">
					<input id="review_close_btn" type="button" onclick="fn_review_close()" value="취소"/>
					<input id="review_insert_btn" type="button" onclick="review_submit(this)" value="등록"/>
				</div>
				<input type="hidden" name="review_writeId" value="${review_writeId}"/>
				<input type="hidden" name="product_code" value="${param.product_code}"/>
				<input type="hidden" name="product_cateL" value="${product_cateL}"/>
				<input type="hidden" name="product_cateS" value="${product_cateS}"/>
			</form>
		</div>
	</div>
</body>
</html>