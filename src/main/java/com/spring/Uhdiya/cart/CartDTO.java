package com.spring.Uhdiya.cart;

public class CartDTO {
	
	
	private String member_id;
	private String product_code;
	private int cart_qty;
	
	
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
	public int getCart_qty() {
		return cart_qty;
	}
	public void setCart_qty(int cart_qty) {
		this.cart_qty = cart_qty;
	}
	
	
	
	
}
