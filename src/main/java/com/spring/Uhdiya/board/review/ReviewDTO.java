package com.spring.Uhdiya.board.review;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component
public class ReviewDTO {
	private int review_id; // 글 고유번호
	private String review_writeId; // 작성자
	private int review_star; // 평점
	private String review_title; // 제목
	private String review_content; // 내용
	private Date review_regDate; // 등록일
	private String product_code; // 상품코드

	public ReviewDTO() {
		// TODO Auto-generated constructor stub
	}

	public ReviewDTO(String review_writeId, int review_star, String review_title, String review_content) {
		// TODO Auto-generated constructor stub
		this.review_writeId = review_writeId;
		this.review_star = review_star;
		this.review_title = review_title;
		this.review_content = review_content;
	}

	public int getReview_id() {
		return review_id;
	}

	public void setReview_id(int review_id) {
		this.review_id = review_id;
	}

	public String getReview_writeId() {
		return review_writeId;
	}

	public void setReview_writeId(String review_writeId) {
		this.review_writeId = review_writeId;
	}

	public int getReview_star() {
		return review_star;
	}

	public void setReview_star(int review_star) {
		this.review_star = review_star;
	}

	public String getReview_title() {
		return review_title;
	}

	public void setReview_title(String review_title) {
		this.review_title = review_title;
	}

	public String getReview_content() {
		return review_content;
	}

	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}

	public Date getReview_regDate() {
		return review_regDate;
	}

	public void setReview_regDate(Date review_regDate) {
		this.review_regDate = review_regDate;
	}

	public String getProduct_code() {
		return product_code;
	}

	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
}