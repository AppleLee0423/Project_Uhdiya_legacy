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
	border: 2px solid black;
	padding: 10px;
	margin: auto;
	text-align: center;
}
</style>
<link rel="stylesheet" href="${path}/resources/css/reset.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
	<div class="div" style="margin-top: 75px; min-height: 200px;"
		align="center">
		<form id="frm" method="post" action="${path }/mem/modMem">
			<table width="800">
				<tr height="40">
					<td align="center" ><b>
					<font size="5" color="black">[회원정보 수정]</font></b></td>
				</tr>
			</table>
			<table width="700" height="600" cellpadding="0"
				style="border-collapse: collapse; font-size: 9pt;">
				<tr class="register" height="30">
					<td width="5%" align="center">*</td>
					<td width="15%">회원 ID</td>
					<td><input type="text" id="member_id" name="member_id" />&nbsp;
						<button type="button" onclick="checkId();" id="idcheck" value="N">중복확인</button>

					</td>
				</tr>
				<tr height="7">
					<td colspan="3"><hr /></td>
				</tr>

				<tr class="register" height="30">
					<td width="5%" align="center">*</td>
					<td width="15%">비밀번호</td>
					<td><input type="password" name="member_password"
						id="member_password" onchange="checkPw()" /> &nbsp;(영문
						소문자/숫자/특수문자 조합, 6자~16자)</td>
				</tr>
				<tr height="7">
					<td colspan="3"><hr /></td>
				</tr>
				<tr class="register" height="30">
					<td width="5%" align="center">*</td>
					<td width="15%">비밀번호 확인</td>
					<td><input type="password" name="member_password2"
						id="member_password2" onchange="check_pwd()" /> <a href="#"
						onclick="checkPw()">확인</a></td>
				</tr>
				<tr height="7">
					<td colspan="3"><hr /></td>
				</tr>
				<tr class="register" height="30">
					<td width="5%" align="center">*</td>
					<td width="15%">이 름</td>
					<td><input type="text" name="member_name" /></td>
				</tr>
				<tr height="7">
					<td colspan="3"><hr /></td>
				</tr>
				<tr class="register" height="30">
					<td width="5%" align="center">*</td>
					<td width="15%">휴대전화</td>
					<td><select name="member_phone">
							<option value="" selected="selected">선택</option>
							<option value="010">010</option>
					</select> &nbsp;-&nbsp; <input type="text" name="member_phone1" size="4"
						maxlength="4"> &nbsp;-&nbsp; <input type="text"
						name="member_phone2" size="4" maxlength="4"></td>

				</tr>
				<tr height="7">
					<td colspan="3"><hr /></td>
				</tr>
				<tr class="register" height="30">
					<td width="5%" align="center">*</td>
					<td width="15%">이메일</td>
					<td><input type="email" name="member_email" /></td>
				</tr>
				<tr height="7">
					<td colspan="3"><hr /></td>
				</tr>
				<tr>
					<td width="5%" align="center">*</td>
					<td width="15%">주 소</td>
					<td><input type="text" size="10" name="zipno"
						id="sample4_postcode" placeholder="우편번호" readonly="readonly"
						onclick="DaumPostcode()"> <input type="button"
						onclick="execution_daum_address()" value="우편번호 찾기"><br>
						<br /> <input type="text" size="30" name="roadFullAddr"
						id="sample4_roadAddress" placeholder="도로명주소" readonly="readonly"
						onclick="DaumPostcode()"> <input type="text" size="30"
						name="roadFullAddr" id="sample4_jibunAddress" placeholder="지번주소"
						readonly="readonly" onclick="DaumPostcode()"> <br /> <span
						id="guide" style="color: #999; font-size: 10px;"></span> <br /> <br />
						<input type="text" name="addDetail" id="sample4_detailAddress"
						placeholder="나머지 주소" size="70" /></td>
				</tr>
			</table>
			
			<input class="check" type="button" value="확인"
				onclick="javascript:window.location='modmemPro'"/>
				<input class="back" type="button" value="취소"
				onclick="javascript:window.location='MainForm'"/>
				
		</form>
	</div>
</body>
</html>