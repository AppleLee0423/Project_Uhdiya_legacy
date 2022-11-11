package com.spring.Uhdiya.board.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NoticeService {
	@Autowired NoticeDAO noticeDAO;
	
//	public List<NoticeDTO> selectAllNotice(){
//		// TODO Auto-generated method stub
//		return noticeDAO.selectAllNotice();
//	}
}