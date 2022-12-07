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
                                <span>저희 쇼핑몰을 이용해 주셔서 감사합니다.</span>
                                <strong class="txtem">${sessionScope.member.member_id} 님 환영합니다.</strong>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="between">
                    <button onclick="location.href='${path}/order/orderList';">
                        <p>📃</p>
                        <h2>Purchase</h2>
                        <h3>구매내역</h3>
                        <h4>고개님께서 구매하신 상품의 주문내역을 확인하실 수 있습니다.</h4>
                    </button>
					<button onclick="location.href='${path}/member/edit_member';">
                        <p>😄</p>
                        <h2>Profile</h2>
                        <h3>회원 정보</h3>
                        <h4>회원이신 고객님의 개인정보를 관리하는 공간입니다.</h4>
                    </button>
                    <button onclick="location.href='${path}/cart/cartList';">
                        <p>🛒</p>
                        <h2>Basket</h2>
                        <h3>장바구니</h3>
                        <h4>장바구니에 등록하신 상품의 목록을 보여드립니다.</h4>
                    </button>
                    <button onclick="location.href='${path}/board/qna_my';">
                        <p>📬</p>
                        <h2>Questions</h2>
                        <h3>문의 내역</h3>
                        <h4>고객님께서 작성하신 게시물을 관리하는 공간입니다.</h4>
                    </button>
                    <button onclick="location.href='${path}/board/review_my';">
                        <p>✍</p>
                        <h2>Review</h2>
                        <h3>리뷰 목록</h3>
                        <h4>고객님께서 작성하신 리뷰를 관리하는 공간입니다.</h4>
                    </button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>