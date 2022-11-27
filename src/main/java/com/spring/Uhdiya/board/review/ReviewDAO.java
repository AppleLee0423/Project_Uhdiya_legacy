package com.spring.Uhdiya.board.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.Uhdiya.board.qna.QnaDTO;
import com.spring.Uhdiya.board.qna.QnaFileDTO;

@Repository
public class ReviewDAO {
	@Autowired SqlSession sqlSession;

	public List<ReviewDTO> all_review(Map<String, Object> pageMap) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.review.all_review",pageMap);
	}

	public int total_review() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.review.total_review");
	}

	public List<ReviewDTO> product_review(Map<String, Object> pageMap) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.review.product_review",pageMap);
	}

	public int total_product_review(String product_code) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.review.total_product_review",product_code);
	}

	public List<ReviewDTO> my_review(Map<String, Object> pageMap) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.review.my_review",pageMap);
	}

	public int total_my_review(String review_writeId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.review.total_my_review",review_writeId);
	}

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

	private void insert_review_file(Map<String, Object> reviewMap) {
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

	private int new_review_file_number() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.review.new_review_file_num");
	}

	private int new_review_number() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.review.new_review_num");
	}

	public void update_review(Map<String, Object> reviewMap) {
		// TODO Auto-generated method stub
		Integer review_id = Integer.parseInt((String) reviewMap.get("review_id"));
		sqlSession.update("mapper.review.update_review",reviewMap);
		if(reviewMap.get("imageList") != null) {
			sqlSession.delete("mapper.review.delete_review_file",review_id);
			insert_review_file(reviewMap);
		}
	}

	public void delete_review(int review_id) {
		// TODO Auto-generated method stub
		sqlSession.delete("mapper.review.delete_review",review_id);
		sqlSession.delete("mapper.review.delete_review_file",review_id);
	}

	public Map<String, Object> one_review(int review_id) {
		// TODO Auto-generated method stub
		ReviewDTO reviewDTO = sqlSession.selectOne("mapper.review.one_review", review_id);
		List<ReviewFileDTO> reviewFileList = sqlSession.selectList("mapper.review.one_review_file", review_id);
		Map<String, Object> reviewMap = new HashMap<String, Object>();
		reviewMap.put("reviewDTO", reviewDTO);
		reviewMap.put("reviewFileList", reviewFileList);
		return reviewMap;
	}
}