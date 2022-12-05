package com.spring.Uhdiya.order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.Uhdiya.product.ProductDTO;

@Service
public class OrderService {
	@Autowired OrderDAO orderDAO;

	//주문서 작성단계
	public int addOrder(Map orderMap) {
		int result = orderDAO.addOrder(orderMap);
		return result;
	}
	//상품수량조회
	public int countQty(Map qtyMap) {
		int qty = orderDAO.countQty(qtyMap);
		return qty;
	}
	//주문서리스트
	public Map<String, List<OrderDTO>> onOrder(Map search) {
		Map onOrdersMap = new HashMap();
		List<OrderDTO> onOrdersList = orderDAO.onOrder(search);
		onOrdersMap.put("onOrdersList", onOrdersList);
		return onOrdersMap;
	}
	//상품수조회
	public int onOrderCnt(String member_id) {
		int total = orderDAO.onOrderCnt(member_id);
		return total;
	}
	//가장최근 주문서아이디 조회
	public String lastOrderId(String member_id) {
		String lastOrderId = orderDAO.lastOrderId(member_id);
		return lastOrderId;
	}
	//삭제
	public int del(Map delMap) {
		int result = orderDAO.del(delMap);
		return result;
	}
	//회원정보주소가져오기
	public OrderAddressDTO getAddress(String member_id) {
		OrderAddressDTO orderAddress = orderDAO.getAddress(member_id);
		return orderAddress;
	}
	//주문서작성넘어갈때 기존주문서 초기화
	public int delOrder(String member_id) {
		int delResult = orderDAO.delOrder(member_id);
		return delResult;
	}
	//결제하기처리
	public int payNow1(Map<String, Object> orderInfo) {
		int result1 = orderDAO.payNow1(orderInfo);
		return result1;
	}
	public int payNow2(Map<String, Object> orderInfo) {
		int result2 = orderDAO.payNow2(orderInfo);
		return result2;
	}
	public int payNow3(Map<String, Object> orderInfo) {
		int result3 = orderDAO.payNow3(orderInfo);
		return result3;
	}
	public int payNow4(Map<String, Object> orderInfo) {
		int result4 = orderDAO.payNow4(orderInfo);
		return result4;
	}
	//결제정보리스트
	public Map<String, List<OrderListDTO>> orderList(String member_id) {
		Map ordersMap = new HashMap();
		List<OrderDTO> ordersList = orderDAO.onOrder(member_id);
		ordersMap.put("ordersList", ordersList);
		return ordersMap;
	}
	public Map<String, List<OrderCntDTO>> cntInOrder(String member_id) {
		Map cntMap = new HashMap();
		List<OrderCntDTO> cntList = orderDAO.cntInOrder(member_id);
		cntMap.put("cntList", cntList);
		return cntMap;
	}
	public String paidTotal(String order_id) {
		String paidTotal = orderDAO.paidTotal(order_id);
		return paidTotal;
	}
	public OrderDetailDTO detail(String order_id) {
		OrderDetailDTO detailDTO = orderDAO.detail(order_id);
		return detailDTO;
	}



	


}