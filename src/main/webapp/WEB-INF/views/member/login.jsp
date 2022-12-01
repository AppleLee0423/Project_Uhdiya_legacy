<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path}/resources/css/reset.css" />

<link href= "${path}/resources/css/member/bootstrap.min.css" rel = "stylesheet">
<link href= "${path}/resources/css/member/signin.css" rel="stylesheet">


<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<c:set var="result" value="${param.result }" />
<c:choose>
	<c:when test ="${result == 'login' }">
		<script>
			window.onload = function(){
				alert('반갑습니다!.');
			}
		</script>
	</c:when>
</c:choose>
<style>
      .bd-placeholder-img{
       font-size: 1.125rem;
       text-anchor: middle;
       -webkit-user-select: none;
       user-select: none;
   }
   
   @media (min-width: 768px){
       .bd-placeholder-img-lg {
        font-size: 3.5rem;
       } 
   }
   
   
   ul {
       list-style:none;
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
       margin-top : 50px;
       margin-left: auto;
      margin-right: auto;
   }

   </style>
      <c:set var="result" value="${param.result }" />
      <c:choose>
	  <c:when test="${result == 'loginFailed' }">
		<script>
			window.onload = function(){
				alert('아이디나 비밀번호가 틀립니다. 다시 로그인 하세요!.');
			}
		</script>
	</c:when>
</c:choose>
   
</head>
<body>
<body class="text-center">
	<main class="form-signin">
		<form method="post" action="${path }/member/loginMember" >
			<div class="sss"
				style="border: 1px solid black; width: 1200px; height: 400px; margin-left: auto; margin-right: auto; margin-top: 75px;">
				<div class="ni">
					<h1 class="h3 mb-3 fw-normal">로그인</h1>
					<label for="inputId" class="visually-hidden">ID</label>
					<input type="ID" name="member_id" class="form-control" placeholder="아이디" required autofocus>
					<label for="inputPassword" class="visually-hidden">Password</label> 
					<input type="password" name="member_password" class="form-control" placeholder="비밀번호" required>
					<button class="w-100 btn btn-lg btn-primary" type="submit">
						로그인
					</button>
					<ul>
						<div class="sb">
							<li><a href="find_id">아이디찾기</a></li>
							<li><a href="find_pw">비밀번호찾기</a></li>
							<li><a href="memberForm">회원가입</a></li>
						</div>
					</ul>
				</div>
				<button class="w-100 btn btn-lg" style="position: relative; margin: 25px 9px 0 0; padding: 25px 0 0 0; color: #757575; border-top: 1px solid #e9e9e9;" type="submit">
					회원가입
				</button>
			</div>
		</form>
	</main>


</body>
</body>
</html>