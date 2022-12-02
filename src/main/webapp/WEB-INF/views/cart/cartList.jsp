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


/* 상품주문 */
function order(part) {
	// 선택주문 : partly , 전체주문 : all , partly 도 all도 아닌경우 (품목행에서 바로구매선택)
	let exist=''; // 선택된 상품 없는경우 컷하기 위함.
	let member_id = document.getElementById('member_id').value;
	
	let form = document.createElement('form');
	let input_member_id = document.createElement('input');
	
	input_member_id.setAttribute('type', 'hidden');
	input_member_id.setAttribute('name', 'member_id');
	input_member_id.setAttribute('value', member_id);
	form.appendChild(input_member_id);
	
	// 들어온값이 상품코드인경우 ( 품목행에서 바로 구매 선택)
	if(part != 'partly' && part != 'all' ){
		exist = 'exist'; // 구매할 상품이 있다
		let input = document.createElement('input');
		input.setAttribute('type', 'hidden');
		input.setAttribute('name', 'product_code[]');
		input.setAttribute('value', part);
		form.appendChild(input);
	} else {	// 들어온값이 상품코드가 아닌경우 (선택주문또는 전체주문)
		let selectArr = new Array();
		let chk = document.getElementsByName("chk[]");
		let input = new Array();
		
		for(i=0;i<chk.length;i++){
			if(chk[i].checked==true && part == 'partly'){
				exist = 'exist'; // 선택된 상품이 있다
				selectArr[i]=chk[i].value;
				console.log(selectArr[i]);
				
				input[i] = document.createElement('input');
				input[i].setAttribute('type', 'hidden');
				input[i].setAttribute('name', 'product_code[]');
				input[i].setAttribute('value', selectArr[i]);
				form.appendChild(input[i]);
			} else if (part == 'all'){	// 전체상품주문
				selectArr[i]=chk[i].value;
				console.log(selectArr[i]);
				
				input[i] = document.createElement('input');
				input[i].setAttribute('type', 'hidden');
				input[i].setAttribute('name', 'product_code[]');
				input[i].setAttribute('value', selectArr[i]);
				form.appendChild(input[i]);
			}
		}
	}
	// 선택된 상품이 있는경우 또는 전체주문의경우
	if(exist=='exist' || part =='all' ){
		document.body.appendChild(form);
		
		form.method="post";
	 	form.action="${path}/order/addOrder";
		form.submit();
	} else {	//전체주문도 아니고 선택된 상품도없는경우
		alert('선택된 상품이 없습니다. 선택 후 다시 시도해주세요.');
	}
}
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
/* 수량변경버튼 */
function qty_change(sign,product_code,qty){
	console.log('수량변경들어옴'+sign+product_code+qty);
	let member_id = document.getElementById('member_id').value;
	console.log(member_id);
			
	if(qty==1 && sign=='m'){
		alert('최소수량은 1개입니다. 구매를 원치않으시면 선택상품 삭제해주세요.');
	} else {
		$.ajax({
	    	url : "qtyChange",
	    	type : "post",
	    	dataType : 'text',
	   		data : { sign : sign,
	   				product_code:product_code,
	   				qty:qty,
	   				member_id : member_id
	   		},
	    	success : function(data){
	    		if(data=='y'){
	    			/* alert('수량 변경됨.'); */
		     		/* location.href = "${path}/cart/cartList"; */
		     		window.location.reload();
	    		} else {
	    			alert('오류발생하였습니다. 다시시도해주세요.');
	    			location.href = "${path}/cart/cartList";
	    		}
	    	},
			error: function() {
	           alert('에러');
	        }
		});// ajax end
	}
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
	$(".cartListTotal_cnt").html('( '+num+' 개 ) ');
	$(".cartListTotal_price").html(total_price_com_won);
	$(".cartListTotal_price_last").html(total_price_com_won); 
}
function numberWithCommas(n) {
    return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function priceToWon(n){
	let won = n+'원';
	return won;
}
/* 선택상품삭제 */
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
			     		location.href = "${path}/cart/cartList";
		    		} else {
		    			alert('오류발생하였습니다. 다시시도해주세요.');
		    			location.href = "${path}/cart/cartList";
		    		}
		    	},
				error: function() {
		           alert('에러');
		        }
			}); // ajax end
		}
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
	$(".cartListTotal_cnt").html('( '+num+' 개 ) ');
	$(".cartListTotal_price").html(total_price_com_won);
	$(".cartListTotal_price_last").html(total_price_com_won); 
}
/* 행에서 상품삭제 */
function cartList_del(product_code){
	console.log(product_code);
	window.location.href='${path}/cart/del?product_code='+product_code;
}
</script>
<style>
.cartListPage {
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
.cartList {
	width:1200px;
	margin-top:10px;
	border: 1px solid #d7d5d5;
    
}
.cartList th {
	height: 10px;
	padding: 8px 0 8px;
    border-left: 1px solid #dfdfdf;
    border-bottom: 1px solid #dfdfdf;
    color: #353535;
    vertical-align: middle;
    font-size: small;
    background: #fbfafa;
}
.cartList td {
	border-top: 1px solid #dfdfdf;
    color: #353535;
    vertical-align: middle;
    font-size: small;
    text-align: center;
	padding: 6px 0 6px;
    
}
.cartList_obj_info {
	text-align:left !important;
	font-weight:bold !important;
}
.cartListTotal {
	text-align: right !important;
	padding-right: 20px !important;
}
.cartListTotal_cnt {
	text-align: right !important;
	padding-right: 20px !important;
}
.cartList_obj_btn{
	background-color: #4a5164;
	border-radius: 2px;
	color: #fff;
	font-size: 12px;
	font-weight: normal;
	vertical-align: middle;
	height: 25px;
	width: 70px;
	border: 1px solid transparent;
	margin-bottom:3px;
}
.cartList_obj_btn_del{
	background-color: lightgray;
	border-radius: 2px;
	color: #fff;
	font-size: 12px;
	font-weight: normal;
	vertical-align: middle;
	height: 25px;
	width: 70px;
	border: 1px solid transparent;
}
.cartList_sub_img {
  width: 110px;
}
.cartList_sub_info {
  width: 605px;
}
.cartList_sub_price {
  width: 110px;
}
.cartList_sub_qty {
  width: 100px;
}
.cartList_sub_total {
  width: 110px;
}
.cartList_sub_choose {
  width: 110px;
}
.selectDel{
	padding: 15px 0 10px;
	width: 600px;
	margin-right:0px;
	display: inline-block;
	margin-bottom:200px;
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
	width: 580px;
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
.selectOrder_btn_all{
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
.cartListTotal_price{
	font-size: 14px;
	font-weight: bold;
}
.cartListTotal_txt_highlight {
	font-size: 16px;
	color: red;
}
.cartListTotal_price_last {
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
.cartList_obj_qty {
}
#quantity {
  width: 23px;
  height: 20px;
  text-align: left;
  color: gray;
  border: 1px solid #cbcdce;
  border-radius: 3px;
}
.qty_num {
  float: left;
  padding-left:25px;
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
</style>
</head>
<body>
	<input type="hidden" id="member_id" value="${member.member_id }">

	<div class="cartListPage">
		<div class="title">
			<span class="title_txt">장바구니</span>
		</div>
		<div class="step">
			<img class="step_img" src="${path }/resources/img/cart/cart.png" width="450px" height="35px">
		</div>
		<div class="totalCntBox">
			<div class="totalCntBox_txtArea">
				<c:choose>
					<c:when test="${member.member_id!=null }">
						<span class="totalCntBox_txt_highLight">${member.member_name }님! ( 회원아이디 : ${member.member_id } )</span>
						<span class="totalCntBox_txt">장바구니에 총 </span><span class="totalCnt">${cartListCount }개</span><span class="totalCntBox_txt">의 상품이 추가되어 있습니다.</span>
						<span class="totalCntBox_txt">주문하실 상품을 선택해주세요.</span>
					</c:when>
					<c:otherwise>
						<span class="totalCntBox_txt">로그인 후 이용해주세요.</span>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<table class="cartList">
			<tr>
				<th class="cartList_sub_checkBox">
					<input type="checkbox" id="checkAll" name="all" onclick="checkAll()" checked="on" >
				</th>
				<th class="cartList_sub_img">이미지</th>
				<th class="cartList_sub_info">상품정보</th>
				<th class="cartList_sub_price">판매가</th>
				<th class="cartList_sub_qty">수량</th>
				<th class="cartList_sub_total">합계</th>
				<th class="cartList_sub_choose">선택</th>
			</tr>
			
			<c:choose>
				<c:when test="${member.member_id==null || empty cartsMap.cartList }">
						<tr>
							<td colspan="7" height="300">
								<c:choose>
									<c:when test="${empty cartsMap.cartList }" >
										장바구니가 비었습니다. 상품을 추가해주세요.
									</c:when>
									<c:otherwise>
										로그인 후 사용 가능합니다.
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<td class="cartListTotal" colspan="7">
								<span class="cartListTotal_txt">상품구매금액</span>
								<span class="cartListTotal_price">0</span>
								<span class="cartListTotal_txt">+ 배송비 0 (무료) = </span>
								<span class="cartListTotal_txt_highlight">합계 : </span>
								<span class="cartListTotal_price_last">0</span>
							</td>
						</tr>
					</table>
					
					<c:choose>
						<c:when test="${empty cartsMap.cartList }" >
							<div class="notUser">
								<button type="button" class="selectOrder_btn" onclick="location.href='${path}/main'">
									쇼핑계속하기
								</button>
							</div>
						</c:when>
						<c:otherwise>
							<div class="notUser">
								<button type="button" class="notUser_btn" onclick="location.href='${path}/member/login'">
									로그인
								</button>
							</div>
						</c:otherwise>
					</c:choose>
				</c:when>
				
				<c:otherwise>
					<form name="frm">
						<c:set var="k" value="0" />
						<c:forEach items="${cartsMap.cartList }" var="list">
							<tr>
								<td class="cartList_obj_checkBox">
									<input type="checkbox"  name="chk[]" value="${list.product_code }" checked onclick="selItem()">
								</td>
								<td class="cartList_obj_imgArea">
									<img class="cartList_obj_img" width="80" height="80" src="${path }/product_download?product_fileName=${list.product_fileName }&product_code=${list.product_code}">
								</td>
								<td class="cartList_obj_info">${list.product_name }</td>
								<td class="cartList_obj_price">
									<fmt:formatNumber  value="${list.product_price }" type="number" var="product_price" />
				         			${product_price}원
								</td>
								<td class="cartList_obj_qty">
								
									<!-- 수량표기 -->
									<div class="qty_num">
										<input id="quantity" name="cart_qty" type="text" value="${list.cart_qty }" readonly="readonly">
									</div>
									<!-- 버튼 -->
									<div class="qty_btn">
										<div class="qty_btn_plus">
											<a href="javascript:qty_change('p','${list.product_code }','${list.cart_qty }')">
												<img src="${path }/resources/img/product/btn_p.gif" alt="+">
											</a>
										</div>
										<div class="qty_btn_minus">
											<a href="javascript:qty_change('m','${list.product_code }','${list.cart_qty }')"><img src="${path }/resources/img/product/btn_m.gif" alt="-"></a>
										</div>
									</div>
								</td>
								<td class="cartList_obj_price">
									<input type="hidden" id="eachPrice[${k }]" name="eachPrice[${k }]" value="${list.product_price*list.cart_qty}"> 
					   				<fmt:formatNumber  value="${list.product_price*list.cart_qty}" type="number" var="each_total" />
				         			${each_total}원
								</td>
								<td class="cartList_obj_choose">
									<button type="button" class="cartList_obj_btn" onclick="javascript:order('${list.product_code }')">
										바로구매
									</button>
									<button type="button" class="cartList_obj_btn_del" onclick="javascript:cartList_del('${list.product_code }')">
										X 삭제
									</button>
								</td>
							</tr>
							
							<c:set  var="all_total" value="${all_total+list.product_price*list.cart_qty }" />
							<c:set  var="all_num" value="${all_num+1 }" />
							<c:set var="k" value="${k+1 }" />
						</c:forEach>
					</form>
				</c:otherwise>
			</c:choose>
			
			<c:if test="${member.member_id!=null && not empty cartsMap.cartList  }">
				<tr>
					<td class="cartListTotal" colspan="7">
						<span class="cartListTotal_txt">총 상품수 </span>
						<span class="cartListTotal_cnt"> ( ${all_num } 개 ) </span>
						<span class="cartListTotal_txt"> 상품구매금액 </span>
						<span class="cartListTotal_price">
							<fmt:formatNumber  value="${all_total}" type="number" var="a_total" />
								${a_total }원
						</span>
						<span class="cartListTotal_txt">+ 배송비 0원 (무료) = </span>
						<span class="cartListTotal_txt_highlight">합계 : </span>
						<span class="cartListTotal_price_last">
							<fmt:formatNumber  value="${all_total}" type="number" var="a_total" />
								${a_total }원
						</span>
					</td>
				</tr>
			</table>
				<div class="selectDel">
					<span class="selectDel_txt">선택상품을</span>
						<button type="button" class="selectDel_btn" onclick="javascript:selectDel()">
							X 삭제하기
						</button>
					</div>
				<div class="selectOrder">
					<button type="button" class="selectOrder_btn" onclick="location.href='${path}/main'">
						쇼핑계속하기
					</button>
					<button type="button" class="selectOrder_btn" onclick="javascript:order('partly')">
						선택상품주문
					</button>
					<button type="button" class="selectOrder_btn_all" onclick="javascript:order('all')">
						전체상품주문
					</button>
				</div>
			</c:if>
			
			
	</div>
</body>
</html>