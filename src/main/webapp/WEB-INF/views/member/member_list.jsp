<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
	
	<meta charset="UTF-8">
	
	<link href="${path}/resources/css/member/bootstrap.min.css" rel="stylesheet">
	
	<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
	<script type="text/javascript">
		
		function deleteMember(no) {

			if( !confirm("회원정보를 삭제하시겠습니까?") ) {
				return;
			}
			
			$.ajax({
				url : "/Uhdiya/member/member_delete",
				type : "POST",
				data : {
					member_id : no
				},
				dataType : "text",
				success : function(data) {
					console.log(data);
					if( data == "Y" ) {
						alert("회원정보 삭제를 완료하였습니다");
						location.reload();
					} else {
						alert("회원정보 삭제에 실패하였습니다");						
					}
					
				},
		        error : function() {
		        	alert("오류가 발생하였습니다.");
		        }
		    });
			
		}
		
	</script>
	
</head>
<body class="text-center">
	<main class="form-signin" style="margin-bottom: 75px;">
		<div class="container">
			<div class="table-responsive pt-3" style="max-height: 500px;">
				<table class="table table-bordered table-hover mt-3">
					<thead>
						<tr>
							<th>아이디</th>
							<th>이름</th>
							<th>이메일</th>
							<th>삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${list ne null && list.size() > 0}">
								<c:forEach items="${list}" var="m">
									<tr>
										<td>${m.member_id}</td>
										<td>${m.member_name}</td>
										<td>${m.member_phone}</td>
										<td>${m.member_email}</td>
										<td>
											<button type="button" class="btn btn-danger" onclick="deleteMember('${m.member_id}')">삭제</button>
										</td>
									</tr>
									<%-- <tr>
										<td>${m.member_id}</td>
										<td>${m.member_name}</td>
										<td>${m.member_email}</td>
										<td>
											<button type="button" class="btn btn-danger" onclick="deleteMember('${m.member_id}')">삭제</button>
										</td>
									</tr>
									<tr>
										<td>${m.member_id}</td>
										<td>${m.member_name}</td>
										<td>${m.member_email}</td>
										<td>
											<button type="button" class="btn btn-danger" onclick="deleteMember('${m.member_id}')">삭제</button>
										</td>
									</tr>
									<tr>
										<td>${m.member_id}</td>
										<td>${m.member_name}</td>
										<td>${m.member_email}</td>
										<td>
											<button type="button" class="btn btn-danger" onclick="deleteMember('${m.member_id}')">삭제</button>
										</td>
									</tr>
									<tr>
										<td>${m.member_id}</td>
										<td>${m.member_name}</td>
										<td>${m.member_email}</td>
										<td>
											<button type="button" class="btn btn-danger" onclick="deleteMember('${m.member_id}')">삭제</button>
										</td>
									</tr> --%>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="4">회원목록이 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
		</div>
	</main>
</body>
</html>