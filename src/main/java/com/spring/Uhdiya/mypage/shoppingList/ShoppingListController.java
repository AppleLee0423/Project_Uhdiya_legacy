package com.spring.Uhdiya.mypage.shoppingList;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ShoppingListController {
  
	@RequestMapping("/mypage/shoppingList")
	public String shoppingList() {
		
		return "mypage/shoppingList";
	}//shoppingList
}//class
