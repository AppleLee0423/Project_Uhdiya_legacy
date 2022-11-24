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
$(function(){
	$("#product_cateL").val("${param.product_cateL}").attr("selected","selected");
	$("#product_cateS").val("${param.product_cateS}").attr("selected","selected");
	$("#searchSel").val("${param.searchSel}").attr("selected","selected");
	$("#searchSelTxt").val("${param.searchSelTxt}").attr("selected","selected");
});
function btn_prev(){
	let urlParams = new URL(location.href).searchParams;
	let page = urlParams.get('page');
	let product_cateL = urlParams.get('product_cateL');
	let product_cateS = urlParams.get('product_cateS');
	let searchSel = urlParams.get('searchSel');
	let searchSelTxt = urlParams.get('searchSelTxt');
	let page_prev = page - 1;
	console.log(page);
	console.log(page_prev);
	if(page=='1' || page==null){
		window.location.href='${path}/product/modProductList?product_cateL='+product_cateL+'&product_cateS='+product_cateS+'&searchSel='+searchSel+'&searchSelTxt='+searchSelTxt+'&page=1';
		alert('첫 페이지입니다.');
	} else {
		window.location.href='${path}/product/modProductList?product_cateL='+product_cateL+'&product_cateS='+product_cateS+'&searchSel='+searchSel+'&searchSelTxt='+searchSelTxt+'&page='+page_prev;
	}
}
function btn_next(){
	let urlParams = new URL(location.href).searchParams;
	let page = urlParams.get('page');
	let product_cateL = urlParams.get('product_cateL');
	let product_cateS = urlParams.get('product_cateS');
	let searchSel = urlParams.get('searchSel');
	let searchSelTxt = urlParams.get('searchSelTxt');
	if(page==null){
		page=1;
	}
	if(product_cateL==null){
		product_cateL='';
	}
	if(product_cateS==null){
		product_cateS='';
	}
	if(searchSelTxt==null){
		searchSelTxt='';
	}
	let page_next = parseInt(page) + 1;
 	let lastPage = document.getElementById('lastPage');
	if(page_next > lastPage.value ){
		window.location.href='${path}/product/modProductList?product_cateL='+product_cateL+'&product_cateS='+product_cateS+'&searchSel='+searchSel+'&searchSelTxt='+searchSelTxt+'&page='+page;
		alert('마지막 페이지입니다.');
	} else{
		window.location.href='${path}/product/modProductList?product_cateL='+product_cateL+'&product_cateS='+product_cateS+'&searchSel='+searchSel+'&searchSelTxt='+searchSelTxt+'&page='+page_next;
	} 
}
function search() {
	let product_cateL = document.getElementById('product_cateL');
	let product_cateS = document.getElementById('product_cateS');
	let searchSel = document.getElementById('searchSel');
	let searchSelTxt = document.getElementById('searchSelTxt');
	window.location.href='${path}/product/modProductList?product_cateL='+product_cateL.value+'&product_cateS='+product_cateS.value+'&searchSel='+searchSel.value+'&searchSelTxt='+searchSelTxt.value;
}
function del_product(del_product_code){
	console.log('들어옴');
	let url = window.location.href;
	console.log(del_product_code);
	let txt = prompt('선택하신 상품코드('+del_product_code+')의 상품정보를 완전삭제합니다. 해당 상품코드를 입력해주세요. 잘못 입력하실경우 삭제가 취소됩니다.');
	if(txt==del_product_code){
		//alert('상품코드('+txt+')의 정보가 삭제되었습니다.');	
		window.location.href='${path}/product/delProduct?del_product_code='+txt+'&url='+url;
	} else{
		alert('상품정보 삭제가 취소되었습니다. 상품코드('+del_product_code+')의 정보가 삭제되지 않았습니다.');
	}
}
</script>
<style>
.modProductList{
	width:1200px;
	margin:50px auto 30px auto;
}
.modProductList__title{
	margin: 30px auto 0px auto;
	text-align: center;
	color:gray;
	font-size:large;
	font-weight:bold;
	width:1200px;
	height:30px;
}

.search_title{
	min-height:30px;
	margin-bottom: 5px;
}
.search_title_txt{
	display: inline-block;
    padding: 20px 0 0 10px;
    color: #2e2e2e;
    font-size: 12px;
    font-weight: bold;
}
.search_box {
    border: 5px solid #e8e8e8;
    color: #404040;
    height: 240px;
    margin-bottom:20px;
}
.search_box_form{
	margin: 0px auto 0px auto;
	width:500px;
	padding-top: 60px;
}
.search_box_form_sub{
	float:left;
	width: 150px;
	height:27px;
}
.search_box_form_sub_txt {
	
	display: inline-block;
	color: #2e2e2e;
    font-size: 11px;
    font-weight: bold;
    height: 27px;
}
.search_box_form_obj{
	float:left;
	width: 350px;
	height:27px;
}
.search_box_form_obj_txt{
	
	width: 300px;
	display: inline-block;
	height: 18px;
    line-height: 20px;
    padding: 2px 4px;
    border: 1px solid #d5d5d5;
    color: #353535;
    font-size: 12px;
}
.cateSel{
	width: 300px;
	font-size: small;
    vertical-align: middle;
    border: 1px solid #d5d5d5; 
    background:white;
    height:23px;
}
.searchSel{
	width: 100px;
	font-size: small;
    vertical-align: middle;
    border: 1px solid #d5d5d5; 
    background:white;
    height:23px;
}
.searchSel_txt{
	width: 185px;
	display: inline-block;
	height: 18px;
    line-height: 20px;
    padding: 2px 4px;
    border: 1px solid #d5d5d5;
    color: #353535;
    font-size: 12px;
}
.search_box_btn_area{
	width:150px;
	margin: 70px auto;
	padding-right: 40px;
}
.search_box_btn{
	background-color: #4a5164;
	border-radius: 2px;
	color: #fff;
	font-size: 12px;
	font-weight: normal;
	vertical-align: middle;
	margin-left: 50px;
	height: 30px;
	margin-top: 20px;
	width: 130px;
	border: 1px solid transparent;
}
.totalCntBox{
	margin-height:20px;
	height:28px;
	color: #333;
	border: 0.5px #ccc solid;
}
.totalCntBox_textArea{
	margin-left:10px;
	padding-top:3px;
}
.totalCntBox_txt {
	text-align:left;
	font-size: 8px;
	color: #008BCC;
}
.totalCnt{
	font-size: 8px;
	font-weight:bold;
	color: #008BCC;
}
.product_list{
	margin-top:20px;
	text-align:left;
	width:1200px;
	vertical-align: middle;
	border: 1px solid gray;
	margin-bottom:30px;
}
.list_title {
	height:20px;
	text-align: center;
	color: gray;
	font-weight: bold;
	border-bottom: 1px solid lightgray;
	vertical-align: middle;
	background: ivory;
}
 .product_list tr {
	font-size:small;
} 
 .product_list tr:hover {
	background:rgb(245,245,245);
} 
.product_list img {
	vertical-align: middle;
	width:50px;
	height:50px;
}
.list_obj {
	width: 50px;
	height: 55px;
	vertical-align: middle;
	text-align: center;
}
 .product_list tr a {
	color:#2d2c2d;
	text-decoration: none;
} 
.list_obj_txt {
	font-weight:lighter;
}
/* 페이지버튼 */
.pageBtn {
	margin: 35 auto;
	width:1200px;
	min-height:60px;
}
.pageBtn_ul {
	display: inline-block;
    font-size: 0;
    margin-left:570px;
}
.pageBtn_li {
	display: inline-block;
    margin: 0 0 0 -1px;
    color: #757575;
    vertical-align: middle;
}
.pageBtn_li_txt {
	display: inline-block;
    border: 1px solid #d7d5d5;
    color: #757575;
    font-size: medium;
	line-height: 2;
    vertical-align: middle;
    height:32.5px;
    min-width: 33px;
    text-align:center;
}
</style>
</head>
<body>
<c:set var="total" value="${productsMap.total }" />

	<div class="modProductList">
		<div class="modProductList__title">
			상품 관리하기
		</div>
		
		<div class="search_title">
			<span class="search_title_txt">상품검색</span>
		</div>
		<div class="search_form">
			<div class="search_box">
				<div class="search_box_form">
					<div class="search_box_form_sub">
						<span class="search_box_form_sub_txt">상품 대분류로 검색</span>
					</div>
					<div class="search_box_form_obj">
						<select class="cateSel" onchange="itemChange()" id="product_cateL">
							<option value="">전체</option>
							<option value="커피">커피</option>
							<option value="스틱커피">스틱커피</option>
							<option value="음료">음료</option>
							<option value="티">티</option>
						</select>
					</div>
					<div class="search_box_form_sub">
						<span class="search_box_form_sub_txt">상품 소분류로 검색</span>
					</div>
					<div class="search_box_form_obj">
						<select class="cateSel"  id="product_cateS">
							<option value="">전체</option>
							
							<option value="홀빈원두">커피 > 홀빈원두</option>
							<option value="핸드드립">커피 > 핸드드립</option>
							<option value="캡슐커피">커피 > 캡슐커피</option>
							<option value="커피머신">커피 > 커피머신</option>
							
							<option value="아메리카노">스틱커피 > 아메리카노</option>
							<option value="라떼">스틱커피 > 라떼</option>
							<option value="커피믹스">스틱커피 > 커피믹스</option>
							
							<option value="주스">음료 > 주스</option>
							<option value="컵커피">음료 > 컵커피</option>
							<option value="블렌딩티">티 > 블렌딩티</option>
							<option value="전통차">티 > 전통차</option>
						</select>
					</div>
					<div class="search_box_form_sub">
						<span class="search_box_form_sub_txt">검색조건</span>
					</div>
					<div class="search_box_form_obj">
						<select class="searchSel"  id="searchSel" name="searchSel">
							<option value="product_name">상품명</option>
							<option value="product_code">상품코드</option>
						</select>
						<input type="text" class="searchSel_txt" id="searchSelTxt" value="${param.searchSelTxt }" placeholder="미입력시 전체 항목이 검색됩니다.">
					</div>
					<div class="search_box_btn_area">
						<button type="button" class="search_box_btn" onclick="javascript:search()">
							검색
						</button>
					</div>
				</div>
			</div>
		</div>
		
		<div class="totalCntBox">
			<div class="totalCntBox_textArea">
				<span class="totalCntBox_txt">총 </span><span class="totalCnt">${total }</span><span class="totalCntBox_txt"> 개 의 상품이 검색되었습니다.</span>
			</div>
		</div>
		
		<table class="product_list">
			<tr>
				<td class="list_title" style="padding-left:20px;">상품이미지</td>
				<td class="list_title" >제품고유코드</td>
				<td class="list_title" style="padding-left:80px;">상품명</td>
				<td class="list_title">대분류명</td>
				<td class="list_title" >소분류명</td>
				<td class="list_title" >상품가격</td>
				<td class="list_title" >관리</td>
			</tr>
			<c:forEach items="${productsMap.productsList }" var="list">
				<tr>
					<td class="list_obj">
						<a href="#">
							<img src="${path }/product_download?product_fileName=${list.product_fileName }&product_code=${list.product_code}" id="preview">
						</a>
					</td>	
					<td class="list_obj">
						<a href="#">
							<span class="list_obj_txt" >${list.product_code}</span>
						</a>
					</td>	
					<td class="list_obj">	
						<a href="#">
							<span class="list_obj_txt" >${list.product_name}</span>
						</a>
					</td>	
					<td class="list_obj">	
						<a href="#">
							<span class="list_obj_txt" >${list.product_cateL}</span>
						</a>
					</td>	
					<td class="list_obj">	
						<a href="#">
							<span class="list_obj_txt" >${list.product_cateS}</span>
						</a>
					</td>	
					<td class="list_obj">	
						<a href="#">
							<fmt:formatNumber  value="${list.product_price}" type="number" var="product_price" />
							<span class="list_obj_txt" >${product_price }원</span>
						</a>
					</td>
					<td class="list_obj">
						<a href="javascript:del_product('${list.product_code }')">
							<span style="width:30px; color :rgb(255,0,0); ">상품삭제</span>
						</a>
					</td>
				</tr>
			</c:forEach>
		</table>
		<c:set var="k" value="${total }" />
		<div class="pageBtn">
			<ul class="pageBtn_ul">
				<li class="pageBtn_li">
					<a href="javascript:btn_prev()">
						<img src="${path }/resources/img/product/btn_page_prev.gif">
					</a>
				</li>
				<c:forEach var="i" begin="1" end="${k }" step="1">
					<c:if test="${k>(i-1)*10 }">
						<li class="pageBtn_li_txt">
							<a href="${path}/product/modProductList?product_cateL=${param.product_cateL }&product_cateS=${param.product_cateS }&searchSel=${param.searchSel }&searchSelTxt=${param.searchSelTxt }&page=${i}">
								<span>${i }</span>
								<c:if test="${param.page==i || (param.page==null) && i==1 }">
									<hr style="border-width: 2px 0 0 0; border-color: #fff; margin-top:0px;">
								</c:if>
							</a>
						</li>
					</c:if>
				</c:forEach> 
				<li class="pageBtn_li">
					<a href="javascript:btn_next()">
						<img src="${path }/resources/img/product/btn_page_next.gif" style="border-left: 1px solid #d7d5d5;">
						<input id = "lastPage" type="hidden" value="${k/10+1 }">
					</a>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>