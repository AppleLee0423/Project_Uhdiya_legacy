<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path}/resources/css/reset.css" />

<link href= "${path}/resources/css/memJ/bootstrap.min.css" rel = "stylesheet">
<link href= "${path}/resources/css/memJ/signin.css" rel="stylesheet">

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>비밀번호 찾기</title>
    
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
        
    </head>
    
      <body class="text-center">
    
    <main class="form-signin">
        <form>
        <div class="sss" style="border: 1px solid black; width: 1200px; height: 400px; margin-left: auto; margin-right: auto; margin-top : 75px;"> 
        <div class = "ni">
            <h1 class="h3 mb-3 fw-normal">비밀번호 찾기</h1>
            <label for="inputName" class="visually-hidden">Name</label>
            <input type="name" id="inputName" class="form-control" placeholder="이름" required>
            <label for="inputEmail" class="visually-hidden">Email</label>
            <input type="Email" id="inputEmail" class="form-control" placeholder="이메일" required>
            <label for="inputPhone" class="visually-hidden">Phone</label>
            <input type="Phone" id="inputPhone" class="form-control" placeholder="휴대폰" required>                   
        </div>
        <button class="w-100 btn btn-lg" style="position: relative; margin: 25px 9px 0 0; padding: 25px 0 0 0; color: #757575; border-top: 1px solid #e9e9e9;" type="submit">비밀번호 찾기</button>    </div>
        </form>
    </main>
    
        
      </body>
    
    </html>