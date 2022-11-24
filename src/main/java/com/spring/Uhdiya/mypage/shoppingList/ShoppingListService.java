package com.spring.Uhdiya.mypage.shoppingList;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;

public class ShoppingListService {
    //선택한 기간 계산하기
	//String day : 1일전 3일전 7일전 한 달 세 달전 전체...
	//String searchDay : 사용자가 찾으려는 날짜 중 제일 과거의 날짜
	//예 : 오늘 -> 221118 1일전 -> 221117일때, 사용자는 오늘부터 1일전 까지의 구매목록을 보고 싶어 하는 것
	//searchDay는 221117이 된다.
	public DaySearchVO searchDay(String day, String id) {
		DaySearchVO daySearchVO=new DaySearchVO();
		
		//VO에 아이디 저장
		daySearchVO.setId(id);
		
		//찾고자 하는 날짜 구하기(searchDay 구하기)
		Calendar calendar = new GregorianCalendar();
		SimpleDateFormat SDF = new SimpleDateFormat("yyyy-MM-dd");
		
		daySearchVO.setToday(SDF.format(calendar.getTime())); //오늘날짜 vo에 저장	
		//System.out.println("오늘 날짜 : " + chkDate);
		
		/** jre different
		switch(day) {
		case "1" : 
			calendar.add(Calendar.DATE, -1);	
			break;
		case "3" :
			calendar.add(Calendar.DATE, -3);	
			break;
		case "7" : 
			calendar.add(Calendar.DATE, -7);	
			break;
		case "30" : 
			calendar.add(Calendar.DATE, -30);	
			break;
		case "90" : 
			calendar.add(Calendar.DATE, -90);	
			break;
		}//switch
		*/
		daySearchVO.setSearchDay(SDF.format(calendar.getTime())); //검색할 날짜 중 가장 과거의 날짜
		
		//전체 구매 내역 조회 시 과거 날짜 구할 필요 없음
		if(day =="all") {
			daySearchVO.setSearchDay(null);
		}//end if
		
		//System.out.println("제일 과거의 숫자 : "+searchDay);
		
		//VO의 searchDay today의 형식 0000-00-00을 0000/00/00으로 바꿈(db select 조회를 위해)
		String searchDayChg=daySearchVO.getSearchDay();
		String todayChg=daySearchVO.getToday();
		if(day != "all") {
			daySearchVO.setSearchDay(searchDayChg.replace('-', '/'));
		}//end if -- all일때 replace문법을 실행시킬 수 없으므로
		daySearchVO.setToday(todayChg.replace('-', '/'));
		
		return daySearchVO;
	}//searchDay
	
	//기간에 따른 주문내역 db에서 select 
	public List<ShoppingListDomain> searchShoppingList(String day, String id) {
		List<ShoppingListDomain> sldList=new ArrayList<ShoppingListDomain>(); //domain담을 list 생성
		DaySearchVO daySearchVO=new DaySearchVO(); //날짜 설정
		daySearchVO=searchDay(day, id); //searchDay 메소드를 실행시킴
		
		//DAO에서 select문 실행
		//DAO객체 생성
		ShoppingListDAO slDAO=ShoppingListDAO.getInstance();
		sldList=slDAO.selectShoppingList(daySearchVO);
				
		return sldList;
	}//class
	
	//searchDetail
	public ShoppingListDomain searchDetail(String order_num, String id){
		ShoppingListDomain sldList=new ShoppingListDomain();
		
		//VO생성
		DetailSearchVO detailSearchVO=new DetailSearchVO();
		detailSearchVO.setOrder_num(order_num);
		detailSearchVO.setId(id);
		
		//DAO에서 select문 실행
		ShoppingListDAO slDAO=ShoppingListDAO.getInstance();
		sldList=slDAO.selectDetail(detailSearchVO);
		
		
		
		return sldList;
	}//searchDetail

}//class