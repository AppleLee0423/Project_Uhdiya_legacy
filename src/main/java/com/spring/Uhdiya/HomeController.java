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
	
	// 임시로 설정해놓음
	@RequestMapping(value="/about")
	public String about(Locale local, Model model) {
		return "about";
	}
	
	// 임시로 설정해놓음
	@RequestMapping(value="/mypage")
	public String mypage(Locale local, Model model) {
		return "mypage";
	}
}