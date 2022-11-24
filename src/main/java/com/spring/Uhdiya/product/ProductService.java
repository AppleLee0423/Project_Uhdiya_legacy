package com.spring.Uhdiya.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



@Service
public class ProductService {
	@Autowired ProductDAO productDAO;
	
	//상품삭제
	public int delProduct(String del_product_code) {
		int result = productDAO.delProduct(del_product_code);
		return result;
	}
	// 관리자검색
	public Map searchProduct(Map search) {
		Map productsMap = new HashMap();
		List<ProductDTO> productsList = productDAO.searchProduct(search);
		productsMap.put("productsList", productsList);
		
		// 검색결과 카운트
		int total = productDAO.selectSearchProductCnt(search);
		productsMap.put("total", total);
		
		return productsMap;
	}
	// 대분류페이지
	public Map listProductsL(Map search) {
		Map productsMap = new HashMap();

		List<ProductDTO> productsList = productDAO.selectProductsListL(search);
		productsMap.put("productsList", productsList);

		// 대분류 카운트
		int total = productDAO.selectProductsByCateL(search);
		productsMap.put("total", total);

		// 대분류페이지에서 소분류별 카운트
		List<ProductCntDTO> totalS = productDAO.selectCountByCateS(search);
		productsMap.put("totalS", totalS);

		return productsMap;
	}
	// 소분류페이지
	public Map<String, List<ProductDTO>> listProductsS(String product_cateS) {
		Map productsMap = new HashMap();

		List<ProductDTO> productsList = productDAO.selectProductsListS(product_cateS);
		productsMap.put("productsList", productsList);

		// 소분류 카운트
		int total = productDAO.selectProductsByCateS(product_cateS);
		productsMap.put("total", total);
		return productsMap;
	}
	//상품상세
	public Map productsDetail(String product_code) throws Exception {
		Map productsMap = new HashMap();

		ProductDTO productDTO = productDAO.selectProductDetail(product_code);
		productsMap.put("productDTO",productDTO);

		List<ProductFileDTO> infoFileList = productDAO.selectProductInfoFile(product_code);
		productsMap.put("infoFileList", infoFileList);
		return productsMap;
	}

	//상품추가
	public Map addNewProduct(Map<String, Object> productMap) {
		productDAO.insertNewProduct(productMap);
		return productMap;
	}
	//상품사진추가
	public void addNewGoodsImage(List imageFileList) throws Exception{
		productDAO.insertGoodsImageFile(imageFileList);
	}

	
	









}