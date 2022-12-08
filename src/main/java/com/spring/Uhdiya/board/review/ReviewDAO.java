package com.spring.Uhdiya.board.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReviewDAO {
	@Autowired SqlSession sqlSession;

	//관리자 페이지 리뷰
	public List<ReviewDTO> all_review(Map<String, Object> pageMap) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.review.all_review",pageMap);
	}
	public int total_review() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.review.total_review");
	}

	//상품 상세페이지 리뷰
	public List<ReviewDTO> product_review(Map<String, Object> pageMap) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.review.product_review",pageMap);
	}
	public List<ReviewFileDTO> product_review_file(Map<String, Object> pageMap) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.review.product_review_file",pageMap);
	}
	public int total_product_review(String product_code) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.review.total_product_review",product_code);
	}

	// 마이페이지 리뷰
	public List<ReviewDTO> my_review(Map<String, Object> pageMap) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.review.my_review",pageMap);
	}
	public int total_my_review(String review_writeId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.review.total_my_review",review_writeId);
	}
	
	//리뷰 상세 페이지
	public Map<String, Object> one_review(int review_id) {
		// TODO Auto-generated method stub
		ReviewDTO reviewDTO = sqlSession.selectOne("mapper.review.one_review", review_id);
		List<ReviewFileDTO> reviewFileList = sqlSession.selectList("mapper.review.one_review_file", review_id);
		Map<String, Object> reviewMap = new HashMap<String, Object>();
		reviewMap.put("reviewDTO", reviewDTO);
		reviewMap.put("reviewFileList", reviewFileList);
		return reviewMap;
	}

	//리뷰 등록
	public int insert_review(Map<String, Object> reviewMap) {
		// TODO Auto-generated method stub
		int review_id = new_review_number()+1;
		reviewMap.put("review_id", review_id);
		List<ReviewFileDTO> imageList = (List<ReviewFileDTO>) reviewMap.get("imageList");
		if(imageList != null) {
			insert_review_file(reviewMap);
		}
		sqlSession.insert("mapper.review.insert_review",reviewMap);
		return review_id;
	}
	public void insert_review_file(Map<String, Object> reviewMap) {
		// TODO Auto-generated method stub
		List<ReviewFileDTO> imageList = (List<ReviewFileDTO>) reviewMap.get("imageList");
		Integer review_id = (Integer) reviewMap.get("review_id");
		int review_fileId = new_review_file_number();
		
		for(ReviewFileDTO dto : imageList) {
			dto.setReview_fileId(++review_fileId);
			dto.setReview_id(review_id);
		}
		sqlSession.insert("mapper.review.insert_review_file",imageList);
	}
	public int new_review_file_number() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.review.new_review_file_num");
	}
	public int new_review_number() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.review.new_review_num");
	}

	//리뷰 수정
	public void update_review(Map<String, Object> reviewMap) {
		// TODO Auto-generated method stub
		Integer review_id = Integer.parseInt((String) reviewMap.get("review_id"));
		sqlSession.update("mapper.review.update_review",reviewMap);
		if(reviewMap.get("imageList") != null) {
			sqlSession.delete("mapper.review.delete_review_file",review_id);
			insert_review_file(reviewMap);
		}
	}

	// 리뷰 삭제
	public void delete_review(int review_id) {
		// TODO Auto-generated method stub
		sqlSession.delete("mapper.review.delete_review",review_id);
		sqlSession.delete("mapper.review.delete_review_file",review_id);
	}

	// 회원 탈퇴 시 리뷰 삭제
	public void delete_member_review(String review_writeId) {
		// TODO Auto-generated method stub
		sqlSession.delete("mapper.review.delete_member_review",review_writeId);
	}
}