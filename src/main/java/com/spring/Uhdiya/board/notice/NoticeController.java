package com.spring.Uhdiya.board.notice;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/board/**")
public class NoticeController {
	@Autowired NoticeService noticeService;
	@Autowired ServletContext servletContext;
	
	// 공지사항
	@RequestMapping(value="notice")
	public ModelAndView notice(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		List<NoticeDTO> notice_list = noticeService.all_notice();
		mav.addObject("notice_list",notice_list);
		String webappRoot = servletContext.getRealPath("/");
		String relativeFolder = File.separator + "resources" + File.separator + "file" + File.separator + "notice_repo";
		

		return mav;
	}
	
	// 공지사항 작성폼(관리자만)
	@RequestMapping("noticeForm")
	public ModelAndView noticeForm(HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		ModelAndView mav = null;
		String viewName = (String) request.getAttribute("viewName");
		mav = new ModelAndView(viewName);
		
		/* 
		session 값 받아서 admin 일때만 가능하게

		HttpSession session = request.getSession();
		if(session.getAttribute("member") == "admin") {
			String viewName = (String) request.getAttribute("viewName");
			mav = new ModelAndView(viewName);
		} else {
			out.println("<script>");
			out.println("alert('관리자 로그인이 필요합니다.');");
			out.println("location.href='"+request.getContextPath()+"/board/login';");
			out.println("</script>");
		}
		*/
		
		return mav;
	}
	
	// 공지사항 게시(관리자만)
	@RequestMapping(value="addNotice",method=RequestMethod.POST)
	public ResponseEntity<String> addNotice(MultipartHttpServletRequest multiRequest, HttpServletResponse response) throws Exception{
		multiRequest.setCharacterEncoding("UTF-8");
		ResponseEntity<String> resEnt = null;
		Map<String, Object> noticeMap = new HashMap<String, Object>();
		Enumeration<String>	enu = multiRequest.getParameterNames();
		String webPath = "/resources/file/notice_repo/";
		String folderPath = multiRequest.getSession().getServletContext().getRealPath(webPath);
		
		while(enu.hasMoreElements()) {
			String name = enu.nextElement();
			String value = multiRequest.getParameter(name);
			noticeMap.put(name, value);
		}
		
		List<String> fileList = upload(multiRequest,folderPath);
		List<NoticeFileDTO> imageList = new ArrayList<NoticeFileDTO>();
		if(fileList != null && fileList.size() != 0) {
			for(String fileName : fileList) {
				NoticeFileDTO noticeFile = new NoticeFileDTO();
				noticeFile.setNotice_fileName(fileName);
				imageList.add(noticeFile);
			}
		}
		
		/*
		HttpSession session = multiRequest.getSession();
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		String notice_writeId = member.getId();
		*/
		
		noticeMap.put("notice_writeId", "admin");
		noticeMap.put("imageList", imageList);
		
		String message;
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type","text/html;charset=utf-8");
		
		try {
			int notice_id = noticeService.addNotice(noticeMap);
			
			if(fileList != null && fileList.size() != 0) {
				for(String fileName : fileList) {
					File srcFile = new File(folderPath+"\\"+"temp"+"\\"+fileName);
					File destDir = new File(folderPath+"\\"+notice_id);
					FileUtils.moveFileToDirectory(srcFile, destDir, true);
				}
			}
			
			message = "<script>";
			message += "alert('공지사항을 추가했습니다.');";
			message += "location.href='"+multiRequest.getContextPath()+"/board/notice';";
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

	private List<String> upload(MultipartHttpServletRequest multiRequest, String folderPath) throws Exception{
		// TODO Auto-generated method stub
		List<String> fileList = new ArrayList<String>();
		Iterator<String> fileNames = multiRequest.getFileNames();
		
		while(fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = multiRequest.getFile(fileName);
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
		}
		return fileList;
	}

	// 공지사항 수정(관리자만)
	@RequestMapping("update_Notice")
	public ModelAndView updateNotice(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	// 공지사항 삭제(관리자만)
	@RequestMapping("deleteNotice")
	public ModelAndView deleteNotice(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
}