package com.spring.Uhdiya.board.qna;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/board/*")
public class QnaController {
	@Autowired QnaService qnaService;
	private String folderPath = "C:\\Users\\CJ\\Spring_workspace\\Project_Uhdiya\\src\\main\\webapp\\resources\\file\\qna_repo";
	
	// 전체 QnA(관리자만)
	@RequestMapping("/qna_list")
	public ModelAndView qna_list(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		String _section = request.getParameter("section"); 
		String _pageNum = request.getParameter("pageNum");
		int section = Integer.parseInt((_section == null) ? "1" : _section);  
		int pageNum = Integer.parseInt((_pageNum == null) ? "1" : _pageNum);
		
		Map<String, Object> pageMap = new HashMap<String, Object>();
		
		pageMap.put("section", section);
		pageMap.put("pageNum", pageNum);
		Map<String,Object> qnaMap = new HashMap<String, Object>();
		
		qnaMap = qnaService.qna_list(pageMap);
		qnaMap.put("section", section);
		qnaMap.put("pageNum", pageNum);
		
		mav.addObject("qnaMap",qnaMap);
		return mav;
	}
	
	// 상품 QnA
	@RequestMapping("/qna_product")
	public ModelAndView qna_product( HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		String _section = request.getParameter("section"); 
		String _pageNum = request.getParameter("pageNum");
		int section = Integer.parseInt((_section == null) ? "1" : _section);  
		int pageNum = Integer.parseInt((_pageNum == null) ? "1" : _pageNum);
		// @RequestParam("product_code")String product_code,
		String product_code = request.getParameter("product_code");
		
		Map<String, Object> pageMap = new HashMap<String, Object>();
		
		pageMap.put("section", section);
		pageMap.put("pageNum", pageNum);
		pageMap.put("product_code", "001");
		Map<String,Object> qnaMap = new HashMap<String, Object>();
		
		qnaMap = qnaService.product_qna(pageMap);
		qnaMap.put("section", section);
		qnaMap.put("pageNum", pageNum);
		
		mav.addObject("qnaMap",qnaMap);
		return mav;
		
		
	}
	
	// 나의 QnA
	@RequestMapping("/qna_my")
	public ModelAndView qna_my(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		String _section = request.getParameter("section"); 
		String _pageNum = request.getParameter("pageNum");
		int section = Integer.parseInt((_section == null) ? "1" : _section);  
		int pageNum = Integer.parseInt((_pageNum == null) ? "1" : _pageNum);
		// @RequestParam("product_code")String product_code,
		String product_code = request.getParameter("product_code");
		
		Map<String, Object> pageMap = new HashMap<String, Object>();

//		HttpSession session = request.getSession();
//		MemberDTO dto = session.getAttribute("member");
//		String member_id = dto.getMember_id();
//		pageMap.put("qna_writeId", member_id);
		
		pageMap.put("section", section);
		pageMap.put("pageNum", pageNum);
		pageMap.put("qna_writeId", "hong");
		Map<String,Object> qnaMap = new HashMap<String, Object>();
		
		qnaMap = qnaService.my_qna(pageMap);
		qnaMap.put("section", section);
		qnaMap.put("pageNum", pageNum);
		
		mav.addObject("qnaMap",qnaMap);
		return mav;
	}
	
	// Qna 상세페이지
	@RequestMapping("/qna_page")
	public ModelAndView qna_page
	(@RequestParam("qna_id")int qna_id, @RequestParam("qna_writeId")String qna_writeId, HttpServletRequest request, HttpServletResponse response) 
			throws Exception{
		response.setContentType("text/html;charset=utf-8");
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = null;
		PrintWriter out = response.getWriter();
		
		Map<String, Object> qnaMap = qnaService.one_qna(qna_id);
		mav = new ModelAndView(viewName);
		mav.addObject("qnaMap",qnaMap);
		
		/*
		HttpSession session = request.getSession();
		MemberDTO dto = session.getAttribute("member");
		String member_id = dto.getMember_id();
		
		if(qna_writeId.equals(member_id)) {
			Map<String, Object> qnaMap = qnaService.one_qna(qna_id);
			mav = new ModelAndView(viewName);
			mav.addObject("qnaMap",qnaMap);
		} else {
			out.println("<script>");
			out.println("alert('해당 글 작성자만 볼 수 있습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
		*/
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
	public ResponseEntity<String> addQna(MultipartHttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("UTF-8");
		ResponseEntity<String> resEnt = null;
		Map<String, Object> qnaMap = new HashMap<String, Object>();
		Enumeration<String>	enu = request.getParameterNames();
		
		while(enu.hasMoreElements()) {
			String name = enu.nextElement();
			String value = request.getParameter(name);
			qnaMap.put(name, value);
		}
		
		List<String> fileList = upload(request,folderPath);
		List<QnaFileDTO> imageList = new ArrayList<QnaFileDTO>();
		if(fileList != null && fileList.size() != 0) {
			for(String fileName : fileList) {
				QnaFileDTO qnaFile = new QnaFileDTO();
				qnaFile.setQna_fileName(fileName);
				imageList.add(qnaFile);
			}
			qnaMap.put("imageList", imageList);
		}
		/*
		HttpSession session = multiRequest.getSession();
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		String notice_writeId = member.getId();
		*/
		qnaMap.put("review_writeId", "hong");

		String message;
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type","text/html;charset=utf-8");
		
		try {
			int qna_id = qnaService.addQna(qnaMap);
			
			if(fileList != null && fileList.size() != 0) {
				for(String fileName : fileList) {
					File srcFile = new File(folderPath+"\\"+"temp"+"\\"+fileName);
					File destDir = new File(folderPath+"\\"+qna_id);
					FileUtils.moveFileToDirectory(srcFile, destDir, true);
				}
			}
			
			message = "<script>";
			message += "alert('문의글을 추가했습니다.');";
//			message += "location.href='"+request.getContextPath()+"/board/product?product_code='"+product_code;
			message += "location.href='"+request.getContextPath()+"/board/qna_product'";
			message += "</script>";
			resEnt = new ResponseEntity<String>(message,headers,HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			if(fileList != null && fileList.size() != 0) {
				for(String fileName : fileList) {
					File srcFile = new File(folderPath+"\\"+"temp"+"\\"+fileName);
					srcFile.delete();
				}
			}
			
			message = "<script>";
			message += "alert('오류가 발생했습니다.');";
			message += "history.back();";
			message += "</script>";
			resEnt = new ResponseEntity<String>(message,headers,HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		return resEnt;
	}
	
	private List<String> upload(MultipartHttpServletRequest request, String folderPath) throws Exception{
		// TODO Auto-generated method stub
		List<String> fileList = new ArrayList<String>();
		Iterator<String> fileNames = request.getFileNames();
		
		while(fileNames.hasNext()) {
			String fileName = fileNames.next();
			if(fileName != null && fileName != "") {
				MultipartFile mFile = request.getFile(fileName);
				String originalFileName = mFile.getOriginalFilename();
				fileList.add(originalFileName);
				File file = new File(folderPath+"\\"+fileName);
				
				if(mFile.getSize() != 0) {
					if(!file.exists()) {
						if(file.getParentFile().mkdirs()) {
							file.createNewFile();
						}
					}
					mFile.transferTo(new File(folderPath+"\\"+"temp"+"\\"+originalFileName));
				}
			} else {
				return null;
			}
		}
		return fileList;
	}

	// Qna 수정
	@RequestMapping("/update_qna")
	public ResponseEntity<String> updateQna(@RequestParam("qna_id")int qna_id, MultipartHttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("UTF-8");
		ResponseEntity<String> resEnt = null;
		Map<String, Object> qnaMap = new HashMap<String, Object>();
		Enumeration<String>	enu = request.getParameterNames();
		
		while(enu.hasMoreElements()) {
			String name = enu.nextElement();
			String value = request.getParameter(name);
			qnaMap.put(name, value);
		}
		
		List<String> fileList = upload(request,folderPath);
		List<QnaFileDTO> imageList = new ArrayList<QnaFileDTO>();
		if(fileList != null && fileList.size() != 0) {
			for(String fileName : fileList) {
				QnaFileDTO qnaFile = new QnaFileDTO();
				qnaFile.setQna_fileName(fileName);
				imageList.add(qnaFile);
			}
			qnaMap.put("imageList", imageList);
		}
		/*
		HttpSession session = multiRequest.getSession();
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		String notice_writeId = member.getId();
		*/
//		qnaMap.put("notice_writeId", "hong");

		String message;
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type","text/html;charset=utf-8");
		
		try {
			qnaService.update_qna(qnaMap);
			
			if(fileList != null && fileList.size() != 0) {
				for(String fileName : fileList) {
					File srcFile = new File(folderPath+"\\"+"temp"+"\\"+fileName);
					File destDir = new File(folderPath+"\\"+qna_id);
					FileUtils.deleteDirectory(destDir);
					FileUtils.moveFileToDirectory(srcFile, destDir, true);
				}
			}
			
			message = "<script>";
			message += "alert('문의글을 수정했습니다.');";
//			message += "location.href='"+request.getContextPath()+"/board/product?product_code="+product_code+"'";
			message += "location.href='"+request.getContextPath()+"/board/qna_my'";
			message += "</script>";
			resEnt = new ResponseEntity<String>(message,headers,HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			if(fileList != null && fileList.size() != 0) {
				for(String fileName : fileList) {
					File srcFile = new File(folderPath+"\\"+"temp"+"\\"+fileName);
					srcFile.delete();
				}
			}
			
			message = "<script>";
			message += "alert('오류가 발생했습니다.');";
			message += "history.back();";
			message += "</script>";
			resEnt = new ResponseEntity<String>(message,headers,HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		return resEnt;
	}
	
	// Qna 삭제
	@RequestMapping("/delete_qna")
	public ResponseEntity<String> deleteQna(@RequestParam("qna_id")int qna_id, HttpServletRequest request, HttpServletResponse response) throws Exception{
		ResponseEntity<String> resEnt = null;
		String message;
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type","text/html;charset=utf-8");
		
		try {
			File destDir = new File(folderPath+"\\"+qna_id);
			FileUtils.deleteDirectory(destDir);
			
			qnaService.delete_qna(qna_id);
			
			message = "<script>";
			message += "alert('문의글을 삭제했습니다.');";
			message += "location.href='"+request.getContextPath()+"/board/qna_my';";
			message += "</script>";
			resEnt = new ResponseEntity<String>(message,headers,HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			message = "<script>";
			message += "alert('문의글을 삭제할 수 없습니다.');";
			message += "history.back();";
			message += "</script>";
			resEnt = new ResponseEntity<String>(message,headers,HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		return resEnt;
	}
}