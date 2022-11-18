package com.spring.Uhdiya.product;

public class ProductFileDTO {
	
	private int product_fileId;
	private String product_fileName;
	private String product_fileType;
	private String product_code;
	
	
	
	public String getProduct_fileType() {
		return product_fileType;
	}
	public void setProduct_fileType(String product_fileType) {
		this.product_fileType = product_fileType;
	}
	public int getProduct_fileId() {
		return product_fileId;
	}
	public void setProduct_fileId(int product_fileId) {
		this.product_fileId = product_fileId;
	}
	public String getProduct_fileName() {
		return product_fileName;
	}
	public void setProduct_fileName(String product_fileName) {
		this.product_fileName = product_fileName;
	}
	public String getProduct_code() {
		return product_code;
	}
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
	
	

}
