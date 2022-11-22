package com.spring.Uhdiya.member;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jdk.internal.org.jline.utils.Log;



@Controller
@RequestMapping("/member/**")
public class MemberController {
	@Autowired MemberService memberService;
		

	//  http://localhost:8080/Uhdiya/member/login
	// 로그인
	@RequestMapping("login")
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	// 로그인처리
	@RequestMapping(value="loginMember", method=RequestMethod.POST)
	public ModelAndView login(@ModelAttribute("member") MemberDTO member, RedirectAttributes rAttr, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// TODO Auto-generated method stub
		ModelAndView mav = new ModelAndView();
		MemberDTO memberDTO = memberService.login(member);
		
		if(memberDTO != null) {
			HttpSession session = request.getSession();
			Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
			String viewName = (String) request.getAttribute("viewName");
			session.setAttribute("member", memberDTO);
			session.setAttribute("isLogOn", true);
			mav.setViewName("redirect:/home/index");
		} else {
			rAttr.addAttribute("result", "loginFailed");
			mav.setViewName("redirect:/member/login");
		}
		return mav;
	}
	
	//  http://localhost:8080/Uhdiya/member/memberForm
	// 회원가입
	@RequestMapping("memberForm")
	public ModelAndView memberForm(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	// 회원가입처리
	@RequestMapping(value="addMember", method=RequestMethod.POST)
	public ModelAndView addMember(@ModelAttribute("member") MemberDTO member, 
			RedirectAttributes rAttr,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		int result = (int) memberService.addMember(member);
		PrintWriter pw =response.getWriter(); 
		ModelAndView mav = new ModelAndView();
		
		if(result==1) {
			rAttr.addAttribute("result","login");
			mav.setViewName("redirect:/member/login");
			System.out.println("회원가입 성공!");
			return mav;
		} else {
			rAttr.addAttribute("result","joinfailed");
			mav.setViewName("redirect:/member/memberForm");
			System.out.println("가입실패");
			return mav;
//			pw.println("<script>");
//			pw.println( "alert('회원가입이 되지않았습니다. 다시 시도해주세요');");
//			pw.println("</script>");
//			return null;
			
		}
	
		
	}
    // 아이디중복체크
	
    @ResponseBody
    @RequestMapping("/idcheck")
    public int idcheck(MemberDTO member) throws Exception {
    	Log.info(member);
    	int result = memberService.idcheck(member);
    	return result;
    }

	
	//  http://localhost:8080/Uhdiya/member/find_id
	// 아이디 찾기
	@RequestMapping("find_id")
	public ModelAndView find_id(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	//  http://localhost:8080/Uhdiya/member/find_pw
	// 비밀번호 찾기
	@RequestMapping("find_pw")
	public ModelAndView find_pw(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}

}