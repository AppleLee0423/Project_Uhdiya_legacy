<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
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
.productListPage {
	margin:0 auto;
	width: 1240px;
}
/* 메뉴맵 */
.menuMap {
	width: 1240px;
	margin: 0px;
	min-height: 20px;
	text-align: right;
	font-size: small;
	color: gray;
}
/* 페이지상단 */
.contentsIntro {
	width: 1240px;
	margin: 20px auto;
}
/* 상단 리스트명,아이템수,정렬 (테이블) */
.products_info {
	margin: 0 auto;
	text-align: center;
	width: 1240px;
}
/* 리스트명(대분류 또는 소분류명) */
.cate {
	text-align: center;
	font-size: small;
	height:50px;
}
/* 대분류리스트페이지에서 소분류별 제품숫자버튼 */
.listCateS{
	margin: 0 auto;
	width: 1240px;
}
.listCateS_menu {
	text-align:right;
	width: 1240px;
	height:30px;
	color:gray;
	font-size:11px;
}
.listCateS_buttons {
	margin-rignt:0px;
	margin-top:20px;
	width: 1200px;
}
.listCateS_menu li{
	height:30px;
	width: 300px;
	display: table-cell;
	vertical-align: middle;
	text-align:center;
}
/* 상품토탈 */
.cnt {
	margin-top:20px;
	font-size: small;
	color:gray;
	text-align: left;
}
/* 토탈숫자 */
.total {
	font-weight:border;
	font-size:medium;
}
/* 정렬 리스트 */
.orderBy {
	text-align: right;
	font-size: small;
	color:gray;
}
.orderBy_choose {
	font-size: small;
	display: inline;
}
/* 페이지중앙(제품리스트) */
.mainList {
	width: 1240px;
	margin: 40px auto;
	min-height: 700px;
}
/* 제품들(테이블) */
.products {
	position: static;
	width:1240px;
	border: "2";
	margin: 60px auto;
}
/* 제품 한칸 */
.product {
	padding: 0 2px 100px 2px;
	max-width: 310px;
	height: 350px;
	float:left;
}
/* 제품명 */
.product_title {
	text-align: left;
	font-size: small;
}
/* 제품가격 */
.product_price {
	font-size: small;
	font-weight: bold;
	color: lightblue;
	text-align: left;
	padding-left: 2px;
	color: #008BCC;
}
</style>
<script type="text/javascript">
function cateL() {
	let cateL = document.getElementById('cateL');
	console.log(cateL.value);
	window.location.href='${path}/product/productList?product_cateL='+cateL.value+'&product_cateS=';
}
function cateS() {
	let cateL = document.getElementById('cateL');
	let cateS1 = document.getElementById('cateS1');
	let cateS2 = document.getElementById('cateS2');
	let cateS3 = document.getElementById('cateS3');
	let cateS4 = document.getElementById('cateS4');
	console.log(cateS.value);
	window.location.href='${path}/product/productList?product_cateL='+cateL.value+'&product_cateS='+cateS1.value;
	window.location.href='${path}/product/productList?product_cateL='+cateL.value+'&product_cateS='+cateS2.value;
	window.location.href='${path}/product/productList?product_cateL='+cateL.value+'&product_cateS='+cateS3.value;
	window.location.href='${path}/product/productList?product_cateL='+cateL.value+'&product_cateS='+cateS4.value;
}
</script>
</head>
<body>
<c:set var="total" value="${productsMap.total }" />
<!-- 전체페이지 : 상품 디테일 -->
<div class="productListPage">

	<!-- 메뉴맵 -->
	<div class="menuMap">
		<a href="${path }/main">
			홈 > 
		</a>
		<a href="javascript:cateL()">
			<span >${param.product_cateL } </span>
			<input type="hidden" id="cateL" value="${param.product_cateL }">
		</a>
		<c:if test="${param.product_cateS != '' }">
			<span> > ${param.product_cateS }</span>
		</c:if>
	</div>
	
	<!-- 페이지 상단(소분류명,총아이템수,가격순) -->
	<div class="contentsIntro">	
 		<table class="products_info">
			<tr>
				<!-- 분류명 -->
				<td class="cate" colspan="4">
					<c:choose>
					<c:when test="${param.product_cateS=='' }">
						<span>${param.product_cateL }</span>
							<div class="listCateS">
								<div class="listCateS_menu">
									<ul class="listCateS_buttons">
										<c:set var="k" value="1" />
										<c:forEach items="${productsMap.totalS }" var="totalS">
											<li class="totalSbtn" id="totalSbtn">
												<a href="javascript:cateS()">${totalS.product_cateS} (${totalS.cateS}) </a>
												<input id="cateS${k}" type="hidden" value="${totalS.product_cateS}">
											</li>
											<c:set var="k" value="${k+1 }" />
										</c:forEach>
									</ul>
								</div>
							</div>
							
					</c:when>
					<c:otherwise>
						<span>${param.product_cateS }</span>
					</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<!-- 총상품토탈수 -->
				<td colspan="4" >
					<div class="cnt">
						<span>TOTAL : </span> <span class="total">${total }</span> <span> items</span> 
					</div>
					<hr style="border-width: 1px 0 0 0; border-color: #fff;">
				</td>
			</tr>
		</table>	
	</div>
	
	<!-- 메인 상품들 -->
	<div class ="mainList">
		<c:set var="i" value="0" />
		<c:set var="j" value="4" /> 
		
		<!-- 상품들(테이블) -->
	 	<table class="products">
	
			<c:forEach items="${productsMap.productsList }" var="list">
				<c:if test="${i%j == 0 }"> 
					<tr>
				</c:if>
				
				<!-- 각 상품 -->
				<td class="product">
				
					<!-- 상품사진 -->
						<a href ="${path }/product/productDetail?product_code=${list.product_code }">
							<img width="305" height="305"
								src="${path }/resources/img/product/${list.product_fileName }"> 
							<hr style="border-width: 1px 0 0 0; border-color: #fff;">
						</a>
					
					<!-- 상품명 -->
					<div class="product_title">
						<h1 style="font-weight:lighte">${list.product_name}</h1>
						<br>
					</div>
					
					<!-- 상품가격 -->
					<div class="product_price">
						<fmt:formatNumber  value="${list.product_price}" type="number" var="product_price" />
						${product_price }원
					</div>
				</td>
				<c:if test="${i%j == j-1 }">
					</tr>
				</c:if>
				<c:set var="i" value="${i+1 }" />
			</c:forEach>
		</table> 
	</div>
</div>			










</body>
</html>