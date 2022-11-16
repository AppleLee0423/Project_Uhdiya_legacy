package com.spring.Uhdiya.board.qna;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component
public class QnaDTO {
	private int qna_id; // 글 고유번호
	private int qna_parentId; // 0:질문글 그외:답변글
	private String qna_writeId; // 작성자
	private String qna_title; // 제목
	private String qna_content; // 내용
	private Date qna_regDate; // 등록일
	private int qna_status; // 0:답변대기, 1:답변완료
	private String product_code; // 상품코드

	public QnaDTO() {
		// TODO Auto-generated constructor stub
	}

	public QnaDTO(String qna_writeId, String qna_title, String qna_content) {
		// TODO Auto-generated constructor stub
		this.qna_writeId = qna_writeId;
		this.qna_title = qna_title;
		this.qna_content = qna_content;
	}

	public int getQna_id() {
		return qna_id;
	}

	public void setQna_id(int qna_id) {
		this.qna_id = qna_id;
	}

	public int getQna_parentId() {
		return qna_parentId;
	}

	public void setQna_parentId(int qna_parentId) {
		this.qna_parentId = qna_parentId;
	}

	public String getQna_writeId() {
		return qna_writeId;
	}

	public void setQna_writeId(String qna_writeId) {
		this.qna_writeId = qna_writeId;
	}

	public String getQna_title() {
		return qna_title;
	}

	public void setQna_title(String qna_title) {
		this.qna_title = qna_title;
	}

	public String getQna_content() {
		return qna_content;
	}

	public void setQna_content(String qna_content) {
		this.qna_content = qna_content;
	}

	public Date getQna_regDate() {
		return qna_regDate;
	}

	public void setQna_regDate(Date qna_regDate) {
		this.qna_regDate = qna_regDate;
	}

	public int getQna_status() {
		return qna_status;
	}

	public void setQna_status(int qna_status) {
		this.qna_status = qna_status;
	}

	public String getProduct_code() {
		return product_code;
	}

	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
}