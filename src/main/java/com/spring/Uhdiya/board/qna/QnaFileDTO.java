package com.spring.Uhdiya.board.qna;

import org.springframework.stereotype.Component;

@Component
public class QnaFileDTO {
	private int qna_id; // 글 고유번호
	private String qna_fileName; // 이미지 파일명

	public QnaFileDTO() {
		// TODO Auto-generated constructor stub
	}

	public QnaFileDTO(int qna_id, String qna_fileName) {
		// TODO Auto-generated constructor stub
		this.qna_id = qna_id;
		this.qna_fileName = qna_fileName;
	}

	public int getqna_id() {
		return qna_id;
	}

	public void setqna_id(int qna_id) {
		this.qna_id = qna_id;
	}

	public String getqna_fileName() {
		return qna_fileName;
	}

	public void setqna_fileName(String qna_fileName) {
		this.qna_fileName = qna_fileName;
	}
}