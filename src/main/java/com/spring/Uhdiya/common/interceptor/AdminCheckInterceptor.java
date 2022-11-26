package com.spring.Uhdiya.common.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.spring.Uhdiya.member.MemberDTO;

public class AdminCheckInterceptor extends HandlerInterceptorAdapter {
	
	private static final String ADMIN_ID = "admin";
	
	@Override
	public boolean preHandle( HttpServletRequest request,
								HttpServletResponse response, Object handler ) throws Exception {
		
		HttpSession session = request.getSession();
		
		boolean isLogOn = (boolean) (session.getAttribute("isLogOn") != null ? session.getAttribute("isLogOn") : false);
		
		if( !isLogOn ) {
			this.sendMessage(response, "로그인 후 이용가능합니다.");
			return false;
		}
		
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		
		if( member == null || !ADMIN_ID.equals(member.getMember_id()) ) {
			this.sendMessage(response, "관리자만 접근 가능합니다.");
			return false;
		}
		
		return true;
	}
	
	public void sendMessage(HttpServletResponse response, String msg) throws Exception {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter printwriter = response.getWriter();
		printwriter.print("<script>alert('"+msg+"');window.history.back();</script>");
		printwriter.flush();
		printwriter.close();
	}
	
}
