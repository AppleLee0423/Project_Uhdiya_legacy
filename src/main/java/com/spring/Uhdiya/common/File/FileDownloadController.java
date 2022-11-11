package com.spring.Uhdiya.common.File;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class FileDownloadController {
	// src-main-webapp-resources에 각각의 repo 만들어서 저장하는걸 권장(시연용)
	private static final String PRODUCT_IMAGE_REPO = "상품 이미지 저장, ";
	private static final String NOTICE_IMAGE_REPO = "공지사항 이미지 저장, ";
	private static final String QNA_IMAGE_REPO = "QNA 이미지 저장, ";
	private static final String REVIEW_IMAGE_REPO = "리뷰 이미지 저장, ";
	
	@RequestMapping("/product_download.do")
	public void product_download
	(@RequestParam("이미지 파일 이름") String 이미지파일이름, @RequestParam("상품코드") String 상품코드, HttpServletResponse response) throws Exception {
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
	}
	
	@RequestMapping("/notice_download.do")
	public void notice_download
	(@RequestParam("이미지 파일 이름") String 이미지파일이름, @RequestParam("게시글번호") String 게시글번호, HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String downFile = NOTICE_IMAGE_REPO + "\\" + 게시글번호 + "\\" + 이미지파일이름;
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
	}
	
	@RequestMapping("/qna_download.do")
	public void qna_download
	(@RequestParam("이미지 파일 이름") String 이미지파일이름, @RequestParam("게시글번호") String 게시글번호, HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String downFile = QNA_IMAGE_REPO + "\\" + 게시글번호 + "\\" + 이미지파일이름;
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
	}
	
	@RequestMapping("/review_download.do")
	public void review_download
	(@RequestParam("이미지 파일 이름") String 이미지파일이름, @RequestParam("게시글번호") String 게시글번호, HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String downFile = REVIEW_IMAGE_REPO + "\\" + 게시글번호 + "\\" + 이미지파일이름;
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
	}
}