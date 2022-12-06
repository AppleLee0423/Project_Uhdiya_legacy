package com.spring.Uhdiya.member;

import java.sql.Date;

public class MemberDTO {
	
	private int id;
	private String member_id;
	private String member_password;
	private String member_name;
	private String member_phone;
	private String member_phone1;
	private String member_phone2;
	private String member_email;
	private Date member_joinDate;
	private String zipno;           //우편번호
	private String roadFullAddr;    // 도로명주소
	private String addDetail;       // 상세주소
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_password() {
		return member_password;
	}
	public void setMember_password(String member_password) {
		this.member_password = member_password;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getMember_phone() {
		return member_phone;
	}
	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}
	public String getMember_phone1() {
		return member_phone1;
	}
	public void setMember_phone1(String member_phone1) {
		this.member_phone1 = member_phone1;
	}
	public String getMember_phone2() {
		return member_phone2;
	}
	public void setMember_phone2(String member_phone2) {
		this.member_phone2 = member_phone2;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public Date getMember_joinDate() {
		return member_joinDate;
	}
	public void setMember_joinDate(Date member_joinDate) {
		this.member_joinDate = member_joinDate;
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