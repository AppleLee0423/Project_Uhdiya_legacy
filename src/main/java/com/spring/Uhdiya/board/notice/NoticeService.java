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
}