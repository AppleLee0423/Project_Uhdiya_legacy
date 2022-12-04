package com.spring.Uhdiya.board.qna;

import java.sql.Date;
import com.fasterxml.jackson.annotation.JsonInclude;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class Qna_list {
	private int current_page; // 현재 페이지
	private int list_count; // 페이지당 결과수 [20,50]
	private String list_day; // 등록일 순 [[desc,asc]

	private Date startDate; // 시작일
	private Date endDate; // 종료일
	private int status; // 답변상태[0:답변대기,1:답변완료]
	private String keyword_set; // 검색조건[title,qna_writeId,product_name]
	private String keyword; // 검색어

	private int startNum; // 페이지 내 첫번째 데이터
	private int endNum; // 페이지 내 마지막 데이터

	public int getCurrent_page() {
		return current_page;
	}

	public void setCurrent_page(String current_page) {
		this.current_page = Integer.parseInt(current_page);
	}

	public int getList_count() {
		return list_count;
	}

	public void setList_count(String list_count) {
		this.list_count = Integer.parseInt(list_count);
	}

	public String getList_day() {
		return list_day;
	}

	public void setList_day(String list_day) {
		this.list_day = list_day;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getKeyword_set() {
		return keyword_set;
	}

	public void setKeyword_set(String keyword_set) {
		this.keyword_set = keyword_set;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getStartNum() {
		return startNum;
	}

	public void setStartNum() {
		this.startNum = (current_page - 1) * list_count + 1;
	}

	public int getEndNum() {
		return endNum;
	}

	public void setEndNum() {
		this.endNum = current_page * list_count;
	}
}