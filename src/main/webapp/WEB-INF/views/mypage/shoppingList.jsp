<%@page import="com.spring.Uhdiya.mypage.shoppingList.ShoppingListDomain"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path}/resources/css/reset.css" />
<link rel="stylesheet" href="${path}/resources/css/header.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
	<div id="wrapper">
        <div id="header">
	        <c:import url="../common/header.jsp" />
        </div> <!-- header  -->	
		<div id="orderListSelectDiv">
			<button type="button" onclick="location.href='http://localhost:8080/Uhdiya/mypage/shoppingList?day=1'">하루</button>
			<button type="button" onclick="location.href='http://localhost:8080/Uhdiya/mypage/shoppingList?day=7'">일주일</button>
			<button type="button" onclick="location.href='http://localhost:8080/Uhdiya/mypage/shoppingList?day=30'">한달</button>
			<button type="button" onclick="location.href='http://localhost:8080/Uhdiya/mypage/shoppingList?day=90'">세달</button>
			<button type="button" onclick="location.href='http://localhost:8080/Uhdiya/mypage/shoppingList?day=all'">전체</button>
		</div>
		<div id="orderListTableDiv">
			<%
				List<ShoppingListDomain> sldList=(List<ShoppingListDomain>)request.getAttribute("order_list");
			if( sldList != null && sldList.size() != 0  ){
				for( int i=0; i< sldList.size(); i++){
			%>
					  <label style="margin-bottom: 0px; margin-top: 5%">000</label>
					  <hr style="margin-bottom: 3%; margin-top: 0px">
					  <table>
					  <%
					  	sldList.get(i).getOrder_list_num();
					  %>
					  	<tr>
					  		<td colspan="10">
					  		<%  %>
					  		</td>
					  	</tr>
					  	<tr>
					  		<td rowspan="2" style="width: 100px; height: 150px"></td>
					  		<td style="width: 100px; height: 75px">주문번호</td>
					  		<td colspan="6"><%  %></td>
					  		<td rowspan="2" style="text-align: center">
					  			<button type="button" onclick="location.href='http://localhost:8080/Uhdiya/mypage/shoppingList/detail?order_num=<%= sldList.get(i).getOrder_num().trim() %>'">주문상세</button>
					  		</td>
					  	</tr>
					  	<tr>
					  		<td>결제금액</td>
					  		<td colspan="6"><%   %>원</td>
					  	</tr>
					  </table>
					  </form>
					  <%
 				}//end for
			}else{  
				%>
				<table>
				<tr>
					<td>조회된 주문내역이 없습니다.</td>
				</tr>
				</table>
 				<%
			}//end else 
					  %>
	        <c:import url="../common/footer.jsp" />
        </div> <!-- footer  -->
   </div> <!-- wrapper  -->
</html>