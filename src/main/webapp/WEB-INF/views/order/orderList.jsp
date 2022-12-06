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

/* 배송정보 결제정보 상세창띄우기 */
function detail(order_id){
	console.log(order_id);
	let form = document.createElement('form');
	let input_order_id = document.createElement('input');
	input_order_id.setAttribute('type', 'hidden');
	input_order_id.setAttribute('name', 'order_id');
	input_order_id.setAttribute('value', order_id);
	form.appendChild(input_order_id);
	document.body.appendChild(form);
	
	form.method="post";
 	form.action="${path}/order/detail";
	form.submit();
}

</script>
<style>
.orderListPage {
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
.orderList {
	width:1200px;
	margin-top:20px;
	border: 1px solid #d7d5d5;
}
.orderList th {
	height: 10px;
	padding: 8px 0 8px;
    border: 1px solid #dfdfdf;
    color: #353535;
    vertical-align: middle;
    font-size: small;
    background: #fbfafa;
}
.orderList td {
	border-top: 1px solid #dfdfdf;
	border-right: 1px solid #dfdfdf;
    color: #353535;
    vertical-align: middle;
    font-size: small;
    text-align: center;
	padding: 6px 0 6px;
}
.orderList_obj_info {
	text-align:left !important;
	font-weight:bold !important;
}
.orderList_sub_date {
  width: 185px;
}
.orderList_sub_img {
  width: 110px;
}
.orderList_sub_info {
  width: 580px;
}
.orderList_sub_price {
  width: 110px;
}
.orderList_sub_qty {
  width: 100px;
}
 #quantity {
  width: 23px;
  height: 20px;
  color: gray;
  border: 0 solid black;
  padding-left:15px;
}
.detail_btn{
	margin-top:6px;
	background-color: #4a5164;
	border-radius: 2px;
	color: #fff;
	font-size: 12px;
	font-weight: normal;
	vertical-align: middle;
	height: 23px;
	width: 120px;
	border: 1px solid transparent;
	margin-bottom:3px;
}
.menuMap{
	width: 1200px;
	margin-top:35px;
	min-height:20px;
	text-align:right;
	font-size:small;
	color:gray;
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
.contentsIntro_ico {
	padding-left:20px;
	background: url(/Uhdiya/resources/img/product/ico_info.gif) no-repeat;
	text-align:left;
}
</style>
</head>
<body>
<input type="hidden" id="member_id" value="${member.member_id }">
	<div class="orderListPage">
		<!-- 메뉴맵 -->
		<div class="menuMap">
			<a href="${path }/main">
				홈 > 
			</a>
			<a href="${path }/order/orderList">
				<span >주문내역  </span>
			</a>
		</div>
		<div class="title">
			<span class="title_txt">주문내역</span>
		</div><br><br>
		<div class="infoBox">
			<div class="infoBox_txtArea">
				<span class="infoBox_txt_highLight">${member.member_name }님의 ( 회원아이디 : ${member.member_id } )</span>
				<span class="infoBox_txt">주문내역 입니다. </span>
			</div>
		</div>
		<table class="orderList">
			<tr>
				<th colspan="6" style="padding-left:5px; background: #fff8f5;">
					<p class="contentsIntro_ico">
						<span style="font-size: x-small;color:#f76560;">총 결제금액 및 배송,결제정보는 배송지/결제정보(주문상세 페이지)에서 확인 가능합니다.</span>
					</p>
				</th>
			</tr>
			<tr>
				<th class="orderList_sub_date">주문일자(주문번호)</th>
				<th class="orderList_sub_img">이미지</th>
				<th class="orderList_sub_info">상품정보</th>
				<th class="orderList_sub_price">상품금액</th>
				<th class="orderList_sub_qty">수량</th>
			</tr>
			<c:if test = "${empty ordersMap.ordersList }">
				<tr>
					<td colspan="5" height="300">
						주문 내역이 없습니다. 쇼핑을 계속 해주세요.
					</td>
				</tr>
			</c:if>
			
			
			
			<c:set var="a" value="0"/>
			<c:forEach items="${ordersMap.ordersList }" var="list">
				<tr>
					<!-- 한 주문번호안에 상품숫자조회 -->
					<c:forEach items="${cntMap.cntList }" var="cntList">
						<c:if test="${cntList.order_id==list.order_id }">
							<c:set var="cntCheck" value="${cntList.cnt }"/>
						</c:if>
					</c:forEach>
					<c:if test="${cntCheck-cntCheck+a==0 }">
						<td class="orderList_sub_date" rowspan="${cntCheck }">
							${list.order_date }<br>
							(${list.order_id }) 
							<button type="button" id="popup_open_btn" class="detail_btn" onclick="javascript:detail('${list.order_id }')" >
								배송지/결제정보
							</button>
						</td>
					</c:if>
					<td class="orderList_obj_imgArea">
						<img class="orderList_obj_img" width="80" height="80" src="${path }/product_download?product_fileName=${list.product_fileName }&product_code=${list.product_code}">
					</td>
					<td class="orderList_obj_info">&nbsp;&nbsp;&nbsp;${list.product_name }</td>
					<td class="orderList_obj_price">
						<fmt:formatNumber  value="${list.product_price }" type="number" var="product_price" />
	         			${product_price }원
					</td>
					<td class="orderList_obj_qty">
						<!-- 수량표기 -->
						<div class="qty_num">
							<input id="quantity" name="cart_qty" type="text" value="${list.order_qty }" readonly="readonly">
						</div>
					</td>
				</tr>
				<c:set var="a" value="${a+1 }" />
				<c:if test="${cntCheck==a }">
						<c:set var="a" value="0"/>
				</c:if>
			</c:forEach>
			</table>
			<br><br><br>
			<div class="back">
				<button type="button" class="back_btn" onclick="location.href='${path}/main'">
					쇼핑 계속하기
				</button>
			</div>
			<br><br><br>

			
		

			
			
			
			
			
			
			
	</div>
</body>
</html>