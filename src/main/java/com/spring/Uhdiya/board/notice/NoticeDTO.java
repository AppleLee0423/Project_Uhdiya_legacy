package com.spring.Uhdiya.board.notice;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component
public class NoticeDTO {
	private int notice_id; // 글 고유번호
	private String notice_writeId; // 작성자
	private String notice_title; // 제목
	private String notice_content; // 내용
	private Date notice_regDate; // 등록일 default:sysdate
	private int notice_count; // 조회수 default:0

	public NoticeDTO() {
		// TODO Auto-generated constructor stub
	}

	public NoticeDTO(String notice_writeId, String notice_title, String notice_content) {
		// TODO Auto-generated constructor stub
		this.notice_writeId = notice_writeId;
		this.notice_title = notice_title;
		this.notice_content = notice_content;
	}

	public int getNotice_id() {
		return notice_id;
	}

	public void setNotice_id(int notice_id) {
		this.notice_id = notice_id;
	}

	public String getNotice_writeId() {
		return notice_writeId;
	}

	public void setNotice_writeId(String notice_writeId) {
		this.notice_writeId = notice_writeId;
	}

	public String getNotice_title() {
		return notice_title;
	}

	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}

	public String getNotice_content() {
		return notice_content;
	}

	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}

	public Date getNotice_regDate() {
		return notice_regDate;
	}

	public void setNotice_regDate(Date notice_regDate) {
		this.notice_regDate = notice_regDate;
	}

	public int getNotice_count() {
		return notice_count;
	}

	public void setNotice_count(int notice_count) {
		this.notice_count = notice_count;
	}
}