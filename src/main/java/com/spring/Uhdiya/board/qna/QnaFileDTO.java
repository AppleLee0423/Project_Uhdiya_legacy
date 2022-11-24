package com.spring.Uhdiya.board.qna;

import org.springframework.stereotype.Component;

@Component
public class QnaFileDTO {
	private int qna_fileId; // 이미지 고유번호
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

	public int getQna_fileId() {
		return qna_fileId;
	}

	public void setQna_fileId(int qna_fileId) {
		this.qna_fileId = qna_fileId;
	}

	public int getQna_id() {
		return qna_id;
	}

	public void setQna_id(int qna_id) {
		this.qna_id = qna_id;
	}

	public String getQna_fileName() {
		return qna_fileName;
	}

	public void setQna_fileName(String qna_fileName) {
		this.qna_fileName = qna_fileName;
	}
}