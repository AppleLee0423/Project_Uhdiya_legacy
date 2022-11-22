package com.spring.Uhdiya.memJ;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class MemJDAO {
	@Autowired SqlSession sqlSession;
	
	
	public int addMember(MemJDTO memJ) {
		int result = sqlSession.insert("mapper.member.insertMember", memJ);
		sqlSession.insert("mapper.member.insertaddress", memJ);
		return result;
	}
	
	public MemJDTO login(MemJDTO memJ) {
		// TODO Auto-generated method stub
		MemJDTO memJDTO = sqlSession.selectOne("mapper.member.loginById", memJ);
		return memJDTO;
	}

	
	
//	public List<NoticeDTO> selectAllNotice() {
//		// TODO Auto-generated method stub
//		return sqlSession.selectList("mapper.board.selectAllNotice");
//	}
}