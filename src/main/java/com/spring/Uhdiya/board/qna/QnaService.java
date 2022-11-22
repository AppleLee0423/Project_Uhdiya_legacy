package com.spring.Uhdiya.board.qna;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class QnaService {
	@Autowired QnaDAO qnaDAO;

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

	public int addQna(Map<String, Object> qnaMap) {
		// TODO Auto-generated method stub
		return qnaDAO.addQna(qnaMap);
	}

	public void update_qna(Map<String, Object> qnaMap) {
		// TODO Auto-generated method stub
		qnaDAO.update_qna(qnaMap);
	}

	public void delete_qna(int qna_id) {
		// TODO Auto-generated method stub
		qnaDAO.delete_qna(qna_id);
	}

	public Map<String, Object> qna_list(Map<String, Object> pageMap) {
		// TODO Auto-generated method stub
		Map<String,Object> qnaMap = new HashMap<String, Object>();
		List<QnaDTO> qna_list = qnaDAO.qna_list(pageMap);
		int total_qna = qnaDAO.total_qna();
		qnaMap.put("qna_list", qna_list);
		qnaMap.put("total_qna", total_qna);
		return qnaMap;
		
	}

	public Map<String, Object> my_qna(Map<String, Object> pageMap) {
		// TODO Auto-generated method stub
		Map<String,Object> qnaMap = new HashMap<String, Object>();
		List<QnaDTO> qna_list = qnaDAO.my_qna(pageMap);
		String qna_writeId = (String) pageMap.get("qna_writeId");
		int total_qna = qnaDAO.total_my_qna(qna_writeId);
		qnaMap.put("qna_list", qna_list);
		qnaMap.put("total_qna", total_qna);
		return qnaMap;
	}
}