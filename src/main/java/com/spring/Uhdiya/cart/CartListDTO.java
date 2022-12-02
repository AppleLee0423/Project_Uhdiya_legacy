package com.spring.Uhdiya.cart;

public class CartListDTO {
	
	private int cart_seq_num;
	private String member_id;
	private String product_code;
	private String product_name;
	private String product_fileName;
	private int product_price;
	private int cart_qty;
	
	
	public int getCart_seq_num() {
		return cart_seq_num;
	}
	public void setCart_seq_num(int cart_seq_num) {
		this.cart_seq_num = cart_seq_num;
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
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getProduct_fileName() {
		return product_fileName;
	}
	public void setProduct_fileName(String product_fileName) {
		this.product_fileName = product_fileName;
	}
	public int getProduct_price() {
		return product_price;
	}
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	public int getCart_qty() {
		return cart_qty;
	}
	public void setCart_qty(int cart_qty) {
		this.cart_qty = cart_qty;
	}
	
	

	
	
	
	
}
