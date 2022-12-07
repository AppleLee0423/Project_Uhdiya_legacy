<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="total_qna" value="${total_qna}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://kit.fontawesome.com/96e0fede2d.js" crossorigin="anonymous"></script>
<script>
	let current_page = 1; // 현재 페이지
	$(function(){
		let now = new Date();
		let today = date_setting(now);
		
		$('input[name=endDate]').attr('max',today);
		$('input[name=endDate]').val(today);
		
		let ago = new Date(new Date(now.setDate(now.getDate()-365)));
		let year = date_setting(ago);
		$('input[name=startDate]').attr('min',year);
		
		checkbox_setting();
		
		paging_set();
		
		get_page();
		
		let reply_modal = $('.reply_modal');
		let reply_open = $('#reply_btn');
		
		$('#reply_btn').click(function(){
			$('.reply_modal').css("display","block");
			$('body').css("overflow","hidden");
		});
		
		$('#reply_close_btn').click(function(){
			$('.reply_modal').css("display","none");
			$('body').css("overflow","unset");
		});
		
		
	});
	
	// 테이블 불러오기
	function get_page(){		
		let list_day = $('#list_day').val();
		let list_count = $('#list_count').val();
		let start_date = null;
		
		if($('input[name=startDate]').val() != null){
			start_date = $('input[name=startDate]').val();
		}
		
		let end_date = $('input[name=endDate]').val();
		if(start_date == null || end_date == null){
			start_date = $('input[name=startDate]').attr('min');
			end_date = $('input[name=endDate]').attr('max');
		}

		let keyword_set = $('#keyword_set').val();
		let keyword = $('#keyword').val();
		
		var status = null;
		if ($('input[name="status"]:checked').length == 0){
			status = 2;
		} else {
			$("input[name='status']:checked").each(function(i) {
		        status = ($(this).val());
		    });
		}
		
		console.log(end_date);
		var data_str = 
		{
			'current_page' : current_page,
			'list_count' : list_count,
			'list_day' : list_day,
			'start_date' : start_date,
			'end_date' : end_date,
			'keyword_set' : keyword_set,
			'keyword' : keyword,
			'status' : status
		}
		
		$.ajax({
			url:'/Uhdiya/board/do_qna_list',
			data:data_str,
			dataType:'json',
			contentType: "application/json;charset=UTF-8" ,
			success:function(data){
				var qna_list = data.qna_list;
				var reply_list = data.reply_list;
				var total_qna = ${total_qna};
				
				$('.no_content').empty();
				$('.list_content').empty();
				
				if(qna_list.length == 0){
					var empty_content = '<p id="empty_content" align="center" style="padding-top:13px;">작성된 문의가 없습니다.</p>';
					$('.no_content').append(empty_content);
					$('.list_content').css("display","none");
				} else {
					$('.no_content').css("display","none");
					var list_content = "";
					$('#total_qna').text(qna_list.length);
					for(let i=0; i<qna_list.length; i++){
						list_content = '<details>';
						list_content += '<summary>';
						list_content += '<span id="num">'+(total_qna-i)+'</span>';
						list_content += '<span id="product">'+qna_list[i].product_name+'</span>';
						list_content += '<span id="title" onclick="go_page('+qna_list[i].qna_id+')">&nbsp;&nbsp;'+qna_list[i].qna_title+'</span>';
						list_content += '<span id="writer">'+qna_list[i].qna_writeId+'</span>';
						list_content += '<span id="date">'+qna_list[i].qna_regDate+'</span>';

						if(qna_list[i].qna_status == 0){
							//list_content += '<span id="status"><button id="reply_btn">답변하기</button></span>';
							list_content += '<span id="status"><button id="reply_btn" onclick="modal_set('+qna_list[i].qna_id+')">답변하기</button></span>';
						} else if(qna_list[i].qna_status == 1){
							list_content += '<span id="status">답변완료</span>';
						}
						
						list_content += '<span id="delete"><button id="delete_btn" onclick="delete_qna('+qna_list[i].qna_id+')">삭제</button></span>';
						list_content += '</summary>';
						list_content += '<div class="content_inner">';
						list_content += '<div class="user_content">';
						list_content += '<span id="content">'+qna_list[i].qna_content+'</span>';
						list_content += '</div>';
						list_content += '<input type="hidden" name="qna_id" value="'+qna_list[i].qna_id+'>"';
						list_content += '<input type="hidden" name="qna_writeId'+qna_list[i].qna_id+'" value="'+qna_list[i].qna_writeId+'>"';
						let qna_num = qna_list[i].qna_id;
						
						for(let j=0; j<reply_list.length; j++){
							var reply_num = reply_list[j].qna_parentId;
							if(qna_num == reply_num){
								list_content += '<div class="reply_content">';
								list_content += '<span id="reply_front">└</span>';
								list_content += '<span id="reply_second">답변</span>';
								list_content += '<span id="reply_content">'+reply_list[j].qna_content+'</span>';
								list_content += '<span id="date" >'+reply_list[j].qna_regDate+'</span>';
								list_content += '<span id="writer">관리자</span>';
								list_content += '</div>';
								list_content += '</details>';
							}
						}
						$('.list_content').append(list_content);
						let send_id = $('input[name=qna_id]').val();
						
					}
				}
			}
		});
	}
	
	// 검색
	function fn_search(){
		keyword_set = $('#keyword_set').val();
		keyword = $('#keyword').val();
		status = $('input[name=status]').val();
		start_date = $('input[name=startDate]').val();
		end_date = $('input[name=endDate]').val();
		
		console.log(keyword);
		console.log(keyword_set);
		
		get_page();
	}
	
	// 취소 버튼
	function fn_reset(){
		now = new Date();
		today = date_setting(now);
		$('input[type=date]').val('');
		$('input[name=endDate]').val(today);
		$('input[name=status]').prop("checked",false);
		$("#keyword_set option:eq(0)").prop("selected", true);
		$('#keyword').val(null);
	}
	
	// 초기화 버튼
	function fn_allset(){
		location.href='${path}/board/qna_list';
	}
	
	// 페이징 세팅
	function paging_set(){
		let list_count = $('#list_count').val();
		let total_qna = ${total_qna};
		
		let total = (total_qna / list_count) + 1;
		$('.list_paging').append('<button id="prev"><i class="fa-solid fa-angle-left"></i></button>');
		for(let i=1; i<total; i++){
			$('.list_paging').append('<button id="page" onclick="page_go(this)">'+i+'</button>');
		}
		$('.list_paging').append('<button id="prev"><i class="fa-solid fa-angle-right"></i></button>');
	}
	
	// 검색란 답변대기, 완료 다중체크 방지 
	function checkbox_setting(){
		$('input[type="checkbox"][name="status"]').click(function(){
			if($(this).prop('checked')){
				$('input[type="checkbox"][name="status"]').prop('checked',false);
				$(this).prop('checked',true);
			}
		});
	}
	
	// 날짜 계산
	function getDay(obj){
		let today = new Date();
		let select_date = $(obj).attr('id');
		
		switch(select_date){
		case 'now': today = new Date(); break;
		case 'week': today = new Date(today.setDate(today.getDate()-7)); break;
		case '1month': today = new Date(today.setMonth(today.getMonth()-1)); break;
		case '3month': today = new Date(today.setMonth(today.getMonth()-3)); break;
		}
		
		date = date_setting(today);
		
		$('input[name=startDate]').val(date);
	}
	
	// 날짜값 형식 세팅
	 function date_setting(today){
		let day = today.getDate();
		let month = today.getMonth()+1;
		let year = today.getFullYear();
		if(day < 10) day = '0'+day;
		if(month < 10) month = '0'+month;
		today = year + '-' + month + '-' + day;
		return today;
	 }

	// 답변창 모달 (작동x)
	function modal_setttt(){
		let reply_modal_btn = document.querySelect('#reply_btn');
		let reply = document.querySelect('.reply');
		//let reply = $('.reply_modal_content');
		//obj.addEventListener('click', function(){}
		reply_modal_btn.addEventListener('click', function(){
		
			reply.css("display","block");
		});
	}
	
	// 답변창 모달 수정
	function modal_set(qna_id){
		$.ajax({
			url:'/Uhdiya/board/reply?qna_id='+qna_id,
			contentType: "application/json;charset=UTF-8" ,
			success:function(data){
				$('.reply_modal').empty();
				$('.reply_modal').append(
						$('<div>').prop({
							class:'reply_modal-content'
							})
						);
				$('.reply_modal-content').html(data); 
				$('.reply_modal').css("display","block");
			}
		});
	}
	
	function go_page(qna_id){
		var qna_writeId = $('input[name=qna_writeId'+qna_id+']').val();
		location.href='/Uhdiya/board/qna_page?qna_id='+qna_id+'&qna_writeId='+qna_writeId+'';
	}
		
	
	// 삭제 버튼
	function delete_qna(qna_id){
		if(confirm('삭제하시겠습니까?')){
			location.href='${path}/board/delete_qna?qna_id='+qna_id;
		} else{
			alert('취소되었습니다.');
		}
	}
</script>
<style>
	@import url("https://fonts.google.com/noto/specimen/Noto+Sans+KR/about?query=noto#supported-writing-systems");
	*{margin:0; padding:0; font-family: Noto Sans Korean;}
	.qna_list{margin:45px auto; width:1200px; background-color: #EDF0F5; padding-top: 10px;}
	.qna_list_header{margin-left:10px;height:60px; box-shadow: 0 6px 6px -6px rgba(0,0,0,1); background-color: #F8F9FD;}
	.qna_list_header_title{margin-left:10px; padding-top:10px;}
	.qna_list_search{margin-top: 10px;margin-left:10px; box-shadow: 0 6px 6px -6px rgba(0,0,0,1); background-color: #F8F9FD;}
	.qna_search_table{width:100%;}
	.qna_search_title{padding-left:20px; width:20%; height:50px;}
	.qna_search_date{width:80%; display: flex; margin-top:5px;}
	.date_btn{width:60px; font-size: small; height: 35px; border:1px solid #474948; background-color: #F8F9FD; color:black; margin-right: 5px;}
	.date_btn:hover{background-color:#474948; color:white;}
	input[type=date] {width:150px; text-align: center; font-weight: bold;}
	input[type=checkbox] {transform:scale(1.3);}
	.qna_search_detail{height:50px;}
	.qna_search_status{padding-top:13px;}
	select{width:100px; height:35px;}
	#keyword {width:480px; height:35px;}
	.qna_search_button input{margin-bottom: 0px;}
	#qna_search_btn {width: 150px; height: 50px; border-radius: 2px; background-color: #474948; color: white; font-size: large;}
	#search_reset, #reset {width: 150px; height: 50px; border-radius: 1px; background-color: transparent; color: black; border-width: 1px; font-size: large; margin-right:50px; margin-top: 25px;}
	
	.qna_list_body_header{margin-left:10px; height:60px; margin-top:20px; display: flex; justify-content: space-between;}
	.body_header_one{display:flex; padding-top:25px;}
	.body_header_two{margin-right:10px;padding-top:15px;}
	.body_header_two>select {width:110px;}
	.qna_list_body_content{margin-left:10px; box-shadow: 0 6px 6px -6px rgba(0,0,0,1); background-color: #F8F9FD;}
	
	.list_header{display:flex; justify-content:space-between; height:50px; border-bottom: 2px solid #A6A7AB; background-color: #F8F9FD;}
	.list_header span{text-align: center; font-weight: bold; padding-top:13px; margin-right:10px;}
	.list_content {min-height:50px;}
	.no_content {min-height:50px;}
	.list_content span{margin-top:13px; margin-right:10px;}
	.no_content span{margin-top:13px; margin-right:10px;}
	summary{display: flex; justify-content: space-between; text-align: center; min-height:50px;}
	summary:hover{background-color: rgb(108, 117, 125, 0.2);}
	#num{width:5%; text-align: center;}
	#product{width:15%; overflow: hidden; white-space: nowrap; text-align: center;}
	.list_content #product {font-size: small; white-space: nowrap; text-align: center; display: block;}
	#title{width:40%; cursor: pointer;}
	#writer{width:10%; text-align: center;}
	#date{width:10%; text-align: center;}
	#status{width:10%; text-align: center;}
	#delete{width:10%; text-align: center; margin-right:0;}
	summary>#title{text-align: left;}
	.content_inner{border-top:1px solid #A6A7AB; border-bottom:1px solid #A6A7AB; background-color: #F7F8FA; padding-left: 100px;}
	.user_content{min-height: 50px; display: flex;}
	.reply_content{display: flex; min-height: 50px; justify-content: space-between;}
	#reply_front{color:#525253; width:20px;}
	#reply_second{background-color:#525253; color:white; border-radius: 3px; height:100%; width:35px;}
	#reply_content{width:795px; border-bottom:1px solid #A6A7AB; border-top:1px solid #A6A7AB;}
	#delete_btn {margin-right:20px;}
	#reply_btn, #delete_btn {height: 30px; border-radius: 2px; border:1px solid #474948; cursor: pointer; width:75px; background-color: #F8F9FD;}
	#reply_btn:hover, #delete_btn:hover {background-color: #474948; color:white;}

	.reply_modal {display: none; position: fixed; z-index: 999; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgb(0,0,0); 
		background-color: rgba(0,0,0,0.4);}
	/* .reply_modal:first-child {width: 800px; position: absolute; top: 15%; left: 25%; background-color: #fefefe; border: 1px solid #888;}
	.reply_modal:last-child {width: 800px; position: absolute; top: 15%; left: 25%; background-color: #fefefe; border: 1px solid #888;} */
	.reply_modal-content {width: 800px; position: absolute; top: 15%; left: 25%; background-color: #fefefe; border: 1px solid #888;}
	
	.qna_list_footer{margin:20px auto; margin-left:10px;}
	.list_paging{height: 50px; display: flex; justify-content: space-between; padding: 0 475px;}
	.list_paging>button {width:25px; height:25px; border:0; background-color: transparent; cursor: pointer;}
	.list_paging>button:hover {background-color: #474948; border-radius: 50%; color:white;}
	.list_paging>#prev,#next {background-color: #474948; border-radius: 50%; color:white;}
</style>
</head>
<body>
	<div class="qna_list">
		<div class="qna_list_header">
			<div class="qna_list_header_title"><h2>문의글 관리</h2></div>
		</div>
		
		<div class="qna_list_search">
			<table class="qna_search_table">
				<tr>
					<td class="qna_search_title">작성일</td>
					<td class="qna_search_date">
						<input type="date" name="startDate" max="" min=""/>&nbsp;~
						<input type="date" name="endDate" max="" min=""/>&nbsp;&nbsp;
						<button class="date_btn" id="today" onclick="getDay(this)">오늘</button>
						<button class="date_btn" id="week" onclick="getDay(this)">1주일</button>
						<button class="date_btn" id="1month" onclick="getDay(this)">1개월</button>
						<button class="date_btn" id="3month" onclick="getDay(this)">3개월</button>
					</td>
				</tr>
				<tr>
					<td class="qna_search_title">답변구분</td>
					<td class="qna_search_status">
						<input type="checkbox" id="reply_on" name="status" value="0"/>
						<label for="reply_on">답변대기</label>&nbsp;&nbsp;
						<input type="checkbox" id="reply_off" name="status" value="1"/>
						<label for="reply_off">답변완료</label>
						
					</td>
				</tr>
				<tr>
					<td class="qna_search_title">상세구분</td>
					<td class="qna_search_detail">
						<select name="keyword_set" id="keyword_set">
							<option>검색조건</option>
							<option value="qna_title">글제목</option>
							<option value="qna_writeId">작성자</option>
							<option value="product_name">상품명</option>
						</select>
						<input type="text" id="keyword" name="keyword" placeholder="검색어를 입력하세요."/>
					</td>
				</tr>
				<tr>
					<td class="qna_search_button" colspan="2" style="text-align: center; height:100px;">
						<input type="button" id="search_reset" onclick="fn_reset()" value="취소"/>
						<input type="button" id="reset" onclick="fn_allset()" value="목록 초기화"/>
						<input type="button" id="qna_search_btn" onclick="fn_search()" value="검색"/>
					</td>
				</tr>
			</table>
		</div>
		
		<div class="qna_list_body">
			<div class="qna_list_body_header">
				<div class="body_header_one">
					<div class="qna_list_body_header_title"><h4>문의글 목록&nbsp;&nbsp;</h4></div>(총&nbsp;<font color="blue"><span id="total_qna"></span></font>개&nbsp;)
				</div>
				
				<div class="body_header_two">
					<select name="list_day" id="list_day" onchange="get_page()">
						<option value="desc">최근등록일순</option>
						<option value="asc">등록일순</option>
					</select>
				
					<select name="list_count" id="list_count" onchange="get_page()" style="text-align: center;">
						<option value="20">20개씩</option>
						<option value="50">50개씩</option>
					</select>
				</div>
			</div>
			
			<div class="qna_list_body_content">
				<div class="list_header">
					<span id="num">번호</span>
					<span id="product">상품명</span>
					<span id="title">제목</span>
					<span id="writer">작성자</span>
					<span id="date">작성일</span>
					<span id="status">답변상태</span>
					<span id="delete">삭제</span>
				</div>
				
				<!-- 데이터 없을때  -->
				<div class="no_content" style="border-bottom: 1px solid #A6A7AB; display: block;"></div>
				<!-- 데이터 있을때  -->	
				<div class="list_content"></div>
	
				<!-- Modal의 내용 -->
				<div class="reply_modal"> 
					<!-- <div class="reply_modal-content"></div> -->
				</div>
			</div>
		</div>
		
		<div class="qna_list_footer">
			<div class="list_paging"></div>
		</div>
	</div>
</body>
</html>