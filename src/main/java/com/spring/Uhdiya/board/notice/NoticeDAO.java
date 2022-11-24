package com.spring.Uhdiya.board.notice;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAO {
	@Autowired SqlSession sqlSession;

	public List<NoticeDTO> all_notice(Map<String, Integer> pageMap) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.notice.all_notice",pageMap);
	}

	public int addNotice(Map<String, Object> noticeMap) {
		// TODO Auto-generated method stub
		int notice_id = new_notice_number()+1;
		noticeMap.put("notice_id", notice_id);
		List<NoticeFileDTO> imageList = (List<NoticeFileDTO>) noticeMap.get("imageList");
		if(imageList != null) {
			insert_notice_file(noticeMap);
		}
		sqlSession.insert("mapper.notice.insert_notice",noticeMap);
		return notice_id;
	}

	private void insert_notice_file(Map<String, Object> noticeMap) {
		// TODO Auto-generated method stub
		List<NoticeFileDTO> imageList = (List<NoticeFileDTO>) noticeMap.get("imageList");
		Integer notice_id = (Integer) noticeMap.get("notice_id");
		int notice_fileId = new_notice_file_number();
		
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

	public Map<String, Object> one_notice(int notice_id) {
		// TODO Auto-generated method stub
		NoticeDTO noticeDTO = sqlSession.selectOne("mapper.notice.one_notice", notice_id);
		List<NoticeFileDTO> noticeFileList = sqlSession.selectList("mapper.notice.one_notice_file", notice_id);
		Map<String, Object> noticeMap = new HashMap<String, Object>();
		noticeMap.put("noticeDTO", noticeDTO);
		noticeMap.put("noticeFileList", noticeFileList);
		return noticeMap;
	}

	public void countUp(int notice_id) {
		// TODO Auto-generated method stub
		sqlSession.update("mapper.notice.count_plus",notice_id);
	}

	public void delete_notice(int notice_id) {
		// TODO Auto-generated method stub
		sqlSession.delete("mapper.notice.delete_notice",notice_id);
		sqlSession.delete("mapper.notice.delete_notice_file",notice_id);
	}

	public void update_notice(Map<String, Object> noticeMap) {
		// TODO Auto-generated method stub
		Integer notice_id = Integer.parseInt((String) noticeMap.get("notice_id"));
		sqlSession.update("mapper.notice.update_notice",noticeMap);
		// 파일은 기존파일 삭제 후 추가
		if(noticeMap.get("imageList") != null) {
			sqlSession.delete("mapper.notice.delete_notice_file",notice_id);
			insert_notice_file(noticeMap);
		}
	}

	public List<NoticeDTO> search_notice(String keyword) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.notice.search_notice",keyword);
	}

	public int total_notice() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.notice.total_notice");
	}
}