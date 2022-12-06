package com.spring.Uhdiya.member;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class MemberDAO {
	@Autowired SqlSession sqlSession;


	public int addMember(MemberDTO member) {
		int result = sqlSession.insert("mapper.member.insertMember", member);
		sqlSession.insert("mapper.member.insertaddress", member);
		return result;
	}

	public MemberDTO login(MemberDTO member) {
		// TODO Auto-generated method stub
		MemberDTO memberDTO = sqlSession.selectOne("mapper.member.loginById", member);
		return memberDTO;
	}

	public int idcheck(MemberDTO member) throws Exception {

		return sqlSession.selectOne("mapper.member.idcheck",member);

	}

	public int phonecheck(MemberDTO member) throws Exception {

		return sqlSession.selectOne("mapper.member.phonecheck",member);

	}

	public int emailcheck(MemberDTO member) throws Exception {

		return sqlSession.selectOne("mapper.member.emailcheck",member);

	}

	public MemberDTO findid(MemberDTO member) {
		System.out.println("==> Mybatis로 findid() 기능 처리");
		return sqlSession.selectOne("mapper.member.findid", member);
	}

	public MemberDTO findpassword(MemberDTO member) {
		System.out.println("==> Mybatis로 findpassword() 기능 처리");
		return sqlSession.selectOne("mapper.member.findpassword", member);
	}
	
	/**
	 * 회원 리스트 가져오기
	 * @param param
	 * @return
	 */
	public List<MemberDTO> getMemList(MemberDTO param) {
		return sqlSession.selectList("mapper.member.getMemList", param);
	}
	
	// 회원정보수정
	public int editMember(MemberDTO member) {
		int result = sqlSession.update("mapper.member.editMember", member);
		sqlSession.update("mapper.member.editAddress", member);
		return result;
	}
	
	/**
	 * 회원정보 삭제
	 * @param param
	 */
	public int deleteMember(MemberDTO param) {
		return sqlSession.delete("mapper.member.deleteMember", param);
	}

	// 회원 수정페이지 데이터
	public MemberDTO one_member(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.member.one_member",member_id);
	}
}