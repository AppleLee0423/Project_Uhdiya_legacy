package com.spring.Uhdiya.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;




@Service
public class MemberService {
	
	@Autowired
	MemberDAO memberDAO;
	//회원가입
	public int addMember(MemberDTO member) {
		int result = memberDAO.addMember(member);
		return result;
	}
	//로그인
	public MemberDTO login(MemberDTO member) {
		return memberDAO.login(member);
	}
	// 아이디 중복체크
	public int idcheck(MemberDTO member) throws Exception {
		return memberDAO.idcheck(member);
	}
	// 폰 중복체크
	public int phonecheck(MemberDTO member) throws Exception {
		return memberDAO.phonecheck(member);
	}
	// 이메일 중복체크
	public int emailcheck(MemberDTO member) throws Exception {
		return memberDAO.emailcheck(member);
	}
	//아이디찾기
	public MemberDTO findid(MemberDTO member) {
		return memberDAO.findid(member);
	}
	//비밀번호찾기
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
	
	// 회원정보 수정
	public int editMember(MemberDTO member) {
		return memberDAO.editMember(member);
	}
	
}