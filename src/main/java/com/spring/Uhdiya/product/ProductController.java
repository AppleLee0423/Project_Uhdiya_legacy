package com.spring.Uhdiya.product;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.Uhdiya.common.interceptor.ViewNameInterceptor;




@Controller
@RequestMapping("/product/**")
public class ProductController {
	private static final String UHDIYA_IMAGE_REPO  = "C:\\Uhdiya" + "\\product"; 
	
	@Autowired ProductService productService;
	
//소분류리스트페이지 : http://localhost:8080/Uhdiya/product/productList?product_cateL=커피&product_cateS=홀빈원두
//대분류리스트페이지 : http://localhost:8080/Uhdiya/product/productList?product_cateL=커피&product_cateS=
//디테일 페이지 : http://localhost:8080/Uhdiya/product/productDetail?product_cateL=커피&product_cateS=홀빈원두&product_code=beans001
//관리자 상품추가 :  http://localhost:8080/Uhdiya/product/addProductForm
//관리자 상품검색삭제 : http://localhost:8080/Uhdiya/product/modProductList?searchSel=product_name
	
	
	//상품등록(제품고유코드 중복체크)
	@RequestMapping("productCodeCheck")
	@ResponseBody
	public String productCodeCheck(@RequestParam("product_code") String product_code)	{
		int cnt=productService.productCodeCheck(product_code);
		String res = "";
    	if( cnt > 0 ) {
    		res = "n";
    	} else if (cnt==0) {
    		res="y";
    	}
    	return res;
	}
	
	//상품삭제
	@RequestMapping("/delProduct")
	public void delProduct(
			@RequestParam Map<String, String> delMap,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/html;charset=utf-8");
		
		String del_product_code = delMap.get("del_product_code");
		String url = delMap.get("url");
		System.out.println(del_product_code);
		System.out.println(url);
		
		PrintWriter out = response.getWriter();
		
		String msg = null;
		try {
			int result = productService.delProduct(del_product_code);
			if(result>=1) {
				File file = new File(UHDIYA_IMAGE_REPO + "\\" + del_product_code);
				FileUtils.deleteDirectory(file);
				msg = "정삭적으로 삭제가 완료 되었습니다.";
			}
		} catch(Exception e){
			msg = "삭제에 실패했습니다. 다시 시도하세요.";
			e.printStackTrace();
		}
		out.println("<script>");
		out.println("alert('" + msg + "');");
		out.println("location.href='" + url + "';");
		out.println("</script>");
	}
	
	// 상품검색,목록(관리자)
	@RequestMapping("modProductList")
	public ModelAndView modProductList(
			@RequestParam Map<String, String> pageMap,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		String page = pageMap.get("page");
		if(page==null || page=="0" || page=="-1") {
			page="1";
		}
		String product_cateL = pageMap.get("product_cateL");
		if(product_cateL==null) {
			product_cateL="";
		}
		String product_cateS = pageMap.get("product_cateS");
		if(product_cateS==null) {
			product_cateS="";
		}
		String searchSelTxt = pageMap.get("searchSelTxt");
		if(searchSelTxt==null) {
			searchSelTxt="";
		}
		Map search = new HashMap();
		search.put("product_cateL", product_cateL);
		search.put("product_cateS", product_cateS);
		search.put("searchSel", pageMap.get("searchSel"));
		search.put("searchSelTxt", searchSelTxt);
		
		String count = "10";
		search.put("page", page);
		search.put("count", count);
		
		Map productsMap = productService.searchProduct(search);
		mav.addObject("productsMap", productsMap);
		
		return mav;
	}
	// 상품리스트페이지(대분류,소분류)
	@RequestMapping(value="productList")
	public ModelAndView productList(
			@RequestParam("product_cateL") String product_cateL,
			@RequestParam("product_cateS") String product_cateS,
			@RequestParam Map<String, String> pageMap,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		String page = pageMap.get("page");
		if(page==null || page=="0" || page=="-1") {
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
	
	// 상품디테일페이지
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

	// 상품등록
	@RequestMapping("addProductForm")
	public ModelAndView addProductForm(HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	public ResponseEntity<String> addProduct(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		Map<String, Object> productMap = new HashMap<String, Object>();
		Enumeration<String> enu = multipartRequest.getParameterNames();

		while(enu.hasMoreElements()) {
			String name = enu.nextElement();
			String value = multipartRequest.getParameter(name);
			productMap.put(name, value);
		}
		////////
		String message;
		ResponseEntity<String> resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html;charset=utf-8");
		try {
			productService.addNewProduct(productMap);
			message = "<script>";
			message += "alert('상품을 추가했습니다.');";
			message += "location.href='" + multipartRequest.getContextPath() +"/product/addProductForm';";
			message += "</script>";
			resEnt = new ResponseEntity<String>(message, responseHeaders, HttpStatus.OK);
		} catch(Exception e) {
			message = "<script>";
			message += "alert('상품추가 오류가 발생했습니다. 상품이 추가되지 않았습니다. 다시 시도해 주세요.');";
			message += "location.href='" + multipartRequest.getContextPath() +"/product/addProductForm';";
			message += "</script>";
			resEnt = new ResponseEntity<String>(message, responseHeaders, HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		////////
		String imageFileName=null;
		List<ProductFileDTO> imageFileList=null;
		String product_code=null;
		try {
			imageFileList =upload(multipartRequest);
			if(imageFileList!= null && imageFileList.size()!=0) {
				for(ProductFileDTO imageFileVO : imageFileList) {
					product_code = (String)productMap.get("product_code");
					imageFileVO.setProduct_code(product_code);
				}
			    productService.addNewGoodsImage(imageFileList);
				for(ProductFileDTO  imageFileVO:imageFileList) {
					imageFileName = imageFileVO.getProduct_fileName();
					File srcFile = new File(UHDIYA_IMAGE_REPO+"\\"+"temp"+"\\"+imageFileName);
					File destDir = new File(UHDIYA_IMAGE_REPO+"\\"+product_code);
					FileUtils.moveFileToDirectory(srcFile, destDir,true);
				}
			}
		}catch(Exception e) {
			if(imageFileList!=null && imageFileList.size()!=0) {
				for(ProductFileDTO  imageFileVO:imageFileList) {
					imageFileName = imageFileVO.getProduct_fileName();
					File srcFile = new File(UHDIYA_IMAGE_REPO+"\\"+"temp"+"\\"+imageFileName);
					srcFile.delete();
				}
			}
			e.printStackTrace();
		}
		return resEnt;
	}
	private List<String> uploadMulti(MultipartHttpServletRequest multipartRequest) throws Exception{
		// TODO Auto-generated method stub
		List<String> fileList = new ArrayList<String>();
		Iterator<String> fileNames = multipartRequest.getFileNames();
		
		while(fileNames.hasNext()) {
			String fileName= fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			String originalFileName = mFile.getOriginalFilename();
			fileList.add(originalFileName);
			
			File file = new File(UHDIYA_IMAGE_REPO  + "\\" + fileName);
			if(mFile.getSize() != 0) {
				if(!file.exists()) {
					if(file.getParentFile().mkdirs()) {
						file.createNewFile();
					}
				}
				mFile.transferTo(new File(UHDIYA_IMAGE_REPO  + "\\" + "temp" + "\\" + originalFileName));
			}
		}
		return fileList;
	}
	private List<ProductFileDTO> upload(MultipartHttpServletRequest multipartRequest) throws Exception{
		List<ProductFileDTO> fileList= new ArrayList<ProductFileDTO>();
		Iterator<String> fileNames = multipartRequest.getFileNames();
		while(fileNames.hasNext()){
			ProductFileDTO imageFileVO =new ProductFileDTO();
			String fileName = fileNames.next();
			imageFileVO.setProduct_fileType(fileName);
			MultipartFile mFile = multipartRequest.getFile(fileName);
			String originalFileName=mFile.getOriginalFilename();
			imageFileVO.setProduct_fileName(originalFileName);
			fileList.add(imageFileVO);
			
			File file = new File(UHDIYA_IMAGE_REPO +"\\"+ fileName);
			if(mFile.getSize()!=0){ 
				if(! file.exists()){ 
					if(file.getParentFile().mkdirs()){ 
							file.createNewFile(); 
					}
				}
				mFile.transferTo(new File(UHDIYA_IMAGE_REPO +"\\"+"temp"+ "\\"+originalFileName)); 
			}
		}
		return fileList;
	}

}