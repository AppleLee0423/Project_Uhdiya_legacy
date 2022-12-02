<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	
	<title>아이디 찾기</title>
	
	<link rel="stylesheet" href="${path}/resources/css/reset.css" />
	<link href="${path}/resources/css/member/bootstrap.min.css" rel="stylesheet">
	<link href="${path}/resources/css/member/signin.css" rel="stylesheet">
	
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
	<script>
		
		function isNull( object ) {
			
			return object == null || object == undefined || !object.trim().length > 0;
		}
		
		function findId() {
			
			var name = $("#inputName").val().trim();
			if( isNull(name) ) {
				alert("이름을 입력하세요");
				$("#inputName").focus();
				return;
			}
			
			var email = $("#inputEmail").val().trim();
			if( isNull(email) ) {
				alert("이메일을 입력하세요");
				$("#inputEmail").focus();
				return;
			}
			
			$.ajax({
				url : '/member/findid',
				type : 'POST',
				data : {
					member_name : name,
					member_email : email
				},
				dataType : "text",
				success : function(data) {
					
					if( !isNull(data) ) {
						$("#form_div").hide();
						$("#result_id").text("회원님의 정보로 등록된 아이디는 : " + data + " 입니다.");
						$("#result_id").show();
					} else {
						alert("일치하는 회원정보가 없습니다.\n정보를 다시 입력해주시길 바랍니다.");
					}
				},
		        error : function(XMLHttpRequest, textStatus, errorThrown) {
		        	alert("정보를 다시 입력해주시길 바랍니다.");
		        }
		    });
		}
		
	</script>
	
	<style>
		.bd-placeholder-img {
			font-size: 1.125rem;
			text-anchor: middle;
			-webkit-user-select: none;
			user-select: none;
		}
		
		@media ( min-width : 768px) {
			.bd-placeholder-img-lg {
				font-size: 3.5rem;
			}
		}
		
		ul {
			list-style: none;
		}
		
		li {
			float: left;
		}
		
		.sb {
			display: table;
			margin-left: auto;
			margin-right: auto;
		}
		
		.ni {
			width: 400px;
			padding: 10px;
			border: 10px;
			margin: 10px;
			margin-top: 50px;
			margin-left: auto;
			margin-right: auto;
		}
	</style>
	
</head>

<body class="text-center">
	<main class="form-signin" style="margin-bottom: 75px;">
		<div class="sss"
			style="border: 1px solid black; width: 1200px; height: 400px; margin-left: auto; margin-right: auto; margin-top: 75px;">
			<div id="form_div" class="ni">
				<h1 class="h3 mb-3 fw-normal">아이디 찾기</h1>
				<label for="inputName" class="visually-hidden">Name</label>
				<input type="text" id="inputName" class="form-control" placeholder="이름" required>
				<label for="inputEmail" class="visually-hidden">Email</label>
				<input type="Email" id="inputEmail" class="form-control" placeholder="이메일" required>
				<button class="w-100 btn btn-lg"
					style="position: relative; margin: 25px 9px 0 0; padding: 25px 0 0 0; color: #757575; border-top: 1px solid #e9e9e9;"
					type="button" onclick="findId()">아이디 찾기</button>
			</div>
			<h1 id="result_id" style="display: none; margin-top: 200px;"></h1>
		</div>
	</main>
</body>

</html>