package com.spring.Uhdiya.product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

@Repository
public class ProductDAO {
	@Autowired SqlSession sqlSession;
	
	//상품등록(제품고유코드 중복체크
	public int productCodeCheck(String product_code) {
		int cnt = sqlSession.selectOne("mapper.product.productCodeCheck",product_code);
		return cnt;
	}
	//상품삭제
	public int delProduct(String del_product_code) {
		int result = sqlSession.delete("mapper.product.delProductFile",del_product_code);
		if(result>=1) {
			result = sqlSession.delete("mapper.product.delProduct",del_product_code);
		} else {
			System.out.println("사진데이터베이스 삭제 오류");
		}
		return result;
	}
	//검색
	public List<ProductDTO> searchProduct(Map search) {
		List<ProductDTO> productsList = (ArrayList)sqlSession.selectList("mapper.product.selectSearchProduct",search);
		return productsList;
	}
	// 검색결과 카운트
	public int selectSearchProductCnt(Map search) {
		int total = sqlSession.selectOne("mapper.product.selectSearchProductCnt",search);
		return total;
	}
	// 대분류 카운트
	public int selectProductsByCateL(Map search) {
		int total = sqlSession.selectOne("mapper.product.selectProductCountByCateL",search);
		return total;
	}
	// 대분류 리스트페이지에서 소분류별 토탈
	public List<ProductCntDTO> selectCountByCateS(Map search) {
		List<ProductCntDTO> totalS = (ArrayList)sqlSession.selectList("mapper.product.selectCountByCateS",search);
		return totalS;
	}
	// 소분류 카운트
	public int selectProductsByCateS(String product_cateS) {
		int total = sqlSession.selectOne("mapper.product.selectProductCountByCateS",product_cateS);
		return total;
	}
	// 제품메인사진, 제품명, 제품금액 (대분류) : 대분류 제품리스트페이지에서 사용
	public List<ProductDTO> selectProductsListL(Map search) {
		List<ProductDTO> productList = (ArrayList)sqlSession.selectList("mapper.product.selectProductsListL",search);
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
	// 상품추가
	public void insertNewProduct(Map<String, Object> productMap) {
		sqlSession.insert("mapper.product.insertNewProduct", productMap);
	}
	// 상품 사진 추가
	public void insertGoodsImageFile(List fileList)  throws DataAccessException {
		for(int i=0; i<fileList.size();i++){
			ProductFileDTO imageFileVO=(ProductFileDTO)fileList.get(i);
			sqlSession.insert("mapper.product.insertGoodsImageFile",imageFileVO);
		}
	}

}