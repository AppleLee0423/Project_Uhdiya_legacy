<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path}/resources/css/reset.css" />
<link rel="stylesheet" href="${path}/resources/css/mypage.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <div class="mypageAll">
        <div class="container">
            <div id="contents">
                <div class="first">
                    <h2>마이 쇼핑</h2>
                </div>
                <div class="second">
                    <div class="second2">
                        <div class="second3">
                            <p class="thumbnail">
                                <img src="${path}/resources/img/member_default.gif" />
                            </p>
                            <div class="description">
                                <span>오늘도 고생이 많군요</span>
                                <strong class="txtem">${sessionScope.member.member_id} 님!!</strong>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="between">
                    <button onclick="location.href='${path}/product/modProductList';">
                        <p>📃</p>
                        <h2>Product</h2>
                        <h3>상품 관리</h3>
                        <h4>고개님께서 구매하신 상품의 주문내역을 확인하실 수 있습니다.</h4>
                    </button>
                    <button onclick="location.href='${path}/member/member_list';">
                        <p>😄</p>
                        <h2>Profile</h2>
                        <h3>회원 관리</h3>
                        <h4>정우정우정우정우정우</h4>
                    </button>
                    <button>
                        <p>🛒</p>
                        <h2>Basket</h2>
                        <h3>장바구니</h3>
                        <h4>장바구니에 등록하신 상품의 목록을 보여드립니다.</h4>
                    </button>
                    <button onclick="location.href='${path}/board/qna_list';">
                        <p>📬</p>
                        <h2>Questions</h2>
                        <h3>문의내역 관리</h3>
                        <h4>안 이뻐요.</h4>
                    </button>
                    <button onclick="location.href='${path}/board/review_list';">
                        <p>✍</p>
                        <h2>Review</h2>
                        <h3>리뷰 관리</h3>
                        <h4>안 이뻐요.</h4>
                    </button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>