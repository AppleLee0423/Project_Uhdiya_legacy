package com.spring.Uhdiya.board.qna;

public class PagingVO {
	private int section;
	private int pageNum;
	private String keyword;
	private String product_code;
	
	public PagingVO() {
		// TODO Auto-generated constructor stub
	}
	public PagingVO(int section, int pageNum, String product_code) {
		// TODO Auto-generated constructor stub
		this.section = section;
		this.pageNum = pageNum;
		this.product_code = product_code;
	}
	public PagingVO(int section, int pageNum, String keyword, String product_code) {
		// TODO Auto-generated constructor stub
		this.section = section;
		this.pageNum = pageNum;
		this.keyword = keyword;
		this.product_code = product_code;
	}

	public String getProduct_code() {
		return product_code;
	}
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
	public int getSection() {
		return section;
	}
	public void setSection(int section) {
		this.section = section;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}	
}