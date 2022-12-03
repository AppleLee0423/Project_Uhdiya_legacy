<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="qna" value="${qnaMap.qnaDTO}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	*{margin:0; padding:0;}
	ul{list-style: none;}
	.reply{width:800px;}
	.reply_header{background-color:#353B4C; height:45px; }
	.reply_header_title{font-size:large; color:white; padding-left:20px; padding-top:10px; text-align: left;}
	.reply_body{padding: 10px;}
	.qna_info{background-color: #F3F4F5; padding: 10px 0;}
	.reply_product_name{padding-bottom: 5px; border-bottom: #8BA3A7; height: 30px; font-weight: bold;}
	.member_qna_content{height:30px; font-size: small;}
	#reply_content{width:100%; margin-top: 10px; resize: none;}
	.reply_info{margin-bottom:20px;}
	.ctrl_btn {text-align: center; display: flex; justify-content: space-between; padding: 0 200px;}
	#reply_insert_btn {width: 150px; height: 50px; border-radius: 2px; background-color: #474948; color: white; font-size: large;}
	#reply_close_btn {width: 150px; height: 50px; border-radius: 1px; background-color: transparent; color: black; border-width: 1px; font-size: large;}
</style>
<script>
	function fn_reply_close(){
		$('.reply_modal').css("display","none");
		$('body').css("overflow","unset");
		$('#reply_content').val('');
	}
	
	function reply_submit(obj){
		let form = document.reply_form;
		let reply_content = $('#reply_content').val();
		if (reply_content == "" || reply_content == null){
			alert('답변이 입력되지 않았습니다.');
			reply_content.select();
			return;
		} else {
			form.action = '${path}/board/addReply';
			form.submit();
			$('body').css("overflow","unset");
		}
	}
</script>
</head>
<body>
	<div class="reply">
		<div class="reply_header">
			<div class="reply_header_title">문의답변</div>
		</div>
		<div class="reply_body">
			<form name="reply_form" action="">
				<ul class="qna_info">
					<li class="reply_product_name"><b>${qna.product_name}</b></li>
					<li class="member_qna_content">${qna.qna_content}</li>
				</ul>
				<ul class="reply_info">
					<li><textarea name="qna_content" id="reply_content" cols="30" rows="15" placeholder="문의에 대한 답변을 입력해주세요."></textarea></li>
				</ul>
				
				<div class="ctrl_btn">
					<input id="reply_close_btn" type="button" onclick="fn_reply_close()" value="취소"/>
					<input id="reply_insert_btn" type="button" onclick="reply_submit(this)" value="등록"/>
					<input type="hidden" name="qna_parentId" value="${qna.qna_id}"/>
				</div>
			</form>
		</div>
	</div>
</body>
</html>