package com.spring.Uhdiya.board.notice;

import org.springframework.stereotype.Component;

@Component
public class NoticeFileDTO {
	private int notice_fileId; // 이미지 고유번호
	private int notice_id; // 글 고유번호
	private String notice_fileName; // 이미지 파일명

	public NoticeFileDTO() {
		// TODO Auto-generated constructor stub
	}

	public NoticeFileDTO(int notice_id, String notice_fileName) {
		// TODO Auto-generated constructor stub
		this.notice_id = notice_id;
		this.notice_fileName = notice_fileName;
	}

	public int getNotice_fileId() {
		return notice_fileId;
	}

	public void setNotice_fileId(int notice_fileId) {
		this.notice_fileId = notice_fileId;
	}

	public int getNotice_id() {
		return notice_id;
	}

	public void setNotice_id(int notice_id) {
		this.notice_id = notice_id;
	}

	public String getNotice_fileName() {
		return notice_fileName;
	}

	public void setNotice_fileName(String notice_fileName) {
		this.notice_fileName = notice_fileName;
	}
}