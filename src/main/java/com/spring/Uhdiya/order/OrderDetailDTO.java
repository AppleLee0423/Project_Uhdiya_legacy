package com.spring.Uhdiya.order;

import java.sql.Date;

public class OrderDetailDTO {
	
	private String order_id;
	
	private String receiver_name;
	private String receiver_phone;
	private String receiver_zipno;           //우편번호
	private String receiver_roadFullAddr;    // 도로명주소,지번주소
	private String receiver_addDetail;       // 상세주소
	private String receiver_content;
	private String payment_cardCo;
	private String payment_cardNum;
	private int payment_cardExM;
	private int payment_cardExY;
	private int payment_cardCVS;
	
	
	
	
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
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
	public String getReceiver_zipno() {
		return receiver_zipno;
	}
	public void setReceiver_zipno(String receiver_zipno) {
		this.receiver_zipno = receiver_zipno;
	}
	public String getReceiver_roadFullAddr() {
		return receiver_roadFullAddr;
	}
	public void setReceiver_roadFullAddr(String receiver_roadFullAddr) {
		this.receiver_roadFullAddr = receiver_roadFullAddr;
	}
	public String getReceiver_addDetail() {
		return receiver_addDetail;
	}
	public void setReceiver_addDetail(String receiver_addDetail) {
		this.receiver_addDetail = receiver_addDetail;
	}

	public String getReceiver_content() {
		return receiver_content;
	}
	public void setReceiver_content(String receiver_content) {
		this.receiver_content = receiver_content;
	}
	public String getPayment_cardCo() {
		return payment_cardCo;
	}
	public void setPayment_cardCo(String payment_cardCo) {
		this.payment_cardCo = payment_cardCo;
	}
	public String getPayment_cardNum() {
		return payment_cardNum;
	}
	public void setPayment_cardNum(String payment_cardNum) {
		this.payment_cardNum = payment_cardNum;
	}
	public int getPayment_cardExM() {
		return payment_cardExM;
	}
	public void setPayment_cardExM(int payment_cardExM) {
		this.payment_cardExM = payment_cardExM;
	}
	public int getPayment_cardExY() {
		return payment_cardExY;
	}
	public void setPayment_cardExY(int payment_cardExY) {
		this.payment_cardExY = payment_cardExY;
	}
	public int getPayment_cardCVS() {
		return payment_cardCVS;
	}
	public void setPayment_cardCVS(int payment_cardCVS) {
		this.payment_cardCVS = payment_cardCVS;
	}
	
	
	
	
	
	
	
	
}
