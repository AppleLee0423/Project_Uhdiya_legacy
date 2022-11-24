package com.spring.Uhdiya.mypage.shoppingList;
//구매목록 view에서 뿌려줄 정보 저장하는 객체 목록
//db select후 결과 컬럼값들이 이곳에 저장됨
public class ShoppingListDomain {

//	주문내역에서
//	보여줘야 하는 것들
	private String order_num; //단일 종류 제품의 주문 번호
	private String order_list_num;//총 제품 주문 번호
	private int total_price;  //전체 가격
	private String order_date; //주문 날짜
	private String chk_cancle;  //취소 여부
	private String member_id; //아이디
	private String product_name; //제품 이름
	private int quantity; //수량
	private int totalQuantity; //총 제품 수량 -- 이 부분은 db로 조회하지 않음
	private int receiver_zipcode;//우편번호
	private String receiver_name;  //받는 이 이름
	private String receiver_phone; //받는 이 전화번호
	private String receiver_addr1; //받는이 상세주소1
	private String receiver_addr2; //받는이 상세주소2
	
	
	public String getOrder_num() {
		return order_num;
	}
	public void setOrder_num(String order_num) {
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
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	public String isChk_cancle() {
		return chk_cancle;
	}
	public void setChk_cancle(String chk_cancle) {
		this.chk_cancle = chk_cancle;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getTotalQuantity() {
		return totalQuantity;
	}
	public void setTotalQuantity(int totalQuantity) {
		this.totalQuantity = totalQuantity;
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
	public String getReceiver_addr2() {
		return receiver_addr2;
	}
	public void setReceiver_addr2(String receiver_addr2) {
		this.receiver_addr2 = receiver_addr2;
	}
	
	
}//class
