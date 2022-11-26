<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%
	request.setCharacterEncoding("utf-8");
%>
<c:set var="path" value="${pageContext.request.contextPath }" />
 <c:set var="product"  value="${productsMap.productDTO}"  />
<c:set var="infoFileList"  value="${productsMap.infoFileList }"  />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path } /resources/css/reset.css" />
<link rel="stylesheet" href="${path }/resources/css/product/productDetail.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
function priceToWon(n){
	let won = n+'원';
	return won;
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
		document.getElementById("totalPrice").innerHTML = priceToWon(num_com);
		document.getElementById("totalPrice2").innerHTML = priceToWon(num_com);
		document.getElementById("totalQty").innerHTML = '('+quantity.value+'개)';
	} else if(name=='m'){
		if(quantity.value==1){
			alert('최소주문수량은 1개 입니다.')
		} else {
			quantity.value--;
			let num = quantity.value*price.value;/* @@@@@@@@@@@@@ 여기 계산된 토탈금액있음!!!!@@@ */
			let num_com =numberWithCommas(num);
			document.getElementById("totalPrice").innerHTML = priceToWon(num_com);
			document.getElementById("totalPrice2").innerHTML = priceToWon(num_com);
			document.getElementById("totalQty").innerHTML = '('+quantity.value+'개)';
		}
	} 
}
$(document).ready(function() {

	$(window).scroll(function() {
	    // top button controll
	    if ($(this).scrollTop() > 500) {
	        $('#topButton').fadeIn();
	    } else {
	        $('#topButton').fadeOut();
	    }
	});

	$("#topButtonImg").click(function() {
		$('html, body').animate({scrollTop:0}, '300');
	});

});
function cateL() {
	let cateL = document.getElementById('cateL');
	window.location.href='${path}/product/productList?product_cateL='+cateL.value+'&product_cateS=';
}
function cateS() {
	let cateL = document.getElementById('cateL');
	let cateS = document.getElementById('cateS');
	window.location.href='${path}/product/productList?product_cateL='+cateL.value+'&product_cateS='+cateS.value;
}
</script>
<style>
/* ㅅ 버튼 */
#topButton {
  width: 35px;
  height: 34px;
  margin-left: 1160px;
}
#topButtonImg {
  width: 65px;
  height: 65px;
}
.menuMap{
	width: 1200px;
	margin-top:35px;
	min-height:20px;
	text-align:right;
	font-size:small;
	color:gray;
}
/* 페이지상단 */
.contentsIntro {
	width: 1200px;
	margin: 40px auto;
	min-height: 520px;
}
</style>
</head>
<body>
<!-- 전체페이지 : 상품 디테일 -->
<div class="productDetailPage">

	<!-- 메뉴맵 -->
	<div class="menuMap">
		<a href="${path }/main">
			홈 > 
		</a>
		<a href="javascript:cateL()">
			<span >${param.product_cateL } </span>
			<input type="hidden" id="cateL" value="${param.product_cateL }">
		</a>
		<a href="javascript:cateS()">
			<span> > ${param.product_cateS }</span>
			<input type="hidden" id="cateS" value="${param.product_cateS }">
		</a>
	</div>
	
	<!-- 페이지 상단(상품사진,결제정보입력부분) -->
	<div class="contentsIntro">	
	
		<!-- 페이지상단 좌측 // 상품이미지 -->
		<div class="contentsIntro_detailImg">	
			<img width="500" height="500" src="${path }/product_download?product_fileName=${product.product_fileName }&product_code=${product.product_code }" 
								 id="preview"> 				 
		</div>
		
		<!-- 페이지상단 우측 // 상품가격,구매하기버튼등 -->
		<div class="contentsIntro_payInfoTxt">	
		
			<!-- 페이지상단 우측 결제정보의 상품명과 가격정보 /////@@@@데이터베이스에서 상품명 가격 가져와야함@@@@-->
			<div class="contentsIntro_productName">
				<h1>${product.product_name }</h1>
			</div>
			<div class="contentsIntro_payInfo">
				<span>원산지&nbsp;&nbsp;&nbsp;</span>
				<span>국내</span><br><br>
				<div class="contentsIntro_payInfo_productPrice">
					<span style="color:#008BCC; font-weight:bold"><b>판매가격</b></span>
					<span style="color:#008BCC;">
						<fmt:formatNumber  value="${product.product_price }" type="number" var="product_price" />
						${product_price }원
						<input id="price" name="price" value=${product.product_price } type="hidden">	<!-- 가져온가격들어가야함@@@@@@@@@@@@@@ -->
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
							&nbsp;${product.product_name }
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
											<a href="javascript:qty_change('p')">
												<img src="${path }/resources/img/product/btn_p.gif" alt="+">
											</a>
										</div>
										<div class="qty_btn_minus">
											<a href="javascript:qty_change('m')"><img src="${path }/resources/img/product/btn_m.gif" alt="-"></a>
										</div>
									</div>
								</form>
							</td>
							<!-- 수량*금액 출력부분 -->
							<td class="contentsIntro_payInfo_select_price">
							<span id="totalPrice2" style="float:right">
								<fmt:formatNumber  value="${product.product_price }" type="number" var="product_price" />
								${product_price }원
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
								<fmt:formatNumber  value="${product.product_price }" type="number" var="product_price" />
								${product_price }원
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
			
			<div id="topButton" style="cursor: pointer"  >
				<img src="${path }/resources/img/product/top.png" id="topButtonImg">
			</div>
			
		</div>
		
		<!-- 상품설명 이미지 -->
		<p class="info"></p> <!-- 메뉴바 스크롤반응위치  -->
		<div class="contentsMain_contents">	
			<p id="info"></p> <!-- 클릭이동한곳(스크롤반응 위치 보다 아래있어야 버튼색상이 클릭할때 변경됨) -->
			
			<c:forEach var="info" items="${infoFileList }">
				<img src="${path }/product_download?product_fileName=${info.product_fileName}&product_code=${info.product_code}" 
								 id="preview"> 
			</c:forEach> 
			
			
		</div>
		
		<!-- 상품후기 -->
		<p class="boardReview"></p> <!-- 메뉴바 스크롤반응위치  -->
		<div class="contentsMain_board_review" align="center"> 
			<p id="boardReview"></p><!-- 클릭이동한곳(스크롤반응 위치 보다 아래있어야 버튼색상이 클릭할때 변경됨) -->
			<jsp:include page="/WEB-INF/views/board/review_product.jsp" ></jsp:include>
		</div>
		
		<!-- 상품문의  -->
		<p class="boardQna"></p><!-- 메뉴바 스크롤반응위치  -->
		<div class="contentsMain_board_qna" align="center"> 
			<p id="boardQna"></p> <!-- 클릭이동한곳(스크롤반응 위치 보다 아래있어야 버튼색상이 클릭할때 변경됨) -->
			<jsp:include page="/WEB-INF/views/board/qna_product.jsp" ></jsp:include>
		</div>
	</div>
</div>
</body>
</html>