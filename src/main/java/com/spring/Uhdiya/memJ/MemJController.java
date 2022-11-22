package com.spring.Uhdiya.memJ;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
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
			Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
			String viewName = (String) request.getAttribute("viewName");
			session.setAttribute("memJ", memJDTO);
			session.setAttribute("isLogOn", true);
			mav.setViewName("redirect:/home/index");
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
			RedirectAttributes rAttr,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		
		int result = (int) memJService.addMember(memJ);
		PrintWriter pw =response.getWriter(); 
		ModelAndView mav = new ModelAndView();
		
		if(result==1) {
			rAttr.addAttribute("result","login");
			mav.setViewName("redirect:/memJ/loginJ");
			System.out.println("회원가입 성공!");
			return mav;
		} else {
			rAttr.addAttribute("result","joinfailed");
			mav.setViewName("redirect:/memJ/memberFormJ");
			System.out.println("가입실패");
			return mav;
//			pw.println("<script>");
//			pw.println( "alert('회원가입이 되지않았습니다. 다시 시도해주세요');");
//			pw.println("</script>");
//			return null;
			
		}
	
		
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