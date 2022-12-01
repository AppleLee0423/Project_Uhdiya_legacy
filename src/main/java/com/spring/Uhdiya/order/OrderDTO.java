package com.spring.Uhdiya.order;

import java.sql.Date;

public class OrderDTO {
	
	private int order_seq_num;
	private int order_id;
	private String member_id;
	private String product_code;
	private int order_qty;
	private Date order_date;
	private String order_state;
	
	
	
	public int getOrder_seq_num() {
		return order_seq_num;
	}
	public void setOrder_seq_num(int order_seq_num) {
		this.order_seq_num = order_seq_num;
	}
	public int getOrder_id() {
		return order_id;
	}
	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getProduct_code() {
		return product_code;
	}
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
	public int getOrder_qty() {
		return order_qty;
	}
	public void setOrder_qty(int order_qty) {
		this.order_qty = order_qty;
	}
	public Date getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}
	public String getOrder_state() {
		return order_state;
	}
	public void setOrder_state(String order_state) {
		this.order_state = order_state;
	}
	
	
	

	
	

	
	
	
	
}
