package com.spring.Uhdiya.board.review;

import org.springframework.stereotype.Component;

@Component
public class ReviewFileDTO {
	private int review_fileId; // 이미지 고유번호
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

	public int getReview_fileId() {
		return review_fileId;
	}

	public void setReview_fileId(int review_fileId) {
		this.review_fileId = review_fileId;
	}

	public int getReview_id() {
		return review_id;
	}

	public void setReview_id(int review_id) {
		this.review_id = review_id;
	}

	public String getReview_fileName() {
		return review_fileName;
	}

	public void setReview_fileName(String review_fileName) {
		this.review_fileName = review_fileName;
	}
}