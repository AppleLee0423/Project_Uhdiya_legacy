package com.spring.Uhdiya.order;

import java.io.File;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.Uhdiya.common.interceptor.ViewNameInterceptor;
import com.spring.Uhdiya.member.MemberDTO;
import com.spring.Uhdiya.product.ProductDTO;




@Controller
@RequestMapping("/order/**")
public class OrderController {
	
	@Autowired OrderService orderService;
	
	// 주문서작성 리스트페이지
	
	
	
	// 장바구니에서 주문추가 (주문서작성단계)
	@RequestMapping(value="/addOrder" ,  method =RequestMethod.POST )
	public void addOrder(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam("member_id")  String member_id,
			@RequestParam("product_code[]") List<String> product_code	
			) throws Exception{
		//시리얼생성
		Date date = new Date(System.currentTimeMillis());
		SimpleDateFormat date_format = new SimpleDateFormat("yyyyMMddHHmmss"); 
		String serialNum = date_format.format(date) + "-" + member_id ;  
		System.out.println(serialNum);

		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		System.out.println("아이디 : "+ member_id);
		
		Map orderMap = new HashMap();
		orderMap.put("order_id", serialNum);
		orderMap.put("member_id", member_id);
		
		for(String i : product_code) {
			System.out.println(i);
			orderMap.put("product_code",i);
			
			//해당품목의 수량 조회
			Map qtyMap = new HashMap();
			qtyMap.put("member_id", member_id);
			qtyMap.put("product_code", i);
			
			System.out.println(qtyMap.get("product_code"));
			
			int qty = orderService.countQty(qtyMap);
			
			System.out.println("조회해온값"+qty);
			
			orderMap.put("order_qty", qty);
			int result = orderService.addOrder(orderMap);
			
			System.out.println(result);
		}
		//return mav;  addOrderDirect
	}
	// 상품디테일에서 바로구매 (주문서작성단계)
	@RequestMapping(value="/addOrderDirect" ,  method =RequestMethod.POST )
	public void addOrderDirect(
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam("member_id")  String member_id,
			@RequestParam("product_code") String product_code,	
			@RequestParam("order_qty") int order_qty			
			) throws Exception{
		//시리얼생성
		Date date = new Date(System.currentTimeMillis());
		SimpleDateFormat date_format = new SimpleDateFormat("yyyyMMddHHmmss"); 
		String serialNum = date_format.format(date) + "-" + member_id ;  
		
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		Map orderMap = new HashMap();
		orderMap.put("order_id", serialNum);
		orderMap.put("member_id", member_id);
		orderMap.put("product_code",product_code);
		orderMap.put("order_qty", order_qty);
		
		System.out.println(serialNum);
		System.out.println(member_id);
		System.out.println(product_code);
		System.out.println(order_qty);
		
		
		int result = orderService.addOrder(orderMap);
		System.out.println(result);
	
		//return mav;  addOrderDirect
	}

	
	
	
	
	
	
	


}