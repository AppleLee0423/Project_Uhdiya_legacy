<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>회원정보 수정처리</title>
<style type="text/css">
.memBox {
	text-align: center;
	margin: 100px auto;
}

.mainbt {
	width: 150px;
	height: 40px;
	font-size: 16px;
}
</style>
</head>
<body>



	<br>
	<br>
	<div class="memBox">
		<div>
			<font size="5" color="gray">회원정보가 수정되었습니다.</font> <br> <br>
			<br> <input class="mainbt" type="button" value="메인으로"
				onclick="javascript:window.location='MainForm.jsp'" />
		</div>
	</div>
</body>
</html>
