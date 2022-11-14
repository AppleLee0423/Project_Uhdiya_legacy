package com.spring.Uhdiya.product;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;


@Repository
public class ProductDAO {
	@Autowired SqlSession sqlSession;

	public List<ProductDTO> selectProductsList(String cateS) {
		
		List<ProductDTO> productList = (ArrayList)sqlSession.selectList("mapper.product.selectProductsList",cateS);
		
		return productList;
	}
	
	
	

//	public List<NoticeDTO> selectAllNotice() {
//		// TODO Auto-generated method stub
//		return sqlSession.selectList("mapper.board.selectAllNotice");
//	}
}