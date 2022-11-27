package com.spring.Uhdiya.board.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReviewService {
	@Autowired ReviewDAO reviewDAO;

	public Map<String, Object> all_review(Map<String, Object> pageMap) {
		// TODO Auto-generated method stub
		Map<String,Object> reviewMap = new HashMap<String, Object>();
		List<ReviewDTO> review_list = reviewDAO.all_review(pageMap);
		int total_review = reviewDAO.total_review();
		reviewMap.put("review_list", review_list);
		reviewMap.put("total_review", total_review);
		return reviewMap;
	}

	public Map<String, Object> product_review(Map<String, Object> pageMap) {
		// TODO Auto-generated method stub
		Map<String,Object> reviewMap = new HashMap<String, Object>();
		List<ReviewDTO> review_list = reviewDAO.product_review(pageMap);
		String product_code = (String) pageMap.get("product_code");
		int total_review = reviewDAO.total_product_review(product_code);
		reviewMap.put("review_list", review_list);
		reviewMap.put("total_review", total_review);
		return reviewMap;
	}

	public Map<String, Object> my_review(Map<String, Object> pageMap) {
		// TODO Auto-generated method stub
		Map<String,Object> reviewMap = new HashMap<String, Object>();
		List<ReviewDTO> review_list = reviewDAO.my_review(pageMap);
		String review_writeId = (String) pageMap.get("review_writeId");
		int total_review = reviewDAO.total_my_review(review_writeId);
		reviewMap.put("review_list", review_list);
		reviewMap.put("total_review", total_review);
		return reviewMap;
	}

	public int insert_review(Map<String, Object> reviewMap) {
		// TODO Auto-generated method stub
		return reviewDAO.insert_review(reviewMap);
	}

	public void update_review(Map<String, Object> reviewMap) {
		// TODO Auto-generated method stub
		reviewDAO.update_review(reviewMap);
	}

	public void delete_review(int review_id) {
		// TODO Auto-generated method stub
		reviewDAO.delete_review(review_id);
	}

	public Map<String, Object> one_review(int review_id) {
		// TODO Auto-generated method stub
		return reviewDAO.one_review(review_id);
	}
}