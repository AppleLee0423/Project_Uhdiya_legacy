<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<html>
<head>
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
	width: 320px;
	height: 50px;
	margin: 0 auto;
	background-color: #DB712D;
}

</style>

<script type="text/javascript">
        // 비밀번호 미입력시 경고창
        function checkValue(){
            if(!document.deleteform.password.value){
                alert("비밀번호를 입력 해주세요.");
                return false;
            }
        }
    </script>
</head>

<body>

	<form name="deleteform" method="post"
		action="MainForm.jsp?contentPage=member/pro/DeletePro.jsp"
		onsubmit="return checkValue()">
		<div class="deletePage">
			<br>
			<br>
			<div class="deleteText">
				<b><font size="6" color="gray">회원탈퇴</font></b> <br>
				<br>
				<br>
				<table class="pwd">
					<tr>
						<td>비밀번호 :</td>
						<td><input class="txt" type="password" name="password"
							maxlength="50"></td>
							
					</tr>
				</table>

				<br> <input type="submit" value="확인">
				<input type="button" value="취소" onclick="javascript:window.location='modmemPro.jsp'"> 
				
			</div>
		</div>
	</form>
</body>
</html>