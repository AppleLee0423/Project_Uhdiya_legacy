package com.spring.Uhdiya.board.qna;

import org.springframework.stereotype.Component;

@Component
public class Qna_list {
	private int current_page;
	private int list_count;
	private String list_day;
	
	public int getCurrent_page() {
		return current_page;
	}
	public void setCurrent_page(int current_page) {
		this.current_page = current_page;
	}
	public int getList_count() {
		return list_count;
	}
	public void setList_count(int list_count) {
		this.list_count = list_count;
	}
	public String getList_day() {
		return list_day;
	}
	public void setList_day(String list_day) {
		this.list_day = list_day;
	}	
}