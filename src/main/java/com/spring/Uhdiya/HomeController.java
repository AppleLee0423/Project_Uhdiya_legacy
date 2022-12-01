package com.spring.Uhdiya;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {	
//	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	// localhost:8080/Uhdiya/
	@RequestMapping(value = {"/","/main"})
	public String main(Locale locale, Model model) {
		return "main";
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