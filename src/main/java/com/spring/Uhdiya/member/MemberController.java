package com.spring.Uhdiya.member;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired MemberService memberService;

	//  http://localhost:8080/Uhdiya/member/login
	// 로그인
	@RequestMapping("login")
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		System.err.println(viewName);
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	// 로그인처리
	@RequestMapping(value="loginMember", method=RequestMethod.POST)
	public ModelAndView login(@ModelAttribute("member") MemberDTO member, RedirectAttributes rAttr, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// TODO Auto-generated method stub
		ModelAndView mav = new ModelAndView();
		
		System.err.println(member.getMember_id());
		System.err.println(member.getMember_password());
		
		MemberDTO memberDTO = memberService.login(member);
		System.err.println(memberDTO.toString());
		if(memberDTO != null) {
			HttpSession session = request.getSession();
			Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
			String viewName = (String) request.getAttribute("viewName");
			session.setAttribute("member", memberDTO);
			session.setAttribute("isLogOn", true);
			
			mav.setViewName("redirect:/main");
			
			if( "admin".equals(memberDTO.getMember_id()) ) {
				mav.setViewName("redirect:/member/member_list");
			}
		} else {
			rAttr.addAttribute("result", "loginFailed");
			mav.setViewName("redirect:/member/login");
		}
		return mav;
	}
	
	// 로그아웃
	@RequestMapping(value="/member/logout.do", method=RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		session.invalidate();
		
		out.println("<script>");
		out.println("alert('로그아웃 되었습니다.');");
		out.println("</script>");
		
		mav.setViewName("redirect:/main");
		
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
		}
	}
	
    // 아이디중복체크
    @ResponseBody
    @RequestMapping("/idcheck")
    public String idcheck(MemberDTO member) throws Exception {
    	
    	String res = "Y";
    	
    	int result = memberService.idcheck(member);
    	
    	if( result > 0 ) {
    		res = "N";
    	}
    	
    	return res;
    }
    
    // 전화번호중복체크
     @ResponseBody
     @RequestMapping("/phonecheck")
     public String phonecheck(MemberDTO member) throws Exception {
    	
    	String res = "Y";
    	
    	int result = memberService.phonecheck(member);
    	
    	if( result > 0 ) {
    		res = "N";
    	}
    	
    	return res;
     }
     
     // 이메일중복체크
     @ResponseBody
     @RequestMapping("/emailcheck")
     public String emailcheck(MemberDTO member) throws Exception {
    	
    	String res = "Y";
    	
    	int result = memberService.emailcheck(member);
    	
    	if( result > 0 ) {
    		res = "N";
    	}
    	
    	return res;
     }

	//  http://localhost:8080/Uhdiya/member/find_id
	// 아이디 찾기 폼
	@RequestMapping("find_id")
	public ModelAndView find_id(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	// 아이디 찾기 실행
	@RequestMapping(value = "/findid", method = RequestMethod.POST)
	@ResponseBody
	public String findingId(@ModelAttribute MemberDTO member, Model model , HttpServletResponse response)throws Exception {
		
		System.out.println(member.getMember_name());
		System.out.println(member.getMember_email());
		
		MemberDTO id = memberService.findid(member);
		
		String findid = null;
		
		if( id != null ) {
			findid = id.getMember_id();
		}
		
		System.out.println(findid);
		
		return findid;
	}

	//  http://localhost:8080/Uhdiya/member/find_pw
	// 비밀번호 찾기
	@RequestMapping("find_pw")
	public ModelAndView find_pw(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	// 비밀번호 찾기 실행
	@RequestMapping(value = "/findpassword", method = RequestMethod.POST)
	@ResponseBody
	public String findingPassword(@ModelAttribute MemberDTO member, Model model , HttpServletResponse response)throws Exception {
		
//		System.out.println(member.getMember_phone1());
//		System.out.println(member.getMember_phone2());
		
		member.setMember_phone(member.getMember_phone().replaceAll("-", ""));
		
		System.out.println(member.getMember_name());
		System.out.println(member.getMember_email());
		System.out.println(member.getMember_phone());
		
		MemberDTO password = memberService.findpassword(member);
		
		String findpassword = null;
		
		if( password != null ) {
			findpassword = password.getMember_password();
		}
		
		System.out.println(findpassword);
		
		return findpassword;
	}
		
	// 관리자페이지 리스트
	@RequestMapping("/member_list")
	public ModelAndView memberList( HttpServletRequest request, MemberDTO param ) {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("list", memberService.getMemList(param));
		return mav;
	}
	
	@RequestMapping(value = "/member_delete", method = RequestMethod.POST)
	@ResponseBody
	public String memberDelete( MemberDTO param ) {
		
		String res = "N";
		
		int cnt = memberService.deleteMember(param);
		
		if( cnt > 0 ) {
			res = "Y";
		}
		
		return res;
	}

   // 회원정보수정	
	@RequestMapping("edit_member")
	public ModelAndView c_member(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		System.err.println(viewName);
		ModelAndView mav = new ModelAndView(viewName);
		
		HttpSession session = request.getSession();
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		
		if( member == null ) {
			return new ModelAndView("redirect:/member/login");
		}
		
		mav.addObject("m", member);
		
		return mav;
	}
	
	// 회원수정처리
	@RequestMapping(value="editMember", method=RequestMethod.POST)
	@ResponseBody
	public String editMember(@ModelAttribute("editMember") MemberDTO member, RedirectAttributes rAttr,
										HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String res = "N";
		
		int result = memberService.editMember(member);
		
		if( result > 0 ) {
			res = "Y";
		}
		
		return res;
	}
}