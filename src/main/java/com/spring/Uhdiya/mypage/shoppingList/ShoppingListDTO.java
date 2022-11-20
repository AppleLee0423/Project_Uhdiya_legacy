package com.spring.Uhdiya.mypage.shoppingList;
//주문내역 페이지에서 보여줄 정보들
public class ShoppingListDTO {
//	private String[] order_num; 개별상품 주문번호
//	private String order_list_num; 전체상품 주문번호
//	private int total_price; 전체 총 금액
//	private String order_list_date; 주문 일자
//	private boolean chk_cancle; 상품 취소 
//	private String member_id; 주문자 아이디
//	private String[] product_name; 제품 이름 목록
//	private int[] order_quantity; 각 제품 구매 갯수
//	private int order_list_quantity; 총 구매 갯수
//	private int receiver_zipcode; 받는 이 우편번호
//	private String receiver_name; 받는 이 이름
//	private String receiver_phone; 받는 이 전화번호	
//  private String receiver_addr1; 받는 이 주소1
//	private String receiver_add2; 받는 이 주소2
	private String[] order_num;
	private String order_list_num; 
	private int total_price;
	private String order_list_date;
	private boolean chk_cancle; 
	private String member_id; 
	private String[] product_name;
	private int order_list_quantity;
	private int[] order_quantity; 
	private int receiver_zipcode; 
	private String receiver_name; 
	private String receiver_phone; 	
    private String receiver_addr1;
	private String receiver_add2;
	
	public String[] getOrder_num() {
		return order_num;
	}
	public void setOrder_num(String[] order_num) {
		this.order_num = order_num;
	}
	public String getOrder_list_num() {
		return order_list_num;
	}
	public void setOrder_list_num(String order_list_num) {
		this.order_list_num = order_list_num;
	}
	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	public String getOrder_list_date() {
		return order_list_date;
	}
	public void setOrder_list_date(String order_list_date) {
		this.order_list_date = order_list_date;
	}
	public boolean isChk_cancle() {
		return chk_cancle;
	}
	public void setChk_cancle(boolean chk_cancle) {
		this.chk_cancle = chk_cancle;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String[] getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String[] product_name) {
		this.product_name = product_name;
	}
	public int getOrder_list_quantity() {
		return order_list_quantity;
	}
	public void setOrder_list_quantity(int order_list_quantity) {
		this.order_list_quantity = order_list_quantity;
	}
	public int[] getOrder_quantity() {
		return order_quantity;
	}
	public void setOrder_quantity(int[] order_quantity) {
		this.order_quantity = order_quantity;
	}
	public int getReceiver_zipcode() {
		return receiver_zipcode;
	}
	public void setReceiver_zipcode(int receiver_zipcode) {
		this.receiver_zipcode = receiver_zipcode;
	}
	public String getReceiver_name() {
		return receiver_name;
	}
	public void setReceiver_name(String receiver_name) {
		this.receiver_name = receiver_name;
	}
	public String getReceiver_phone() {
		return receiver_phone;
	}
	public void setReceiver_phone(String receiver_phone) {
		this.receiver_phone = receiver_phone;
	}
	public String getReceiver_addr1() {
		return receiver_addr1;
	}
	public void setReceiver_addr1(String receiver_addr1) {
		this.receiver_addr1 = receiver_addr1;
	}
	public String getReceiver_add2() {
		return receiver_add2;
	}
	public void setReceiver_add2(String receiver_add2) {
		this.receiver_add2 = receiver_add2;
	}

}//class
