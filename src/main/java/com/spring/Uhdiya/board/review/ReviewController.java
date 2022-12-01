package com.spring.Uhdiya.board.review;

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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.Uhdiya.member.MemberDTO;

@Controller
@RequestMapping("/board/*")
public class ReviewController {
	@Autowired ReviewService reviewService;
	private static final String UHDIYA_IMAGE_REPO  = "C:\\Uhdiya" + "\\review";
	
	// 전체 Review(관리자만)
	@RequestMapping("/review_list")
	public ModelAndView review_list(HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = null;
		
		HttpSession session = request.getSession();
		Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		
		if(isLogOn != null && isLogOn == true && member != null) {
			String member_id = member.getMember_id();
			if(member_id.equals("admin")) {
				mav = new ModelAndView(viewName);
				
				String _section = request.getParameter("section"); 
				String _pageNum = request.getParameter("pageNum");
				int section = Integer.parseInt((_section == null) ? "1" : _section);  
				int pageNum = Integer.parseInt((_pageNum == null) ? "1" : _pageNum);
				
				Map<String, Object> pageMap = new HashMap<String, Object>();
				
				pageMap.put("section", section);
				pageMap.put("pageNum", pageNum);
				Map<String,Object> reviewMap = new HashMap<String, Object>();
				
				reviewMap = reviewService.all_review(pageMap);
				reviewMap.put("section", section);
				reviewMap.put("pageNum", pageNum);
				
				mav.addObject("reviewMap",reviewMap);
			}
		} else {
			message(request, response);
			return null;
		}
		return mav;
	}
	
	// 상품 Review
	@RequestMapping("/review_product")
	public ModelAndView review_product(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		String _section = request.getParameter("section"); 
		String _pageNum = request.getParameter("pageNum");
		int section = Integer.parseInt((_section == null) ? "1" : _section);  
		int pageNum = Integer.parseInt((_pageNum == null) ? "1" : _pageNum);
		
		Map<String, Object> pageMap = new HashMap<String, Object>();
		String product_code = request.getParameter("product_code");
		
		pageMap.put("product_code", product_code);
		pageMap.put("section", section);
		pageMap.put("pageNum", pageNum);
		Map<String,Object> reviewMap = new HashMap<String, Object>();
		
		reviewMap = reviewService.product_review(pageMap);
		reviewMap.put("section", section);
		reviewMap.put("pageNum", pageNum);
		
		mav.addObject("reviewMap",reviewMap);
		return mav;
	}
	
	// 나의 Review
	@RequestMapping("/review_my")
	public ModelAndView review_my(HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = null;
		
		HttpSession session = request.getSession();
		Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		
		if(isLogOn != null && isLogOn == true && member != null) {
			String member_id = member.getMember_id();
			mav = new ModelAndView(viewName);
			
			String _section = request.getParameter("section"); 
			String _pageNum = request.getParameter("pageNum");
			int section = Integer.parseInt((_section == null) ? "1" : _section);  
			int pageNum = Integer.parseInt((_pageNum == null) ? "1" : _pageNum);
			
			Map<String, Object> pageMap = new HashMap<String, Object>();
			
			pageMap.put("review_writeId", member_id);
			pageMap.put("section", section);
			pageMap.put("pageNum", pageNum);
			Map<String,Object> reviewMap = new HashMap<String, Object>();
			
			reviewMap = reviewService.my_review(pageMap);
			reviewMap.put("section", section);
			reviewMap.put("pageNum", pageNum);
			
			mav.addObject("reviewMap",reviewMap);
		} else {
			message(request, response);
			return null;
		}
		return mav;
	}
	
	// 리뷰 상세페이지
	@RequestMapping("/review_page")
	public ModelAndView review_page
	(@RequestParam("review_id")int review_id, HttpServletRequest request, HttpServletResponse response) throws Exception{
		//, @RequestParam("review_writeId")String review_writeId, 
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		Map<String, Object> reviewMap = reviewService.one_review(review_id);
		mav.addObject("reviewMap",reviewMap);
		return mav;
	}
	
	// Review 작성폼
	@RequestMapping("/reviewForm")
	public ModelAndView reviewForm(@RequestParam("product_code")String product_code, HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = null;
		
		HttpSession session = request.getSession();
		Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		
		if(isLogOn != null && isLogOn == true && member != null) {
			String member_id = member.getMember_id();
			mav = new ModelAndView(viewName);
			mav.addObject("product_code", product_code);
			mav.addObject("review_writeId", member_id);
			mav.addObject("product_cateL",request.getParameter("product_cateL"));
			mav.addObject("product_cateS",request.getParameter("product_cateS"));
		} else {
			message(request, response);
			return null;
		}
		return mav;
	}
	
	// Review 게시
	@RequestMapping("/addReview")
	public ResponseEntity<String> addReview(MultipartHttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("UTF-8");
		ResponseEntity<String> resEnt = null;
		Map<String, Object> reviewMap = new HashMap<String, Object>();
		Enumeration<String>	enu = request.getParameterNames();
		
		while(enu.hasMoreElements()) {
			String name = enu.nextElement();
			String value = request.getParameter(name);
			reviewMap.put(name, value);
		}
		
		List<String> fileList = upload(request,UHDIYA_IMAGE_REPO);
		List<ReviewFileDTO> imageList = new ArrayList<ReviewFileDTO>();
		if(fileList != null && fileList.size() != 0) {
			for(String fileName : fileList) {
				ReviewFileDTO reviewFile = new ReviewFileDTO();
				reviewFile.setReview_fileName(fileName);
				imageList.add(reviewFile);
			}
			reviewMap.put("imageList", imageList);
		}

		String message;
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type","text/html;charset=utf-8");
		
		try {
			int review_id = reviewService.insert_review(reviewMap);
			
			if(fileList != null && fileList.size() != 0) {
				for(String fileName : fileList) {
					File srcFile = new File(UHDIYA_IMAGE_REPO+"\\"+"temp"+"\\"+fileName);
					File destDir = new File(UHDIYA_IMAGE_REPO+"\\"+review_id);
					FileUtils.moveFileToDirectory(srcFile, destDir, true);
				}
			}
			String product_cateL = request.getParameter("product_cateL");
			String product_cateS = request.getParameter("product_cateS");
			String product_code = request.getParameter("product_code");
			
			message = "<script>";
			message += "alert('상품후기를 추가했습니다.');";
			message += "location.href='"+request.getContextPath()+"/product/productDetail?product_cateL="+product_cateL+"&product_cateS="+product_cateS+"&product_code="+product_code+"';";
//			message += "history.go(-2);";
			message += "</script>";
			resEnt = new ResponseEntity<String>(message,headers,HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			if(fileList != null && fileList.size() != 0) {
				for(String fileName : fileList) {
					File srcFile = new File(UHDIYA_IMAGE_REPO+"\\"+"temp"+"\\"+fileName);
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
	
	private List<String> upload(MultipartHttpServletRequest request, String UHDIYA_IMAGE_REPO)throws Exception {
		// TODO Auto-generated method stub
		List<String> fileList = new ArrayList<String>();
		Iterator<String> fileNames = request.getFileNames();
		
		while(fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = request.getFile(fileName);
			String originalFileName = mFile.getOriginalFilename();
			fileList.add(originalFileName);
			File file = new File(UHDIYA_IMAGE_REPO+"\\"+fileName);
			
			if(mFile.getSize() != 0) {
				if(!file.exists()) {
					if(file.getParentFile().mkdirs()) {
						file.createNewFile();
					}
				}
				mFile.transferTo(new File(UHDIYA_IMAGE_REPO+"\\"+"temp"+"\\"+originalFileName));
			}
		}
		return fileList;
	}

	// Review 수정
	@RequestMapping("/update_review")
	public ResponseEntity<String> update_review(@RequestParam("review_id")int review_id, MultipartHttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("UTF-8");
		ResponseEntity<String> resEnt = null;
		Map<String, Object> reviewMap = new HashMap<String, Object>();
		Enumeration<String>	enu = request.getParameterNames();
		
		while(enu.hasMoreElements()) {
			String name = enu.nextElement();
			String value = request.getParameter(name);
			reviewMap.put(name, value);
		}
		
		List<String> fileList = upload(request,UHDIYA_IMAGE_REPO);
		List<ReviewFileDTO> imageList = new ArrayList<ReviewFileDTO>();
		if(fileList != null && fileList.size() != 0) {
			for(String fileName : fileList) {
				ReviewFileDTO reviewFile = new ReviewFileDTO();
				reviewFile.setReview_fileName(fileName);
				imageList.add(reviewFile);
			}
			reviewMap.put("imageList", imageList);
		}

		String message;
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type","text/html;charset=utf-8");
		
		try {
			reviewService.update_review(reviewMap);
			
			if(fileList != null && fileList.size() != 0) {
				for(String fileName : fileList) {
					File srcFile = new File(UHDIYA_IMAGE_REPO+"\\"+"temp"+"\\"+fileName);
					File destDir = new File(UHDIYA_IMAGE_REPO+"\\"+review_id);
					FileUtils.deleteDirectory(destDir);
					FileUtils.moveFileToDirectory(srcFile, destDir, true);
				}
			}
			
			message = "<script>";
			message += "alert('상품후기를 수정했습니다.');";
			message += "location.href='"+request.getContextPath()+"/board/review_my'";
			message += "</script>";
			resEnt = new ResponseEntity<String>(message,headers,HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			if(fileList != null && fileList.size() != 0) {
				for(String fileName : fileList) {
					File srcFile = new File(UHDIYA_IMAGE_REPO+"\\"+"temp"+"\\"+fileName);
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
	
	// Review 삭제
	@RequestMapping("/delete_review")
	public ResponseEntity<String> delete_review(@RequestParam("review_id")int review_id, HttpServletRequest request, HttpServletResponse response) throws Exception{
		ResponseEntity<String> resEnt = null;
		String message;
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type","text/html;charset=utf-8");
		
//		Integer review_id = Integer.parseInt(request.getParameter("review_id"));
		
		try {
			File destDir = new File(UHDIYA_IMAGE_REPO+"\\"+review_id);
			FileUtils.deleteDirectory(destDir);
			
			reviewService.delete_review(review_id);
			
			message = "<script>";
			message += "alert('상품후기를 삭제했습니다.');";
			message += "location.href='"+request.getContextPath()+"/board/review_my';";
			message += "</script>";
			resEnt = new ResponseEntity<String>(message,headers,HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			message = "<script>";
			message += "alert('상품후기를 삭제할 수 없습니다.');";
			message += "history.back();";
			message += "</script>";
			resEnt = new ResponseEntity<String>(message,headers,HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		return resEnt;
	}
	
	// 에러메세지(to 로그인)
	public void message(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		out.println("<script>");
		out.println("alert('로그인 후 이용가능합니다.');");
		out.println("location.href='"+request.getContextPath()+"/member/login';");
		out.println("</script>");
	}
	
	// 에러메세지(to 이전페이지)
	public void message2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		out.println("<script>");
		out.println("alert('작성자만 확인 가능합니다.');");
		out.println("history.back();");
		out.println("</script>");
	}
}