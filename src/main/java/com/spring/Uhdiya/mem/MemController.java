package com.spring.Uhdiya.mem;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/mem/**")
public class MemController {
//	@Autowired NoticeService noticeService;
	
	
	// 회원정보 수정
	@RequestMapping("modMem")
	public ModelAndView modMem(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	// 회원정보 수정처리
		@RequestMapping("modmemPro")
		public ModelAndView modmemPro(HttpServletRequest request, HttpServletResponse response) throws Exception{
			String viewName = (String) request.getAttribute("viewName");
			ModelAndView mav = new ModelAndView(viewName);
			return mav;
		}
	
	// 회원탈퇴
	@RequestMapping("delete")
	public ModelAndView delete(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	// 회원탈퇴 처리
	@RequestMapping("deletePro")
	public ModelAndView deletePro(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	
}