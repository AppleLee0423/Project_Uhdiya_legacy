package com.spring.Uhdiya;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.Uhdiya.product.ProductService;

@Controller
public class HomeController {
	
	@Autowired ProductService productService;
//	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	// localhost:8080/Uhdiya/
	@RequestMapping(value = {"/","/main"})
	public ModelAndView main(Locale locale, Model model
			) throws Exception{
		ModelAndView mav = new ModelAndView();
		String cateL = "커피";
		
		Map productsMap = productService.listMain(cateL);
		mav.addObject("productsMap", productsMap);
		
		Map productsMap3 = productService.listMainDesc(cateL);
		mav.addObject("productsMap3", productsMap3);
		
		cateL="스틱커피";
		Map productsMap2 = productService.listMain(cateL);
		mav.addObject("productsMap2", productsMap2);
		
		mav.setViewName("main");	
		return mav;
	}
	
	// About us
	@RequestMapping(value="/about")
	public String about(Locale local, Model model) {
		return "about";
	}
	
	// 회원 마이페이지
	@RequestMapping(value="/mypage")
	public String mypage(Locale local, Model model) {
		return "mypage";
	}
	
	// 관리자 페이지
	@RequestMapping(value="/adminpage")
	public String adminpage(Locale local, Model model) {
		return "adminpage";
	}
}