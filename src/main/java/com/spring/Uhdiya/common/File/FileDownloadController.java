package com.spring.Uhdiya.common.File;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class FileDownloadController {
	
	@RequestMapping("/product_download")
	public void product_download
	(@RequestParam("product_fileName") String product_fileName, @RequestParam("product_code") String product_code, HttpServletResponse response) throws Exception {
		String UHDIYA_IMAGE_REPO = "C:\\najin\\uhdiya";
		OutputStream out = response.getOutputStream();
		String downFile = UHDIYA_IMAGE_REPO + "\\" + product_code + "\\" + product_fileName;
		File file = new File(downFile);
		
		response.setHeader("Cache-control", "no-cache");
		response.addHeader("Content-disposition", "attachment;fileName="+product_fileName);
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
	
	@RequestMapping("/notice_download")
	public void notice_download
	(@RequestParam("notice_fileName") String notice_fileName, @RequestParam("notice_id") String notice_id, MultipartHttpServletRequest multiRequest, HttpServletResponse response) throws Exception {
		String webPath = "/resources/file/notice_repo/";
		String folderPath = multiRequest.getSession().getServletContext().getRealPath(webPath);
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
	(@RequestParam("이미지 파일 이름") String 이미지파일이름, @RequestParam("게시글번호") String 게시글번호, HttpServletResponse response) throws Exception {
		/*
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
		*/
	}
	
	@RequestMapping("/review_download")
	public void review_download
	(@RequestParam("이미지 파일 이름") String 이미지파일이름, @RequestParam("게시글번호") String 게시글번호, HttpServletResponse response) throws Exception {
		/*
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
		*/
	}
}