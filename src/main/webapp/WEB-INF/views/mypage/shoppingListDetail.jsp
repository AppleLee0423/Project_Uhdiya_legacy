<%@page import="com.spring.Uhdiya.mypage.shoppingList.ShoppingListDomain"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../css/reset.css" />
<link rel="stylesheet" href="../css/header.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
#orderListTitileDiv{position: absolute; top: 17%; left: 30%; width: 60%}
#orderListTableDiv{position: absolute; top: 25%; left: 31%; width: 55%}
</style>
</head>
<body>
	<div id="wrapper">
        <div id="header">
	        <c:import url="../common/header.jsp" />
        </div> <!-- header  -->	
			<div id="orderListTitileDiv">
					<h3>주문내역 상세보기</h3>
					<hr>
			</div>
			<!-- order_detail -->
			<div id="orderListTableDiv">
			<label style="margin-bottom: 0px">주문일자 <c:out value="${ order_date }"/></label>
			<hr style="margin-top: 1%; margin-bottom: 2%" >
			<table class="table table-bordered">
					  	<tr>
					  		<td rowspan="2" style="width: 100px; height: 150px"><img src="http://211.238.142.30/greentable_admin/upload_img/<c:out value="${ order_detail.pro_img_thumb }"/>" style="width: 100px; height:150px"/></td>
					  		<td style="text-align: left"><c:out value="${ order_detail.product_name }"/></td>
					  	</tr>
					  	<tr>
					  		<td><c:out value="${ order_detail.option_price }"/>원</td>
					  	</tr>
					  </table>
			<hr style="margin-bottom: 0px">
			<table class="table table-bordered" style="margin-top: 0px; margin-bottom: 5%">
					  	<tr>
					  		<td style="width: 12%">주문번호</td> 
					  		<td><c:out value="${ order_num }"/></td>
					  	</tr>
					  	<tr>
					  		<td style="width: 12%">주문수량</td>
					  		<td><c:out value="${ order_detail.quantity }"/>개 (<c:out value="${ order_detail.total_price }"/>원)</td>
					  	</tr>
			</table>
			<div id="orderListInfoDiv" style="background-color: #FBFBFB; padding: 3%" > 
				<h4 style="margin-bottom: 2%">결제 정보</h4>
				<span style="margin-right: 5%; font-size: 18px">총 상품금액</span><span style="font-size: 18px"><c:out value="${ order_detail.total_price }"/> 원</span>
				<h4 style="margin-top: 5%;margin-bottom: 2%">배송 정보</h4>
				<span style="margin-right: 5%; font-size: 18px">받으시는 분</span><span style="font-size: 18px"><c:out value="${ order_detail.receiver_name }"/></span><br/>
				<span style="margin-right: 9%; font-size: 18px">연락처</span><span style="font-size: 18px"><c:out value="${ order_detail.receiver_phone }"/></span><br/>
				<span style="margin-right: 9%; font-size: 18px">배송지</span>
				<span style="font-size: 18px">
					(<c:out value="${ order_detail.receiver_zipcode }"/>) &nbsp;
					<c:out value="${ order_detail.receiver_addr1 }"/> &nbsp;
					<c:out value="${ order_detail.receiver_addr2 }"/>
				</span><br/>
				<h4 style="margin-top: 7%;margin-bottom: 2%">취소 및 교환/반품 안내</h4>
				<span style="font-size: 16px">구매하신 배송상품의 취소/환불 또는 교환/반품을 원하실 경우에는 다음 내용을 참고해 주세요.</span><br/>
				<span style="font-size: 16px">&gt; 물품 배송 전 청약 철회 (취소/환불)</span><br/>
				<span style="font-size: 16px">상품(재화)를 판매자가 배송하기 이전에는 취소 및 환불 가능</span><br/>
				<br/>
				<span style="font-size: 16px">* 청약 철회 방법</span><br/>
				<span style="font-size: 16px">주문내역 &gt; 해당 주문 상세화면에서 취소 선택</span><br/>
				<br/>
				<span style="font-size: 16px">&gt; 물품 배송 후 청약 철회 (교환/반품 환불)</span><br/>
				<span style="font-size: 16px">상품(재화)의 공급을 받은 날로부터 7일 이내 청약 철회 가능</span><br/>
			</div>
	        <c:import url="../common/footer.jsp" />
        </div> <!-- footer  -->
   </div> <!-- wrapper  -->
</html>