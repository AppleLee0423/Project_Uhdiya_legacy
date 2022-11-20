package com.spring.Uhdiya.board.notice;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NoticeService {
	@Autowired NoticeDAO noticeDAO;
	
	// 공지사항 전체 호출
	public List<NoticeDTO> all_notice() {
		// TODO Auto-generated method stub
		return noticeDAO.all_notice();
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
}