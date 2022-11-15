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
<link rel="stylesheet" href="${path } /resources/css/main.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
	.cate {
		font-weight:bold;
		text-align:center;
		font-size: small;
    	color: rgb(56, 54, 54);
	}
	.products_info {
		margin: 0 auto;
		padding: 2px;
		text-align: center;
    	width: 1260px;
	}
 	.products {
 		border:"2";
		margin: 100px auto;
		position: static;
	} 
	.product {
		 padding:0 2px 100px 2px;
		 width:315px;
		 height:350px;
	}
	.product_title {
		text-align:left;
		font-size: small;
	}
	.product_price {
		font-size: small;
		font-weight:bold;
		color: lightblue;
		text-align:left;
		padding-left: 2px;
		color: #008BCC;
	}
	.cnt {
		font-size: small;
		text-align:left;
	}
	.orderBy {
		text-align:right;
	}
	.orderBy_choose {
		font-size: small;
		display:inline;
	}
</style>


</head>
<body>
	
 	<table class="products_info">
		<tr>
			<td class="cate" colspan="4">
			<br><br><br><br>
			<h1>소분류명(ex:홀빈원두)</h1>
			</td>
		</tr>
		<tr>
			<td colspan="4" >
				<div class="cnt">TOTAL : 5 items</div>
				<ul class="orderBy">
					<li class="orderBy_choose"><a href="#">높은가격순</a></li>
					<li class="orderBy_choose"><a href="#">낮은가격순</a></li>
				</ul>
				<hr>
			</td>
		</tr>
	</table>	
			
			
			
			
			
	<c:set var="i" value="0" />
	<c:set var="j" value="4" /> 
	<c:set var="productsList" value="${productsMap.test }" />
	
	<!-- // 이 테이블을 주석하면 에러가안나는데 주석을 풀면 에러가나요 -->
 	<table class="products">

		<c:forEach items="${productsMap.test }" var="list">

			<c:if test="${i%j == 0 }"> 
				<tr>
			</c:if>

			<td class="product">
				<img width="305" height="305"
				src="/Uhdiya/resources/img/product/${list.product_fileName }"> <span><hr style="border-width:1px 0 0 0; border-color:#fff;"> </span>
				<div class="product_title">
					<h1>${list.product_name}</h1>
					<br>
				</div>
				<div class="product_price">
					<h1>${list.product_price}</h1>
				</div>
			</td>

			<c:if test="${i%j == j-1 }">
				</tr>
			</c:if>

			<c:set var="i" value="${i+1 }" />

		</c:forEach>
	</table> 
<!--  -->











</body>
</html>