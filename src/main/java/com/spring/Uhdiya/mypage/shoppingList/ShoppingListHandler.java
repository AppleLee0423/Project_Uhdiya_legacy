package com.spring.Uhdiya.mypage.shoppingList;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;


public class ShoppingListHandler {
//주문내역 조회를 위한 핸들러
	private static ShoppingListHandler slhDAO;
	private static SqlSessionFactory ssf;
	
	private ShoppingListHandler() {
		org.apache.ibatis.logging.LogFactory.useLog4JLogging();
	}//생성자
	
	public static ShoppingListHandler getInstance() {
		if(slhDAO==null) { //객체가 null이라면
			slhDAO=new ShoppingListHandler();
		}//end if
		return slhDAO; //객체 초기화
	}//getInstance	

	public SqlSession getSqlSession() {
		
		SqlSession ss=null;
		
		if(ssf ==null) {
			try {
				//1.Stream
				//xml 주소가 어디인가?
				String xmlConfig="com/spring/Uhdiya/mypage/shoppingList/mybatis_shoppingList_config.xml";
				Reader reader=Resources.getResourceAsReader(xmlConfig);
				
				//2MyBatis Framework 
				ssf=new SqlSessionFactoryBuilder().build(reader);
				reader.close();
			}catch(IOException ie) {
				ie.printStackTrace();
			}//end catch
		}//end if
		ss=ssf.openSession();
		return ss;
	}//getSqlSessionFactory
	
	
}//class
