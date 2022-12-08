<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="member" value="${member}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://kit.fontawesome.com/96e0fede2d.js" crossorigin="anonymous"></script>
<style>
	.member_info a{text-decoration: none; color:black;}
	.member_info ul{list-style: none;}
	.member_info li{min-height:90px;}
	.member_info button {cursor: pointer;}
	.member_info button:hover {background-color: #474948;}
	.member_info button:hover .btn_text {color:white;}
	.member_info div{display: inline-block; vertical-align: middle;}
	.member_info{margin:50px auto; width:1200px; background-color: #F4F6F6; display: flex; justify-content: space-between;}
	.content_one, .content_two {height:500px; margin: 20px 50px; width: 500px; box-shadow: 2px 2px 14px 0 rgb(0 164 73,0.8); 
		border-radius:12px; border: 1px solid #e3e9ed; box-sizing:border-box; background-color: #fff; padding:10px;}
	.head_title, .head_icon {display: inline-block; font-size: 16px; font-weight: 700; line-height: 17px; letter-spacing: -.4px; color: #96a1aa;}
	.content_body{display: block; margin-top:10px;}
	.account div{display: block;}
	.edit_btn{display: inline-block; min-width: 44px; padding: 2px 9px 3px; border-radius: 4px; border: solid 1px rgba(212,216,229,.5); background-color: rgba(212,216,229,.25);
		box-sizing: border-box; text-align: center;}
	.photo {margin-right:10px; width:80px;}
	.account{width:260px;}
	.photo img{box-shadow: 0 3px 6px 0 rgb(29 34 53 / 8%); border-radius: 50%; vertical-align: top;}
	.update_btn{display: inline-block; position: relative; width: 80px;}
	.btn_text {font-size: 14px; font-weight: 500; line-height: 17px; letter-spacing: -.47px; color: #7b8994; white-space:normal; word-wrap: break-word;}
	#name{font-size: 24px; font-weight: 700; line-height: 29px; letter-spacing: -.63px; color: #1e1e23; word-break: break-all;}
	.icon, .iphone, .mail {line-height: 80px;}
	.icon {width: 50px; text-align: center;}
	.phone, .email {width:300px;}
	
	#info_tooltip{left: 5px; right: 5px; margin-top: 10px; padding: 13px 33px 13px 13px; border-radius: 8px; box-shadow: 2px 2px 8px 0 rgb(0 0 0 / 6%);
		border: solid 1px #cfdce6; background-color: #fff; box-sizing: border-box; width: 100%;}
	#info_tooltip .info_head{display: block; font-size: 13px; font-weight: 700; line-height: 18px; letter-spacing: -.8px; color: #7b8994;} 
	#info_tooltip .tooltip_text{display: block; padding-top: 2px; font-size: 13px; font-weight: 400; line-height: 18px; letter-spacing: -.8px; color: #96a1aa;}
	.code, .fulladdr, .detail{display: block;}
	#code, #fulladdr, #detail {font-size: 10pt; letter-spacing: -.4px;}
	.address {width: 380px;}
	.address div {display: block;}
	.icon2 {margin-right:10px;}
	#base {display: block; width: 61px; height: 19px; margin: 3px auto 0; border: 1px solid #C26225; font-size: 11px; 
		font-weight: bold; line-height: 19px; color: #C26225; text-align: center;}
	.withdraw{width: 100%; text-align: right;}
	#withdraw{margin-top:10px; border: 0; background-color: transparent;}
	#withdraw .btn_text{ color:#4D4D4D; font-weight: bolder; }
	.ctrl_btn {text-align: center; display: flex; justify-content: space-between; padding: 0 100px; margin-top:20px;}
	#update_btn {width: 120px; height: 35px; border-radius: 2px #C26225; background-color: #474948; color: white; font-size: medium; border-color: #474948; cursor: pointer;}
	#close_btn {width: 120px; height: 35px; border-radius: 1px; background-color: transparent; color: black; border-width: 1px; font-size:medium; cursor: pointer;}
	
	.modal {display: none; position: fixed; z-index: 999; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgb(0,0,0); 
      background-color: rgba(0,0,0,0.4);}
	.modal_content{{width: 500px; position: absolute; top: 15%; left: 25%; background-color: #fefefe; border: 1px solid #888;}}
	
	.update_form{width: 500px; min-height: 280px; background-color: #fff; display: block; margin:0 auto; border-radius: 10px; border-color:transparent; padding: 10px 20px;}
	.form_head{border-bottom: 1px solid rgba(220,227,233,.8); vertical-align: middle; display: inline-block; width: 100%;}
	.form_head_title{text-align: center; min-height:60px;}
	.form_body {margin: 10px 0; border-bottom: 1px solid rgba(220,227,233,.8);}
	.form_body div {display: inline-block; width:100%;}
	.form_body .content_title {display: inline-block; font-size: 16px; font-weight: 700; line-height: 17px; letter-spacing: -.4px; color: #96a1aa;}
	.form_footer {text-align: center; display: flex; justify-content: space-between; padding: 0 50px; margin-top:20px;}
	#update_insert_btn {width: 120px; height: 30px; background-color: #474948; border-radius: 0 0 0 12px; color: white; font-size: medium; cursor: pointer;}
	#update_insert_btn:disabled { background-color: #959eae;}
	#update_close_btn {width: 120px; height: 30px; border-radius: 1px; background-color: transparent; color: black; border-width: 1px; font-size:medium; cursor: pointer;}
	.new_data{padding: 9px 11px 9px 11px; width: 100%; height: 36px; font-size: 14px; font-weight: 400; line-height: 16px; letter-spacing: -.46px; box-sizing: border-box; 
		color: #303038;}
	.form_body div span{display: inline-block; font-size: 16px; font-weight: 700; line-height: 17px; letter-spacing: -.4px; color: #96a1aa;}
	.form_head_title h2{font-size: large; font-weight: bold; margin-top:20px;}
</style>
<script>
	var member_id = '${member.member_id}';
	var member_password = '${member.member_password}';
	var first_name = '${member.member_name}';
	var first_phone = '${member.member_phone}';
	var first_phone1 = '${member.member_phone1}';
	var first_phone2 = '${member.member_phone2}';
	var first_email = '${member.member_email}';
	var first_zipno = '${member.zipno}';
	var first_roadFullAddr = '${member.roadFullAddr}';
	var first_addDetail = '${member.addDetail}';
	var clicked_btn = "";

	// 회원정보 수정창 활성화
	function modal_open(e,str){
		var form_head_title = ""; <!-- 무엇을 변경하시겠습니까? -->
		var first_content = ""; <!-- 변경 전 항목입니다 -->
		var ori_content = ""; <!-- 변경 전 데이터입니다 -->
		var second_content = ""; <!-- 변경 항목입니다 -->
		var new_content = ""; <!-- 변경 입력창입니다 -->
		
		clicked_btn = $(e).attr('id');
		
		switch(str){
		case 'password' : 
			form_head_title = '<h2>비밀번호를 변경하시겠습니까?</h2>';
			first_content = '<span>변경 전 비밀번호를 입력해주세요.</span>';
			ori_content = '<input type="password" id="ori_pwd" class="new_data">';
			second_content = '<span>새로운 비밀번호를 입력해주세요.</span>';
			new_content = '<input type="password" name="member_password" id="new_pwd" class="new_data" disabled="disabled">';
			break;
		case 'name': 
			form_head_title = '<h2>이름을 변경하시겠습니까?</h2>';
			first_content = '<span>변경 전 이름</span>';
			ori_content = first_name;
			second_content = '<span>변경 후 이름</span>';
			new_content = '<input type="type" name="member_name" id="new_name" class="new_data">';
			break;
		case 'phone' : 
			form_head_title = '<h2>전화번호를 변경하시겠습니까?</h2>';
			first_content = '<span>변경 전 전화번호</span>';
			ori_content = '+82 ' + first_phone + ' - ' + first_phone1 + ' - ' + first_phone2;
			second_content = '<span>변경 후 전화번호</span>';
			new_content = '<input type="text" name="member_phone" id="new_phone" size="3" maxlength="3" class="new_data" style="width:auto;">&nbsp;-&nbsp;';
			new_content += '<input type="text" name="member_phone1" id="new_phone" size="4" maxlength="4" class="new_data" style="width:auto;">&nbsp;-&nbsp;';
			new_content += '<input type="text" name="member_phone2" id="new_phone" size="4" maxlength="4" class="new_data" style="width:auto;">';
			break;
		case 'email' : 
			form_head_title = '<h2>이메일을 변경하시겠습니까?</h2>';
			first_content = '<span>변경 전 이메일</span>';
			ori_content = first_email;
			second_content = '<span>새로운 이메일 입력해주세요.</span>';
			new_content = '<input type="email" name="member_email" id="new_email" class="new_data">';
			break;
		}
		
		$('#'+clicked_btn).css('background-color','#C26225');
		$('#'+clicked_btn).children('.btn_text').css('color','white');
		$('#'+clicked_btn).attr("disabled", true);
		
		$('.form_head_title').append(form_head_title);
		$('.first_content').append(first_content);
		$('.ori_content').append(ori_content);
		$('.second_content').append(second_content);
		$('.new_content').append(new_content);
		
		$('.modal').css("display","block");
		$('body').css("overflow","hidden");
	}
	
	
</script>
</head>
<body>
	<!-- 회원정보창 -->
	<div class="member_info">
	
		<!-- 좌측 화면 -->
		<div class="content_one">
		
			<div class="content_head">
				<span class="head_title">기본정보</span>
				<span class="head_icon"><i class="fa-regular fa-circle-question"></i></span>
			</div>
			
			<div class="content_body">
				<ul class="content_list">
				
					<li>
						<div class="photo">
							<img src="${path}/resources/img/default.png" style="width:70px;height:70px;" />
						</div>
						<div class="account">
							<div class="name"><span id="name">${member.member_name }</span></div>
							<div class="id"><span id="id">${member.member_id }</span></div>
						</div>
						<div class="update_btn">
							<button type="button" class="edit_btn" id="password_btn" onclick="modal_open(this,'password')" style="margin-bottom:5px;"><span class="btn_text">비밀번호변경</span></button>
							<button type="button" class="edit_btn" id="name_btn" onclick="modal_open(this,'name')"><span class="btn_text">실명수정</span></button>
						</div>
					</li>
					
					<li style="border-top: 1px solid rgba(220,227,233,.8);">
						<div class="icon">
							<span id="icon"><i class="fa-solid fa-mobile-screen-button"></i></span>
						</div>
						<div class="phone">
							<span id="phone">+82 ${member.member_phone}&nbsp;-&nbsp;${member.member_phone1}&nbsp;-&nbsp;${member.member_phone2}</span>
						</div>
						<div class="update_btn">
							<button type="button" class="edit_btn" onclick="modal_open('phone')"><span class="btn_text">수정</span></button>
						</div>
					</li>
					
					<li style="border-top: 1px solid rgba(220,227,233,.8);">
						<div class="icon"><span id="icon"><i class="fa-regular fa-envelope"></i></span></div>
						<div class="email"><span id="mail">${member.member_email}</span></div>
						<div class="update_btn">
							<button type="button" class="edit_btn" onclick="modal_open('email')"><span class="btn_text">수정</span></button>
						</div>
					</li>
					
					<li style="border-top: 1px solid rgba(220,227,233,.8);">
						<div id="info_tooltip" class="tooltip">
							<strong class="info_head">사용자 이름</strong>
							<p class="tooltip_text">본인확인이 가능한 이름을 사용하시기 바랍니다.</p>
							<strong class="info_head">연락처 이메일</strong>
							<p class="tooltip_text">아이디, 비밀번호 찾기, 로그인이 안되는 경우 등 <br>본인확인이 필요한 경우 사용합니다.</p>
							<strong class="info_head">주소 변경</strong>
							<p class="tooltip_text">기존 배송지로 사용할 수 있으니, 정확한 주소입력이 필요합니다.</p>
						</div>
					</li>
					
				</ul>
			</div>
			
		</div>
		
		<!-- 우측 화면 -->
		<div class="content_two">
		
			<div class="content_head">
				<span class="head_title">주소관리</span>
				<span class="head_icon"><i class="fa-regular fa-circle-question"></i></span>
			</div>
			
			<div class="content_body">
				<ul class="content_list">
				
					<li style="border-bottom: 1px solid rgba(220,227,233,.8); padding-bottom:15px;">
						<div class="icon2">
							<span id="base">기본배송지</span>
						</div>
						<div class="address">
							<div class="code">
								<span id="code">${member.zipno}</span>
							</div>
							<div class="fulladdr">
								<span id="fulladdr">${member.roadFullAddr}</span>
							</div>
							<div class="detail">
								<span id="detail">${member.addDetail}</span>
							</div>
						</div>
						<div class="update_btn" style="width: 100%; text-align: right;">
							<button type="button" class="edit_btn" onclick="" style="width:80px;"><span class="btn_text">주소 변경</span></button>
						</div>
					</li>
					
					<li>
						<div class="ctrl_btn">
							<input id="close_btn" type="button" value="취소"/>
							<input id="update_btn" type="button" value="수정 적용하기"/>
						</div>
					</li>
					
					<li>
						<div class="content_head" style="margin-top:80px;">
							<span class="head_title">상품보러가기</span>
							<span class="head_icon"><i class="fa-regular fa-circle-question"></i></span>
						</div>
						<div class="content_body" style="width: 100%;">
							<div class="banner" style="width: 100%;">
								<a href="${path}/product/productList?product_cateL=커피&product_cateS=">
									<img src="${path}/resources/img/1.jpg" style="width: 100%; height: 80px; box-shadow: rgb(149, 157, 165, 0.2) 0px 8px 24px;"/>
								</a>
							</div>
						</div>
					</li>
					
					<li>
						<div class="withdraw" style="margin-top:10px; display: flex; justify-content: space-between;">
							<button class="edit_btn" onclick="history.back()" style="display: block;"><span class="btn_text">돌아가기</span></button>
							<button type="button" class="edit_btn" id="withdraw" 
								onclick="location.href='${path}/member/withdraw_page?member_id=${member.member_id}';" style="display: block;"><span class="btn_text">회원탈퇴</span></button>
						</div>
					</li>
					
				</ul>
			</div>
			
		</div>
		
	</div>
	
	<!-- 수정창 -->
	<div class="modal">
		<div class="modal_content">
			<div class="update_form">
				<div class="form_head">
					<!-- 무엇을 변경하시겠습니까? -->
					<div class="form_head_title"></div>
				</div>
				
				<div class="form_body">
					<!-- 변경 전 항목입니다 -->
					<div class="first_content" style="width: 30%;"></div>
					<!-- 변경 전 데이터입니다 -->
					<div class="ori_content" style="width: 60%; margin-bottom:10px;"></div>
					<!-- 변경 항목입니다 -->
					<div class="second_content" style="width: 30%;"></div>
					<!-- 변경 입력창입니다 -->
					<div class="new_content" style="width: 60%; margin-bottom:10px;"></div>
				</div>
				
				<div class="form_footer">
					<input id="update_close_btn" type="button" onclick="modal_btn()" value="취소"/>
					<input id="update_insert_btn" type="button" onclick="update_check()" value="수정하기" disabled="disabled"/>
				</div>
			</div>
		</div>
	</div>
	
<script>
	//회원정보 수정창 비활성화
	function modal_btn(){
			$('.form_head_title').empty();
			$('.first_content').empty();
			$('.ori_content').empty();
			$('.second_content').empty();
			$('.new_content').empty();
			
			$('#'+clicked_btn).css('background-color','rgba(212,216,229,.25)');
			$('#'+clicked_btn).children('.btn_text').css('color','#7b8994');
			$('#'+clicked_btn).attr("disabled", false);

			$('.modal').css("display","none");
			$('body').css("overflow","unset");
	}
	
	// 영역 밖 클릭 시 닫힘 이벤트
	window.onclick = function(event){
		if(event.target.className == 'modal'){
			event.target.style.display = "block";
			$('.modal').css("display","none");
			$('.form_head_title').empty();
			$('.first_content').empty();
			$('.ori_content').empty();
			$('.second_content').empty();
			$('.new_content').empty();
			
			$('#'+clicked_btn).css('background-color','rgba(212,216,229,.25)');
			$('#'+clicked_btn).children('.btn_text').css('color','#7b8994');
			$('#'+clicked_btn).attr("disabled", false);
			
			$('body').css("overflow","unset");
		};
	}
	
	// 유효성 검사
	
	$(function(){
		// 모달이 활성화 중일때
		console.log(야호);
		if($('.modal').css('display') == 'block'){
			var message = '';
			console.log('야호');
			//기존 비밀번호와 일치 확인
			$('#ori_pwd').focus(function(){
				if($('#ori_pwd').val().length > 0 && $('#ori_pwd').val() != first_password){
					message = '<span id="message" style="color:red; font-size:small;">비밀번호가 일치하지 않습니다.</span>';
					$('.ori_content').append(message);
				}
				if($('#ori_pwd').val().length > 0 && $('#ori_pwd').val() === first_password){
					 $(".ori_content").find("#message").remove();
					message = '<span id="message" style="color:green; font-size:small;">비밀번호가 일치합니다.</span>';
					$('.ori_content').append(message);
					$('#new_pwd').attr("disabled", false);
				}
			});
			
			// 새로운 비밀번호 유효성 검사
			$('#new_pwd').focus(function(){
				if($('#new_pwd').val().length >= 0 && $('#new_pwd').val().length < 6){
					message = '<span id="message" style="color:red; font-size:small;">비밀번호는 6자리 이상 16자리 이하로 작성해주세요.</span>';
					$('.new_content').append(message);
				} 
				if($('#new_pwd').val().length > 16) {
					$(".new_content").find("#message").remove();
					message = '<span id="message" style="color:red; font-size:small;">비밀번호는 6자리 이상 16자리 이하로 작성해주세요.</span>';
					$('.new_content').append(message);
				}
				if($('#new_pwd').val().length >= 6 && $('#new_pwd').val().length < 16){
					$(".new_content").find("#message").remove();
					var pw1 = $('#new_pwd').val();
					
					var pattern1 = /[0-9]/;  // 숫자
					var pattern2 = /[a-z]/;
					var pattern3 = /[A-Z]/;
					var pattern4 = /[~!@#$%^&*()_+|<>?:{}]/;  // 특수문자
					var patternCnt = 0;
					if( pattern1.test(pw1) ) {
					   patternCnt++;
					}
					if( pattern2.test(pw1) ) {
					   patternCnt++;
					}
					if( pattern3.test(pw1) ) {
					   patternCnt++;
					}
					if( pattern4.test(pw1) ) {
					   patternCnt++;
					}
					if( patternCnt >= 2 ) {
				    	 $(".new_content").find("#message").remove();
							message = '<span id="message" style="color:green; font-size:small;">비밀번호 변경이 가능합니다.</span>';
							$('.new_content').append(message);
							$('#update_insert_btn').attr("disabled", false);
				     }
				} 
			});
			
			
			
			
		}
			
	});
</script>
</body>
</html>