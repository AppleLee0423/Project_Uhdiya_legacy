package com.spring.Uhdiya.mypage.shoppingList;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ShoppingListController {
  
	@RequestMapping("/mypage/shoppingList")
	public String shoppingList(HttpServletRequest request, HttpServletResponse response) {
		
		String day=request.getParameter("day");
		//day파라미터가 없는 경우
		if( day == null || day.equals("") || day.equals("null") ){
			
		//day파라미터가 있는 경우
		}else {
			
		}//end else
		
		return "mypage/shoppingList";
	}//shoppingList
	
	public List<ShoppingListDTO> findShoppingList() {
		List<ShoppingListDTO> slDTO=new ArrayList<ShoppingListDTO>();
		
		return slDTO;
	}//findShoppingList
}//class
