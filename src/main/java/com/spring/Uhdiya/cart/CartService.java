package com.spring.Uhdiya.cart;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.Uhdiya.product.ProductDTO;

@Service
public class CartService {
	@Autowired CartDAO cartDAO;

	// 장바구니 추가
	public int addCart(CartDTO cart) {
		int result = cartDAO.addCart(cart);
		return result;
	}
	// 장바구니 리스트
	public Map cartList(String member_id) {
		System.out.println(member_id);
		Map cartsMap = new HashMap();
		List<CartListDTO> cartList = cartDAO.cartList(member_id);
		cartsMap.put("cartList", cartList);
		return cartsMap;
	}
	// 장바구니 품목숫자
	public int cartListCount(String member_id) {
		int cartListCount = cartDAO.cartListCount(member_id);
		return cartListCount;
	}
	//장바구니 삭제
	public int del(Map delMap) {
		int result = cartDAO.del(delMap);
		return result;
	}
	//장바구니 중복체크
	public int cartSameCode(CartDTO cart) {
		int cnt = cartDAO.cartSameCode(cart);
		return cnt;
	}
	// 장바구니 수량변경
	public int qtyChange(Map cartMap) {
		int result = cartDAO.qtyChange(cartMap);
		return result;
	}
	


}