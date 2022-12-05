<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%
request.setCharacterEncoding("UTF-8");
%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path}/resources/css/reset.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
/* 결제하기 */
function payNow(){
	let who = document.querySelector('input[name="add"]:checked').value;
	console.log(who);
	let total = document.getElementById('total').value;
	let member_id = document.getElementById('member_id').value;
	let order_id = document.getElementById('order_id').value;
	if(total=="0"||total==null){
		alert('결제하실 상품이 없습니다. 장바구니 또는 상품상세에서 상품을 추가해주세요.');
	} else {
		if(who=='receiver'){
			var receiver_name=document.getElementById('name').value;
			var receiver_phone = document.getElementById('new_phone1').value+'-'+document.getElementById('new_phone2').value+'-'+document.getElementById('new_phone3').value;
			if(document.getElementById('new_phone1').value==''||document.getElementById('new_phone2').value==''||document.getElementById('new_phone3').value==''){
				receiver_phone='';
			}
			var receiver_zipno = document.getElementById('sample4_postcode').value;
			var receiver_roadFullAddr = document.getElementById('sample4_roadAddress').value+','+document.getElementById('sample4_jibunAddress').value;
			var receiver_addDetail = document.getElementById('sample4_detailAddress').value;
		} else if (who=='orderer'){
			var receiver_name=document.getElementById('member_name').value;
			var receiver_phone=document.getElementById('member_phone').value;
			var receiver_zipno=document.getElementById('member_zipno').value;
			var receiver_roadFullAddr=document.getElementById('member_fullAddr').value;
			var receiver_addDetail=document.getElementById('member_detailAddr').value;
		}
		let receiver_content = document.getElementById('content').value;
		let payment_cardCo = document.getElementById('cardCo').value;
		let payment_cardNum = document.getElementById('cardNum1').value+'-'+document.getElementById('cardNum2').value+'-'+document.getElementById('cardNum3').value+'-'+document.getElementById('cardNum4').value;
		if(document.getElementById('cardNum1').value==''||document.getElementById('cardNum2').value==''||document.getElementById('cardNum3').value==''||document.getElementById('cardNum4').value==''){
			payment_cardNum='';
		}
		let payment_cardExM = document.getElementById('cardExM').value;
		let payment_cardExY = document.getElementById('cardExY').value;
		let payment_cardCVS = document.getElementById('cardCVS').value;
		var orderInfo = {
			member_id:member_id,	
			order_id:order_id,	
			receiver_name:receiver_name,
			receiver_phone:receiver_phone,	
			receiver_zipno:receiver_zipno,	
			receiver_roadFullAddr:receiver_roadFullAddr,	
			receiver_addDetail:receiver_addDetail,	
			receiver_content:receiver_content,	
			payment_cardCo:payment_cardCo,	
			payment_cardNum:payment_cardNum,	
			payment_cardExM:payment_cardExM,	
			payment_cardExY:payment_cardExY,	
			payment_cardCVS:payment_cardCVS,	
		};
		let blankCheck='';
		let blankSub='';
		Object.keys(orderInfo).forEach(function(k){
		    console.log('키값 : '+k + ', 데이터값 : ' + orderInfo[k]);
		    if(orderInfo[k]==''&&k!='receiver_content'){
		    	blankCheck='exist';
		    	if(k=='receiver_phone'){
		    		blankSub='핸드폰번호';
		    	} else if(k=='receiver_zipno'||k=='receiver_roadFullAddr'||k=='receiver_addDetail'){
		    		blankSub='주소';
		    	} else if(k=='payment_cardCo'||k=='payment_cardNum'||k=='payment_cardExM'||k=='payment_cardExY'||k=='payment_cardCVS'){
		    		blankSub='카드정보';
		    	} else if(k=='receiver_name'){
		    		blankSub='받으시는 분 이름';
		    	} else{
		    		console.log(k+'뭐가남았지');
		    	}
		    }
		});
	    if(blankCheck=='exist'){
	    	alert('필수입력항목값 중 '+blankSub+' 값이 입력되지 않았습니다. 확인 후 다시시도해주세요.');
	    	return;
	    }
 	    $.ajax({
			type:'post',
			url:'payNow',
			dataType : 'text',
			data:orderInfo,
			success:function(data){
	    		if(data=='y'){
	    			alert('결제가 완료되었습니다.');
		     		location.href = "${path}/order/orderList";
	    		} else {
	    			alert('오류발생하였습니다. 다시시도해주세요.');
	    			location.href = "${path}/order/onOrder";
	    		}
			},error :function(jqXHR, textStatus, errorThrown){
				alert("ERROR : " + textStatus + " : " + errorThrown);
			}
		}); 
	}
}
/* 회원주소지 새로운주소지 선택 sample4_detailAddress */
$(document).ready(function(){
	$('#radio1').click(function(){
		$('#name').css('display','none');
		$('#new_add').css('display','none');
		$('#new_phone').css('display','none');
		$('#member_name').css('display','block');
		$('#member_add').css('display','block');
		$('#member_phone_div').css('display','block');
	});
   $('#radio2').click(function(){
		 $('#name').css('display','block');
		 $('#new_add').css('display','block');
		 $('#new_phone').css('display','block');
	     $('#member_name').css('display','none');
	     $('#member_add').css('display','none');
	     $('#member_phone_div').css('display','none');
	
    });
});
/* 주문서페이지에서 선택상품 삭제 */
function selectDel(){
	let member_id = document.getElementById('member_id').value;
	console.log(member_id);
	let confirm_val = confirm('정말 삭제하시겠습니까?');
	if(confirm_val){
		let selectArr = new Array();
		let obj = document.getElementsByName("chk[]");
		for(i=0;i<obj.length;i++){
			if(obj[i].checked==true){
				selectArr[i]=obj[i].value;
			}
		}
		console.log(selectArr);
		if(selectArr==''){
			alert('선택된 상품이 없습니다.');
		}else {
			$.ajax({
		    	url : "selectDel",
		    	type : "post",
		    	dataType : 'text',
		   		data : { selectArr : selectArr,
		   				member_id : member_id
		   		},
		    	success : function(data){
		    		if(data=='y'){
		    			alert('성공적으로 삭제되었습니다.');
			     		location.href = "${path}/order/onOrder";
		    		} else {
		    			alert('오류발생하였습니다. 다시시도해주세요.');
		    			location.href = "${path}/order/onOrder";
		    		}
		    	},
				error: function() {
		           alert('에러');
		        }
			}); // ajax end
		}
	}
}
/* 배송메세지 글자수카운트및제한 */
$(function(){
	$('.DOC_TEXT').keyup(function (e){
	    var content = $(this).val();
	    $('#counter').html(" ( "+content.length+" / 최대 200자)");    //글자수 실시간 카운팅
	
	    if (content.length > 200){
	        alert("최대 200자까지 입력 가능합니다.");
	        $(this).val(content.substring(0, 200));
	        $('#counter').html("(200 / 최대 200자)");
	    }
	});
});
//주문중에 이전페이지클릭
function exitOrder(){
    let confirm_val = confirm("이 페이지를 벗어나면 작성된 내용은 저장되지않습니다. 이전페이지로 돌아가시겠습니까?");
    if(confirm_val){
	    history.back();
    }
}
/* 전체선택 */
function checkAll(){
	let obj = document.getElementsByName("chk[]");
	if(document.getElementById("checkAll").checked==true) {
		for(i=0;i<obj.length;i++){
			console.log(i);
			console.log(obj[i]);
			obj[i].checked =true;
		}
	}
	if(document.getElementById("checkAll").checked==false) {
		for(i=0;i<obj.length;i++){
			console.log(i);
			console.log(obj[i]);
			obj[i].checked =false;
		}
	}
	let total_price = 0;
	let price = 0;
	let num = 0;
	for(i=0;i<obj.length;i++){
		if(obj[i].checked) {
			price = document.getElementById("eachPrice["+i+"]").value;
			total_price = total_price + parseInt(price);
			num++;
		}
	}
	let total_price_com= numberWithCommas(total_price);
	let total_price_com_won = priceToWon(total_price_com);
	$(".onOrderTotal_cnt").html('( '+num+' 개 ) ');
	$(".onOrderTotal_price").html(total_price_com_won);
	$(".onOrderTotal_price_last").html(total_price_com_won); 
}
/* 행에서 상품선택시 총상품수 금액 업데이트 */
function selItem(){
	let total_price = 0;
	let price = 0;
	let num = 0;
	let obj = document.getElementsByName("chk[]");
	for(i=0;i<obj.length;i++){
		if(obj[i].checked) {
			price = document.getElementById("eachPrice["+i+"]").value;
			total_price = total_price + parseInt(price);
			num++;
		}
	}
	console.log(num);
	console.log(total_price);
	let total_price_com= numberWithCommas(total_price);
	let total_price_com_won = priceToWon(total_price_com);
	$(".onOrderTotal_cnt").html('( '+num+' 개 ) ');
	$(".onOrderTotal_price").html(total_price_com_won);
	$(".onOrderTotal_price_last").html(total_price_com_won); 
}
function numberWithCommas(n) {
    return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function priceToWon(n){
	let won = n+'원';
	return won;
}
</script>
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
<style>
.onOrderPage {
	width:1200px;
	position:relative;
	margin:0px auto;
}
.title {
	width:1200px;
	min-height:30px;
	
}
.title_txt {
	display: inline-block;
    padding: 20px 0 0 0px;
    font-size: 13px;
    font-weight: bold;
}
.step {
	padding: 15px 0 0 0px;
	width:800px;
	min-height:60px;
}
.totalCntBox{
	height:25px;
	color: #333;
	border: 0.5px #ccc solid;
}
.totalCntBox_textArea{
	margin-left:10px;
	padding-top:3px;
}
.totalCntBox_txt {
	text-align:left;
	font-size: 10px;
	color: slategray;
	padding-left:8px;
}
.totalCntBox_txt_highLight {
	text-align:left;
	font-size: 12px;
	color: #123478;
	padding-left:8px;
	font-weight:bold;
}
.totalCnt{
	font-size: 12px;
	font-weight:bold;
	color: #123478;
}
.onOrder {
	width:1200px;
	margin-top:10px;
	border: 1px solid #d7d5d5;
    
}
.onOrder th {
	height: 10px;
	padding: 8px 0 8px;
    border: 1px solid #dfdfdf;
    /* border-bottom: 1px solid #dfdfdf; */
    color: #353535;
    vertical-align: middle;
    font-size: small;
    background: #fbfafa;
}
.onOrder td {
	border-top: 1px solid #dfdfdf;
    color: #353535;
    vertical-align: middle;
    font-size: small;
    text-align: center;
	padding: 6px 0 6px;
    
}
.onOrder_obj_info {
	text-align:left !important;
	font-weight:bold !important;
}
.onOrderTotal {
	text-align: right !important;
	padding-right: 20px !important;
}
.onOrderTotal_cnt {
	text-align: right !important;
	padding-right: 20px !important;
}
.contentsIntro_ico {
	padding-left:20px;
	background: url(/Uhdiya/resources/img/product/ico_info.gif) no-repeat;
	text-align:left;
}
.onOrder_sub_checkBox {
width: 50px;
}
.onOrder_sub_img {
  width: 110px;
}
.onOrder_sub_info {
  width: 605px;
}
.onOrder_sub_price {
  width: 110px;
}
.onOrder_sub_qty {
  width: 100px;
}
.onOrder_sub_total {
  width: 110px;
}
.selectDel{
	padding: 15px 0 10px;
	width: 600px;
	margin-right:0px;
	display: inline-block;
	margin-bottom:30px;
}
.selectDel_txt{
	color: #353535;
    vertical-align: middle;
    font-size: 11px;
    font-weight:bold;
}
.selectDel_btn{
	background-color: darkgray;
	border-radius: 2px;
	color: #fff;
	font-size: 12px;
	font-weight: normal;
	vertical-align: middle;
	height: 25px;
	width: 100px;
	border: 1px solid transparent;
}
.selectOrder {
	padding: 15px 0 10px;
	text-align:right;
	width: 593px;
	margin-right:0px;
	display: inline-block;
}
.selectOrder_btn{
	background-color: darkgray;
	border-radius: 2px;
	color: #fff;
	font-size: 15px;
	font-weight: normal;
	vertical-align: middle;
	height: 35px;
	width: 120px;
	border: 1px solid transparent;
}
.selectOrder_btn_exitOrder{
	background-color: lightgray;
	border-radius: 2px;
	color: #fff;
	font-size: 15px;
	font-weight: normal;
	vertical-align: middle;
	height: 35px;
	width: 140px;
	border: 1px solid transparent;
}
.selectOrder_empty{
	padding: 15px 0 10px;
	text-align:right;
}
.selectOrder_empty_btn_exitOrder{
	background-color: lightgray;
	border-radius: 2px;
	color: #fff;
	font-size: 15px;
	font-weight: normal;
	vertical-align: middle;
	height: 35px;
	width: 140px;
	border: 1px solid transparent;
}
.onOrderTotal_price{
	font-size: 14px;
	font-weight: bold;
}
.onOrderTotal_txt_highlight {
	font-size: 16px;
	color: red;
}
.onOrderTotal_price_last {
	font-size: 16px;
	color: red;
	font-weight:bold;
}
.notUser{
	padding-top:20px;
	width: 1200px;
	margin-right:0px;
	text-align:right;
	padding-bottom: 150px;
}
.notUser_btn {
	background-color: #4a5164;
	border-radius: 2px;
	color: #fff;
	font-size: 15px;
	font-weight: normal;
	vertical-align: middle;
	height: 35px;
	width: 140px;
	border: 1px solid transparent;
}
/* 숫자나오는부분 */
#quantity {
  width: 23px;
  height: 20px;
  color: gray;
  border: 0 solid black;
  padding-left:15px;
}
.orderSheet {
	width:1200px;
	margin-top:10px;
	border: 1px solid #d7d5d5;
	font: 0.70em "Lato",Nanum Gothic,Arial,Dotum,AppleGothic,sans-serif;
	color: #707070;
}
.orderSheet td {
	border: 1px solid #d7d5d5;
    vertical-align: middle;
    text-align: left;
	padding: 6px 0 6px;
    
}
.orderSheet_sub {
	text-align:left;
	height: 32px;
	width: 100px;
	border: 1px solid #d7d5d5;
    vertical-align: middle;
    font-size: 12px;
    background: #fbfafa;
	font-weight:bold;
}
.orderSheet_txt {
	margin-left:10px;
	padding-left:10px;
	width: 150px;
	height: 23px;
	border: 1px solid #d5d5d5;
    font-size: 14px;
    color: #707070;
}
#member_name {
	margin-left:10px;
	padding-left:10px;
	width: 150px;
	height: 23px;
	border: 1px solid #d5d5d5;
    font-size: 14px;
    color: #707070;
    display:none;
}
#name {
	margin-left:10px;
	padding-left:10px;
	width: 150px;
	height: 23px;
	border: 1px solid #d5d5d5;
    font-size: 14px;
    color: #707070;
    display:block;
}
.orderSheet_sub_large {
	text-align:left;
	height: 100px;
	width: 100px;
	border: 1px solid #d7d5d5;
    vertical-align: middle;
    font-size: 14px;
    background: #fbfafa;
	font-weight:bold;
}
/* #orderSheet_txt_content{
	margin-left:10px;
	padding-left:10px;
	width: 750px;
	height: 80px;
	border: 1px solid #d5d5d5;
    font-size: 14px;
    color: #707070;
} */
.add{
	margin-left:10px;
	padding-left:10px;
	height: 23px;
	border: 1px solid #d5d5d5;
    font-size: 14px;
    color: #707070;
}
.add_btn{
	padding: 2px 8px;
    border: 1px solid #d1d1d1;
    border-radius: 2px;
    background-color: #fff;
}
.new_add{
	display:block;
}
.member_add{
	display:none;
}
.new_phone{
	display:block;
}
.member_phone_div{
	display:none;
}
.DOC_TEXT {
	margin-left:10px;
	padding-left:10px;
	width: 800px;
	height: 100px;
	border: 1px solid #d5d5d5;
    font-size: 14px;
    color: #707070;
}
.paymentSheet {
	width:1200px;
	height:160px;
	margin-top:10px;
	border: 0.5px solid black;
	font: 0.70em "Lato",Nanum Gothic,Arial,Dotum,AppleGothic,sans-serif;
	color: #707070;
}
.paymentSheet_sel{
	width:950px;
	height: 22px;
	padding: 14px;
	border-bottom: 1px solid #d7d5d5;
}
.paymentSheet_total{
	padding: 14px;
	border-left: 1px solid black;
}
.paymentSheet_input{
	width:850px;
	padding: 14px;
}
.card_sub{
	text-align:left;
	height: 32px;
	width: 70px;
    vertical-align: middle;
    font-size: 12px;
	font-weight:bold;
}
.card_obj{
	margin-left:10px;
	padding-left:10px;
	height: 23px;
	border: 1px solid #d5d5d5;
    font-size: 14px;
    color: #707070;
}
.paymentSheet_total{
	text-align:right;
	background: #fbfafa;
}
.payNow{
	background-color: #4a5164;
	border-radius: 2px;
	color: #fff;
	font-size: 15px;
	font-weight: normal;
	vertical-align: middle;
	height: 44px;
	width: 180px;
	border: 1px solid transparent;
	margin-right:6px;
}
.info{
	margin: 20px 0;
    border: 1px solid #d6d4d4;
    line-height: 18px;
    margin-bottom:150px;
}
.info h3 {
	padding: 9px 6px 6px 10px;
    border-bottom: 1px solid #e8e7e7;
    color: #101010;
    font-size: 12px;
    background: #fbfbfb;
}
.info_inner {
	padding: 6px 9px 12px;
	color: #707070;
	font: 0.70em "Lato",Nanum Gothic,Arial,Dotum,AppleGothic,sans-serif;
}
</style>
</head>
<body>
	<input type="hidden" id="member_id" value="${member.member_id }">

	<div class="onOrderPage">
		<div class="title">
			<span class="title_txt">주문서작성</span>
		</div>
		<div class="step">
			<img class="step_img" src="${path }/resources/img/order/order.png" width="450px" height="35px">
		</div>
		<div class="totalCntBox">
			<div class="totalCntBox_txtArea">
				<c:choose>
					<c:when test="${member.member_id!=null }">
						<span class="totalCntBox_txt_highLight">${member.member_name }님! ( 회원아이디 : ${member.member_id } )</span>
						<span class="totalCntBox_txt">구매하시려는 제품은 총 </span>
						<span class="totalCnt">
							${total }개
							<input type="hidden" value="${total }" id="total">
						</span>
						<span class="totalCntBox_txt">입니다.</span>
						<span class="totalCntBox_txt">주문서 작성을 완료해주세요.</span>
					</c:when>
					<c:otherwise>
						<span class="totalCntBox_txt">로그인 후 이용해주세요.</span>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<table class="onOrder">
			<tr>
				<th colspan="6" style="padding-left:5px; background: #fff8f5;">
					<p class="contentsIntro_ico">
						<span style="font-size: x-small;color:#f76560;">상품의 옵션 및 수량 변경은 상품상세 또는 장바구니에서 가능합니다.</span>
					</p>
				</th>
			</tr>
		
		
			<tr>
				<th class="onOrder_sub_checkBox">
					<input type="checkbox" id="checkAll" name="all" onclick="checkAll()" checked="on" >
				</th>
				<th class="onOrder_sub_img">이미지</th>
				<th class="onOrder_sub_info">상품정보</th>
				<th class="onOrder_sub_price">판매가</th>
				<th class="onOrder_sub_qty">수량</th>
				<th class="onOrder_sub_total">합계</th>
			</tr>
			
			<c:choose>
				<c:when test="${member.member_id==null || empty onOrdersMap.onOrdersList }">
						<tr>
							<td colspan="6" height="300">
								<c:choose>
									<c:when test="${member.member_id==null}" > 
										로그인 후 사용 가능합니다. 
									</c:when>
									<c:otherwise>
										선택된 상품이 없습니다. 상품상세 또는 장바구니에서 구매를 선택해주세요.
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<td class="onOrderTotal" colspan="6">
								<span class="onOrderTotal_txt">상품구매금액</span>
								<span class="onOrderTotal_price">0</span>
								<span class="onOrderTotal_txt">+ 배송비 0 (무료) = </span>
								<span class="onOrderTotal_txt_highlight">합계 : </span>
								<span class="onOrderTotal_price_last">0</span>
							</td>
						</tr>
					</table>
					<c:choose>
						<c:when test="${member.member_id==null}" >
							<div class="notUser">
								<button type="button" class="notUser_btn" onclick="location.href='${path}/member/login'">
									로그인
								</button>
							</div>
						</c:when>
						<c:when test ="${empty onOrdersMap.onOrdersList }" >
							<div class="selectOrder_empty">
								<button type="button" class="selectOrder_empty_btn_exitOrder" onclick="location.href='${path}/main'">
									이전페이지
								</button>
							</div>
						</c:when>
					</c:choose>
				</c:when>
				<c:when test="${member.member_id!=null && not empty onOrdersMap.onOrdersList }">
				
					<form name="frm">
						<c:set var="k" value="0" />
						<c:forEach items="${onOrdersMap.onOrdersList }" var="list">
							<input type="hidden" id="order_id" value="${list.order_id }">
							<tr>
								<td class="onOrder_obj_checkBox">
									<input type="checkbox"  name="chk[]" value="${list.product_code }" checked onclick="selItem()">
								</td>
								<td class="onOrder_obj_imgArea">
									<img class="onOrder_obj_img" width="80" height="80" src="${path }/product_download?product_fileName=${list.product_fileName }&product_code=${list.product_code}">
								</td>
								<td class="onOrder_obj_info">${list.product_name }</td>
								<td class="onOrder_obj_price">
									<fmt:formatNumber  value="${list.product_price }" type="number" var="product_price" />
				         			${product_price }원
								</td>
								<td class="onOrder_obj_qty">
								
									<!-- 수량표기 -->
									<div class="qty_num">
										<input id="quantity" name="cart_qty" type="text" value="${list.order_qty }" readonly="readonly">
									</div>
									
								</td>
								<td class="onOrder_obj_price">
									<input type="hidden" id="eachPrice[${k }]" name="eachPrice[${k }]" value="${list.product_price*list.order_qty }"> 
					   				<fmt:formatNumber  value="${list.product_price*list.order_qty }" type="number" var="each_total" />
				         			${each_total}원
								</td>
							</tr>
							
							<c:set  var="all_total" value="${all_total+list.product_price*list.order_qty }" />
							<c:set  var="all_num" value="${all_num+1 }" />
							<c:set var="k" value="${k+1 }" />
						</c:forEach>
					</form>
				</c:when>
			</c:choose>
			
			<c:if test="${member.member_id!=null && not empty onOrdersMap.onOrdersList  }">
				<tr>
					<td class="onOrderTotal" colspan="6">
						<span class="onOrderTotal_txt">총 상품수 </span>
						<span class="onOrderTotal_cnt"> ( ${all_num } 개 ) </span>
						<span class="onOrderTotal_txt"> 상품구매금액 </span>
						<span class="onOrderTotal_price">
							<fmt:formatNumber  value="${all_total}" type="number" var="a_total" />
								${a_total }원
						</span>
						<span class="onOrderTotal_txt">+ 배송비 0원 (무료) = </span>
						<span class="onOrderTotal_txt_highlight">합계 : </span>
						<span class="onOrderTotal_price_last">
							<fmt:formatNumber  value="${all_total}" type="number" var="a_total" />
								${a_total }원
						</span>
					</td>
				</tr>
				<tr>
				<th colspan="6" style="padding-left:5px; background: #fff8f5;">
					<p class="contentsIntro_ico">
						<span style="font-size: x-small;color:#f76560;">상품의 옵션 및 수량 변경은 상품상세 또는 장바구니에서 가능합니다.</span>
					</p>
				</th>
			</tr>
			</table>
				<div class="selectDel">
					<span class="selectDel_txt">선택상품을</span>
						<button type="button" class="selectDel_btn" onclick="javascript:selectDel()">
							X 삭제하기
						</button>
					</div>
				<div class="selectOrder">
					<button type="button" class="selectOrder_btn_exitOrder" onclick="javascript:exitOrder()">
						이전페이지
					</button>
				</div>
			</c:if>
			
			
			
			<hr style="border-width: 0.5px 0 0 0; border-color: #fff; "><br>
			<div class="title">
				<span class="title_txt">주문 정보</span>
			</div>
			<br>
			<table class="orderSheet">
				<tr>
					<td class="orderSheet_sub">
						&nbsp;&nbsp;주문하시는 분
					</td>
					<td>
						<input class="orderSheet_txt" type="text" value="${member.member_name }" readonly="readonly" style="border:0 solid black !important;">
					</td>
				</tr>
				<tr>
					<td class="orderSheet_sub">
						&nbsp;&nbsp;휴대폰번호
					</td>
					<td>
						<input class="orderSheet_txt" type="text" value="${member.member_phone }" readonly="readonly" style="border:0 solid black !important;">
					</td>
				</tr>
				<tr>
					<td class="orderSheet_sub">
						&nbsp;&nbsp;e-mail
					</td>
					<td>
						<input class="orderSheet_txt" type="text" value="${member.member_email }" readonly="readonly" style="border:0 solid black !important;">
					</td>
				</tr>
			</table>
			
			
			<hr style="border-width: 0.5px 0 0 0; border-color: #fff; "><br>
			<div class="title">
				<span class="title_txt">배송 정보</span>
			</div>
			<br>
			<table class="orderSheet">
			
			
			
			
				<tr>
					<td class="orderSheet_sub">
						&nbsp;&nbsp;배송지 선택
					</td>
					<td>
						&nbsp;&nbsp;<input type="radio" id="radio1" name="add" value="orderer" >주문자 정보와 동일
						<input type="radio" name="add" id="radio2" value="receiver" checked >새로운 배송지
					</td>
				</tr>
				
				
				
					<tr>
						<td class="orderSheet_sub">
							&nbsp;&nbsp;받으시는 분
						</td>
						
						<td>
							<input class="orderSheet_txt"  id="member_name" type="text" value="${member.member_name }" readonly="readonly" style="border:0 solid black !important;">
							<input id="name" type="text" >
						</td>
					</tr>
					<tr>
						<td class="orderSheet_sub">
							&nbsp;&nbsp;휴대폰번호
						</td>
						<td>
							<div id="new_phone">
								<select id="new_phone1" class="add" name="new_phone1">
		                     		<option value="" selected="selected">선택</option>
		                     		<option value="010">010</option>
		              		 	</select> &nbsp;-&nbsp; 
		              		 	<input id="new_phone2" class="add" type="text" name="new_phone2" size="4" maxlength="4"> &nbsp;-&nbsp; 
		              		 	<input id = "new_phone3" class="add" type="text" name="new_phone3" size="4" maxlength="4">
	              			</div>
	              			<div id="member_phone_div" style="display:none;">
	              				<input id="member_phone" type="text" class="add" value="${member.member_phone }" size="12" readonly="readonly" style="border:0 solid black !important;">
	              			</div>
	              		</td>
					</tr>
					<tr>
						<td class="orderSheet_sub_large">
							&nbsp;&nbsp;주소
						</td>
						<td>
						<div id="new_add">
								<input class="add" type="text" size="10" name="zipno"
			                  id="sample4_postcode" placeholder="우편번호" readonly="readonly"
			                  onclick="DaumPostcode()"> <input class="add_btn" type="button"
			                  onclick="execution_daum_address()" value="우편번호 찾기"><br>
			               <br /> <input class="add" type="text" size="32" name="roadFullAddr"
			                  id="sample4_roadAddress" placeholder="도로명주소" readonly="readonly"
			                  onclick="DaumPostcode()"> <input class="add" type="text" size="30"
			                  name="roadFullAddr" id="sample4_jibunAddress" placeholder="지번주소"
			                  readonly="readonly" onclick="DaumPostcode()"> <br />
			               <span id="guide" style="color: #999; font-size: 10px;"></span> <br />
			               <br />
			               <input class="add" type="text" name="addDetail" id="sample4_detailAddress"
			                  placeholder="나머지 주소" size="70" />
	                  </div>
	                  <div id="member_add" style="display:none;">
	                  		&nbsp;&nbsp;우편번호 : <input id="member_zipno" class="add" type="text" size="10" value="${memberAddress.zipno }" readonly="readonly" style="border:0 solid black !important;"><br><br/>
	                  		&nbsp;&nbsp;도로명주소,지번주소 : <input id="member_fullAddr" class="add" type="text" size="70" value="${memberAddress.roadFullAddr }" readonly="readonly" style="border:0 solid black !important;"><br /><br /><br />
	                  		&nbsp;&nbsp;나머지 주소 : <input id="member_detailAddr" class="add" type="text" size="70" value="${memberAddress.addDetail }" readonly="readonly" style="border:0 solid black !important;">
	                  </div>	
	                  
	                  
	                  </td>
					</tr>
				
				
				
				<tr>
					<td class="orderSheet_sub_large">
						&nbsp;&nbsp;배송메세지
					</td>
					<td>
						<textarea id="content" style="width: 600px;" class="DOC_TEXT" name="DOC_TEXT" placeholder="배송메세지를 200자 이내로 기재해주세요."></textarea> <br /> 
						<span style="color: #aaa;" id="counter" style="margin-left:10px;">
							 ( 0 / 최대 200자 )
						</span>
					</td>
				</tr>
			</table>
			<hr style="border-width: 0.5px 0 0 0; border-color: #fff; "><br>
			<div class="title">
				<span class="title_txt">결제하기</span>
			</div>
			<br>
			<table class="paymentSheet">
				<tr>
					<td class="paymentSheet_sel">
						<input type="radio" name="cart" value="card" checked>신용카드
					</td>
					<td class="paymentSheet_total" rowspan="2">
						<br>
						<span style="font-size:16px !important ; font-weight:bold !important; color: #353535 !important;">카드 결제</span>
						<span style="font-size:16px !important ; color: #353535 !important;">최종결제 금액</span><br><br><br>
						<p style="font-size:24px !important ; color: #008bcc !important;">${a_total }원</p><br><br><br>
						<button type="button" class="payNow" onclick="javascript:payNow()">
							결제하기
						</button>
					</td>
				</tr>
				<tr>
					<td class="paymentSheet_input">
						<table>
							<tr>
								<td class="card_sub">
									카드종류
								</td>
								<td>
									<select id="cardCo" class="card_obj" name="card_obj">
			                     		<option value="" selected="selected">=====카드선택=====</option>
			                     		<option value="삼성카드">삼성카드</option>
			                     		<option value="우리카드">우리카드</option>
			                     		<option value="국민카드">국민카드</option>
			                     		<option value="현대카드">현대카드</option>
			              		 	</select>
								</td>
							</tr>
							<tr>
								<td class="card_sub">
									카드번호
								</td>
								<td>
									<input id="cardNum1" class="card_obj" type="text" size="4" maxlength="4" >&nbsp;&nbsp;&nbsp;&nbsp;-
									<input id="cardNum2"  class="card_obj" type="text" size="4" maxlength="4" >&nbsp;&nbsp;&nbsp;&nbsp;-
									<input id="cardNum3" class="card_obj" type="text" size="4" maxlength="4" >&nbsp;&nbsp;&nbsp;&nbsp;-
									<input id="cardNum4" class="card_obj" type="text" size="4" maxlength="4" >
								</td>
							</tr>
							<tr>
								<td class="card_sub">
									만료일
								</td>
								<td>
									<input id="cardExM" class="card_obj" type="text" size="4" maxlength="2">&nbsp;월/ 
									<input id="cardExY" class="card_obj" type="text" size="4" maxlength="2">&nbsp;년
								</td>
							</tr>
							<tr>
								<td class="card_sub">
									CVC입력
								</td>
								<td>
									<input id="cardCVS" class="card_obj" type="text" size="4" maxlength="3"> * 카드 뒷면에 표기 된 3자리 숫자
								</td> 
							</tr>
						</table>
					</td>
				</tr>
			</table>
			
			<div class="info">
				<h3>이용안내</h3>
				<div class="info_inner">
					<ul>
						<li>
							- 변경된 부가가치세법에 의거, 2004.7.1 이후 신용카드로 결제하신 주문에 대해서는 세금계산서 발행이 불가하며
						</li>
						<li>
							- 신용카드매출전표로 부가가치세 신고를 하셔야 합니다.(부가가치세법 시행령 57조)
						</li>
						<li>
							- 상기 부가가치세법 변경내용에 따라 신용카드 이외의 결제건에 대해서만 세금계산서 발행이 가능함을 양지하여 주시기 바랍니다.
						</li>
					</ul>
				</div>
			</div>
			
			
			
			
			
			
			
	</div>
</body>
</html>