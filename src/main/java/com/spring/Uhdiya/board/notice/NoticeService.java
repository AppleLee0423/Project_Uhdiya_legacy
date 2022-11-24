package com.spring.Uhdiya.board.notice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NoticeService {
	@Autowired NoticeDAO noticeDAO;
	
	// 공지사항 전체 호출
	public Map<String,Object> all_notice(Map<String, Integer> pageMap) {
		// TODO Auto-generated method stub
		Map<String,Object> noticeMap = new HashMap<String, Object>();
		List<NoticeDTO> notice_list = noticeDAO.all_notice(pageMap);
		int total_notice = noticeDAO.total_notice();
		noticeMap.put("notice_list", notice_list);
		noticeMap.put("total_notice", total_notice);
		return noticeMap;
	}

	// 공지사항 추가
	public int addNotice(Map<String, Object> noticeMap) {
		// TODO Auto-generated method stub
		return noticeDAO.addNotice(noticeMap);
	}
	
	// 공지사항 상세페이지
	public Map<String, Object> one_notice(int notice_id) {
		// TODO Auto-generated method stub
		noticeDAO.countUp(notice_id);
		return noticeDAO.one_notice(notice_id);
	}
	
	//공지사항 수정
	public void update_notice(Map<String, Object> noticeMap) {
		// TODO Auto-generated method stub
		noticeDAO.update_notice(noticeMap);
	}
	
	// 공지사항 삭제
	public void delete_notice(int notice_id) {
		// TODO Auto-generated method stub
		noticeDAO.delete_notice(notice_id);
	}

	// 공지사항 검색결과
	public List<NoticeDTO> search_notice(String keyword) {
		// TODO Auto-generated method stub
		return noticeDAO.search_notice(keyword);
	}
}