package com.spring.Uhdiya.member;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
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
		return sqlSession.selectOne("mamper.member.findid", member);
	}

	public MemberDTO findpassword(MemberDTO member) {
		System.out.println("==> Mybatis로 findpassword() 기능 처리");
		return sqlSession.selectOne("mamper.member.findpassword", member);
	}
 


	
	
//	public List<NoticeDTO> selectAllNotice() {
//		// TODO Auto-generated method stub
//		return sqlSession.selectList("mapper.board.selectAllNotice");
//	}
}

