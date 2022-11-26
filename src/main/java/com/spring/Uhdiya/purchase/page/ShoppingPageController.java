package com.spring.Uhdiya.purchase.page;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ShoppingPageController {
	String id="dayeun"; //임시 아이디
	
	@RequestMapping("/shopping")
	public String shoppingForm(HttpServletRequest request, HttpServletResponse response) {
		
		return "purchase/purchsePage";
	}//shoppingList
	

}//class
