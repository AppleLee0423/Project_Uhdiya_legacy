package com.spring.Uhdiya.common.File;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLDecoder;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class FileDownloadController {
	private static final String FILE_REPO = "C:\\Uhdiya"; 
	
	@RequestMapping("/product_download")
	public void product_download
	(@RequestParam("product_fileName") String product_fileName, @RequestParam("product_code") String product_code, HttpServletResponse response) throws Exception {
		String UHDIYA_IMAGE_REPO = FILE_REPO + "\\product";
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
	(@RequestParam("notice_fileName") String notice_fileName, @RequestParam("notice_id") int notice_id, HttpServletResponse response) throws Exception {
		String UHDIYA_IMAGE_REPO = FILE_REPO + "\\notice";
		
		notice_fileName = URLDecoder.decode(notice_fileName,"UTF-8");
		OutputStream out = response.getOutputStream();
		String downFile = UHDIYA_IMAGE_REPO + "\\" + notice_id + "\\" + notice_fileName;
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
		String UHDIYA_IMAGE_REPO = FILE_REPO + "\\qna";
		
		qna_fileName = URLDecoder.decode(qna_fileName,"UTF-8");
		OutputStream out = response.getOutputStream();
		String downFile = UHDIYA_IMAGE_REPO + "\\" + qna_id + "\\" + qna_fileName;
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
		String UHDIYA_IMAGE_REPO = FILE_REPO + "\\review";
		
		review_fileName = URLDecoder.decode(review_fileName,"UTF-8");
		OutputStream out = response.getOutputStream();
		String downFile = UHDIYA_IMAGE_REPO + "\\" + review_id + "\\" + review_fileName;
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