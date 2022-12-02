package com.spring.Uhdiya.order;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.Uhdiya.cart.CartListDTO;


@Repository
public class OrderDAO {
	@Autowired SqlSession sqlSession;
	
	//주문서 작성단계
	public int addOrder(Map orderMap) {
		int result = sqlSession.insert("mapper.order.addOrder", orderMap);
		return result;
	}

	public int countQty(Map qtyMap) {
		int qty = sqlSession.selectOne("mapper.order.countQty",qtyMap);
		return qty;
	}

	
//	public List<CartListDTO> cartList(String member_id) {
//		System.out.println(member_id);
//		List<CartListDTO> cartList = (ArrayList)sqlSession.selectList("mapper.cart.cartList",member_id);
//		return cartList;
//	}
	
}
