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
	
	// 제품메인사진, 제품명, 제품금액 (대분류) : 대분류 제품리스트페이지에서 사용
	public List<ProductDTO> selectProductsListL(String cateL) {
		List<ProductDTO> productList = (ArrayList)sqlSession.selectList("mapper.product.selectProductsListL",cateL);
		return productList;
	}
	// 제품메인사진, 제품명, 제품금액 (소분류) : 소분류 제품리스트페이지에서 사용
	public List<ProductDTO> selectProductsListS(String cateS) {
		List<ProductDTO> productList = (ArrayList)sqlSession.selectList("mapper.product.selectProductsListS",cateS);
		return productList;
	}
	// 제품메인사진, 제품명, 제품금액 등 (제품고유코드)
	public ProductDTO selectProductDetail(String product_code) {
		ProductDTO productDTO = (ProductDTO) sqlSession.selectOne("mapper.product.selectProductDetail",product_code);
		return productDTO;
	}
	// 제품의 상세정보 사진 (제품고유코드) : 상세정보사진은 1개만 저장했으나 2개이상을 대비
	public List<ProductFileDTO> selectProductInfoFile(String product_code) {
		List<ProductFileDTO> infoFileList = (ArrayList)sqlSession.selectList("mapper.product.selectProductInfoFile",product_code);
		return infoFileList;
	}
	// 토탈 카운트
	public int selectProductsByCateS(String product_cateS) {
		int total = sqlSession.selectOne("mapper.product.selectProductCountByCateS",product_cateS);
		return total;
	}
	public int selectProductsByCateL(String product_cateL) {
		int total = sqlSession.selectOne("mapper.product.selectProductCountByCateL",product_cateL);
		return total;
	}
	public List<ProductCntDTO> selectCountByCateS(String product_cateL) {
		List<ProductCntDTO> totalS = (ArrayList)sqlSession.selectList("mapper.product.selectCountByCateS",product_cateL);
		return totalS;
	}

	
	
	

//	public List<NoticeDTO> selectAllNotice() {
//		// TODO Auto-generated method stub
//		return sqlSession.selectList("mapper.board.selectAllNotice");
//	}
}