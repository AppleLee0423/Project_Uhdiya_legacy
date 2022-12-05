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

</script>
<style>
.orderDetailPage {
	width:1200px;
	position:relative;
	margin:30px auto;
}
.title {
	width:1200px;
}
.title_txt {
	display: inline-block;
    padding: 20px 0 0 0px;
    font-size: 13px;
    font-weight: bold;
}
.back{
	text-align:right;
}
.back_btn{
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
.step {
	padding: 15px 0 0 0px;
	width:800px;
	min-height:60px;
}
.infoBox{
	height:25px;
	color: #333;
	border: 0.5px #ccc solid;
}
.infoBox_textArea{
	margin-left:10px;
	padding-top:3px;
}
.infoBox_txt {
	text-align:left;
	font-size: 10px;
	color: slategray;
	padding-left:8px;
}
.infoBox_txt_highLight {
	text-align:left;
	font-size: 12px;
	color: #123478;
	padding-left:8px;
	font-weight:bold;
}
.info{
	font-size: 12px;
	font-weight:bold;
	color: #123478;
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
	width: 500px;
	height: 23px;
	border: 1px solid #d5d5d5;
    font-size: 14px;
    color: #707070;
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
.menuMap{
	width: 1200px;
	margin-top:35px;
	min-height:20px;
	text-align:right;
	font-size:small;
	color:gray;
}
</style>
</head>
<body>
	<input type="hidden" id="member_id" value="${member.member_id }">
	<input type="hidden" id="order_id" value="${order_id }">

	<div class="orderDetailPage">
	
		<!-- 메뉴맵 -->
		<div class="menuMap">
			<a href="${path }/main">
				홈 > 
			</a>
			<a href="${path }/order/orderList">
				<span >주문내역 > </span>
			</a>
				<span>  주문상세</span>
		</div>

		<div class="title">
			<span class="title_txt">주문상세 [배송정보,결제정보]</span>
		</div>
		<div class="step">
			<img class="step_img" src="${path }/resources/img/order/ordered.png" width="450px" height="35px">
		</div>
		<div class="infoBox">
			<div class="infoBox_txtArea">
				<span class="infoBox_txt_highLight">${member.member_name }님의 ( 회원아이디 : ${member.member_id } )</span>
				<span class="infoBox_txt">주문번호 (${order_id }) [배송정보,결제정보] 입니다. </span>
					
			</div>
		</div><br><br><br>
		<div class="title">
			<span class="title_txt">주문 정보</span>
		</div>
		<table class="orderSheet">
			<tr>
				<td class="orderDetail_sub">
					&nbsp;&nbsp;주문하신 분
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
		<table class="orderSheet">
			<tr>
				<td class="orderSheet_sub">
					&nbsp;&nbsp;받으시는 분
				</td>
				
				<td>
					<input class="orderSheet_txt"  id="member_name" type="text" value="${detail.receiver_name }" readonly="readonly" style="border:0 solid black !important;">
				</td>
			</tr>
			<tr>
				<td class="orderSheet_sub">
					&nbsp;&nbsp;휴대폰번호
				</td>
				<td>
          			<input id="orderSheet_txt" type="text" class="orderSheet_txt" value="${detail.receiver_phone }" readonly="readonly" style="border:0 solid black !important;">
             	</td>
			</tr>
			<tr>
				<td class="orderSheet_sub_large">
					&nbsp;&nbsp;주소
				</td>
				<td>
               		&nbsp;&nbsp;우편번호 : <input id="orderSheet_txt" class="orderSheet_txt" type="text" size="10" value="${detail.receiver_zipno }" readonly="readonly" style="border:0 solid black !important;"><br><br/>
               		&nbsp;&nbsp;도로명주소,지번주소 : <input id="orderSheet_txt" class="orderSheet_txt" type="text" size="200" value="${detail.receiver_roadFullAddr }" readonly="readonly" style="border:0 solid black !important;"><br /><br /><br />
               		&nbsp;&nbsp;나머지 주소 : <input id="orderSheet_txt" class="orderSheet_txt" type="text" size="70" value="${detail.receiver_addDetail }" readonly="readonly" style="border:0 solid black !important;">
                 </td>
			</tr>
			<tr>
				<td class="orderSheet_sub_large">
					&nbsp;&nbsp;배송메세지
				</td>
				<td>
					<p class = "orderSheet_txt" style="border:0 solid black !important;">${detail.receiver_content }</p>
				</td>
			</tr>
		</table>
		<hr style="border-width: 0.5px 0 0 0; border-color: #fff; "><br>
		<div class="title">
			<span class="title_txt">결제정보</span>
		</div>
		<table class="paymentSheet">
			<tr>
				<td class="paymentSheet_sel">
					<input type="radio" name="cart" value="card" checked>신용카드
				</td>
				<td class="paymentSheet_total" rowspan="2">
					<br>
					<span style="font-size:16px !important ; font-weight:bold !important; color: #353535 !important;">카드 결제</span>
					<span style="font-size:16px !important ; color: #353535 !important;">결제완료 금액</span><br><br><br>
					<p style="font-size:24px !important ; color: #008bcc !important;">
						<fmt:formatNumber  value="${paidTotal }" type="number" var="paid" />
	         			${paid }원
					</p><br><br><br>
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
								<input class="card_obj" type="text" value="${detail.payment_cardCo }" readonly="readonly" style="border:0 solid black !important;">
							</td>
						</tr>
						<tr>
							<td class="card_sub">
								카드번호
							</td>
							<td>
								<input class="card_obj" type="text" value="${detail.payment_cardNum }" readonly="readonly" style="border:0 solid black !important;">
							</td>
						</tr>
						<tr>
							<td class="card_sub">
								만료일
							</td>
							<td>
								<input id="cardExM" class="card_obj" type="text" size="4" maxlength="2" value="${detail.payment_cardExM }" readonly="readonly" style="border:0 solid black !important;">&nbsp;월/ 
								<input id="cardExY" class="card_obj" type="text" size="4" maxlength="2" value="${detail.payment_cardExY }" readonly="readonly" style="border:0 solid black !important;">&nbsp;년
							</td>
						</tr>
						<tr>
							<td class="card_sub">
								CVC입력
							</td>
							<td>
								<input id="cardCVS" class="card_obj" type="text" size="4" maxlength="3" value="${detail.payment_cardCVS }" readonly="readonly" style="border:0 solid black !important;"> * 카드 뒷면에 표기 된 3자리 숫자
							</td> 
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<br><br><br>
		<div class="back">
			<button type="button" class="back_btn" onclick="location.href='${path}/order/orderList'">
				주문내역 돌아가기
			</button>
		</div>
		<br><br><br>
		

			
			
			
			
			
			
			
	</div>
</body>
</html>