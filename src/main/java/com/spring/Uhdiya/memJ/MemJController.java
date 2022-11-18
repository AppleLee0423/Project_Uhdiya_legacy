package com.spring.Uhdiya.memJ;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;



@Controller
@RequestMapping("/memJ/**")
public class MemJController {
	@Autowired MemJService memJService;
	

	//  http://localhost:8080/Uhdiya/memJ/loginJ
	// 로그인
	@RequestMapping("loginJ")
	public ModelAndView loginJ(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	// 로그인처리
	@RequestMapping(value="loginMem", method=RequestMethod.POST)
	public ModelAndView login(@ModelAttribute("memJ") MemJDTO memJ, RedirectAttributes rAttr, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// TODO Auto-generated method stub
		ModelAndView mav = new ModelAndView();
		MemJDTO memJDTO = memJService.login(memJ);
		
		if(memJDTO != null) {
			HttpSession session = request.getSession();
			session.setAttribute("memJ", memJDTO);
			session.setAttribute("isLogOn", true);
			mav.setViewName("redirect:/Uhdiya/");
		} else {
			rAttr.addAttribute("result", "loginFailed");
			mav.setViewName("redirect:/memJ/loginJ");
		}
		return mav;
	}
	
	//  http://localhost:8080/Uhdiya/memJ/memberFormJ
	// 회원가입
	@RequestMapping("memberFormJ")
	public ModelAndView memberFormJ(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	// 회원가입처리
	@RequestMapping(value="addMem", method=RequestMethod.POST)
	public ModelAndView addMember(@ModelAttribute("memJ") MemJDTO memJ, 
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		memJService.addMember(memJ);
					
		ModelAndView mav = new ModelAndView("redirect:/memJ/loingJ");
		return mav;
	}
	
	
	//  http://localhost:8080/Uhdiya/memJ/find_id
	// 아이디 찾기
	@RequestMapping("find_id")
	public ModelAndView find_id(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	//  http://localhost:8080/Uhdiya/memJ/find_pw
	// 비밀번호 찾기
	@RequestMapping("find_pw")
	public ModelAndView find_pw(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}

}