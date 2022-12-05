package com.spring.Uhdiya.board.qna;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		List<QnaDTO> reply_list = qnaDAO.my_qna_reply(pageMap);
		String qna_writeId = (String) pageMap.get("qna_writeId");
		int total_qna = qnaDAO.total_my_qna(qna_writeId);
		qnaMap.put("qna_list", qna_list);
		qnaMap.put("reply_list", reply_list);
		qnaMap.put("total_qna", total_qna);
		return qnaMap;
	}

	public Map<String, Object> one_qna(int qna_id) {
		// TODO Auto-generated method stub
		return qnaDAO.one_qna(qna_id);
	}

	public int update_parentId(int qna_id) {
		// TODO Auto-generated method stub
		return qnaDAO.update_parentId(qna_id);
	}

	public int insert_reply(QnaDTO qnaDTO) {
		// TODO Auto-generated method stub
		return qnaDAO.insert_reply(qnaDTO);
	}

	public Map<String, Object> all_qna(Integer current_page, Integer list_count, String list_day) {
		// TODO Auto-generated method stub
		Map<String, Object> pageMap = new HashMap<String, Object>();
		pageMap.put("current_page", current_page);
		pageMap.put("list_count", list_count);
		pageMap.put("list_day", list_day);
		return qnaDAO.all_qna(pageMap);
	}

//	public Map<String, Object> test(Qna_list list) {
//		// TODO Auto-generated method stub
//		 Map<String, Object> qnaMap = new HashMap<String, Object>();
//		 List<QnaDTO> qna_list = qnaDAO.test(list);
//		 List<QnaDTO> reply_list = qnaDAO.test2(list);
//		 int total_qna = qnaDAO.total_qna();
//		 System.out.println("start : " + list.getStartNum());
//		 System.out.println("end : " + list.getEndNum());
//		 System.out.println("day1 : " + list.getCurrent_page());
//
//		 qnaMap.put("qna_list", qna_list);
//		 qnaMap.put("reply_list", reply_list);
//		 qnaMap.put("total_qna", total_qna);
//		return qnaMap;
//	}

	public int total_qna() {
		// TODO Auto-generated method stub
		return qnaDAO.total_qna();
	}

	public Map<String, Object> test(Map<String, Object> dataMap) {
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
		 List<QnaDTO> qna_list = qnaDAO.test(dataMap);
		 List<QnaDTO> reply_list = qnaDAO.test2(dataMap);
		 int total_qna = qnaDAO.total_qna();
		 
		 qnaMap.put("qna_list", qna_list);
		 qnaMap.put("reply_list", reply_list);
		 qnaMap.put("total_qna", total_qna);
		return qnaMap;
	}
}