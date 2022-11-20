package com.spring.Uhdiya.common.File;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class FileDownloadController {
	
	@RequestMapping("/product_download")
	public void product_download
	(@RequestParam("이미지 파일 이름") String 이미지파일이름, @RequestParam("상품코드") String 상품코드, HttpServletResponse response) throws Exception {
		/*
		OutputStream out = response.getOutputStream();
		String downFile = PRODUCT_IMAGE_REPO + "\\" + 상품코드 + "\\" + 이미지파일이름;
		File file = new File(downFile);
		
		response.setHeader("Cache-control", "no-cache");
		response.addHeader("Content-disposition", "attachment;fileName="+이미지파일이름);
		FileInputStream in = new FileInputStream(file);
		byte[] buffer = new byte[1024 * 8];
		while(true) {
			int count = in.read(buffer);
			if(count == -1) {
				break;
			}
			out.write(buffer, 0, count);
		}
		in.close();
		out.close();
		*/
	}
	
	@RequestMapping("/notice_download")
	public void notice_download
	(@RequestParam("notice_fileName") String notice_fileName, @RequestParam("notice_id") int notice_id, HttpServletResponse response) throws Exception {
//		String webPath = "/resources/file/notice_repo/";
//		String folderPath = multiRequest.getSession().getServletContext().getRealPath(webPath);
		String folderPath = "C:\\Users\\CJ\\Spring_workspace\\Project_Uhdiya\\src\\main\\webapp\\resources\\file\\notice_repo";
		
		notice_fileName = URLDecoder.decode(notice_fileName,"UTF-8");
		OutputStream out = response.getOutputStream();
		String downFile = folderPath + "\\" + notice_id + "\\" + notice_fileName;
		File file = new File(downFile);
		
		response.setHeader("Cache-control", "no-cache");
		response.addHeader("Content-disposition", "attachment;fileName="+notice_fileName);
		FileInputStream in = new FileInputStream(file);
		byte[] buffer = new byte[1024 * 8];
		while(true) {
			int count = in.read(buffer);
			if(count == -1) {
				break;
			}
			out.write(buffer, 0, count);
		}
		in.close();
		out.close();
	}
	
	@RequestMapping("/qna_download")
	public void qna_download
	(@RequestParam("qna_fileName") String qna_fileName, @RequestParam("qna_id")int qna_id, HttpServletResponse response) throws Exception {
//		String webPath = "/resources/file/notice_repo/";
//		String folderPath = multiRequest.getSession().getServletContext().getRealPath(webPath);
		String folderPath = "C:\\Users\\CJ\\Spring_workspace\\Project_Uhdiya\\src\\main\\webapp\\resources\\file\\qna_repo";
		
		qna_fileName = URLDecoder.decode(qna_fileName,"UTF-8");
		OutputStream out = response.getOutputStream();
		String downFile = folderPath + "\\" + qna_id + "\\" + qna_fileName;
		File file = new File(downFile);
		
		response.setHeader("Cache-control", "no-cache");
		response.addHeader("Content-disposition", "attachment;fileName="+qna_fileName);
		FileInputStream in = new FileInputStream(file);
		byte[] buffer = new byte[1024 * 8];
		while(true) {
			int count = in.read(buffer);
			if(count == -1) {
				break;
			}
			out.write(buffer, 0, count);
		}
		in.close();
		out.close();
	}
	
	@RequestMapping("/review_download")
	public void review_download
	(@RequestParam("review_fileName") String review_fileName, @RequestParam("review_id") int review_id, HttpServletResponse response) throws Exception {
//		String webPath = "/resources/file/notice_repo/";
//		String folderPath = multiRequest.getSession().getServletContext().getRealPath(webPath);
		String folderPath = "C:\\Users\\CJ\\Spring_workspace\\Project_Uhdiya\\src\\main\\webapp\\resources\\file\\review_repo";
		
		review_fileName = URLDecoder.decode(review_fileName,"UTF-8");
		OutputStream out = response.getOutputStream();
		String downFile = folderPath + "\\" + review_id + "\\" + review_fileName;
		File file = new File(downFile);
		
		response.setHeader("Cache-control", "no-cache");
		response.addHeader("Content-disposition", "attachment;fileName="+review_fileName);
		FileInputStream in = new FileInputStream(file);
		byte[] buffer = new byte[1024 * 8];
		while(true) {
			int count = in.read(buffer);
			if(count == -1) {
				break;
			}
			out.write(buffer, 0, count);
		}
		in.close();
		out.close();
	}
}