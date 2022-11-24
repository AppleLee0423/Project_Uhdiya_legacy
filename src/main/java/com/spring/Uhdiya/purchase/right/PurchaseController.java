package com.spring.Uhdiya.purchase.right;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PurchaseController {
	String id="dayeun"; //임시 아이디
	
	//임시 제품 상세 설명 폼
	@RequestMapping("/product")
	public String shoppingForm(HttpServletRequest request, HttpServletResponse response) {
		
		return "product/productPage";
	}//shoppingList
	
	//바로구매창
	@RequestMapping("/purchase")
	public String purchase(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		//바로구매 시 필요한 것
		
		String product_num=request.getParameter("product_num");
		model.addAttribute("product_num", product_num);
		
		
		
		return "purchase/purchaseForm";
	}//purchase
	
	//장바구니 폼
	//로그인 되어 있는 경우 / 되어 있지 않은 경우 모두 테이블에 저장할 것
	@RequestMapping("/mypage/basket")
	public String basket(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		String product_num=request.getParameter("product_num");
		model.addAttribute("product_num", product_num);
		
		
		return "mypage/basket";
	}//purchase
	
	
}//class
