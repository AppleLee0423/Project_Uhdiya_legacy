<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%
	request.setCharacterEncoding("utf-8");
%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path } /resources/css/reset.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
/* 전체페이지 */
.productDetailPage {
	margin:0 auto;
	width: 1200px;
}
/* 페이지상단 */
.contentsIntro {
	width: 1200px;
	margin: 70px auto;
	min-height: 520px;
}
/* 페이지상단 좌측이미지 부분 */
.contentsIntro_detailImg {
	float: left;
	width: 600px;
	padding-right: 50px;
}
.detailImg {
	float: left;
	width: 500px;
	height: 500px;
}
/* 페이지상단 우측 결제정보 부분 */
.contentsIntro_productName {
	font-size:large;
	font-weight:bold;
}
.contentsIntro_payInfoTxt {
	padding-left:50px;
	float: left;
	width: 500px;
}
.contentsIntro_payInfo {
	padding-left: 10px;
	margin-top: 40px;
	font-size: small;
}
.contentsIntro_payInfo span {
	color: gray;
	margin-right: 60px;
}
.contentsIntro_payInfo_productPrice_ico {
	margin-top:40px;
	background: url(/Uhdiya/resources/img/product/ico_info.gif) no-repeat;
}
/* 페이지 상단 우측 결제정보 부분_구매수량(테이블들) */
.contentsIntro_payInfo_tables {
	font-size: small;
}
/* 페이지 상단 우측 결제정보 부분_구매수량(테이블1) 수량선택*/
.contentsIntro_payInfo_select {
	color: gray;
	float: left;
	border: solid 2px;
	border-color: gray gray;
	border-width: 1px 0px 0.5px 0px;
	width: 500px;
	height: 50px;
}
.contentsIntro_payInfo_select_productName {
	color: gray;
	padding-top: 10px;
	float: left;
	width: 300px;
}
/* 수량버튼 readonly 텍스트창*/
.contentsIntro_payInfo_select_quantity {
	padding-top: 7px;
	float: left;
	width: 75px;
}
/* 숫자나오는부분 */
.qty_num {
  float: left;
}
#quantity {
  width: 23px;
  height: 20px;
  text-align: left;
  color: gray;
  border: 1px solid #cbcdce;
  border-radius: 3px;
}
/* 버튼부분 */
.qty_btn {
  float: left;
  height: 15px;
}
.qty_btn_plus {
  height: 11px;
}
.qty_btn_minus {
  height: 11px;
}
/* 수량*가격 출력부분 */
.contentsIntro_payInfo_select_price {
	text-align: right;
	color: #008BCC;
	padding-top: 10px;
	float: right;
	width: 125px;
}
/* 페이지 상단 우측 결제정보 부분_구매수량(테이블2) 총수량*/
.contentsIntro_payInfo_totalCal {
	margin-top:10px;
	float: left;
	border: solid 2px;
	border-color: lightgray;
	border-width: 0px 0px 0.05px 0px;
	width: 500px;
	height: 70px;
}
.contentsIntro_payInfo_totalCal_txt {
	width: 150px;
	float: left;
	padding-top: 40px;
	font-size: x-small;
}
.contentsIntro_payInfo_totalCal_price {
	text-align: right;
	font-size: x-large;
	font-weight: bold;
	padding-top: 40px;
	width: 300px;
	float: left;
}
.contentsIntro_payInfo_totalCal_quantity {
	text-align: left;
	padding-top: 50px;
	width: 40px;
	float: right;
	font-size: x-small;
	color: gray;
}
/* 페이지 상단 우측 결제정보 부분_상품구매,장바구니 버튼 */
.contentsIntro_buttons {
	margin-top:60px; 
	float: left;
	width: 500px;
	height: 60px;
	font-weight: bold;
	text-align:center;
}
.contentsIntro_buttons_cart {
	float: left;
	width: 249px;
	
	line-height: 70px;
	padding: 2px 0 0 0;
	color: #333;
	font-size: 14px;
	border: 1px #ccc solid;
}
.contentsIntro_buttons_buy {
	margin-top:2px;
	float: right;
    width: 249px;
    line-height: 70px;
    font-size: 16px;
    color: #fff;
    background: #bbb;
}
/* 페이지 하단 메인정보 */
.contentsMain {
	margin-top:100px;
	width: 1200px;
	min-height:700px;
}
/* <메뉴바> 상품상세,사용후기,상품문의*/
.contentsMain_bar {
	position:sticky;
	top:0px;
	width:1200px;
	margin: 0 auto;
	height:37px;
	background:white;
}
.contentsMain_menu {
	width:900px;
	height:36px;
	margin: 0 auto;
	border: 1px solid #cbcdce;
	background: #fff;
	color:gray;
	font-size:11px;
}
.contentsMain_menu_buttons {
	border-bottom:1px solid gray;
}
.contentsMain_menu li{
	height:36px;
	width: 400px;
	display: table-cell;
	vertical-align: middle;
	border-left: 1px solid #cbcdce;
	text-align:center;
}
/* <메뉴바> 스크롤시 메뉴버튼변경 */
.down{
	color:white;
	background-color:lightgray;
	font-weight:bold;
}
.remove{
	background: #fff;
	color:gray;
}
/* 페이지 하단 메인정보_상품정보이미지 */
.contentsMain_contents{
	margin:0 auto;
	padding:20px;
	text-align:center;
}
/* 상품후기 */
.contentsMain_board_review {
	margin:0 auto;
	padding:20px;
	text-align:center;
}
/* 상품문의 */
.contentsMain_board_qna {
	margin:0 auto;
	padding:20px;
	text-align:center;
}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>


<script type="text/javascript">
$(function(){
	  var $header1 = $('.list_info'); //헤더를 변수에 넣기
	  var $header2 = $('.list_review'); 
	  var $header3 = $('.list_qna'); 
	  var $page1 = $('.info'); //색상이 변할 부분
	  var $page2 = $('.boardReview'); 
	  var $page3 = $('.boardQna'); 
	  var $window = $(window);
	  var pageOffsetTop1 = $page1.offset().top;//색상 변할 부분의 top값 구하기
	  var pageOffsetTop2 = $page2.offset().top;
	  var pageOffsetTop3 = $page3.offset().top;
	  
	  $window.on('scroll', function(){ //스크롤시
	    var scrolled1 = $window.scrollTop() >= pageOffsetTop1; //스크롤된 상태
	    $header1.toggleClass('down', scrolled1); //클래스 토글
	    var scrolled2 = $window.scrollTop() >= pageOffsetTop2; 
	    $header2.toggleClass('down', scrolled2); 
	    $header1.toggleClass('remove', scrolled2); 
	    var scrolled3 = $window.scrollTop() >= pageOffsetTop3; 
	    $header2.toggleClass('remove', scrolled3); 
	    $header3.toggleClass('down', scrolled3); 
	  });
}); 
function numberWithCommas(n) {
    return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function qty_change(name){
	let quantity = document.getElementById('quantity');
	let price = document.getElementById('price');
	console.log(price);
	console.log(quantity.value);
	console.log(name);
	if(name=='p'){
		quantity.value++;
		let num = quantity.value*price.value;/* @@@@@@@@@@@@@ 여기 계산된 토탈금액있음!!!!@@@ */
		let num_com =numberWithCommas(num);
		document.getElementById("totalPrice").innerHTML = num_com+'원';
		document.getElementById("totalPrice2").innerHTML = num_com+'원';
		document.getElementById("totalQty").innerHTML = '('+quantity.value+'개)';
	} else if(name=='m'){
		if(quantity.value==1){
			alert('최소주문수량은 1개 입니다.')
		} else {
			quantity.value--;
			let num = quantity.value*price.value;/* @@@@@@@@@@@@@ 여기 계산된 토탈금액있음!!!!@@@ */
			let num_com =numberWithCommas(num);
			document.getElementById("totalPrice").innerHTML = num_com+'원';
			document.getElementById("totalPrice2").innerHTML = num_com+'원';
			document.getElementById("totalQty").innerHTML = '('+quantity.value+'개)';
		}
	} 
}






</script>
</head>
<body>
<!-- 전체페이지 : 상품 디테일 -->
<div class="productDetailPage">

	<!-- 페이지 상단(상품사진,결제정보입력부분) -->
	<div class="contentsIntro">	
	
		<!-- 페이지상단 좌측 // 상품이미지 -->
		<div class="contentsIntro_detailImg">	
			 <img class="detailImg" src="/Uhdiya/resources/img/product/beans_01.jpg"> 
		</div>
		
		<!-- 페이지상단 우측 // 상품가격,구매하기버튼등 -->
		<div class="contentsIntro_payInfoTxt">	
		
			<!-- 페이지상단 우측 결제정보의 상품명과 가격정보 /////@@@@데이터베이스에서 상품명 가격 가져와야함@@@@-->
			<div class="contentsIntro_productName">
				<h1>[어디야] 홀빈커피 페르소나 블렌드 200g</h1>
			</div>
			<div class="contentsIntro_payInfo">
				<span>원산지&nbsp;&nbsp;&nbsp;</span>
				<span>국내</span><br><br>
				<div class="contentsIntro_payInfo_productPrice">
					<span style="color:#008BCC; font-weight:bold"><b>판매가격</b></span>
					<span style="color:#008BCC;">
						20,000원
						<input id="price" name="price" value="20000" type="hidden">	<!-- 가져온가격들어가야함@@@@@@@@@@@@@@ -->
					</span>
				</div>
				<br>
				<hr style="border-width: 1px 0 0 0; border-color: #fff;">
				<span style="font-size: x-small;">&nbsp;(최소주문수량 1개이상)</span>
				<br><br><br>
				<p class="contentsIntro_payInfo_productPrice_ico">
					<span style="font-size: x-small;color:#f76560;padding-left:20px;">수량을 선택해주세요.</span>
				</p>
				
				<br>
			</div>
			
			<!-- 페이지상단 우측 결제정보의 테이블들 (수량선택과 총 금액계산) -->
			<div class="contentsIntro_payInfo_tables">
			
				<!-- 수량선택파트 -->
				<table class="contentsIntro_payInfo_select">
					<tr>
						<td class="contentsIntro_payInfo_select_productName">
							&nbsp;[어디야] 홀빈커피 페르소나 블렌드 200g
						</td>
							<!-- 수량표기및 수량버튼 -->
							<td class="contentsIntro_payInfo_select_quantity">
								<form class="qty">
									<!-- 수량표기 -->
									<div class="qty_num">
										<input id="quantity" name="quantity" type="text" value="1" readonly="readonly">
									</div>
									<!-- 버튼 -->
									<div class="qty_btn">
										<div class="qty_btn_plus">
											<a href="javascript:qty_change('p')"><img src="/Uhdiya/resources/img/product/btn_p.gif" alt="+"></a>
										</div>
										<div class="qty_btn_minus">
											<a href="javascript:qty_change('m')"><img src="/Uhdiya/resources/img/product/btn_m.gif" alt="-"></a>
										</div>
									</div>
								</form>
							</td>
							<!-- 수량*금액 출력부분 -->
							<td class="contentsIntro_payInfo_select_price">
							<span id="totalPrice2" style="float:right">
								20,000원
							</span>
						</td>
					</tr>
				</table>
				
				<!-- 금액계산파트 -->
				<table class="contentsIntro_payInfo_totalCal">
					<tr>
						<td class="contentsIntro_payInfo_totalCal_txt">
							&nbsp;총 상품금액(수량)
						</td>
						<td class="contentsIntro_payInfo_totalCal_price">
							<span id="totalPrice" style="float:right">
								20,000원
							</span>
						</td>
						<td class="contentsIntro_payInfo_totalCal_quantity">
							<span id="totalQty">
								(1개)
							</span>
						</td>
					</tr>
				</table>
			</div>
			
			<!-- 페이지상단 우측 결제정보 하단의 버튼들(장바구니,구매) -->
			<div class="contentsIntro_buttons">
				<div class="contentsIntro_buttons_cart">
					<a href="#" class="btn_cart"> 
						<span class="btn_cart_txt">CART 장바구니담기</span>
					</a>
				</div>
				<div class="contentsIntro_buttons_buy">
					<a href="#" class="btn_buy"> 
						<span class="btn_buy_txt">BUT NOW 바로구매하기</span>
					</a>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 상품설명,상품후기,상품문의 메뉴바 -->
	<div class="contentsMain">
		<!-- 상품후기,상품문의 버튼들 -->
		<div class="contentsMain_bar">
			<div class="contentsMain_menu">
				<ul class="contentsMain_menu_buttons">
					<li class="list_info" id="list"><a href="#info">상품상세정보</a>
					</li>
					<li class="list_review" id="list"><a href="#boardReview">사용후기</a>
					</li>
					<li class="list_qna" id="list"><a href="#boardQna">상품문의</a>
					</li>
				</ul>
			</div>
		</div>
		
		<!-- 상품설명 이미지 -->
		<p class="info"></p> <!-- 메뉴바 스크롤반응위치  -->
		<div class="contentsMain_contents">	
			<p id="info"></p> <!-- 클릭이동한곳(스크롤반응 위치 보다 아래있어야 버튼색상이 클릭할때 변경됨) -->
			<img src="/Uhdiya/resources/img/product/beans_01_info.jpg">
		</div>
		
		<!-- 상품후기 -->
		<p class="boardReview"></p> <!-- 메뉴바 스크롤반응위치  -->
		<div class="contentsMain_board_review" align="center"> 
			<p id="boardReview"></p><!-- 클릭이동한곳(스크롤반응 위치 보다 아래있어야 버튼색상이 클릭할때 변경됨) -->
			<h1>리뷰게시판</h1>
			<h1>리뷰게시판</h1>
			<h1>리뷰게시판</h1>
			<h1>리뷰게시판</h1>
			<h1>리뷰게시판</h1>
			<img src="/Uhdiya/resources/img/product/beans_01.jpg">
			<img src="/Uhdiya/resources/img/product/beans_01.jpg">
		</div>
		
		<!-- 상품문의  -->
		<p class="boardQna"></p><!-- 메뉴바 스크롤반응위치  -->
		<div class="contentsMain_board_qna" align="center"> 
			<p id="boardQna"></p> <!-- 클릭이동한곳(스크롤반응 위치 보다 아래있어야 버튼색상이 클릭할때 변경됨) -->
			<h1>후기게시판</h1>
			<h1>후기게시판</h1>
			<h1>후기게시판</h1>
			<h1>후기게시판</h1>
			<h1>후기게시판</h1>
			<img src="/Uhdiya/resources/img/product/beans_02.jpg">
			<img src="/Uhdiya/resources/img/product/beans_02.jpg">
		</div>
	</div>
 
</div>








</body>
</html>
