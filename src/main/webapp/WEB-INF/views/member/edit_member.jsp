<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
   
   <link rel="stylesheet" href="../css/reset.css" />
   <link href="${path}/resources/css/member/bootstrap.min.css" rel="stylesheet">
   <link href="${path}/resources/css/member/signin.css" rel="stylesheet">
   
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   
   <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
   
   <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
   <script>
      /* 다음 주소 연동 */
       function execution_daum_address() {
           new daum.Postcode({
               oncomplete: function(data) {
                   // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
   
                   // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                   // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                   var roadAddr = data.roadAddress; // 도로명 주소 변수
                   var extraRoadAddr = ''; // 참고 항목 변수
   
                   // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                   // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                   if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                       extraRoadAddr += data.bname;
                   }
                   // 건물명이 있고, 공동주택일 경우 추가한다.
                   if(data.buildingName !== '' && data.apartment === 'Y'){
                      extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                   }
                   // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                   if(extraRoadAddr !== ''){
                       extraRoadAddr = ' (' + extraRoadAddr + ')';
                   }
   
                   // 우편번호와 주소 정보를 해당 필드에 넣는다.
                   document.getElementById('sample4_postcode').value = data.zonecode;
                   document.getElementById("sample4_roadAddress").value = roadAddr;
                   document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
   
                   var guideTextBox = document.getElementById("guide");
                   // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                   if(data.autoRoadAddress) {
                       var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                       guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                       guideTextBox.style.display = 'block';
   
                   } else if(data.autoJibunAddress) {
                       var expJibunAddr = data.autoJibunAddress;
                       guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                       guideTextBox.style.display = 'block';
                   } else {
                       guideTextBox.innerHTML = '';
                       guideTextBox.style.display = 'none';
                   }
               }
           }).open();
       }
   </script>

	<script type="text/javascript">
		
		function editMember() {
			
			// 유효성 체크 및 값 추가
			var member_password = $("input[name='member_password']").val().trim();
			if( member_password == null || !(member_password.length > 0) ) {
				alert("비밀번호를 입력하세요");
				return;
			}
			
			if( !confirm("회원정보를 수정하시겠습니까?") ) {
				return;
			}
			
			$.ajax({
	            url : "editMember",
	            type : "post",
	            dataType : "text",
	            data : {
	            	member_password : member_password
	            },
	            success : function(data) {

	               if( data == "Y" ) {
	                  alert("");
	               } else {
	                  alert("");
	               }
	            },
	            error: function(e) {
	               console.log(e);
	               alert("error");
	            }
	         })
			
	        //폰번호 수정
			var member_phone = $("input[name='member_phone']").val().trim();
			var member_phone1 = $("input[name='member_phone1']").val().trim();
			var member_phone2 = $("input[name='member_phone2']").val().trim();
			if( member_phone == null || !(member_phone.length > 0) ) 
            if( member_phone1 == null || !(member_phone1.length > 0) )
            if( member_phone2 == null || !(member_phone2.length > 0) ){
				alert("번호를 입력하세요");
				return;
			}
			
			if( !confirm("회원정보를 수정하시겠습니까?") ) {
				return;
			}
			
			$.ajax({
	            url : "editMember",
	            type : "post",
	            dataType : "text",
	            data : {
	            	member_phone : member_phone
	            	member_phone1 : member_phone1
	            	member_phone2 : member_phone2
	            	
	            },
	            success : function(data) {

	               if( data == "Y" ) {
	                  alert("");
	               } else {
	                  alert("");
	               }
	            },
	            error: function(e) {
	               console.log(e);
	               alert("error");
	            }
	         })
	         
			//이메일 수정
			var member_email = $("input[name='member_email']").val().trim();
			if( member_email == null || !(member_email.length > 0) ) {
				alert("이메일을 입력하세요");
				return;
			}
			
			if( !confirm("회원정보를 수정하시겠습니까?") ) {
				return;
			}
			
			$.ajax({
	            url : "editMember",
	            type : "post",
	            dataType : "text",
	            data : {
	            	member_email : member_email
	            },
	            success : function(data) {

	               if( data == "Y" ) {
	                  alert("");
	               } else {
	                  alert("");
	               }
	            },
	            error: function(e) {
	               console.log(e);
	               alert("error");
	            }
	         })
		}
		
             function checkPw() {
	         
	         var pw = document.getElementById("member_password").value; //비밀번호
	         var pw2 = document.getElementById("member_password2").value; // 확인 비밀번호

	         var pattern1 = /^[a-z0-9]/;
	         // var pattern2 = /[a-z]/;
	         // var pattern3 =  /[A-Z]/;
	         // var pattern4 = /[~!@\#$%<>^&*]/;
	         var pw_msg = "";

	         if( pw.length == 0 ) {
	            alert("비밀번호를 입력해주세요");
	            return false;
	         } else {

	            if( pw  !=  pw2) {
	               alert("비밀번호가 일치하지 않습니다.");
	               return false;  
	            } else {

	               if( pw = pw2 ) {
	                  alert("비밀번호가 일치합니다.")
	               }
	            }
	         }    

	         if( !pattern1.test(pw) || pw.length < 6 || pw.length > 16 ) {
	            alert("영문+숫자+특수기호 6자리 이상 16글자 이하만 이용 가능합니다.");
	            return false;
	         }
	      }
             
             function checkaddDetail() {

             var add = $("#member_addDetail").val();
             if( add == null || !(id.length > 0) ) {
                alert("상세주소를 입력해주세요");
                return;
              }
            }
		
	</script>
	
<style>
.edit_member {
	width: 50%;
	border: 2px solid black;
	padding: 10px;
	margin: auto;
	text-align: center;
}
</style>
<link rel="stylesheet" href="${path}/resources/css/reset.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
	<div class="div" style="margin-top: 75px; min-height: 200px;"
		align="center">
		<form id="frm" method="post" action="${path }/member/edit">
			<table width="800">
				<tr height="40">
					<td align="center" ><b>
					<font size="5" color="black">[회원정보 수정]</font></b></td>
				</tr>
			</table>
			<table width="700" height="600" cellpadding="0"
				style="border-collapse: collapse; font-size: 9pt;">
				<tr class="register" height="30">
					<td width="5%" align="center">*</td>
					<td width="15%">회원 ID</td>
					<td>${m.member_id}</td>
				</tr>
				<tr height="7">
					<td colspan="3"><hr /></td>
				</tr>

            <tr class="register" height="30">
               <td width="5%" align="center">*</td>
               <td width="15%">비밀번호</td>
               <td>
                  <input type="password" name="member_password"
                     id="member_password" autocomplete="new-password"/>
                  &nbsp;(영문 소문자/숫자/특수문자, 6자~16자)
               </td>
            </tr>
              <tr height="7">
                 <td colspan="3"><hr /></td>
              </tr>
            <tr class="register" height="30">
               <td width="5%" align="center">*</td>
               <td width="15%">비밀번호 확인</td>
               <td><input type="password" name="member_password2"
                  id="member_password2"/> <a href="#"
                  onclick="checkPw()">확인</a></td>
            </tr>
				<tr height="7">
					<td colspan="3"><hr /></td>
				</tr>
				<tr class="register" height="30">
					<td width="5%" align="center">*</td>
					<td width="15%">이 름</td>
					<td><input type="text" value="${m.member_name}" name="member_name" /></td>
				</tr>
				<tr height="7">
					<td colspan="3"><hr /></td>
				</tr>
				<tr class="register" height="30">
					<td width="5%" align="center">*</td>
					<td width="15%">휴대전화</td>
					<td><select name="member_phone">
							<option value="" selected="selected">선택</option>
							<option value="010">010</option>
					</select> &nbsp;-&nbsp; <input type="text" name="member_phone1" size="4"
						maxlength="4"> &nbsp;-&nbsp; <input type="text"
						name="member_phone2" size="4" maxlength="4"></td>

				</tr>
				<tr height="7">
					<td colspan="3"><hr /></td>
				</tr>
				<tr class="register" height="30">
					<td width="5%" align="center">*</td>
					<td width="15%">이메일</td>
					<td><input type="email" name="member_email" /></td>
				</tr>
				<tr height="7">
					<td colspan="3"><hr /></td>
				</tr>
				<tr>
					<td width="5%" align="center">*</td>
					<td width="15%">주 소</td>
					<td><input type="text" size="10" name="zipno"
						id="sample4_postcode" placeholder="우편번호" readonly="readonly"
						onclick="DaumPostcode()"> <input type="button"
						onclick="execution_daum_address()" value="우편번호 찾기"><br>
						<br /> <input type="text" size="30" name="roadFullAddr"
						id="sample4_roadAddress" placeholder="도로명주소" readonly="readonly"
						onclick="DaumPostcode()"> <input type="text" size="30"
						name="roadFullAddr" id="sample4_jibunAddress" placeholder="지번주소"
						readonly="readonly" onclick="DaumPostcode()"> <br /> <span
						id="guide" style="color: #999; font-size: 10px;"></span> <br /> <br />
						<input type="text" name="addDetail" id="sample4_detailAddress"
						placeholder="나머지 주소" size="70" /></td>
				</tr>
			</table>
			
			<input class="check" type="button" value="확인"
				onclick="javascript:window.location='modmemPro'"/>
				<input class="back" type="button" value="취소"
				onclick="javascript:window.location='MainForm'"/>
				
		</form>
	</div>
</body>
</html>