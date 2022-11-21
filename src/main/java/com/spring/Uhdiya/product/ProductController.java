package com.spring.Uhdiya.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/product/**")
public class ProductController {
	@Autowired ProductService productService;
	
//상품디테일 : http://localhost:8080/Uhdiya/product/productDetail?product_code=beans001
//소분류리스트페이지 : http://localhost:8080/Uhdiya/product/productList?product_cateL=커피&product_cateS=홀빈원두
//대분류리스트페이지 : http://localhost:8080/Uhdiya/product/productList?product_cateL=커피&product_cateS=
	
	//리스트페이지
	@RequestMapping(value="productList")
	public ModelAndView productList(
			@RequestParam("product_cateL") String product_cateL,
			@RequestParam("product_cateS") String product_cateS,
			@RequestParam Map<String, String> pageMap,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		String page = pageMap.get("page");
		System.out.println(page);
		if(page==null) {
			page="1";
		}
		Map search = new HashMap();
		String count = "8";
		search.put("page", page);
		search.put("count", count);
		search.put("cateL", product_cateL);
		search.put("cateS", product_cateS);
		
		if(product_cateS=="") {
			Map productsMap = productService.listProductsL(search);
			mav.addObject("productsMap", productsMap);
		} else {
			Map<String,List<ProductDTO>> productsMap=productService.listProductsS(product_cateS);
			mav.addObject("productsMap", productsMap);
		}
		return mav;
	}
	
	/*
	//리스트페이지
	@RequestMapping(value="page")
	public void productListPage(
			@RequestParam("product_cateL") String product_cateL,
			@RequestParam("product_cateS") String product_cateS,
			@RequestParam("page") Integer page,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
//		String viewName = "product/productList/page";
//		ModelAndView mav = new ModelAndView(viewName);
//		System.out.println(viewName);
		if(page==2) {
			System.out.println("두번째페이지");
		}
		if(page==3) {
			System.out.println("세번째페이지");
		}
//		
//		if(product_cateS=="") {
//			Map productsMap=productService.listProductsL(product_cateL);
//			mav.addObject("productsMap", productsMap);
//		} else {
//			Map<String,List<ProductDTO>> productsMap=productService.listProductsS(product_cateS);
//			mav.addObject("productsMap", productsMap);
//		}
//		return mav;
	}
	
	*/
	
	
	
	// http://localhost:8080/Uhdiya/product/productDetail=beans001
	// 카테고리:대분류선택, 드롭다운:소분류선택 후 제품리스트 페이지 접근
	@RequestMapping(value="productDetail" ,method = RequestMethod.GET)
	public ModelAndView productDetail(
			@RequestParam("product_code") String product_code,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		Map productsMap=productService.productsDetail(product_code);
		mav.addObject("productsMap", productsMap);
		return mav;
	}

	/*
	create table product (
		    product_id number not null,
		   product_code varchar2(255) not null primary key, -- 제품고유코드
		   product_name varchar2(255) not null, -- 제품명
		   product_cateL varchar2(255) not null,  -- 대분류
		   product_cateS varchar2(255) not null,   -- 소분류
		   product_price number not null --제품가격
		);
		create SEQUENCE pro_seq
		    increment by 1
		    start with 100
		    nocache;
		create table product_file (
		   product_fileId number not null primary key,  
		   product_fileName varchar2(255) not null, --파일명
		   product_fileType varchar2(255) not null, -- main(제품사진) 또는 info(제품상세설명사진)
		   product_code varchar2(255) not null -- 제품고유코드 (product테이블)
		);
		create SEQUENCE proFile_seq
		    increment by 1
		    start with 100
		    nocache;

		insert into product values (pro_seq.nextval,'beans001','[어디야] 홀빈커피 페르소나 블렌드 200g X 2개','커피','홀빈원두',26000);
		insert into product values (pro_seq.nextval,'beans002','[어디야] 홀빈커피 콜롬비아 슈프리모 200g X 2개','커피','홀빈원두',24000);
		insert into product values (pro_seq.nextval,'beans003','[어디야] 홀빈커피 케냐 오리진 200g X 2개','커피','홀빈원두',26000);
		insert into product values (pro_seq.nextval,'beans004','[어디야] 홀빈커피 브라질 세라도 200g X 2개','커피','홀빈원두',24000);
		insert into product values (pro_seq.nextval,'beans005','[어디야] 홀빈커피 에티오피아 리무 200g X 2개','커피','홀빈원두',26000);
		insert into product values (pro_seq.nextval,'drip001','[어디야] 커피랩 핸드드립 페르소나 7T x 3개','커피','핸드드립',16500);
		insert into product values (pro_seq.nextval,'drip002','[어디야] 커피랩 핸드드립 에티오피아 7T x 3개','커피','핸드드립',15500);
		insert into product values (pro_seq.nextval,'cupcoffee001','[어디야] 컵커피 5종 X 2개 (토피넛/카페라떼/돌체 콜드브루/바닐라/쇼콜라 모카)','음료','컵커피',18900);

		insert into product_file values (proFile_seq.nextval,'beans001.jpg','main','beans001');
		insert into product_file values (proFile_seq.nextval,'beans002.jpg','main','beans002');
		insert into product_file values (proFile_seq.nextval,'beans003.jpg','main','beans003');
		insert into product_file values (proFile_seq.nextval,'beans004.jpg','main','beans004');
		insert into product_file values (proFile_seq.nextval,'beans005.jpg','main','beans005');
		insert into product_file values (proFile_seq.nextval,'drip001.jpg','main','drip001');
		insert into product_file values (proFile_seq.nextval,'drip002.jpg','main','drip002');
		insert into product_file values (proFile_seq.nextval,'cupcoffee001.jpg','main','cupcoffee001');

		insert into product_file values (proFile_seq.nextval,'beans001_info.jpg','info','beans001');
		insert into product_file values (proFile_seq.nextval,'beans002_info.jpg','info','beans002');
		insert into product_file values (proFile_seq.nextval,'beans003_info.jpg','info','beans003');
		insert into product_file values (proFile_seq.nextval,'beans004_info.jpg','info','beans004');
		insert into product_file values (proFile_seq.nextval,'beans005_info.jpg','info','beans005');
		insert into product_file values (proFile_seq.nextval,'drip001_info.jpg','info','drip001');
		insert into product_file values (proFile_seq.nextval,'drip002_info.jpg','info','drip002');
		insert into product_file values (proFile_seq.nextval,'cupcoffee001_info.jpg','info','cupcoffee001');

		commit;
	 	*/
	

}