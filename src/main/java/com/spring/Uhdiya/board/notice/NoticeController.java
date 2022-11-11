package com.spring.Uhdiya.board.notice;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/board/*")
public class NoticeController {
	@Autowired NoticeService noticeService;
	
	// 공지사항
	@RequestMapping(value="/notice")
	public ModelAndView notice(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
//		List<NoticeDTO> list = noticeService.selectAllNotice();
//		mav.addObject(list);
		return mav;
	}
	
	// 공지사항 작성폼(관리자만)
	@RequestMapping("/noticeForm")
	public ModelAndView noticeForm(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	// 공지사항 게시(관리자만)
	@RequestMapping("/addNotice")
	public ModelAndView addNotice(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}

	// 공지사항 수정(관리자만)
	@RequestMapping("/updateNotice")
	public ModelAndView updateNotice(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	// 공지사항 삭제(관리자만)
	@RequestMapping("/deleteNotice")
	public ModelAndView deleteNotice(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
}