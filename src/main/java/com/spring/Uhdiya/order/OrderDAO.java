package com.spring.Uhdiya.order;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.Uhdiya.cart.CartListDTO;
import com.spring.Uhdiya.product.ProductDTO;


@Repository
public class OrderDAO {
	@Autowired SqlSession sqlSession;
	
	//주문서 작성단계
	public int addOrder(Map orderMap) {
		int result = sqlSession.insert("mapper.order.addOrder", orderMap);
		return result;
	}
	//상품수량조회
	public int countQty(Map qtyMap) {
		int qty = sqlSession.selectOne("mapper.order.countQty",qtyMap);
		return qty;
	}
	// 주문서작성페이지
	public List<OrderDTO> onOrder(Map search) {
		List<OrderDTO> onOrdersList = (ArrayList)sqlSession.selectList("mapper.order.onOrder",search);
		return onOrdersList;
	}
	// 주문하려는 품목 수 카운트
	public int onOrderCnt(String member_id) {
		int total = sqlSession.selectOne("mapper.order.onOrderCnt",member_id);
		return total;
	}
	// 마지막 주문서 아이디 조회
	public String lastOrderId(String member_id) {
		System.out.println("dao들어옴 주문서아이디조회");
		String lastOrderId = sqlSession.selectOne("mapper.order.lastOrderId",member_id);
		System.out.println(lastOrderId+"dao 에서");
		return lastOrderId;
	}
	// 주문서페이지에서 상품삭제
	public int del(Map delMap) {
		int result = sqlSession.delete("mapper.order.del",delMap);
		return result;
	}
	// 회원정보에서 주소 조회
	public OrderAddressDTO getAddress(String member_id) {
		OrderAddressDTO orderAddress = (OrderAddressDTO) sqlSession.selectOne("mapper.order.getAddress",member_id);
		return orderAddress;
	}
	//새로운주문서 작성시에 기존 주문서기록 삭제
	public int delOrder(String member_id) {
		int delOrder = sqlSession.delete("mapper.order.delOrder",member_id);
		return delOrder;
	}
	//결제하기처리
	public int payNow1(Map<String, Object> orderInfo) {
		int result1 = sqlSession.insert("mapper.order.payNow1", orderInfo);
		return result1;
	}
	public int payNow2(Map<String, Object> orderInfo) {
		int result2 = sqlSession.insert("mapper.order.payNow2", orderInfo);
		return result2;
	}
	public int payNow3(Map<String, Object> orderInfo) {
		int result3 = sqlSession.update("mapper.order.payNow3", orderInfo);
		return result3;
	}
	public int payNow4(Map<String, Object> orderInfo) {
		int result4 = sqlSession.delete("mapper.order.payNow4", orderInfo);
		return result4;
	}
	//결제정보 리스트
	public List<OrderDTO> onOrder(String member_id) {
		List<OrderDTO> orderList = (ArrayList)sqlSession.selectList("mapper.order.orderList",member_id);
		return orderList;
	}
	public List<OrderCntDTO> cntInOrder(String member_id) {
		List<OrderCntDTO> cntList = (ArrayList)sqlSession.selectList("mapper.order.cntInOrder",member_id);
		return cntList;
	}
	//주문번호에 해당하는 총 결제금액 조회
	public String paidTotal(String order_id) {
		String paidTotal = (String)sqlSession.selectOne("mapper.order.paidTotal",order_id);
		return paidTotal;
	}
	// 배송정보,결제정보 조회 모든 값 조회
	public OrderDetailDTO detail(String order_id) {
		OrderDetailDTO detailDTO = (OrderDetailDTO)sqlSession.selectOne("mapper.order.detail",order_id);
		return detailDTO;
	}

	
	
	
	
	
//	public List<CartListDTO> cartList(String member_id) {
//		System.out.println(member_id);
//		List<CartListDTO> cartList = (ArrayList)sqlSession.selectList("mapper.cart.cartList",member_id);
//		return cartList;
//	}
	

	
}
