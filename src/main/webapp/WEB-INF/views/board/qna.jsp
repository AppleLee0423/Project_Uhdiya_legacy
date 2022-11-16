<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../css/reset.css" />
<link rel="stylesheet" href="../css/qna.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
	<div class="qna">
		<div class="qna_header">
			<div class="qna_header_title"><b>QnA</b></div>
			<div class="qna_count">총 2건</div>
		</div>
		<div class="qna_body">
			<ul>
				<li>
					<details>
						<summary>
							<span class="qna_q_num">1</span>
							<span class="qna_q_title">문의드립니다.</span>
							<span class="qna_q_writer">hong</span>
							<span class="qna_q_writeDate">2022-11-13</span>
							<span class="qna_q_state">답변완료</span>
							<span class="qna_q_delete"><button onclick="">삭제</button></span>
						</summary>
							<span class="qna_content">도대체 왜 안 되는걸까요?</span>
							<div class="qna_a">
								<span class="answer_tag">답변</span>
								<span class="qna_a_content">그걸 알면 제가 학원을 다닐까요?</span>
								<span class="qna_a_writer">관리자</span>
								<span class="qna_a_writeDate">2022-11-14</span>
								<span class="qna_q_delete"><button onclick="">삭제</button></span>
							</div>
					</details>
				</li>
				<li>
					<details>
						<summary>
							<span class="qna_q_num">2</span>
							<span class="qna_q_title">질문이요</span>
							<span class="qna_q_writer">leeleeleelee</span>
							<span class="qna_q_writeDate">2022-11-14</span>
							<span class="qna_q_state" style="text-decoration: underline;"><a href="#">답변대기</a></span>
							<span class="qna_q_delete"><button onclick="">삭제</button></span>
						</summary>
							<span class="qna_content">남자친구 있어요?</span>
							<!-- <div class="qna_a">
								<span class="answer_tag"></span>
								<span class="qna_a_content"></span>
								<span class="qna_a_writer"></span>
								<span class="qna_a_writeDate"></span>
							</div> -->
					</details>
				</li>
			</ul>
		</div>
		<div class="qna_paging">
				<a href="#" class="prev"><i class="fa-solid fa-angle-left"></i></a>
				<a href="#" class="page1">1</a>
				<a href="#" class="next"><i class="fa-solid fa-angle-right"></i></a>
		</div>
		<div class="qna_search">
			<input type="text" name="qna_search" id="search_box"/>
			<button id="search_button">검색</button>
		</div>
	</div>
</body>
</html>