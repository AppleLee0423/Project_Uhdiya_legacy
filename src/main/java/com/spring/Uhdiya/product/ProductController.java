package com.spring.Uhdiya.product;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping("/product/**")
public class ProductController {
	@Autowired ProductService productService;
	
	
	
	// http://localhost:8080/Uhdiya/product/beansList
	// 카테고리:대분류선택, 드롭다운:소분류선택 후 제품리스트 페이지 접근
	@RequestMapping(value="/product/*List")
	public ModelAndView productList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		Map<String,List<ProductDTO>> productsMap=productService.listProducts();
		mav.addObject("productsMap", productsMap);
		return mav;
	}
	
	// http://localhost:8080/Uhdiya/product/productDetail (제품명+Detail로 변경예정)
	// 카테고리:대분류선택, 드롭다운:소분류선택 후 제품리스트 페이지 접근
	@RequestMapping(value="/product/*Detail")
	public ModelAndView productDetail(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		return mav;
	}
	
	/*
	create table product (
		    id number not null,
		   product_code varchar2(255) not null primary key, 
		   product_name varchar2(150) not null, -- 제품명
		   product_cateL varchar2(30) not null,  -- 대분류
		   product_cateS varchar2(30) not null,   -- 소분류
		   product_price number not null --제품가격
		);

		create table product_file (
		   product_fileId number not null primary key,
		   product_fileName varchar2(255) not null,
		   product_code varchar2(255) not null
		);
	
	*/

}