
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
}