package com.spring.Uhdiya.member;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired MemberService memberService;

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
			
			mav.setViewName("redirect:/main");
		} else {
			rAttr.addAttribute("result", "loginFailed");
			mav.setViewName("redirect:/member/login");
		}
		return mav;
	}
	
	// 로그아웃
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public void logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		response.setContentType("text/html;charset=utf-8");
		
		PrintWriter out = response.getWriter();
		
		HttpSession session = request.getSession();
		
		session.invalidate();
		
		out.println("<script>");
		out.println("alert('로그아웃 되었습니다.'); location.href='/main'");
		out.println("</script>");
		
		out.flush();
	}
	
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
			return mav;
		} else {
			rAttr.addAttribute("result","joinfailed");
			mav.setViewName("redirect:/member/memberForm");
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
		MemberDTO id = memberService.findid(member);
		
		String findid = null;
		
		if( id != null ) {
			findid = id.getMember_id();
		}
		
		return findid;
	}

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
		member.setMember_phone(member.getMember_phone().replaceAll("-", ""));
		
		MemberDTO password = memberService.findpassword(member);
		
		String findpassword = null;
		
		if( password != null ) {
			findpassword = password.getMember_password();
		}
		
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

   // 회원정보수정	
	@RequestMapping("edit_member")
	public ModelAndView c_member(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		HttpSession session = request.getSession();
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		
		if( member == null ) {
			return new ModelAndView("redirect:/member/login");
		}
		
		MemberDTO dto = memberService.one_member(member);
		mav.addObject("member", dto);
		
		return mav;
	}
	
	// 회원수정처리
	@RequestMapping(value="editMember", method=RequestMethod.POST)
	@ResponseBody
	public String editMember(@ModelAttribute("editMember") MemberDTO member, RedirectAttributes rAttr,
								HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String res = "N";
		
		HttpSession session = request.getSession();
		MemberDTO mem = (MemberDTO) session.getAttribute("member");
		
		member.setMember_id(mem.getMember_id());
		
		int result = memberService.editMember(member);
		
		if( result > 0 ) {
			res = "Y";
		}
		
		return res;
	}
	
	 // 회원삭제?
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
	
	@RequestMapping(value="widthdraw_page")
	public ModelAndView widthdraw_page(@RequestBody MemberDTO member, HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = null;
		PrintWriter out = response.getWriter();
		
		HttpSession session = request.getSession();
		Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
		
		if(isLogOn == true && member != null) {
			mav = new ModelAndView(viewName);
			
			MemberDTO dto = memberService.one_member(member);
			mav.addObject("member", dto);
		} else {
			out.println("<script>");
			out.println("alert('로그인이 필요합니다.');");
			out.println("location.href='"+request.getContextPath()+"/member/login';");
			out.println("</script>");
		}
		return mav;
	}
	
	@RequestMapping(value="withdraw")
	public ResponseEntity<String> withdraw
	(@RequestBody MemberDTO member, HttpServletRequest request, HttpServletResponse response) throws Exception{
		ResponseEntity<String> resEnt = null;
		String message;
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type","text/html;charset=utf-8");
		
		try {
			memberService.deleteMember(member);
			
			message = "<script>";
			message = "alert('회원탈퇴 하였습니다.\n 커피향이 그리울 때 다시 만나요!');";
			message = "location.href='"+request.getContextPath()+"/main';";
			message = "</script>";
			
			resEnt = new ResponseEntity<String>(message,headers,HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			message = "<script>";
			message = "alert('회원탈퇴에 실패하였습니다.');";
			message = "history.go(-2);";
			message = "</script>";
			
			resEnt = new ResponseEntity<String>(message,headers,HttpStatus.BAD_REQUEST);
		}
	
		return resEnt;
	}
}