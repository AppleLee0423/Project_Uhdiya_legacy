<%@ page language="java" contentType="text/html; charset=UTF-8" 
         pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="path" value="${pageContext.request.contextPath}"/>

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
   <style>
   input:invalid {
  border: 3px solid red;
}
   </style>
   <script>
   /* 새로고침 스크롤위치고정 */
   var element = document.querySelector("#layout-nav");
   var scroll_position = localStorage.getItem("sidebar-scroll");
   if (scroll_position != null) {
       console.log("scroll position : ",scroll_position)
       element.scrollTop = parseInt(scroll_position, 10);
   }
   window.addEventListener("beforeunload", () => {
       localStorage.setItem("sidebar-scroll", element.scrollTop);
   });
   function safetyPasswordPattern(str) {
       var pass = str.value;
       var message = "";
       var color = "";
       var checkPoint = 0;
       // 입력값이 있을경우에만 실행
       if(pass.length) {
           // 최대 입력 글자수를 제한한다.
           if(pass.length < 6 || pass.length > 16) {
               message = ":: 최소 6자 이상, 최대 16자 이하 ::";
               color = "#A23E48";
           }
           // 문자열의 길이가 8 ~ 16 인경우
           else {
               // 비밀번호 문자열에 숫자 존재 여부 검사
               var pattern1 = /[0-9]/;  // 숫자
               if(pattern1.test(pass) == false) {
                   checkPoint = checkPoint + 1;
               }
               // 비밀번호 문자열에 영문 소문자 존재 여부 검사
               var pattern2 = /[a-z]/;
               if(pattern2.test(pass) == false) {
                   checkPoint = checkPoint + 1;
               }
               // 비밀번호 문자열에 영문 대문자 존재 여부 검사
               var pattern3 = /[A-Z]/;
               if(pattern3.test(pass) == false) {
                   checkPoint = checkPoint + 1;
               }
               // 비밀번호 문자열에 특수문자 존재 여부 검사
               var pattern4 = /[~!@#$%^&*()_+|<>?:{}]/;  // 특수문자
               if(pattern4.test(pass) == false) {
                   checkPoint = checkPoint + 1;
               }
               if(checkPoint >= 3) {
                   message = ":: 보안성이 취약한 비밀번호 ::";
                   color = "#A23E48";
               } else if(checkPoint == 2) {
                   message = ":: 보안성이 낮은 비밀번호 ::";
                   color = "#FF8C42";
               } else if(checkPoint == 1) {
                   message = ":: 보안성이 보통인 비밀번호 ::";
                   color = "#FF8C42";
               } else {
                   message = ":: 보안성이 강력한 비밀번호 ::";
                   color = "#0000CD";
               }
           }
       }
       else {
           message = ":: 비밀번호를 입력해 주세요 ::";
           color = "#000000";
       }
       console.log(checkPoint);
       document.getElementById("checkTxt").innerHTML = message;
       document.getElementById("checkTxt").style.color = color;
   }
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
      
      function jsSubmit() {
      if(!($(check1).prop('checked'))||!($(check2).prop('checked'))){
            alert("이용약관 및 개인정보 수집 이용에 미동의시 회원가입이 불가합니다.");
            return;
      }
         // 아이디 확인
         var idCheck = $("#idcheck").val();
         if( idCheck != "Y" ) {
            alert("아이디 중복확인을 해주세요");
            return;
         }
         // 아이디 확인
         var emailCheck = $("#emailcheck").val();
         if( emailCheck != "Y" ) {
            alert("이메일 중복확인을 해주세요");
            return;
         }
         // 비밀번호 확인
         var passCheck = $("#passCheck").val(); 
         if( passCheck != "Y" ) {
            alert("비밀번호 확인을 해주세요");
            return;
         }
         // 이름 확인
         var member_name = $("#member_name").val();
         if( member_name == null || !(member_name.length > 0) ) {
            alert("이름을 입력해주세요");
            return;
         }
         var phone = $('select[name="member_phone"]').val();
         var phone1 = $('input[name="member_phone1"]').val();
         var phone2 = $('input[name="member_phone2"]').val();
         var member_phone = phone+phone1+phone2;
         if( member_phone == null || !(member_phone.length > 0) ) {
            alert("전화번호를 입력해주세요");
            return;
         }
         var member_email = $("#member_email").val();
         if( member_email == null || !(member_email.length > 0) ) {
            alert("이메일을 입력해주세요");
            return;
         }
         var add = $("input[name=addDetail]").val();
         if( add == null || !(add.length > 0) ) {
            alert("상세주소를 입력해주세요");
            return;
         }
         $("#frm").submit();
      }
      
      $(document).ready(function() {
         $("#checkAll").change(function() {
            var bool = $("#checkAll").prop("checked");
            if( bool ) {
               $(".checkTarget").prop("checked", true);
            } else {
               $(".checkTarget").prop("checked", false);
            }
         });
         $(".checkTarget").change(function() {
            var bool = $(this).prop("checked");
            if( !bool ) {
               $("#checkAll").prop("checked", false);
            } else {
               var bool1 = $("#check1").prop("checked");
               var bool2 = $("#check2").prop("checked");
               if( bool1 && bool2 ) {
                  $("#checkAll").prop("checked", true);
               }
            }
         });
         $("#member_id").change(function() {
            $("#idcheck").val("N");
         });
      });

      function checkId() {
         var id = $("#member_id").val();
         console.log(id);
        var pattern5 = /[ㄱ-ㅎ|가-힣]/;
         if(pattern5.test(id) == true) {
            alert('한글은 입력 불가합니다.');
            return;
         }
         var pattern4 = /[~!@#$%^&*()_+|<>?:{}]/;  // 특수문자
         if(pattern4.test(id) == true) {
            alert('특수문자는 입력 불가합니다.');
            return;
         }
         if( id == null || !(id.length > 0) ) {
            alert("아이디를 입력해주세요");
            return;
         }
         $.ajax({
            url : "idcheck",
            type : "post",
            dataType : "text",
            data : {
               "member_id" : id
            },
            success : function(data) {

               if( data == "Y" ) {
                  $("#idcheck").val("Y");
                  alert("사용가능한 아이디 입니다.");
                $("#member_id").attr("readonly",true).attr("disabled",false); //입력불가
                $("#member_id").css("background-color","silver");
                $("#idcheck").attr("disabled", true);
               } else {
                  alert("중복된 아이디 입니다.");
               }
            },
            error: function(e) {
               console.log(e);
               alert("error");
            }
         })
      }
      
   function checkPw() {
      var pw1 = $("#member_password").val();
      var pw2 = $("#member_password2").val();
      if( !(pw1.length > 0) || !(pw2.length > 0) ) {
         alert("비밀번호를 입력해주세요");
         return;
      } else if( pw1.length < 6 || pw1.length > 16 ) {
         alert("비밀번호는 6자리 이상 16자리 이하로 작성해주세요");
         return;
      } else if( pw1 != pw2 ) {
         alert("비밀번호가 일치하지 않습니다");
         return;
      }
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
         alert("비밀번호 확인이 완료되었습니다");
         $("#passCheck").val("Y");
         $('#member_name').attr("disabled",false);
         $("#Pcheck").attr("disabled", true);
         $("#member_password").attr("readonly",true).attr("disabled",false); //입력불가
         $("#member_password2").attr("readonly",true).attr("disabled",false); //입력불가
         $("#member_password").css("background-color","silver");
         $("#member_password2").css("background-color","silver");
         return;
      } else {
         alert("비밀번호는 영문 대소문자/숫자/특수문자 중 2가지 이상 조합으로 가능합니다.");
         return;
      }
   }
      function checkname() {
    	 var pattern1 = /[0-9]/;  // 숫자
         var name = $("#member_name").val();
         if( name == null || !(id.length > 0) ) {
            alert("이름을 입력해주세요");
            return;
         } else if (pattern1.test(name) == true){
        	 alert("한글 또는 영문으로 입력해주세요");
             return; 
         }
      }
      function checkphone() {
         
      var phone = $('select[name="member_phone"]').val();
      var phone1 = $('input[name="member_phone1"]').val();
      var phone2 = $('input[name="member_phone2"]').val();
      var fullPhone = phone+'-'+phone1+'-'+phone2;
      console.log(fullPhone);
         if( phone == null || phone1 == null || phone2 == null || !(phone.length > 0) || !(phone1.length > 0) || !(phone2.length > 0)) {
            alert("전화번호를 입력해주세요");
            return;
         }
         $.ajax({
            url : "phonecheck",
            type : "post",
            dataType : "text",
            data : {
               "member_phone" : fullPhone
            },
            success : function(data) {
               console.log(data);
               if( data == "Y" ) {
                  alert("사용가능한 전화번호 입니다.");
                  $("#phonecheck").val("Y");
                   $("#member_phone").attr("readonly",true); //입력불가
                   $("#member_phone1").attr("readonly",true).attr("disabled",false); //입력불가
                   $("#member_phone2").attr("readonly",true).attr("disabled",false); //입력불가
                $("#member_phone0").css("background-color","silver");
                $("#member_phone1").css("background-color","silver");
                $("#member_phone2").css("background-color","silver");
                $("#phonecheck").attr("disabled", true);
               } else {
                  alert("중복된 전화번호 입니다.");
               }
            },
            error : function(e) {
               console.log(e);
               alert("error");
            }
         })
      }
      function checkEmail() {
         var email = $("#member_email").val();
         if( email == null || !(email.length > 0) ) {
            alert("이메일을 입력해주세요");
            return;
         }
         $.ajax({
            url : "emailcheck",
            type : "post",
            dataType : "text",
            data : {
               "member_email" : email
            },
            success : function(data) {
               console.log(data);

               if( data == "Y" ) {
                  alert("사용가능한 이메일 입니다.");
                  $("#emailcheck").val("Y");
                  $("#member_email").attr("readonly",true).attr("disabled",false); //입력불가
                $("#member_email").css("background-color","silver");
                $("#emailcheck").attr("disabled", true);
               } else {
                  alert("중복된 이메일 입니다.");
               }
            },
            error : function(e) {
               console.log(e);
               alert("error");
            }
         })
      }
      /* function checkaddDetail() {

         var member_email = $("#member_email").val();
         if( member_email == null || !(id.length > 0) ) {
            alert("상세주소를 입력해주세요");
            return;
         }
      } */
   </script>
</head>
<body>
   <div class="div" style="margin-top: 75px; min-height: 200px;" align="center">
      <form id="frm" method="post" action="${path }/member/addMember">
         <table width="800">
            <tr height="40">
               <td align="center"><b>[회원가입]</b></td>
            </tr>
         </table>
         <table width="700" height="600" cellpadding="0"
            style="border-collapse: collapse; font-size: 9pt;">
            <tr class="register" height="30">
               <td width="5%" align="center">*</td>
               <td width="15%">회원 ID</td>
               <td><input type="text" id="member_id" name="member_id" pattern="[A-Za-z0-9]+" />&nbsp;
                  <button type="button" onclick="checkId();" id="idcheck" value="N" style="background-color: white; border-width: thin; border-radius: 10%;">중복확인</button>

               </td>
            </tr>
            <tr height="7">
               <td colspan="3"><hr /></td>
            </tr>

            <tr class="register" height="30">
               <td width="5%" align="center">*</td>
               <td width="15%">비밀번호</td>
               <td>
                  <input type="hidden" id="passCheck" value="N"/>
                  <input type="password" name="member_password"
                     id="member_password" onKeyup="safetyPasswordPattern(this);" />
                  &nbsp;(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 6자~16자) <p id="checkTxt" style="margin-top:3px;">:: 비밀번호를 입력해 주세요 ::</p>
               </td>
            </tr>
            <tr height="7">
               <td colspan="3"><hr /></td>
            </tr>
            <tr class="register" height="30">
               <td width="5%" align="center">*</td>
               <td width="15%">비밀번호 확인</td>
               <td><input type="password" name="member_password2"
                  id="member_password2"/>&nbsp; <button type="button" onclick="checkPw()" id="Pcheck" style="background-color: white; border-width: thin; border-radius: 10%;">비밀번호 확인</button>
                </td>
            </tr>
            <tr height="7">
               <td colspan="3"><hr /></td>
            </tr>
            <tr class="register" height="30">
               <td width="5%" align="center">*</td>
               <td width="15%">이 름</td>
               <td><input type="text" id="member_name" name="member_name" disabled="disabled"/></td>
            </tr>
            <tr height="7">
               <td colspan="3"><hr /></td>
            </tr>
            
            <tr class="register" height="30">
               <td width="5%" align="center">*</td>
               <td width="15%">휴대전화</td>
               <td><select name="member_phone" id="member_phone" >
                     <option value="" selected="selected">선택</option>
                     <option value="010">010</option>
               </select> &nbsp;-&nbsp; <input type="text" id="member_phone1" name="member_phone1" size="4"
                  maxlength="4"> &nbsp;-&nbsp; <input type="text"
                  name="member_phone2" id="member_phone2" size="4" maxlength="4">
                  <button type="button" onclick="checkphone();" id="phonecheck" value="N" style="background-color: white; border-width: thin; border-radius: 10%;">중복확인</button>
                </td>

            </tr>
            <tr height="7">
               <td colspan="3"><hr /></td>
            </tr>
            <tr class="register" height="30">
               <td width="5%" align="center">*</td>
               <td width="15%">이메일</td>
               <td>
                     <input type="email" id="member_email" name="member_email"/>
                     <button type="button" onclick="checkEmail();" id="emailcheck" value="N" style="background-color: white; border-width: thin; border-radius: 10%;">중복확인</button>
               </td>
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
                  onclick="execution_daum_address()" value="우편번호 찾기" style="background-color: white; border-width: thin; border-radius: 10%;"><br>
               <br /> <input type="text" size="30" name="roadFullAddr"
                  id="sample4_roadAddress" placeholder="도로명주소" readonly="readonly"
                  onclick="DaumPostcode()"> <input type="text" size="30"
                  name="roadFullAddr" id="sample4_jibunAddress" placeholder="지번주소"
                  readonly="readonly" onclick="DaumPostcode()"> <br />
               <span id="guide" style="color: #999; font-size: 10px;"></span> <br />
               <br />
               <input type="text" name="addDetail" id="sample4_detailAddress"
                  placeholder="나머지 주소" size="70" /></td>
            </tr>
         </table>
         <br />
         <table style="margin-bottom:40px;">
            <h3 style="font-weight:bold; color: #2e2e2e; font: 0.70em "Lato",Nanum Gothic,Arial,Dotum,AppleGothic,sans-serif;">전체 동의</h3><br>
            <div class="ec-base-box typeThinBg gStrong" style="margin-bottom:10px;">
               <p>
                  <span class="ec-base-chk">
                     <input type="checkbox" id="checkAll">
                     <em class="checkbox"></em>
                  </span>
                  <label for="sAgreeAllChecked">
                     <strong>이용약관 및 개인정보수집 및 이용에 모두 동의합니다.</strong>
                  </label>
               </p>
            </div>
            
            <hr width="50%">
            
            <div class="ec-base-box typeThinBg agreeArea"
               style="overflow: scroll; height: 200px; width: 60%; font-size: xx-small; margin-top: 10px;">
               <h3 style="font-size:14px;">[필수] 이용약관 동의</h3>
               <div class="content">
                  <div class="fr-view fr-view-mall-agreement" style="text-align:left !important;">
                     <p>제1조(목적)</p>
                     <p>이 약관은 이디야 회사(전자상거래 사업자)가 운영하는 이디야 사이버 몰(이하 “몰”이라 한다)에서
                        제공하는 인터넷 관련 서비스(이하 “서비스”라 한다)를 이용함에 있어 사이버 몰과 이용자의 권리․의무 및 책임사항을
                        규정함을 목적으로 합니다.</p>
                     <p>※「PC통신, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는 한 이 약관을
                        준용합니다.」</p>
                     <p>제2조(정의)</p>
                     <p>① “몰”이란 이디야 회사가 재화 또는 용역(이하 “재화 등”이라 함)을 이용자에게 제공하기 위하여
                        컴퓨터 등 정보통신설비를 이용하여 재화 등을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 사이버몰을
                        운영하는 사업자의 의미로도 사용합니다.</p>
                     <p>② “이용자”란 “몰”에 접속하여 이 약관에 따라 “몰”이 제공하는 서비스를 받는 회원 및 비회원을
                        말합니다.</p>
                     <p>③ ‘회원’이라 함은 “몰”에 (삭제) 회원등록을 한 자로서, 계속적으로 “몰”이 제공하는 서비스를
                        이용할 수 있는 자를 말합니다.</p>
                     <p>④ ‘비회원’이라 함은 회원에 가입하지 않고 “몰”이 제공하는 서비스를 이용하는 자를 말합니다.</p>
                     <p>제3조 (약관 등의 명시와 설명 및 개정)&nbsp;</p>
                     <p>① “몰”은 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는
                        곳의 주소를 포함), 전화번호․모사전송번호․전자우편주소, 사업자등록번호, 통신판매업 신고번호, 개인정보관리책임자등을
                        이용자가 쉽게 알 수 있도록 00 사이버몰의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가
                        연결화면을 통하여 볼 수 있도록 할 수 있습니다.</p>
                     <p>② “몰은 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회․배송책임․환불조건 등과
                        같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야
                        합니다.</p>
                     <p>③ “몰”은 「전자상거래 등에서의 소비자보호에 관한 법률」, 「약관의 규제에 관한 법률」, 「전자문서 및
                        전자거래기본법」, 「전자금융거래법」, 「전자서명법」, 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」,
                        「방문판매 등에 관한 법률」, 「소비자기본법」 등 관련 법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.</p>
                     <p>④ “몰”이 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 몰의 초기화면에 그
                        적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한
                        30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 "몰“은 개정 전 내용과 개정 후 내용을 명확하게 비교하여
                        이용자가 알기 쉽도록 표시합니다.&nbsp;</p>
                     <p>⑤ “몰”이 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그
                        이전에 이미 체결된 계약에 대해서는 개정 전의 약관조항이 그대로 적용됩니다. 다만 이미 계약을 체결한 이용자가
                        개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의 공지기간 내에 “몰”에 송신하여 “몰”의 동의를
                        받은 경우에는 개정약관 조항이 적용됩니다.</p>
                     <p>⑥ 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래 등에서의 소비자보호에 관한
                        법률, 약관의 규제 등에 관한 법률, 공정거래위원회가 정하는 전자상거래 등에서의 소비자 보호지침 및 관계법령 또는
                        상관례에 따릅니다.</p>
                     <p>제4조(서비스의 제공 및 변경)&nbsp;</p>
                     <p>① “몰”은 다음과 같은 업무를 수행합니다.</p>
                     <p>&nbsp; 1. 재화 또는 용역에 대한 정보 제공 및 구매계약의 체결</p>
                     <p>&nbsp; 2. 구매계약이 체결된 재화 또는 용역의 배송</p>
                     <p>&nbsp; 3. 기타 “몰”이 정하는 업무</p>
                     <p>② “몰”은 재화 또는 용역의 품절 또는 기술적 사양의 변경 등의 경우에는 장차 체결되는 계약에 의해
                        제공할 재화 또는 용역의 내용을 변경할 수 있습니다. 이 경우에는 변경된 재화 또는 용역의 내용 및 제공일자를
                        명시하여 현재의 재화 또는 용역의 내용을 게시한 곳에 즉시 공지합니다.</p>
                     <p>③ “몰”이 제공하기로 이용자와 계약을 체결한 서비스의 내용을 재화등의 품절 또는 기술적 사양의 변경
                        등의 사유로 변경할 경우에는 그 사유를 이용자에게 통지 가능한 주소로 즉시 통지합니다.</p>
                     <p>④ 전항의 경우 “몰”은 이로 인하여 이용자가 입은 손해를 배상합니다. 다만, “몰”이 고의 또는 과실이
                        없음을 입증하는 경우에는 그러하지 아니합니다.</p>
                     <p>제5조(서비스의 중단)&nbsp;</p>
                     <p>① “몰”은 컴퓨터 등 정보통신설비의 보수점검․교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는
                        서비스의 제공을 일시적으로 중단할 수 있습니다.</p>
                     <p>② “몰”은 제1항의 사유로 서비스의 제공이 일시적으로 중단됨으로 인하여 이용자 또는 제3자가 입은
                        손해에 대하여 배상합니다. 단, “몰”이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.</p>
                     <p>③ 사업종목의 전환, 사업의 포기, 업체 간의 통합 등의 이유로 서비스를 제공할 수 없게 되는 경우에는
                        “몰”은 제8조에 정한 방법으로 이용자에게 통지하고 당초 “몰”에서 제시한 조건에 따라 소비자에게 보상합니다.
                        다만, “몰”이 보상기준 등을 고지하지 아니한 경우에는 이용자들의 마일리지 또는 적립금 등을 “몰”에서 통용되는
                        통화가치에 상응하는 현물 또는 현금으로 이용자에게 지급합니다.</p>
                     <p>제6조(회원가입)&nbsp;</p>
                     <p>① 이용자는 “몰”이 정한 가입 양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를
                        함으로서 회원가입을 신청합니다.</p>
                     <p>② “몰”은 제1항과 같이 회원으로 가입할 것을 신청한 이용자 중 다음 각 호에 해당하지 않는 한
                        회원으로 등록합니다.</p>
                     <p>&nbsp; 1. 가입신청자가 이 약관 제7조제3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우,
                        다만 제7조제3항에 의한 회원자격 상실 후 3년이 경과한 자로서 “몰”의 회원재가입 승낙을 얻은 경우에는 예외로
                        한다.</p>
                     <p>&nbsp; 2. 등록 내용에 허위, 기재누락, 오기가 있는 경우</p>
                     <p>&nbsp; 3. 기타 회원으로 등록하는 것이 “몰”의 기술상 현저히 지장이 있다고 판단되는 경우</p>
                     <p>③ 회원가입계약의 성립 시기는 “몰”의 승낙이 회원에게 도달한 시점으로 합니다.</p>
                     <p>④ 회원은 회원가입 시 등록한 사항에 변경이 있는 경우, 상당한 기간 이내에 “몰”에 대하여 회원정보
                        수정 등의 방법으로 그 변경사항을 알려야 합니다.</p>
                     <p>제7조(회원 탈퇴 및 자격 상실 등)&nbsp;</p>
                     <p>① 회원은 “몰”에 언제든지 탈퇴를 요청할 수 있으며 “몰”은 즉시 회원탈퇴를 처리합니다.</p>
                     <p>② 회원이 다음 각 호의 사유에 해당하는 경우, “몰”은 회원자격을 제한 및 정지시킬 수 있습니다.</p>
                     <p>&nbsp; 1. 가입 신청 시에 허위 내용을 등록한 경우</p>
                     <p>&nbsp; 2. “몰”을 이용하여 구입한 재화 등의 대금, 기타 “몰”이용에 관련하여 회원이 부담하는
                        채무를 기일에 지급하지 않는 경우</p>
                     <p>&nbsp; 3. 다른 사람의 “몰” 이용을 방해하거나 그 정보를 도용하는 등 전자상거래 질서를 위협하는
                        경우</p>
                     <p>&nbsp; 4. “몰”을 이용하여 법령 또는 이 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우</p>
                     <p>③ “몰”이 회원 자격을 제한․정지 시킨 후, 동일한 행위가 2회 이상 반복되거나 30일 이내에 그
                        사유가 시정되지 아니하는 경우 “몰”은 회원자격을 상실시킬 수 있습니다.</p>
                     <p>④ “몰”이 회원자격을 상실시키는 경우에는 회원등록을 말소합니다. 이 경우 회원에게 이를 통지하고,
                        회원등록 말소 전에 최소한 30일 이상의 기간을 정하여 소명할 기회를 부여합니다.</p>
                     <p>제8조(회원에 대한 통지)</p>
                     <p>① “몰”이 회원에 대한 통지를 하는 경우, 회원이 “몰”과 미리 약정하여 지정한 전자우편 주소로 할 수
                        있습니다.</p>
                     <p>② “몰”은 불특정다수 회원에 대한 통지의 경우 1주일이상 “몰” 게시판에 게시함으로서 개별 통지에
                        갈음할 수 있습니다. 다만, 회원 본인의 거래와 관련하여 중대한 영향을 미치는 사항에 대하여는 개별통지를 합니다.</p>
                     <p>제9조(구매신청)&nbsp;</p>
                     <p>① “몰”이용자는 “몰”상에서 다음 또는 이와 유사한 방법에 의하여 구매를 신청하며, “몰”은 이용자가
                        구매신청을 함에 있어서 다음의 각 내용을 알기 쉽게 제공하여야 합니다. (삭제)</p>
                     <p>&nbsp; 1. 재화 등의 검색 및 선택</p>
                     <p>&nbsp; 2. 받는 사람의 성명, 주소, 전화번호, 전자우편주소(또는 이동전화번호) 등의 입력</p>
                     <p>&nbsp; 3. 약관내용, 청약철회권이 제한되는 서비스, 배송료․설치비 등의 비용부담과 관련한 내용에
                        대한 확인</p>
                     <p>&nbsp; 4. 이 약관에 동의하고 위 3.호의 사항을 확인하거나 거부하는 표시(예, 마우스 클릭)</p>
                     <p>&nbsp; 5. 재화등의 구매신청 및 이에 관한 확인 또는 “몰”의 확인에 대한 동의</p>
                     <p>&nbsp; 6. 결제방법의 선택</p>
                     <p>② “몰”이 제3자에게 구매자 개인정보를 제공•위탁할 필요가 있는 경우 실제 구매신청 시 구매자의 동의를
                        받아야 하며, 회원가입 시 미리 포괄적으로 동의를 받지 않습니다. 이 때 “몰”은 제공되는 개인정보 항목, 제공받는
                        자, 제공받는 자의 개인정보 이용 목적 및 보유‧이용 기간 등을 구매자에게 명시하여야 합니다. 다만
                        「정보통신망이용촉진 및 정보보호 등에 관한 법률」 제25조 제1항에 의한 개인정보 취급위탁의 경우 등 관련 법령에
                        달리 정함이 있는 경우에는 그에 따릅니다.</p>
                     <p>제10조 (계약의 성립)</p>
                     <p>① “몰”은 제9조와 같은 구매신청에 대하여 다음 각 호에 해당하면 승낙하지 않을 수 있습니다. 다만,
                        미성년자와 계약을 체결하는 경우에는 법정대리인의 동의를 얻지 못하면 미성년자 본인 또는 법정대리인이 계약을 취소할
                        수 있다는 내용을 고지하여야 합니다.</p>
                     <p>&nbsp; 1. 신청 내용에 허위, 기재누락, 오기가 있는 경우</p>
                     <p>&nbsp; 2. 미성년자가 담배, 주류 등 청소년보호법에서 금지하는 재화 및 용역을 구매하는 경우</p>
                     <p>&nbsp; 3. 기타 구매신청에 승낙하는 것이 “몰” 기술상 현저히 지장이 있다고 판단하는 경우</p>
                     <p>② “몰”의 승낙이 제12조제1항의 수신확인통지형태로 이용자에게 도달한 시점에 계약이 성립한 것으로
                        봅니다.</p>
                     <p>③ “몰”의 승낙의 의사표시에는 이용자의 구매 신청에 대한 확인 및 판매가능 여부, 구매신청의 정정 취소
                        등에 관한 정보 등을 포함하여야 합니다.</p>
                     <p>제11조(지급방법)</p>
                     <p>“몰”에서 구매한 재화 또는 용역에 대한 대금지급방법은 다음 각 호의 방법중 가용한 방법으로 할 수
                        있습니다. 단, “몰”은 이용자의 지급방법에 대하여 재화 등의 대금에 어떠한 명목의 수수료도 추가하여 징수할 수
                        없습니다.</p>
                     <p>1. 폰뱅킹, 인터넷뱅킹, 메일 뱅킹 등의 각종 계좌이체&nbsp;</p>
                     <p>2. 선불카드, 직불카드, 신용카드 등의 각종 카드 결제</p>
                     <p>3. 온라인무통장입금</p>
                     <p>4. 전자화폐에 의한 결제</p>
                     <p>5. 수령 시 대금지급</p>
                     <p>6. 마일리지 등 “몰”이 지급한 포인트에 의한 결제</p>
                     <p>7. “몰”과 계약을 맺었거나 “몰”이 인정한 상품권에 의한 결제&nbsp;</p>
                     <p>8. 기타 전자적 지급 방법에 의한 대금 지급 등</p>
                     <p>제12조(수신확인통지․구매신청 변경 및 취소)</p>
                     <p>① “몰”은 이용자의 구매신청이 있는 경우 이용자에게 수신확인통지를 합니다.</p>
                     <p>② 수신확인통지를 받은 이용자는 의사표시의 불일치 등이 있는 경우에는 수신확인통지를 받은 후 즉시
                        구매신청 변경 및 취소를 요청할 수 있고 “몰”은 배송 전에 이용자의 요청이 있는 경우에는 지체 없이 그 요청에
                        따라 처리하여야 합니다. 다만 이미 대금을 지불한 경우에는 제15조의 청약철회 등에 관한 규정에 따릅니다.</p>
                     <p>제13조(재화 등의 공급)</p>
                     <p>① “몰”은 이용자와 재화 등의 공급시기에 관하여 별도의 약정이 없는 이상, 이용자가 청약을 한 날부터
                        7일 이내에 재화 등을 배송할 수 있도록 주문제작, 포장 등 기타의 필요한 조치를 취합니다. 다만, “몰”이 이미
                        재화 등의 대금의 전부 또는 일부를 받은 경우에는 대금의 전부 또는 일부를 받은 날부터 3영업일 이내에 조치를
                        취합니다. 이때 “몰”은 이용자가 재화 등의 공급 절차 및 진행 사항을 확인할 수 있도록 적절한 조치를 합니다.</p>
                     <p>② “몰”은 이용자가 구매한 재화에 대해 배송수단, 수단별 배송비용 부담자, 수단별 배송기간 등을
                        명시합니다. 만약 “몰”이 약정 배송기간을 초과한 경우에는 그로 인한 이용자의 손해를 배상하여야 합니다. 다만
                        “몰”이 고의․과실이 없음을 입증한 경우에는 그러하지 아니합니다.</p>
                     <p>제14조(환급)</p>
                     <p>“몰”은 이용자가 구매신청한 재화 등이 품절 등의 사유로 인도 또는 제공을 할 수 없을 때에는 지체 없이
                        그 사유를 이용자에게 통지하고 사전에 재화 등의 대금을 받은 경우에는 대금을 받은 날부터 3영업일 이내에 환급하거나
                        환급에 필요한 조치를 취합니다.</p>
                     <p>제15조(청약철회 등)</p>
                     <p>① “몰”과 재화등의 구매에 관한 계약을 체결한 이용자는 「전자상거래 등에서의 소비자보호에 관한 법률」
                        제13조 제2항에 따른 계약내용에 관한 서면을 받은 날(그 서면을 받은 때보다 재화 등의 공급이 늦게 이루어진
                        경우에는 재화 등을 공급받거나 재화 등의 공급이 시작된 날을 말합니다)부터 7일 이내에는 청약의 철회를 할 수
                        있습니다. 다만, 청약철회에 관하여 「전자상거래 등에서의 소비자보호에 관한 법률」에 달리 정함이 있는 경우에는 동
                        법 규정에 따릅니다.&nbsp;</p>
                     <p>② 이용자는 재화 등을 배송 받은 경우 다음 각 호의 1에 해당하는 경우에는 반품 및 교환을 할 수
                        없습니다.</p>
                     <p>&nbsp; 1. 이용자에게 책임 있는 사유로 재화 등이 멸실 또는 훼손된 경우(다만, 재화 등의 내용을
                        확인하기 위하여 포장 등을 훼손한 경우에는 청약철회를 할 수 있습니다)</p>
                     <p>&nbsp; 2. 이용자의 사용 또는 일부 소비에 의하여 재화 등의 가치가 현저히 감소한 경우</p>
                     <p>&nbsp; 3. 시간의 경과에 의하여 재판매가 곤란할 정도로 재화등의 가치가 현저히 감소한 경우</p>
                     <p>&nbsp; 4. 같은 성능을 지닌 재화 등으로 복제가 가능한 경우 그 원본인 재화 등의 포장을 훼손한
                        경우</p>
                     <p>③ 제2항제2호 내지 제4호의 경우에 “몰”이 사전에 청약철회 등이 제한되는 사실을 소비자가 쉽게 알 수
                        있는 곳에 명기하거나 시용상품을 제공하는 등의 조치를 하지 않았다면 이용자의 청약철회 등이 제한되지 않습니다.</p>
                     <p>④ 이용자는 제1항 및 제2항의 규정에 불구하고 재화 등의 내용이 표시•광고 내용과 다르거나 계약내용과
                        다르게 이행된 때에는 당해 재화 등을 공급받은 날부터 3월 이내, 그 사실을 안 날 또는 알 수 있었던 날부터
                        30일 이내에 청약철회 등을 할 수 있습니다.</p>
                     <p>제16조(청약철회 등의 효과)</p>
                     <p>① “몰”은 이용자로부터 재화 등을 반환받은 경우 3영업일 이내에 이미 지급받은 재화 등의 대금을
                        환급합니다. 이 경우 “몰”이 이용자에게 재화등의 환급을 지연한때에는 그 지연기간에 대하여 「전자상거래 등에서의
                        소비자보호에 관한 법률 시행령」제21조의2에서 정하는 지연이자율(괄호 부분 삭제)을 곱하여 산정한 지연이자를
                        지급합니다.</p>
                     <p>② “몰”은 위 대금을 환급함에 있어서 이용자가 신용카드 또는 전자화폐 등의 결제수단으로 재화 등의
                        대금을 지급한 때에는 지체 없이 당해 결제수단을 제공한 사업자로 하여금 재화 등의 대금의 청구를 정지 또는
                        취소하도록 요청합니다.</p>
                     <p>③ 청약철회 등의 경우 공급받은 재화 등의 반환에 필요한 비용은 이용자가 부담합니다. “몰”은 이용자에게
                        청약철회 등을 이유로 위약금 또는 손해배상을 청구하지 않습니다. 다만 재화 등의 내용이 표시•광고 내용과 다르거나
                        계약내용과 다르게 이행되어 청약철회 등을 하는 경우 재화 등의 반환에 필요한 비용은 “몰”이 부담합니다.</p>
                     <p>④ 이용자가 재화 등을 제공받을 때 발송비를 부담한 경우에 “몰”은 청약철회 시 그 비용을 누가
                        부담하는지를 이용자가 알기 쉽도록 명확하게 표시합니다.</p>
                     <p>제17조(개인정보보호)</p>
                     <p>① “몰”은 이용자의 개인정보 수집시 서비스제공을 위하여 필요한 범위에서 최소한의 개인정보를
                        수집합니다.&nbsp;</p>
                     <p>② “몰”은 회원가입시 구매계약이행에 필요한 정보를 미리 수집하지 않습니다. 다만, 관련 법령상
                        의무이행을 위하여 구매계약 이전에 본인확인이 필요한 경우로서 최소한의 특정 개인정보를 수집하는 경우에는 그러하지
                        아니합니다.</p>
                     <p>③ “몰”은 이용자의 개인정보를 수집•이용하는 때에는 당해 이용자에게 그 목적을 고지하고 동의를
                        받습니다.&nbsp;</p>
                     <p>④ “몰”은 수집된 개인정보를 목적외의 용도로 이용할 수 없으며, 새로운 이용목적이 발생한 경우 또는
                        제3자에게 제공하는 경우에는 이용•제공단계에서 당해 이용자에게 그 목적을 고지하고 동의를 받습니다. 다만, 관련
                        법령에 달리 정함이 있는 경우에는 예외로 합니다.</p>
                     <p>⑤ “몰”이 제2항과 제3항에 의해 이용자의 동의를 받아야 하는 경우에는 개인정보관리 책임자의
                        신원(소속, 성명 및 전화번호, 기타 연락처), 정보의 수집목적 및 이용목적, 제3자에 대한 정보제공
                        관련사항(제공받은자, 제공목적 및 제공할 정보의 내용) 등 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」
                        제22조제2항이 규정한 사항을 미리 명시하거나 고지해야 하며 이용자는 언제든지 이 동의를 철회할 수 있습니다.</p>
                     <p>⑥ 이용자는 언제든지 “몰”이 가지고 있는 자신의 개인정보에 대해 열람 및 오류정정을 요구할 수 있으며
                        “몰”은 이에 대해 지체 없이 필요한 조치를 취할 의무를 집니다. 이용자가 오류의 정정을 요구한 경우에는 “몰”은
                        그 오류를 정정할 때까지 당해 개인정보를 이용하지 않습니다.</p>
                     <p>⑦ “몰”은 개인정보 보호를 위하여 이용자의 개인정보를 취급하는 자를 최소한으로 제한하여야 하며
                        신용카드, 은행계좌 등을 포함한 이용자의 개인정보의 분실, 도난, 유출, 동의 없는 제3자 제공, 변조 등으로 인한
                        이용자의 손해에 대하여 모든 책임을 집니다.</p>
                     <p>⑧ “몰” 또는 그로부터 개인정보를 제공받은 제3자는 개인정보의 수집목적 또는 제공받은 목적을 달성한
                        때에는 당해 개인정보를 지체 없이 파기합니다.</p>
                     <p>⑨ “몰”은 개인정보의 수집•이용•제공에 관한 동의란을 미리 선택한 것으로 설정해두지 않습니다. 또한
                        개인정보의 수집•이용•제공에 관한 이용자의 동의거절시 제한되는 서비스를 구체적으로 명시하고, 필수수집항목이 아닌
                        개인정보의 수집•이용•제공에 관한 이용자의 동의 거절을 이유로 회원가입 등 서비스 제공을 제한하거나 거절하지
                        않습니다.</p>
                     <p>제18조(“몰“의 의무)</p>
                     <p>① “몰”은 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 이 약관이 정하는 바에
                        따라 지속적이고, 안정적으로 재화․용역을 제공하는데 최선을 다하여야 합니다.</p>
                     <p>② “몰”은 이용자가 안전하게 인터넷 서비스를 이용할 수 있도록 이용자의 개인정보(신용정보 포함)보호를
                        위한 보안 시스템을 갖추어야 합니다.</p>
                     <p>③ “몰”이 상품이나 용역에 대하여 「표시․광고의 공정화에 관한 법률」 제3조 소정의 부당한
                        표시․광고행위를 함으로써 이용자가 손해를 입은 때에는 이를 배상할 책임을 집니다.</p>
                     <p>④ “몰”은 이용자가 원하지 않는 영리목적의 광고성 전자우편을 발송하지 않습니다.</p>
                     <p>제19조(회원의 ID 및 비밀번호에 대한 의무)</p>
                     <p>① 제17조의 경우를 제외한 ID와 비밀번호에 관한 관리책임은 회원에게 있습니다.</p>
                     <p>② 회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다.</p>
                     <p>③ 회원이 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 “몰”에
                        통보하고 “몰”의 안내가 있는 경우에는 그에 따라야 합니다.</p>
                     <p>제20조(이용자의 의무)</p>
                     <p>이용자는 다음 행위를 하여서는 안 됩니다.</p>
                     <p>1. 신청 또는 변경시 허위 내용의 등록</p>
                     <p>2. 타인의 정보 도용</p>
                     <p>3. “몰”에 게시된 정보의 변경</p>
                     <p>4. “몰”이 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등의 송신 또는 게시</p>
                     <p>5. “몰” 기타 제3자의 저작권 등 지적재산권에 대한 침해</p>
                     <p>6. “몰” 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위</p>
                     <p>7. 외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에 반하는 정보를 몰에 공개 또는 게시하는
                        행위</p>
                     <p>제21조(연결“몰”과 피연결“몰” 간의 관계)</p>
                     <p>① 상위 “몰”과 하위 “몰”이 하이퍼링크(예: 하이퍼링크의 대상에는 문자, 그림 및 동화상 등이
                        포함됨)방식 등으로 연결된 경우, 전자를 연결 “몰”(웹 사이트)이라고 하고 후자를 피연결 “몰”(웹사이트)이라고
                        합니다.</p>
                     <p>② 연결“몰”은 피연결“몰”이 독자적으로 제공하는 재화 등에 의하여 이용자와 행하는 거래에 대해서 보증
                        책임을 지지 않는다는 뜻을 연결“몰”의 초기화면 또는 연결되는 시점의 팝업화면으로 명시한 경우에는 그 거래에 대한
                        보증 책임을 지지 않습니다.</p>
                     <p>제22조(저작권의 귀속 및 이용제한)</p>
                     <p>① “몰“이 작성한 저작물에 대한 저작권 기타 지적재산권은 ”몰“에 귀속합니다.</p>
                     <p>② 이용자는 “몰”을 이용함으로써 얻은 정보 중 “몰”에게 지적재산권이 귀속된 정보를 “몰”의 사전 승낙
                        없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는
                        안됩니다.</p>
                     <p>③ “몰”은 약정에 따라 이용자에게 귀속된 저작권을 사용하는 경우 당해 이용자에게 통보하여야 합니다.</p>
                     <p>제23조(분쟁해결)</p>
                     <p>① “몰”은 이용자가 제기하는 정당한 의견이나 불만을 반영하고 그 피해를 보상처리하기 위하여
                        피해보상처리기구를 설치․운영합니다.</p>
                     <p>② “몰”은 이용자로부터 제출되는 불만사항 및 의견은 우선적으로 그 사항을 처리합니다. 다만, 신속한
                        처리가 곤란한 경우에는 이용자에게 그 사유와 처리일정을 즉시 통보해 드립니다.</p>
                     <p>③ “몰”과 이용자 간에 발생한 전자상거래 분쟁과 관련하여 이용자의 피해구제신청이 있는 경우에는
                        공정거래위원회 또는 시•도지사가 의뢰하는 분쟁조정기관의 조정에 따를 수 있습니다.</p>
                     <p>제24조(재판권 및 준거법)</p>
                     <p>① “몰”과 이용자 간에 발생한 전자상거래 분쟁에 관한 소송은 제소 당시의 이용자의 주소에 의하고,
                        주소가 없는 경우에는 거소를 관할하는 지방법원의 전속관할로 합니다. 다만, 제소 당시 이용자의 주소 또는 거소가
                        분명하지 않거나 외국 거주자의 경우에는 민사소송법상의 관할법원에 제기합니다.</p>
                     <p>② “몰”과 이용자 간에 제기된 전자상거래 소송에는 한국법을 적용합니다.</p>
                     <p>부 칙(시행일) 이 약관은 년 월 일부터 시행합니다.</p>
                     <p>
                        <br>
                     </p>
                  </div>
               </div>

            </div>
            <p class="check">
               <span>이용약관에 동의하십니까?</span> <input id="check1"
                  class="ec-base-chk checkTarget" value="1" type="checkbox">
               <label for="check1" style="margin-top: 35px;">동의함</label>
            </p>
            
            <hr width="50%">
            
            <div class="ec-base-box typeThinBg agreeArea"
               style="overflow: scroll; height: 200px; width: 60%; font-size: xx-small;">
               <h3 style="font-size:14px;">[필수] 개인정보 수집 및 이용 동의</h3>
               <div class="content">
                  <div class="fr-view fr-view-privacy-required" style="text-align:left !important;">
                     ■ 수집하는 개인정보 항목<br> 회사는 회원가입, 상담, 서비스 신청 등등을 위해 아래와 같은 개인정보를
                     수집하고 있습니다.
                     <p>

                        ο 수집항목 : 이름 , 생년월일 , 성별 , 로그인ID , 비밀번호 , 비밀번호 질문과 답변 , 자택 전화번호 ,
                        자택 주소 , 휴대전화번호 , 이메일 , 직업 , 회사명 , 부서 , 직책 , 회사전화번호 , 취미 , 결혼여부 ,
                        기념일 , 법정대리인정보 , 서비스 이용기록 , 접속 로그 , 접속 IP 정보 , 결제기록<br> ο
                        개인정보 수집방법 : 홈페이지(회원가입) , 서면양식
                     </p>
                     <p>■ 개인정보의 수집 및 이용목적</p>
                     <p>회사는 수집한 개인정보를 다음의 목적을 위해 활용합니다.</p>
                     <p>

                        ο 서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 요금정산 콘텐츠 제공 , 구매 및 요금 결제 , 물품배송
                        또는 청구지 등 발송<br> ο 회원 관리<br> 회원제 서비스 이용에 따른 본인확인 , 개인
                        식별 , 연령확인 , 만14세 미만 아동 개인정보 수집 시 법정 대리인 동의여부 확인 , 고지사항 전달 ο 마케팅
                        및 광고에 활용<br> 접속 빈도 파악 또는 회원의 서비스 이용에 대한 통계
                     </p>
                     <p>■ 개인정보의 보유 및 이용기간</p>
                     <p>회사는 개인정보 수집 및 이용목적이 달성된 후에는 예외 없이 해당 정보를 지체 없이 파기합니다.</p>
                  </div>
               </div>
            </div>
            <p class="check">
               <span>개인정보 수집 및 이용에 동의하십니까?</span>
               <input id="check2" class="ec-base-chk checkTarget" value="1" type="checkbox"/>
               <label for="check2" style="margin-top: 25px; margin-bottom: 15px;">동의함</label>
            </p>
            <tr height="40">
               <td>
                  <button class="w-100 btn btn-lg btn-primary"
                     style="margin-left: auto; margin-right: auto; margin-top:40px; margin-bottom:66px; background-color: #C26225; color: white;
                     border: none; font-size: 30px;" type="button"
                     onclick="jsSubmit()" value="회원가입">회원가입</button>
               </td>
            </tr>
         </table>

      </form>
   </div>
</body>
</html>