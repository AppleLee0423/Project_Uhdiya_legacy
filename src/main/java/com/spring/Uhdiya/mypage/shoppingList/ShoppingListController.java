package com.spring.Uhdiya.mypage.shoppingList;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ShoppingListController {
	String id="dayeun"; //임시 아이디
	
	@RequestMapping("/mypage/shoppingList")
	public String shoppingList(HttpServletRequest request, HttpServletResponse response, Model model) {

		//Service 생성
		ShoppingListService sls=new ShoppingListService();
		
		String day=request.getParameter("day");
		//day파라미터가 없는 경우
		if( day == null || day.equals("") || day.equals("null") ){
			day="all"; //자동으로 전체보기를 띄운다
		}//end if
		
		//주문내역을 구한다
		List<ShoppingListDomain> sldList=new ArrayList<ShoppingListDomain>();
		sldList=sls.searchShoppingList(day, id);
		
		//System.out.println("컨트롤러:"+sldList.get(0).getMember_id());
		//model에 저장
		model.addAttribute("order_list", sldList);
		return "mypage/shoppingList";
	}//shoppingList
	
	//detail
	
	@RequestMapping("mypage/shoppingList/detail")
	public String detail(HttpServletRequest request, HttpServletResponse response, Model model){
		//Service 생성
		ShoppingListService sls=new ShoppingListService();
		//주문번호 받기
		String order_num=request.getParameter("order_num");
		
		//상세 주문내역 찾기
		ShoppingListDomain sld=new ShoppingListDomain();
		sld=sls.searchDetail(order_num, id);
        
        //model에 저장
        model.addAttribute("detail", sld);
		return "mypage/shoppingListDetail";
	}//detail

}//class