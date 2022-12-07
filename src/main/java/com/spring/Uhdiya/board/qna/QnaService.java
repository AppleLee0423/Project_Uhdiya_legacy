package com.spring.Uhdiya.board.qna;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class QnaService {
	@Autowired QnaDAO qnaDAO;
	
	// 관리자페이지 문의내역 전체
	public Map<String, Object> qna_list(Map<String, Object> dataMap) {
		// TODO Auto-generated method stub
		int current_page = Integer.parseInt((String) dataMap.get("current_page"));
		int list_count = Integer.parseInt((String) dataMap.get("list_count"));
		
		int startNum = (current_page - 1) * list_count + 1;
		int endNum = current_page * list_count;
		String keyword = (String) dataMap.get("keyword");
		dataMap.put("keyword", keyword);
		dataMap.put("startNum", startNum);
		dataMap.put("endNum", endNum);
		
		Map<String, Object> qnaMap = new HashMap<String, Object>();
		 List<QnaDTO> qna_list = qnaDAO.qna_list(dataMap);
		 List<QnaDTO> reply_list = qnaDAO.reply_list(dataMap);
		 int total_qna = total_qna();
		 
		 qnaMap.put("qna_list", qna_list);
		 qnaMap.put("reply_list", reply_list);
		 qnaMap.put("total_qna", total_qna);
		return qnaMap;
	}
	public int total_qna() {
		// TODO Auto-generated method stub
		return qnaDAO.total_qna();
	}

	// 상품페이지 문의내역
	public Map<String, Object> product_qna(Map<String, Object> pageMap) {
		// TODO Auto-generated method stub
		Map<String,Object> qnaMap = new HashMap<String, Object>();
		List<QnaDTO> qna_list = qnaDAO.product_qna(pageMap);
		String product_code = (String) pageMap.get("product_code");
		int total_qna = qnaDAO.total_product_qna(product_code);
		qnaMap.put("qna_list", qna_list);
		qnaMap.put("total_qna", total_qna);
		return qnaMap;
	}

	//문의 추가
	public int addQna(Map<String, Object> qnaMap) {
		// TODO Auto-generated method stub
		return qnaDAO.addQna(qnaMap);
	}

	//문의 수정
	public void update_qna(Map<String, Object> qnaMap) {
		// TODO Auto-generated method stub
		qnaDAO.update_qna(qnaMap);
	}

	// 문의 삭제
	public void delete_qna(int qna_id) {
		// TODO Auto-generated method stub
		qnaDAO.delete_qna(qna_id);
	}

	// 마이페이지 문의내역
	public Map<String, Object> my_qna(Map<String, Object> pageMap) {
		// TODO Auto-generated method stub
		Map<String,Object> qnaMap = new HashMap<String, Object>();
		List<QnaDTO> qna_list = qnaDAO.my_qna(pageMap);
		List<QnaDTO> reply_list = qnaDAO.my_qna_reply(pageMap);
		String qna_writeId = (String) pageMap.get("qna_writeId");
		int total_qna = qnaDAO.total_my_qna(qna_writeId);
		qnaMap.put("qna_list", qna_list);
		qnaMap.put("reply_list", reply_list);
		qnaMap.put("total_qna", total_qna);
		return qnaMap;
	}
	
	// 문의 상세페이지
	public Map<String, Object> one_qna(int qna_id) {
		// TODO Auto-generated method stub
		return qnaDAO.one_qna(qna_id);
	}

	// 답글 추가 & 원글 상태 변경
	public boolean insert_reply(Map<String,Object> reply_map) {
		// TODO Auto-generated method stub
		boolean result = false;
		int insert_result = qnaDAO.insert_reply(reply_map); 
		int update_result = qnaDAO.update_parentId(reply_map);
		
		if(insert_result+update_result == 2) {
			result = true;
		}
		return result;
	}
}