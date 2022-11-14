package com.spring.Uhdiya.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class ProductService {
	@Autowired ProductDAO productDAO;

	public Map<String, List<ProductDTO>> listProducts() {
		
		Map<String,List<ProductDTO>> productsMap = new HashMap<String,List<ProductDTO>>();
		
		//소분류별로 추가예정
		List<ProductDTO> productsList = productDAO.selectProductsList("홀빈원두");
		productsMap.put("test", productsList);
		
		return productsMap;
	}
	

}