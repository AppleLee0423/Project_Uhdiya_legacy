package com.spring.Uhdiya.mypage.shoppingList;

public class DaySearchVO {
//오늘 날짜와 찾고자 하는 날짜 중 가장 과거의 날짜
	private String id; //구매목록을 보려는 사용자의 아이디
	private String today; // 오늘날짜
	private String searchDay; // 검색 하는 날짜 중 가장 과거의 날짜
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getToday() {
		return today;
	}
	public void setToday(String today) {
		this.today = today;
	}
	public String getSearchDay() {
		return searchDay;
	}
	public void setSearchDay(String searchDay) {
		this.searchDay = searchDay;
	}
	
	
}//class
