package com.spring.Uhdiya.board.notice;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAO {
	@Autowired SqlSession sqlSession;

	public List<NoticeDTO> all_notice() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.notice.all_notice");
	}

	public int addNotice(Map<String, Object> noticeMap) {
		// TODO Auto-generated method stub
		int notice_id = new_notice_number()+1;
		noticeMap.put("notice_id", notice_id);
		insert_notice_file(noticeMap);
		sqlSession.insert("mapper.notice.insert_notice",noticeMap);
		return notice_id;
	}

	private void insert_notice_file(Map<String, Object> noticeMap) {
		// TODO Auto-generated method stub
		List<NoticeFileDTO> imageList = (List<NoticeFileDTO>) noticeMap.get("imageList");
		Integer notice_id = (Integer) noticeMap.get("notice_id");
		int notice_fileId = new_notice_file_number()+1;
		
		for(NoticeFileDTO dto : imageList) {
			dto.setNotice_fileId(++notice_fileId);
			dto.setNotice_id(notice_id);
		}
		sqlSession.insert("mapper.notice.insert_notice_file",imageList);
	}

	private int new_notice_file_number() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.notice.new_notice_file_number");
	}

	private int new_notice_number() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.notice.new_notice_number");
	}
}