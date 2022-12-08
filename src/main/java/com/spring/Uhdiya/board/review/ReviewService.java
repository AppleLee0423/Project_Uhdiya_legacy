package com.spring.Uhdiya.board.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReviewService {
	@Autowired ReviewDAO reviewDAO;

	// 관리자 페이지 리뷰
	public Map<String, Object> all_review(Map<String, Object> pageMap) {
		// TODO Auto-generated method stub
		Map<String,Object> reviewMap = new HashMap<String, Object>();
		List<ReviewDTO> review_list = reviewDAO.all_review(pageMap);
		int total_review = reviewDAO.total_review();
		reviewMap.put("review_list", review_list);
		reviewMap.put("total_review", total_review);
		return reviewMap;
	}

	// 상품 상세페이지 리뷰
	public Map<String, Object> product_review(Map<String, Object> pageMap) {
		// TODO Auto-generated method stub
		Map<String,Object> reviewMap = new HashMap<String, Object>();
		List<ReviewDTO> review_list = reviewDAO.product_review(pageMap);
		List<ReviewFileDTO> review_fileList = reviewDAO.product_review_file(pageMap);
		String product_code = (String) pageMap.get("product_code");
		int total_review = reviewDAO.total_product_review(product_code);
		reviewMap.put("review_list", review_list);
		reviewMap.put("review_fileList", review_fileList);
		reviewMap.put("total_review", total_review);
		return reviewMap;
	}

	// 마이페이지 리뷰
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
	
	// 리뷰 상세페이지
	public Map<String, Object> one_review(int review_id) {
		// TODO Auto-generated method stub
		return reviewDAO.one_review(review_id);
	}

	// 리뷰 등록
	public int insert_review(Map<String, Object> reviewMap) {
		// TODO Auto-generated method stub
		return reviewDAO.insert_review(reviewMap);
	}

	//리뷰 수정
	public void update_review(Map<String, Object> reviewMap) {
		// TODO Auto-generated method stub
		reviewDAO.update_review(reviewMap);
	}

	// 리뷰 삭제
	public void delete_review(int review_id) {
		// TODO Auto-generated method stub
		reviewDAO.delete_review(review_id);
	}
	
	// 회원 탈퇴 시 리뷰 삭제
	public void delete_member_review(String review_writeId) {
		reviewDAO.delete_member_review(review_writeId);
	}
}