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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
	
	.address {width: 380px;}
	.address input{display: block; max-width: 250px; font-size: 10pt; margin-bottom: 5px; border:none;}

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
	#update_insert_btn:disabled { background-color: #959eae; cursor: not-allowed;}
	#update_close_btn {width: 120px; height: 30px; border-radius: 1px; background-color: transparent; color: black; border-width: 1px; font-size:medium; cursor: pointer;}
	.new_data{padding: 9px 11px 9px 11px; width: 100%; height: 36px; font-size: 14px; font-weight: 400; line-height: 16px; letter-spacing: -.46px; box-sizing: border-box; 
		color: #303038;}
	.form_body div span{display: inline-block; font-size: 16px; font-weight: 700; line-height: 17px; letter-spacing: -.4px; color: #96a1aa;}
	.form_head_title h2{font-size: large; font-weight: bold; margin-top:20px;}
	#new_phone{border-radius: 10px; border-color:  #96a1aa;}
	#detailAddress {border-radius: 5px; border : 1px solid #96a1aa; height:25px;}
</style>
<script>
	var member_id = '${member.member_id}';
	var member_password = '${member.member_password}';
	var first_name = '${member.member_name}';
	var first_phone = '${member.member_phone}';
	var first_email = '${member.member_email}';
	var first_zipno = '${member.zipno}';
	var first_roadFullAddr = '${member.roadFullAddr}';
	var first_addDetail = '${member.addDetail}';
	
	let data_str = "";
	let clicked_btn = ""; <!-- ????????? ????????? ???????????? -->
	
	// ???????????? ????????? ?????????
	function modal_open(e,str){
		var form_head_title = ""; <!-- ????????? ????????????????????????? -->
		var first_content = ""; <!-- ?????? ??? ??????????????? -->
		var ori_content = ""; <!-- ?????? ??? ?????????????????? -->
		var second_content = ""; <!-- ?????? ??????????????? -->
		var new_content = ""; <!-- ?????? ?????????????????? -->
		
		clicked_btn = $(e).attr('id');
		
		switch(str){
		case 'password' : 
			form_head_title = '<h2>??????????????? ?????????????????????????</h2>';
			first_content = '<span>?????? ??? ??????????????? ??????????????????.</span>';
			ori_content = '<input type="password" id="ori_pwd" class="new_data" onclick="ori_pwd_check()">';
			second_content = '<span>????????? ??????????????? ??????????????????.</span>';
			new_content = '<input type="password" name="member_password" id="new_pwd" class="new_data" onclick="new_pwd_check()" disabled="disabled">';
			break;
		case 'name': 
			form_head_title = '<h2>????????? ?????????????????????????</h2>';
			first_content = '<span>?????? ??? ??????</span>';
			ori_content = first_name;
			second_content = '<span>?????? ??? ??????</span>';
			new_content = '<input type="type" name="member_name" id="new_name" class="new_data" onclick="new_name_check()">';
			break;
		case 'phone' : 
			form_head_title = '<h2>??????????????? ?????????????????????????</h2>';
			first_content = '<span>?????? ??? ????????????</span>';
			ori_content = '+82 '+first_phone;
			second_content = '<span>?????? ??? ????????????</span>';
			new_content = '<input type="text" name="member_phone" id="new_phone" size="3" maxlength="3" class="new_data" onclick="new_phone_check()" style="width:auto;">&nbsp;-&nbsp;';
			new_content += '<input type="text" name="member_phone1" id="new_phone" size="4" maxlength="4" class="new_data" style="width:auto;">&nbsp;-&nbsp;';
			new_content += '<input type="text" name="member_phone2" id="new_phone" size="4" maxlength="4" class="new_data" style="width:auto;">';
			break;
		case 'email' : 
			form_head_title = '<h2>???????????? ?????????????????????????</h2>';
			first_content = '<span>?????? ??? ?????????</span>';
			ori_content = first_email;
			second_content = '<span>????????? ????????? ??????????????????.</span>';
			new_content = '<input type="email" name="member_email" id="new_email" class="new_data" onclick="new_email_check()">';
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
		$('#update_insert_btn').attr("disabled", true);
		
		$('.modal').css("display","block");
		$('body').css("overflow","hidden");
	}
	
	/* ?????? ?????? ?????? */
	function execution_daum_address() {
           new daum.Postcode({
               oncomplete: function(data) {
                   // ???????????? ???????????? ????????? ??????????????? ????????? ????????? ???????????? ??????.
   
                   // ????????? ????????? ?????? ????????? ?????? ????????? ????????????.
                   // ???????????? ????????? ?????? ?????? ????????? ??????('')?????? ????????????, ?????? ???????????? ?????? ??????.
                   var roadAddr = data.roadAddress; // ????????? ?????? ??????
                   var extraRoadAddr = ''; // ?????? ?????? ??????
   
                   // ??????????????? ?????? ?????? ????????????. (???????????? ??????)
                   // ???????????? ?????? ????????? ????????? "???/???/???"??? ?????????.
                   if(data.bname !== '' && /[???|???|???]$/g.test(data.bname)){
                       extraRoadAddr += data.bname;
                   }
                   // ???????????? ??????, ??????????????? ?????? ????????????.
                   if(data.buildingName !== '' && data.apartment === 'Y'){
                      extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                   }
                   // ????????? ??????????????? ?????? ??????, ???????????? ????????? ?????? ???????????? ?????????.
                   if(extraRoadAddr !== ''){
                       extraRoadAddr = ' (' + extraRoadAddr + ')';
                   }
   
                   // ??????????????? ?????? ????????? ?????? ????????? ?????????.
                   document.getElementById('postcode').value = data.zonecode;
                   document.getElementById("roadAddress").value = roadAddr;
                   document.getElementById("jibunAddress").value = data.jibunAddress;
   
                   var guideTextBox = document.getElementById("guide");
                   // ???????????? '?????? ??????'??? ????????? ??????, ?????? ???????????? ????????? ?????????.
                   if(data.autoRoadAddress) {
                       var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                       guideTextBox.innerHTML = '(?????? ????????? ?????? : ' + expRoadAddr + ')';
                       guideTextBox.style.display = 'block';
   
                   } else if(data.autoJibunAddress) {
                       var expJibunAddr = data.autoJibunAddress;
                       guideTextBox.innerHTML = '(?????? ?????? ?????? : ' + expJibunAddr + ')';
                       guideTextBox.style.display = 'block';
                   } else {
                       guideTextBox.innerHTML = '';
                       guideTextBox.style.display = 'none';
                   }
               }
           }).open();
       }
	
	//???????????? ????????? ????????????
	function modal_btn(){
			$('.form_head_title').empty();
			$('.first_content').empty();
			$('.ori_content').empty();
			$('.second_content').empty();
			$('.new_content').empty();
			
			$('#'+clicked_btn).css('background-color','rgba(212,216,229,.25)');
			$('#'+clicked_btn).children('.btn_text').css('color','#7b8994');
			$('#'+clicked_btn).attr("disabled", false);

			$('#update_insert_btn').attr("disabled", true);
			$('.modal').css("display","none");
			$('body').css("overflow","unset");
	}
	
	// ?????? ??? ?????? ??? ?????? ?????????
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
			
			$('#update_insert_btn').attr("disabled", true);
			$('body').css("overflow","unset");
		};
	}
	
	// ????????? ??????
	var message = '';
	
	//?????? ??????
	function new_name_check(){
		$('#new_name').keyup(function(){
			var pattern4 = /[~!@#$%^&*()_+|<>?:{}]/;  // ????????????
			var pattern1 = /[0-9]/;  // ??????
			var new_name = $('#new_name').val();
			
			$(".new_content").find("#message").remove();
			
			if(new_name.length < 2){
				message = '<span id="message" style="color:red; font-size:small;">????????? 2???????????? ?????? ???????????????.</span>';
				$('.new_content').append(message);
				$('#update_insert_btn').attr("disabled", true);
			}
			
			if(new_name.length >= 2){
				if(first_name == new_name){
					message = '<span id="message" style="color:red; font-size:small;">?????? ????????? ???????????????.</span>';
					$('.new_content').append(message);
					$('#update_insert_btn').attr("disabled", true);
				} else {
					if(pattern1.test(new_name) == true || pattern4.test(new_name) == true){
						message = '<span id="message" style="color:red; font-size:small;">????????? ?????? ?????? ????????? ?????? ???????????????.</span>';
						$('.new_content').append(message);
						$('#update_insert_btn').attr("disabled", true);
					} else {
						message = '<span id="message" style="color:green; font-size:small;">?????? ????????? ???????????????.</span>';
						$('.new_content').append(message);
						$('#update_insert_btn').attr("disabled", false);
					}
				
				}
			}
		});
	}
	
	
	//?????? ???????????? ??????
	function ori_pwd_check(){
		$('#ori_pwd').keyup(function(e){
			var ori_pwd = $('#ori_pwd').val();
			$(".ori_content").find("#message").remove();
			
			if(ori_pwd.length == member_password.length && ori_pwd === member_password){
				message = '<span id="message" style="color:green; font-size:small;">??????????????? ???????????????.</span>';
				$('.ori_content').append(message);
				$('#new_pwd').attr("disabled", false);
			} else {
				message = '<span id="message" style="color:red; font-size:small;">??????????????? ???????????? ????????????.</span>';
				$('.ori_content').append(message);
			}
			
			if(e.key == 9){
				new_pwd_check();
			}
		});
	}
	
	// ????????? ???????????? ????????? ??????
	function new_pwd_check(){
		$('#new_pwd').keyup(function(e){
			var new_pwd = $('#new_pwd').val();
			
			$(".new_content").find("#message").remove();
			
			if(new_pwd.length > 0 && new_pwd.length < 6){
				message = '<span id="message" style="color:red; font-size:small;">??????????????? 6?????? ?????? 16?????? ????????? ??????????????????.</span>';
				$('.new_content').append(message);
				$('#update_insert_btn').attr("disabled", true);
			} else if(new_pwd.length > 16){
				message = '<span id="message" style="color:red; font-size:small;">??????????????? 6?????? ?????? 16?????? ????????? ??????????????????.</span>';
				$('.new_content').append(message);
				$('#update_insert_btn').attr("disabled", true);
			} else if(new_pwd.length >= 6 && new_pwd.length < 16){
				var pattern1 = /[0-9]/;  // ??????
				var pattern2 = /[a-z]/;
				var pattern3 = /[A-Z]/;
				var pattern4 = /[~!@#$%^&*()_+|<>?:{}]/;  // ????????????
				var patternCnt = 0;
				
				if( pattern1.test(new_pwd) ) {
				   patternCnt++;
				}
				if( pattern2.test(new_pwd) ) {
				   patternCnt++;
				}
				if( pattern3.test(new_pwd) ) {
				   patternCnt++;
				}
				if( pattern4.test(new_pwd) ) {
				   patternCnt++;
				}
				if( patternCnt >= 2 ) {
					if(new_pwd == member_password) {
							message = '<span id="message" style="color:red; font-size:small;">?????? ??????????????? ???????????????.</span>';
							$('.new_content').append(message);
							$('#update_insert_btn').attr("disabled", true);
					} else { 
						message = '<span id="message" style="color:green; font-size:small;">???????????? ????????? ???????????????.</span>';
						$('.new_content').append(message);
						$('#update_insert_btn').attr("disabled", false);
					}
				} else {
					message = '<span id="message" style="color:red; font-size:small;">??????????????? ?????? ????????????/??????/???????????? ??? 2?????? ?????? ???????????? ???????????????.</span>';
					$('.new_content').append(message);
					$('#update_insert_btn').attr("disabled", false);
				}
			}
		});	
	}
	var phone_data = "";
	
	// ???????????? ?????? ????????? ??????, ????????????
	function new_phone_check(){
		var phone1 = "";
		var phone2 = "";
		var phone3 = "";
		
		$('input[name=member_phone]').keyup(function(){
			phone1 = $('input[name=member_phone]').val();
			
			if(isNaN(phone1)){
				$(".new_content").find("#message").remove();
				message = '<span id="message" style="color:red; font-size:small;">????????? ?????????????????????.</span>';
				$('.new_content').append(message);
			} else {
				$(".new_content").find("#message").remove();
			}
		});
		
		$('input[name=member_phone1]').keyup(function(){
			phone2 = $('input[name=member_phone1]').val();
			
			if(isNaN(phone2)){
				$(".new_content").find("#message").remove();
				message = '<span id="message" style="color:red; font-size:small;">????????? ?????????????????????.</span>';
				$('.new_content').append(message);
			} else {
				$(".new_content").find("#message").remove();
			}
		});
		
		$('input[name=member_phone2]').keyup(function(){
			phone3 = $('input[name=member_phone2]').val();
			
			if(isNaN(phone3)){
				$(".new_content").find("#message").remove();
				message = '<span id="message" style="color:red; font-size:small;">????????? ?????????????????????.</span>';
				$('.new_content').append(message);
			} else {
				$(".new_content").find("#message").remove();
			}
			
			if(phone1 != null && phone1.length == 3 && phone2 != null && phone2.length == 4 && phone3 != null && phone3.length == 4){
				phone_data = phone1 + '-' + phone2 + '-' + phone3;
				
				$.ajax({
					url : "phonecheck",
		            type : "post",
		            dataType : "text",
		            data : {
		               "member_phone" : phone_data
		            },
		            success : function(data) {
		            	if(data == 'Y'){
		            		$(".new_content").find("#message").remove();
		            		message = '<span id="message" style="color:green; font-size:small;">?????? ????????? ?????????????????????.</span>';
		            		$('.new_content').append(message);
		            		$('#update_insert_btn').attr("disabled", false);
		            	} else {
		            		$(".new_content").find("#message").remove();
		            		message = '<span id="message" style="color:red; font-size:small;">????????? ?????????????????????.</span>';
		            		$('.new_content').append(message);
		            		$('#update_insert_btn').attr("disabled", true);
		            	}
		            }
				});
			}
		});
	}
	
	// ????????? ????????????
	function new_email_check(){
		var mail_str = '';
		
		$('#new_email').keyup(function(){
			mail_str = $('#new_email').val();
			var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
			
			if(mail_str.length > 9 && exptext.test(mail_str) == false){
				$(".new_content").find("#message").remove();
				message = '<span id="message" style="color:red; font-size:small;">????????? ????????? ???????????????.</span>';
        		$('.new_content').append(message);
        		$('#update_insert_btn').attr("disabled", true);
			} else if(mail_str.length > 9 && exptext.test(mail_str) == true){
				$.ajax({
		            url : "emailcheck",
		            type : "post",
		            dataType : "text",
		            data : {
		               "member_email" : mail_str
		            },
		            success : function(data) {
		            	if(data == 'Y'){
		            		$(".new_content").find("#message").remove();
		            		message = '<span id="message" style="color:green; font-size:small;">?????? ????????? ??????????????????.</span>';
		            		$('.new_content').append(message);
		            		$('#update_insert_btn').attr("disabled", false);
		            	} else {
		            		$(".new_content").find("#message").remove();
		            		message = '<span id="message" style="color:red; font-size:small;">????????? ??????????????????.</span>';
		            		$('.new_content').append(message);
		            		$('#update_insert_btn').attr("disabled", true);
						}
					}
				});
			}
		});
	}
</script>
<script>
	
	// ?????? ???????????? ??????(????????? span ?????? ????????????)
	function update_check(){
		var input_data = $('.new_content').children('input').attr('id');
		
		switch(input_data){
		case 'new_pwd' : 
			//second_passowrd = $('#new_pwd').val();
			$('input[name=second_password]').val($('#new_pwd').val());
			break;
		case 'new_name' :
			$('input[name=second_name').val($('#new_name').val());
			$('#name').text($('#new_name').val());
			break;
		case 'new_phone' :
			$('input[name=second_phone').val(phone_data);
			$('#phone').text(phone_data);
			break;
		case 'new_email' :
			$('input[name=second_email').val($('#new_email').val());
			$('#mail').text($('#new_email').val());
			break;
		}
		
		alert('??????????????? ?????? ?????????????????????. ?????? ??????????????? ???????????????.');

		$('.modal').css("display","none");
		$('body').css("overflow","unset");
		
		$('.form_head_title').empty();
		$('.first_content').empty();
		$('.ori_content').empty();
		$('.second_content').empty();
		$('.new_content').empty();
	}
	
	function update_member(){
		data_str = "";
		var second_password = $('input[name=second_password]').val();
		var second_name = $('input[name=second_name]').val();
		var second_phone = $('input[name=second_phone]').val();
		var second_email = $('input[name=second_email]').val();
		var second_zipno = $('#postcode').val();
		var second_roadFullAddr = $('#roadAddress').val();
		var second_addDetail = $('#detailAddress').val();
		
		if(second_password != "0" || second_name != "0" || second_phone != "0" || second_email != "0" || second_zipno != first_zipno){
			var data_id = '${member.member_id}';
			var data_password = second_password;
			var data_name = $('#name').text();
			var data_phone = $('#phone').text();
			var data_email = $('#mail').text();
			var data_zipno = $('#postcode').val();
			var data_roadFullAddr = $('#roadAddress').val();
			var data_addDetail= $('#detailAddress').val();

			data_str = {
					"member_id" : data_id,
					"member_password" : data_password,
					"member_name" : data_name,
					"member_phone" : data_phone,
					"member_email" : data_email,
					"zipno" : data_zipno,
					"roadFullAddr" : data_roadFullAddr,
					"addDetail" : data_addDetail
			};

			$.ajax({
				url : "editMember",
		        type : "POST",
		        dataType : "text",
		        data : data_str,
		        success:function(result){
					if(result == 1){
						alert('????????? ?????????????????????.');
						location.reload();
					} else {
						alert('????????? ??????????????????.');
					}
				},error: function (request, status, error) {
			        console.log("code: " + request.status)
			        console.log("message: " + request.responseText)
			        console.log("error: " + error);
			    }
			});
		} else {
			alert('????????? ????????? ????????????.');
		}
	}
</script>
</head>
<body>
	<!-- ??????????????? -->
	<div class="member_info">
	
		<!-- ?????? ?????? -->
		<div class="content_one">
		
			<div class="content_head">
				<span class="head_title">????????????</span>
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
							<button type="button" class="edit_btn" id="password_btn" onclick="modal_open(this,'password')" style="margin-bottom:5px;"><span class="btn_text">??????????????????</span></button>
							<button type="button" class="edit_btn" id="name_btn" onclick="modal_open(this,'name')"><span class="btn_text">????????????</span></button>
						</div>
					</li>
					
					<li style="border-top: 1px solid rgba(220,227,233,.8);">
						<div class="icon">
							<span id="icon"><i class="fa-solid fa-mobile-screen-button"></i></span>
						</div>
						<div class="phone">
							+82 &nbsp; <span id="phone">${member.member_phone}</span>
						</div>
						<div class="update_btn">
							<button type="button" class="edit_btn" id="phone_btn" onclick="modal_open(this,'phone')"><span class="btn_text">??????</span></button>
						</div>
					</li>
					
					<li style="border-top: 1px solid rgba(220,227,233,.8);">
						<div class="icon"><span id="icon"><i class="fa-regular fa-envelope"></i></span></div>
						<div class="email"><span id="mail">${member.member_email}</span></div>
						<div class="update_btn">
							<button type="button" class="edit_btn" id="mail_btn" onclick="modal_open(this,'email')"><span class="btn_text">??????</span></button>
						</div>
					</li>
					
					<li style="border-top: 1px solid rgba(220,227,233,.8);">
						<div id="info_tooltip" class="tooltip">
							<strong class="info_head">????????? ??????</strong>
							<p class="tooltip_text">??????????????? ????????? ????????? ??????????????? ????????????.</p>
							<strong class="info_head">????????? ?????????</strong>
							<p class="tooltip_text">?????????, ???????????? ??????, ???????????? ????????? ?????? ??? <br>??????????????? ????????? ?????? ???????????????.</p>
							<strong class="info_head">?????? ??????</strong>
							<p class="tooltip_text">?????? ???????????? ????????? ??? ?????????, ????????? ??????????????? ???????????????.</p>
						</div>
					</li>
					
				</ul>
			</div>
			
		</div>
		
		<!-- ?????? ?????? -->
		<div class="content_two">
		
			<div class="content_head">
				<span class="head_title">????????????</span>
				<span class="head_icon"><i class="fa-regular fa-circle-question"></i></span>
			</div>
			
			<div class="content_body">
				<ul class="content_list">
				
					<li style="border-bottom: 1px solid rgba(220,227,233,.8); padding-bottom:15px;">
						<div class="icon2">
							<span id="base">???????????????</span> <!-- #code, #fulladdr, #detail -->
						</div>
						<div class="address">
							<input type="text" size="10" name="zipno" id="postcode" readonly="readonly" onclick="DaumPostcode()" value="${member.zipno}">
							<input type="text" size="30" name="roadFullAddr" id="roadAddress" readonly="readonly" onclick="DaumPostcode()" value="${member.roadFullAddr}">
							<span id="guide" style="color: #999; font-size: 10px;"></span>
							<input type="text" name="addDetail" id="detailAddress" size="70" value="${member.addDetail}"/>
						</div>
						<div class="update_btn" style="width: 100%; text-align: right;">
							<button type="button" class="edit_btn" id="address_btn" onclick="execution_daum_address()" style="width:80px;"><span class="btn_text">?????? ??????</span></button>
						</div>
					</li>
					
					<li>
						<div class="ctrl_btn">
							<input id="close_btn" onclick="location.reload()" type="button" value="??????"/>
							<input id="update_btn" onclick="update_member()" type="button" value="?????? ????????????"/>
						</div>
					</li>
					
					<li>
						<div class="content_head">
							<span class="head_title">??????????????????</span>
							<span class="head_icon"><i class="fa-regular fa-circle-question"></i></span>
						</div>
						<div class="content_body" style="width: 100%;">
							<div class="banner" style="width: 100%;">
								<a href="${path}/product/productList?product_cateL=??????&product_cateS=">
									<img src="${path}/resources/img/1.jpg" style="width: 100%; height: 80px; box-shadow: rgb(149, 157, 165, 0.2) 0px 8px 24px;"/>
								</a>
							</div>
						</div>
					</li>
					
					<li>
						<div class="withdraw" style="margin-top:10px; display: flex; justify-content: space-between;">
							<button class="edit_btn" onclick="history.back()" style="display: block;"><span class="btn_text">????????????</span></button>
							<button type="button" class="edit_btn" id="withdraw" 
								onclick="location.href='${path}/member/withdraw_page?member_id=${member.member_id}';" style="display: block;"><span class="btn_text">????????????</span></button>
						</div>
					</li>
					
				</ul>
			</div>
			
		</div>
		<input type="hidden" name="second_password" value="0"/>
		<input type="hidden" name="second_name" value="0"/>
		<input type="hidden" name="second_phone" value="0"/>
		<input type="hidden" name="second_email" value="0"/>
		<input type="text" size="30" name="roadFullAddr" id="jibunAddress" readonly="readonly" style="display: none;"onclick="DaumPostcode()">
	</div>
	
	<!-- ????????? -->
	<div class="modal">
		<div class="modal_content">
			<div class="update_form">
				<div class="form_head">
					<!-- ????????? ????????????????????????? -->
					<div class="form_head_title"></div>
				</div>
				
				<div class="form_body">
					<!-- ?????? ??? ??????????????? -->
					<div class="first_content" style="width: 30%;"></div>
					<!-- ?????? ??? ?????????????????? -->
					<div class="ori_content" style="width: 60%; margin-bottom:10px;"></div>
					<!-- ?????? ??????????????? -->
					<div class="second_content" style="width: 30%;"></div>
					<!-- ?????? ?????????????????? -->
					<div class="new_content" style="width: 60%; margin-bottom:10px;"></div>
				</div>
				
				<div class="form_footer">
					<input id="update_close_btn" type="button" onclick="modal_btn()" value="??????"/>
					<input id="update_insert_btn" type="button" onclick="update_check()" value="????????????" disabled="disabled"/>
				</div>
			</div>
		</div>
	</div>
</body>
</html>