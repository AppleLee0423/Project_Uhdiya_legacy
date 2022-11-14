<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<style>

.mem {
	width: 50%;
	border: 3px solid green;
	padding: 10px;
	margin:auto;
}
.modMem{
	text-align:center;
}
</style>
<link rel="stylesheet" href="../css/reset.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
	<div class="mem">
		<div class="modMem">
			<br>
			<h1>
				<font size="5" color="gray">회원정보 수정</font>
			</h1>
			<br>

			<table>
				<tr>
					<th width="100px" height="50px">비밀번호</th>
					<td width="200px"><input type="text" name="pwd"></td>
				</tr>
				<tr>
					<th height="50px">이름</th>
					<td width="200px"><input type="text" name="name"></td>
				</tr>
				<tr>
					<th height="50px">전화번호</th>
					<td width="200px"><input type="text" name="phone"></td>
				</tr>
				<tr>
					<th height="50px">이메일</th>
					<td width="200px"><input type="text" name="email"></td>
				</tr>
				<tr>
					<th height="50px">주소</th>
					<td width="200px"><input type="text" name="address"></td>
				</tr>
				<tr>
					<td colspan="3" style="text-align: center" height="100px"><input
						type="submit" value="완료"> <input type="reset" value="취소">
					</td>
				</tr>
			</table>

		</div>
	</div>
</body>
</html>