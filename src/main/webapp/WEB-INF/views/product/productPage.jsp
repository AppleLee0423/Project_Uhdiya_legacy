<%-- <%@page import="com.spring.Uhdiya.mypage.shoppingList.ShoppingListDomain"%> --%>
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
</head>
<body>
	<div id="wrapper">
        <div id="header">
	        <c:import url="../common/header.jsp" />
        </div> <!-- header  -->	
		<div id="orderListSelectDiv">
			<button type="button" onclick="location.href='http://localhost:8080/Uhdiya/purchase?product_num=<%=1 %>'">바로구매</button>
			<button type="button" onclick="location.href='http://localhost:8080/Uhdiya/mypage/basket?product_num=<%=1 %>'">장바구니</button>
		</div>
		<div>
	        <c:import url="../common/footer.jsp" />
        </div> <!-- footer  -->
   </div> <!-- wrapper  -->
</html>