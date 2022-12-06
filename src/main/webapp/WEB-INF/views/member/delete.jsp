<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="member" value="${member}" />
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<title>회원탈퇴 화면</title>

<style type="text/css">
/*         table{
            margin-left:auto; 
            margin-right:auto;
            border:3px solid skyblue;
        } */
td {
	border: 1px solid skyblue
}

#title {
	background-color: skyblue
}

.deletePage {
	width: 1200px;
	margin: 70px auto;
}

.deleteText {
	text-align: center;
	width: 800px;
	margin: 0 auto;
}

.txt {
	width: 200px;
	height: 20px;
	margin: 20px auto;
}

.pwd {
	width: 400px;
	height: 50px;
	margin: 0 auto;
	background-color: #DB712D;
	color: white;
	text-size: 20px;
}
</style>

<script type="text/javascript">
	// 비밀번호 미입력시 경고창
	function checkValue() {
		if (!document.deleteform.password.value) {
			alert("비밀번호를 입력 해주세요.");
			return false;
		}
	}
	
	function delete_member(member_id){
		var pwd = ${member.member_password};
		var input_pwd = $('input[name=password]').val();
		if(pwd != input_pwd){
			alert('비밀번호가 맞지 않습니다.');
			input_pwd = '';
			$('input[name=password]').focus();
		} else {
			if(confirm('정말로 탈퇴하시겠습니까?')){
				location.href='${path}/member/withdraw?member_id='+member_id;
			} else {
				alert('취소되었습니다.');
				history.back();
			}
		}
	}
</script>
</head>

<body>
	<div class="deletePage">
		<br>
		<div class="deleteText">
			<b><font size="6" color="black">회원탈퇴</font></b> <br> <br>
			<br>
			<table class="pwd">
				<tr>
					<td>비밀번호 :</td>
					<td><input class="txt" type="password" name="password"
						maxlength="50"></td>
				</tr>
			</table>

			<br> <input type="button" onclick="delete_member('${member.member_id}')" value="확인"/> <input
			class="back" type="button" value="취소"
			onclick="history.back()" />

		</div>
	</div>
</body>
</html>