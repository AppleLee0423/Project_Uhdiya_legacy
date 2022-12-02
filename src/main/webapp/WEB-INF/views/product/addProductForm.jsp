<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path}/resources/css/reset.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
let cnt = 1;
function save() {
	let form = document.frm;
	let product_code = document.getElementById('product_code');
	let product_cateL = document.getElementById('select1');
	let product_name = document.getElementById('product_name');
	let product_price = document.getElementById('product_price');
	if(product_code.value==''){
		alert('제품고유코드는 필수입력사항입니다.');
	} 
	else if(product_cateL.value=='대분류'){
		alert('대분류를 반드시 선택해주세요.');
	} else if(product_name.value==''){
		alert('상품명을 반드시 입력해주세요.');
	} else if(product_price.value==''){
		alert('상품가격을 반드시 입력해주세요.');
	} else if(isNaN(product_price.value)) {
		alert('상품가격은 숫자만 입력가능합니다.')
	}
 	else{
		form.method="post";
		form.action = '${path }/product/addProduct';
		form.enctype="multipart/form-data";
		form.submit();
	} 
}
function cancel() {
	let form = document.frm;
	form.action = '${path}/product/addProductForm';
	form.submit();
}
function readURL(input) {
	if (input.files && input.files[0]) {
		let reader = new FileReader();
		reader.onload = function(e) {
			$("#preview").attr('src', e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
}
function itemChange(){
	var coffee = ["홀빈원두","핸드드립","캡슐커피","커피머신"];
	var stick = ["아메리카노","라떼","커피믹스"];
	var juice = ["주스","컵커피"];
	var tea = ["블렌딩티","전통차"];
	 
	var selectItem = $("#select1").val();
	console.log(selectItem);
	
	var changeItem;
	  
	if(selectItem == "커피"){
	  changeItem = coffee;
	}
	else if(selectItem == "스틱커피"){
	  changeItem = stick;
	}
	else if(selectItem == "음료"){
	  changeItem =  juice;
	}
	else if(selectItem == "티"){
	  changeItem =  tea;
	}
	$('#select2').empty();
	 
	for(var i = 0; i<changeItem.length; i++){                
		var option = $("<option value="+changeItem[i]+">"+changeItem[i]+"</option>");
	    $('#select2').append(option);
	}
}
function check_code() {
	   let product_code = $('#product_code').val();
       $.ajax({
          url : 'productCodeCheck',
          type : 'post',
          dataType : 'text',
          data : {
             'product_code' : product_code
          },
          success : function(data) {
             if( data == 'y' ) {
                $('.possible').css("display","inline-block");
                $('.impossible').css("display","none");
                console.log('ajax카운트0');
             } else {
            	$('.possible').css("display","none");
                $('.impossible').css("display","inline-block");
                /* alert("이미 등록된 코드입니다. 제품고유코드를 다시입력해주세요."); */
                /* $('#product_code').val(''); */
                console.log('ajax카운트0아님');
                console.log(data);
             }
          },
          error: function() {
             alert('에러');
          }
       });
};
</script>

<style>
.addProductForm {
	margin: 40px auto 20px auto;
	width: 1190px;
	min-height: 800px;
}
.addProductForm__main {
	margin: 0 auto;
	width: 800px;
}
.addProductForm_buttons {
	margin-top: 20px;
	margin-bottom:20px;
	width: 800px;
	height: 80px;
	font-weight: bold;
	text-align: center;
}
.addProductForm_buttons_submit {
	width: 390px;
	float: left; 
	padding: 2px 0 0 0;
	color: #333;
	font-size: 14px;
	border: 1px #ccc solid;
	line-height: 40px;
}
.addProductForm_buttons_reset {
	width: 390px;
	float: left; 
	padding: 2px 0 0 0;
	color: #fff;
	background: #bbb;
	font-size: 14px;
	border: 1px #ccc solid;
	line-height: 40px;
}
.addProduct_table {
	width: 800px;
}
.addProductform_title {
	width: 800px;
	margin: 30px auto 15px auto;
	text-align: center;
	color:gray;
	font-size:large;
	font-weight:bold;
}
.addProductform_txt {
	width: 800px;
	float: left;
	margin-bottom: 30px;
}
.addProduct_txt_sub {
	float: left;
	width: 250px;
	font-size:small;
	margin-bottom:5px;
}
.addProduct_txt_obj {
	float: left;
	width: 550px;
	margin-bottom:5px;
}
.addProduct_img {
	width: 800px;
	float: left;
}
.addProduct_img_sub {
	float: left;
	width: 250px;
	min-height: 120px;
	font-size:small;
}
.addProduct_img_obj1 {
	float: left;
	width: 250px;
	min-height: 120px;
	
}
.addProduct_img_obj2 {
	float: left;
	width: 300px;
	min-height: 120px;
}

.addProduct_img_obj3 {
	float: left;
	width: 800px;
	min-height: 120px;
}

.addProductForm_input {
  width: 500px;
  height: 28px;
  font-size: 15px;
  border: 0;
  border-radius: 15px;
  outline: none;
  padding-left: 10px;
  background-color: rgb(233, 233, 233);
}
/* .addProductForm_input_code {
  width: 400px;
  height: 28px;
  font-size: 15px;
  border: 0;
  border-radius: 15px;
  outline: none;
  padding-left: 10px;
  background-color: rgb(233, 233, 233);
} */
/* .addProductForm_input_code_checkBtn{
	background-color: #4a5164;
	border-radius: 8px;
	color: #fff;
	font-size: 12px;
	font-weight: normal;
	vertical-align: middle;
	margin-left: 50px;
	height: 28px;
	margin-top: 20px;
	width: 100px;
	border: 1px solid transparent;
	margin-top: 0px;
	margin-left:0px;
} */
.addProduct_txt_check{
	float: left;
	width: 800px;
	font-size:small;
	margin-bottom:5px;
}
/* .needCheck{
	color:red;
	padding-left:250px;
	font-size:10px;
	display:inline-block;
} */
.impossible{
	color:#6A82FB;
	padding-left:250px;
	font-size:10px;
	display:none;
}
.possible{
	color:#008000;
	padding-left:250px;
	font-size:10px;
	display:none;
}

</style>
</head>
<body>
	<div class="addProductForm">
		<div class="addProductForm__main">
			<form name="frm" action="${path}/product/addProductForm" method="post"
				enctype="multipart/form-data">
				<div class="addProduct_table">
					<div class="addProductform_title">상품 추가하기</div>
					<div class="addProductForm_buttons">
						<div class="addProductForm_buttons_submit">
							<a href="javascript:save()"> 상품등록 </a>
						</div>
						<div class="addProductForm_buttons_reset">
							<a href="javascript:cancel()"> 취소 </a>
						</div>
					</div>
					<br><br>
					<div class="addProductform_txt">
						<div class="addProduct_txt_sub">제품고유코드<span style="color:red;font-size:x-small"> (중복불가)</span></div>
						<div class="addProduct_txt_obj">
							<input class="addProductForm_input" type="text" name="product_code" id="product_code" oninput="check_code()">
							<!-- <button type="button" class="addProductForm_input_code_checkBtn" onclick="javascript:code_checkBtn()">
								중복체크
							</button> -->
						</div>
						<div class="addProduct_txt_check">
							<!-- <span class="needCheck">제품고유코드 중복체크를 해주세요!</span> -->
							<span class="impossible">이미 사용중입니다. 다시 입력해주세요.</span>
							<span class="possible">입력하신 제품고유코드는 사용 가능합니다.</span>
						</div>
						<div class="addProduct_txt_sub">대분류</div>
						<div class="addProduct_txt_obj">
							<select onchange="itemChange()" id="select1" name="product_cateL">
								<option selected > 대분류</option>
								<option value="커피">커피</option>
								<option value="스틱커피">스틱커피</option>
								<option value="음료">음료</option>
								<option value="티">티</option>
							</select>
						</div>
						<div class="addProduct_txt_sub">소분류</div>
						<div class="addProduct_txt_obj">
							<select name="product_cateS" id="select2">
							</select>
						</div>
						<div class="addProduct_txt_sub">상품명</div>
						<div class="addProduct_txt_obj">
							<input class="addProductForm_input" type="text" name="product_name" id="product_name" />
						</div>
						<div class="addProduct_txt_sub">상품가격</div>
						<div class="addProduct_txt_obj">
							<input class="addProductForm_input" type="text" name="product_price" id="product_price" />
						</div>
					</div>
					<div class="addProduct_img">
						<hr style="border-width: 1px 0 0 0; border-color: #fff;">
						<div class="addProduct_img_sub">메인이미지</div>
						<div class="addProduct_img_obj1">
							<input type="file" name="main" onchange='readURL(this)'>
						</div>
						<div class="addProduct_img_obj2">
							<img id="preview" src="#" width="100" height="100"
								alt="선택된 이미지가 없습니다">
						</div>
						<div class="addProduct_img_sub">상세설명이미지</div>
						<div class="addProduct_img_obj1">
							<input type="file" name="info" >
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>