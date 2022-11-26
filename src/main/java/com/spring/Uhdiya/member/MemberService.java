package com.spring.Uhdiya.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;




@Service
public class MemberService {
	
	@Autowired
	MemberDAO memberDAO;
	
	public int addMember(MemberDTO member) {
		int result = memberDAO.addMember(member);
		return result;
	}
	
	public MemberDTO login(MemberDTO member) {
		return memberDAO.login(member);
	}
	
	public int idcheck(MemberDTO member) throws Exception {
		return memberDAO.idcheck(member);
	}
	
	public int phonecheck(MemberDTO member) throws Exception {
		return memberDAO.phonecheck(member);
	}
	
	public int emailcheck(MemberDTO member) throws Exception {
		return memberDAO.emailcheck(member);
	}
	
	public MemberDTO findid(MemberDTO member) {
		return memberDAO.findid(member);
	}
	
	public MemberDTO findpassword(MemberDTO member) {
		return memberDAO.findpassword(member);
	}
	
	/**
	 * 회원 리스트 가져오기
	 * @param param
	 * @return
	 */
	public List<MemberDTO> getMemList(MemberDTO param) {
		return memberDAO.getMemList(param);
	}
	
	/**
	 * 회원정보 삭제
	 * @param param
	 */
	public int deleteMember(MemberDTO param) {
		return memberDAO.deleteMember(param);
	}
	
}