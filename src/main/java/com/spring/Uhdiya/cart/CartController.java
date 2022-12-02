package com.spring.Uhdiya.cart;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
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
@RequestMapping("/cart/**")
public class CartController {
	
	@Autowired CartService cartService;
	
	// 장바구니 수량변경
	@RequestMapping("/qtyChange")
	@ResponseBody
	public String qtyChange( 
			@RequestParam("sign") String sign,
			@RequestParam("product_code") String product_code,
			@RequestParam("qty")  String qty,
			@RequestParam("member_id")  String member_id	){
		int result = 0;
		String res="";
		int cart_qty = Integer.parseInt(qty);
		
		if(sign.equals("p")) {
			System.out.println("+기호들어옴");
			cart_qty+=1;
		} else if (sign.equals("m")) {
			System.out.println("-기호들어옴");
			cart_qty-=1;
		}
		System.out.println("결과"+cart_qty);
		Map cartMap = new HashMap();
		cartMap.put("cart_qty", cart_qty);
		cartMap.put("member_id", member_id);
		cartMap.put("product_code", product_code);
		
		result = cartService.qtyChange(cartMap);

		if(result>0) {
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
		System.out.println(member_id);
		
		Map delMap = new HashMap();
		delMap.put("member_id", member_id);
		
		System.out.println("selectDel");
		for(String i : selectArr) {
			System.out.println(i);
			delMap.put("product_code", i);
			try {
				result = cartService.del(delMap);
				
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
	
	// 장바구니 한품목 행에서 삭제
	@RequestMapping("/del")
	public void del(
			@RequestParam("product_code") String product_code,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter pw =response.getWriter(); 
		
		HttpSession session = request.getSession();
		MemberDTO member = (MemberDTO) session.getAttribute("member");
//		Map cartsMap=(Map)session.getAttribute("cartsMap");
//		List<CartListDTO> cartList=(List<CartListDTO>)cartsMap.get("cartList");
//		for(int i=0;i<cartList.size();i++) {
//			CartListDTO cartListDTO = cartList.get(i);
//			System.out.println(cartListDTO.getProduct_fileName());
//		}
		Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
		System.out.println("del"+isLogOn);
		if(isLogOn!=null && member!=null) {
			System.out.println("del"+member.getMember_id());
			String member_id =  member.getMember_id();
			Map delMap = new HashMap();
			delMap.put("member_id", member_id);
			delMap.put("product_code", product_code);
			int result = cartService.del(delMap);
			if(result>0) {
				pw.println("<script>");
				pw.println( "alert('상품이 삭제되었습니다.');");
				pw.println("location.href='"+ request.getContextPath() +"/cart/cartList';");
				pw.println("</script>");
			} else {
				pw.println("<script>");
				pw.println( "alert('상품이 삭제되지않았습니다 다시시도해주세요.');");
				pw.println("location.href='"+ request.getContextPath() +"/cart/cartList';");
				pw.println("</script>");
			}
		}
	}
	
	// 장바구니 리스트
	@RequestMapping("/cartList")
	public ModelAndView cartList(
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		HttpSession session = request.getSession();
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
		System.out.println(isLogOn);
		if(isLogOn!=null && member!=null) {
			System.out.println(member.getMember_id());
			String member_id =  member.getMember_id();
			
			Map<String,List<CartListDTO>> cartsMap = cartService.cartList(member_id);
			mav.addObject("cartsMap",cartsMap);
			session.setAttribute("cartsMap", cartsMap);
			
			int cartListCount = cartService.cartListCount(member_id);
			mav.addObject("cartListCount",cartListCount);
		}
		return mav;
	}
	// 장바구니 상품추가
	@RequestMapping("/addCart")
	@ResponseBody
	public String addCart(
			@ModelAttribute("cart") CartDTO cart,
			@RequestParam("member_id") String member_id,
			@RequestParam("product_code") String product_code,
			@RequestParam("cart_qty") int cart_qty)	{
		System.out.println(member_id);
		System.out.println(product_code);
		System.out.println(cart_qty);
		String res = "";
		
		cart.setMember_id(member_id);
		cart.setProduct_code(product_code);
		cart.setCart_qty(cart_qty);
		
		//장바구니 중복체크
		int cnt = cartService.cartSameCode(cart);
		if(cnt>0) {
			res="e";
		} else {
			int result = cartService.addCart(cart);
			if(result>0) {
				System.out.println("성공했다");
				res="y";
			} else {
				res="n";
			}
		}
    	return res;
	}
	
	
	
	
	
	
	
	


}