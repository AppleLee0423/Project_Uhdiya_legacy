package com.spring.Uhdiya.mypage.shoppingList;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;


public class ShoppingListDAO {

	
	private static ShoppingListDAO slDAO;
	
	//생성자
	private ShoppingListDAO() {
		
	}//ShoppingListDAO
	
	public static ShoppingListDAO getInstance() {
		if(slDAO == null) {
			slDAO=new ShoppingListDAO(); //무조건 객체가 만들어지도록
		}//end if
		return slDAO;
	}//getInstance
	
	//주문내역을 db에서 select로 조회한다
	public List<ShoppingListDomain> selectShoppingList(DaySearchVO daySearchVO){
		List<ShoppingListDomain> sld=new ArrayList<ShoppingListDomain>();
		//SQL
		SqlSession ss=ShoppingListHandler.getInstance().getSqlSession();
		sld=ss.selectList("com.spring.Uhdiya.mypage.shoppingList.selectOrderList", daySearchVO);
		
		return sld;
	}//selectShoppingList
	
	//주문내역 상세보기를 db에서 select로 조회한다
	public ShoppingListDomain selectDetail(DetailSearchVO detailSearchVO){
		ShoppingListDomain sld=new ShoppingListDomain();
		//SQL
		SqlSession ss=ShoppingListHandler.getInstance().getSqlSession();
		sld=ss.selectOne("com.spring.Uhdiya.mypage.shoppingList.detail", detailSearchVO);
		
		return sld;
	}//selectDetail
	
}//class