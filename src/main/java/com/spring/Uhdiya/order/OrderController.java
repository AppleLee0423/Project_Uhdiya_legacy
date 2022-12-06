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
import org.springframework.web.bind.annotation.RequestBody;
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
// 주문내역 조회 : http://localhost:8080/Uhdiya/order/orderList 
// 장바구니 조회 : http://localhost:8080/Uhdiya/cart/cartList
// 주문서작성 : http://localhost:8080/Uhdiya/order/onOrder
// 주문상세 : http://localhost:8080/Uhdiya/order/detail (접근시 반드시 주문번호파람필요)
	
	//디테일정보조회
	@RequestMapping(value="/detail" ,method =RequestMethod.POST)
	@ResponseBody
	public ModelAndView detail(
			@RequestParam String order_id,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session = request.getSession();
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		
		Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
		if(isLogOn!=null && member!=null) {
			String member_id = member.getMember_id();
			
		System.out.println(order_id+"가져온값");
		mav.addObject("order_id",order_id);
		
		String paidTotal = orderService.paidTotal(order_id);
		System.out.println(paidTotal);
		mav.addObject("paidTotal",paidTotal);
		
		OrderDetailDTO detail = orderService.detail(order_id);
		System.out.println(detail.getReceiver_name());
		System.out.println(detail.getReceiver_phone());
		mav.addObject("detail",detail);
		
		} else {
			mav.setViewName("redirect:/member/login");
		}
		return mav;
		
		
		
	}
	// 결제정보리스트페이지
	@RequestMapping("/orderList")
	public ModelAndView orderList(
			HttpServletRequest request, HttpServletResponse response
			)throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		HttpSession session = request.getSession();
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		
		Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
		if(isLogOn!=null && member!=null) {
			String member_id = member.getMember_id();
			
			
			// 결제정보 리스트
			Map<String,List<OrderListDTO>> ordersMap=orderService.orderList(member_id);
			mav.addObject("ordersMap", ordersMap);
			// 주문번호별로 합치기위해 주문번호별로 숫자카운트
			Map<String, List<OrderCntDTO>> cntMap = orderService.cntInOrder(member_id);
			mav.addObject("cntMap",cntMap);
			
			
			
			
		} else {
			mav.setViewName("redirect:/member/login");
		}
		return mav;
	}
	//결제하기처리
	@RequestMapping(value="/payNow" ,method =RequestMethod.POST)
	@ResponseBody
	public String payNow(@RequestParam Map<String, Object> orderInfo) throws Exception{
		System.out.println("payNow들어옴");
		String res="";
		String member_id = (String) orderInfo.get("member_id");
		System.out.println(member_id+"가져온값이다.");
		
		//받는분정보,결제정보 저장
		int result1 = orderService.payNow1(orderInfo);
		int result2 = orderService.payNow2(orderInfo);
		//결제테이블 업데이트
		int result3 = orderService.payNow3(orderInfo);
		//장바구니 정보삭제
		int result4 = orderService.payNow4(orderInfo);
		System.out.println(result1+""+result2+""+result3+""+result4);
		if(result1>0&&result2>0&&result3>0) {
			res="y";
		} else {
			res="n";
		}
		return res;
	}
	// 장바구니 선택항목 삭제
	@RequestMapping("/selectDel")
	@ResponseBody
	public String selectDel( 
			@RequestParam("selectArr[]")  List<String> selectArr,
			@RequestParam("member_id")  String member_id ){
		int result = 0;
		String res="";
		
		Map delMap = new HashMap();
		delMap.put("member_id", member_id);
		
		// 가장마지막 주문테이블 구매고유번호 조회
		String lastOrderId = orderService.lastOrderId(member_id);
		delMap.put("order_id", lastOrderId);
		
		for(String i : selectArr) {
			System.out.println(i);
			delMap.put("product_code", i);
			try {
				result = orderService.del(delMap);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if(result>0) {
			res="y";
		} else {
			res="n";
		}
		return res;
	}
	
	// 주문서작성 리스트페이지
	@RequestMapping("/onOrder")
	public ModelAndView onOnder(
			HttpServletRequest request, HttpServletResponse response
			)throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		HttpSession session = request.getSession();
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		
		Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
		if(isLogOn!=null && member!=null) {
			System.out.println("아이디:"+member.getMember_id());
			String member_id = member.getMember_id();
			
			Map search = new HashMap();
			search.put("member_id", member_id);
			
			// 회원정보에서 이메일가져옴
			OrderAddressDTO orderAddress = orderService.getAddress(member_id);
			mav.addObject("memberAddress",orderAddress);
			
			// 주문서 총 상품수
			int total = orderService.onOrderCnt(member_id);
			mav.addObject("total",total);
			
			// 주문서 상품 리스트
			Map<String,List<OrderDTO>> onOrdersMap=orderService.onOrder(search);
			mav.addObject("onOrdersMap", onOrdersMap);
		} else {
			mav.setViewName("redirect:/member/login");
		}
		return mav;
	}
	// 장바구니에서 주문추가 (주문서작성단계)
	@RequestMapping(value="/addOrder" ,  method =RequestMethod.POST )
	public ModelAndView addOrder(
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
		
		//주문서작성시 기존 주문서정보 삭제
		int delResult = orderService.delOrder(member_id);
		System.out.println(delResult+"기존주문서정보삭제결과값");
		
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
			int qty = orderService.countQty(qtyMap);
			
			orderMap.put("order_qty", qty);
			int result = orderService.addOrder(orderMap);
		}
		mav.setViewName("redirect:/order/onOrder");
		return mav;
	}
	// 상품디테일에서 바로구매 (주문서작성단계)
	@RequestMapping(value="/addOrderDirect" ,  method =RequestMethod.POST )
	public ModelAndView addOrderDirect(
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
		
		//주문서작성시 기존 주문서정보 삭제
		int delResult = orderService.delOrder(member_id);
		System.out.println(delResult+"기존주문서정보삭제결과값");
		
		
		
		int result = orderService.addOrder(orderMap);
		System.out.println(result);
	
		mav.setViewName("redirect:/order/onOrder");
		return mav;
	}
}