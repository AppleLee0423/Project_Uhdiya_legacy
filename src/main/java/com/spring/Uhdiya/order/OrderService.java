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

	public int countQty(Map qtyMap) {
		int qty = orderDAO.countQty(qtyMap);
		return qty;
	}



	


}