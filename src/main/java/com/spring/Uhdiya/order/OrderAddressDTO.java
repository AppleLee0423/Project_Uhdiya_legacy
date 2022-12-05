package com.spring.Uhdiya.order;

import java.sql.Date;

public class OrderAddressDTO {
	
	private String member_id;
	
	private String zipno;           //우편번호
	private String roadFullAddr;    // 도로명주소,지번주소
	private String addDetail;       // 상세주소
	
	
	
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getZipno() {
		return zipno;
	}
	public void setZipno(String zipno) {
		this.zipno = zipno;
	}
	public String getRoadFullAddr() {
		return roadFullAddr;
	}
	public void setRoadFullAddr(String roadFullAddr) {
		this.roadFullAddr = roadFullAddr;
	}
	public String getAddDetail() {
		return addDetail;
	}
	public void setAddDetail(String addDetail) {
		this.addDetail = addDetail;
	}
	
	
	
	
	
}
