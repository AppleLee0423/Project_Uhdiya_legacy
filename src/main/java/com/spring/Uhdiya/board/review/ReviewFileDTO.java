package com.spring.Uhdiya.board.review;

import org.springframework.stereotype.Component;

@Component
public class ReviewFileDTO {
	private int review_id; // 글 고유번호
	private String review_fileName; // 이미지 파일명

	public ReviewFileDTO() {
		// TODO Auto-generated constructor stub
	}

	public ReviewFileDTO(int review_id, String review_fileName) {
		// TODO Auto-generated constructor stub
		this.review_id = review_id;
		this.review_fileName = review_fileName;
	}

	public int getreview_id() {
		return review_id;
	}

	public void setreview_id(int review_id) {
		this.review_id = review_id;
	}

	public String getreview_fileName() {
		return review_fileName;
	}

	public void setreview_fileName(String review_fileName) {
		this.review_fileName = review_fileName;
	}
}