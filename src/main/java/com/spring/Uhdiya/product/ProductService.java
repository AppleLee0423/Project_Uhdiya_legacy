package com.spring.Uhdiya.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



@Service
public class ProductService {
	@Autowired ProductDAO productDAO;

	public Map listProductsL(Map search) {
		Map productsMap = new HashMap();

		List<ProductDTO> productsList = productDAO.selectProductsListL(search);
		productsMap.put("productsList", productsList);

		int total = productDAO.selectProductsByCateL(search);
		productsMap.put("total", total);

		List<ProductCntDTO> totalS = productDAO.selectCountByCateS(search);
		productsMap.put("totalS", totalS);

		int totalAllL = productDAO.selectCountAllL(search);
		productsMap.put("totalAllL", totalAllL);

		return productsMap;
	}

	/*
	//대분류
	public Map<String, List<ProductDTO>> listProductsL(String product_cateL) {
		Map productsMap = new HashMap();

		List<ProductDTO> productsList = productDAO.selectProductsListL(product_cateL);
		productsMap.put("productsList", productsList);

		int total = productDAO.selectProductsByCateL(product_cateL);
		productsMap.put("total", total);

		List<ProductCntDTO> totalS = productDAO.selectCountByCateS(product_cateL);
		productsMap.put("totalS", totalS);

		int totalAllL = productDAO.selectCountAllL(product_cateL);
		productsMap.put("totalAllL", totalAllL);

		return productsMap;
	}

	 */
	//소분류
	public Map<String, List<ProductDTO>> listProductsS(String product_cateS) {
		Map productsMap = new HashMap();

		List<ProductDTO> productsList = productDAO.selectProductsListS(product_cateS);
		productsMap.put("productsList", productsList);

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









}