package com.spring.Uhdiya.memJ;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/memJ/**")
public class MemJController {
//	@Autowired MemJService memJService;
	

	//  http://localhost:8080/Uhdiya/memJ/loginJ
	@RequestMapping("loginJ")
	public ModelAndView loginJ(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	//  http://localhost:8080/Uhdiya/memJ/memberFormJ
	@RequestMapping("memberFormJ")
	public ModelAndView memberFormJ(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	//  http://localhost:8080/Uhdiya/memJ/find_id
	@RequestMapping("find_id")
	public ModelAndView find_id(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	//  http://localhost:8080/Uhdiya/memJ/find_pw
	@RequestMapping("find_pw")
	public ModelAndView find_pw(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}

}