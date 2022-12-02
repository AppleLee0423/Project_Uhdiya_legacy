package com.spring.Uhdiya.cart;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.Uhdiya.product.ProductDTO;

@Repository
public class CartDAO {
	@Autowired SqlSession sqlSession;

	//장바구니추가
	public int addCart(CartDTO cart) {
		int result = sqlSession.insert("mapper.cart.addCart", cart);
		return result;
	}
	//장바구니리스트
	public List<CartListDTO> cartList(String member_id) {
		System.out.println(member_id);
		List<CartListDTO> cartList = (ArrayList)sqlSession.selectList("mapper.cart.cartList",member_id);
		return cartList;
	}
	//장바구니 품목수조회
	public int cartListCount(String member_id) {
		int cartListCount = sqlSession.selectOne("mapper.cart.cartListCount",member_id);
		return cartListCount;
	}
	//장바구니 삭제
	public int del(Map delMap) {
		int result = sqlSession.delete("mapper.cart.del",delMap);
		return result;
	}
	//장바구니 중복체크
	public int cartSameCode(CartDTO cart) {
		int cnt = sqlSession.selectOne("mapper.cart.cartSameCode",cart);
		return cnt;
	}
	// 장바구니 수량변경
	public int qtyChange(Map cartMap) {
		int result = sqlSession.update("mapper.cart.qtyChange",cartMap);
		return result;
	}
	

}