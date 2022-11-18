package com.spring.Uhdiya.board.qna;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/board/*")
public class QnaController {
	@Autowired QnaService qnaService;
	
	// 전체 QnA(관리자만)
	@RequestMapping("/qna_List")
	public ModelAndView qna_List(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	// 상품 QnA
	@RequestMapping("/qna_product")
	public ModelAndView qna_product(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	// 나의 QnA
	@RequestMapping("/qna_my")
	public ModelAndView qna_my(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	// Qna 작성폼
	@RequestMapping("/qnaForm")
	public ModelAndView qnaForm(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	// Qna 게시
	@RequestMapping("/addQna")
	public ModelAndView addQna(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	// Qna 수정
	@RequestMapping("/updateQna")
	public ModelAndView updateQna(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	// Qna 삭제
	@RequestMapping("/deleteQna")
	public ModelAndView deleteQna(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
}