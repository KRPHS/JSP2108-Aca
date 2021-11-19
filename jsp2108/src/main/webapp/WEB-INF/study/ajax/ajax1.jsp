<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>title</title>
  <%@ include file="/include/bs4.jsp" %>
  <script>
  	function idCheck() {
  		var mid = myform.mid.value;
  		if(mid == "") {
  			alert("아이디를 입력하세요.");
  			myform.mid.focus();
  			return false;
  		}
  		
  		var query = {
  				mid: mid
  		}
  		
  		// alert("입력된 아이디 : " + mid);
  		// $.ajax({키1:값1})
  		$.ajax({
  			type: "get",
  			url: "${ctp}/ajax1Ok",
  			//data: {mid: 'hkd1234', age: 22}
  			data : query,
  			success: function(data) {
  				// 성공
  				if(data == "") {
  					alert("검색된자료가 없습니다.");
  				} else {
	  				alert("검색된 성명은? " + data);
  				}
  			},
  			error: function(data) {
  				//실패후 돌아왔을경우
  				alert("검색시 오류발생");
  			}
  		});
  	}
  	
  	// ajax로 User등록시키기
  	function inputCheck() {
  		var name = $("#name").val();
  		var age = $("#age").val();
  		
  		if(name == "") {
  			alert("성명을 입력해주세요").
  			$("#name").focus();
  			return false;
  		}
  		
  		var query = {
  				name: name,
  				age: age
  		}
  		
  		$.ajax({
  			type: "post",
  			url: "${ctp}/userInput",
  			data: query,
  			success: function(data) {
  				if(data == "1") {
  					alert("등록성공");
  				}	
  			},
  			error: function(data) {
  				alert("오류!");
  			}
  		});
  	}
  	function listCheck() {
  		$.ajax({
  			type: "post",
  			url: "${ctp}/userList",
  			success: function(data) {
  				alert("성공");
  			}
  		});
  	}
  </script>
  <style>
  	th,td {text-align: center;}
  	th {background-color: #eee}
  </style>
</head>
<body>
  <%@ include file="/include/header_home.jsp" %>
  <jsp:include page="/include/nav.jsp"/>
  
  <p><br></p>
  <div class="container">
		<h2>Ajax연습</h2>
		<form name="myform">
			아이디 : <input type="text" name="mid">
			<input type="button" value="아이디검색" onclick="idCheck()">
		</form>
		<br>
		<form name="inputForm">
			<table class="table table-bordered">
				<tr style="text-align: center;">
					<td colspan="2"><h3>User 가입</h3></td>
				</tr>
				<tr>
					<th>성명</th>
					<td><input type="text" name="name" id="name" class="form-control" autofocus required></td>
				</tr>
				<tr>
					<th>나이</th>
					<td><input type="number" name="age" id="age" value="20" class="form-control"></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
						<input type="button" value="등록" onclick="inputCheck()" class="btn btn-secondary">
						<input type="reset" value="리셋" class="btn btn-secondary">
						<input type="button" value="User전체조회" class="btn btn-secondary" onclick="listCheck()">
					</td>
				</tr>
			</table>
		</form>
		<hr>
		<h2>User 전체 리스트</h2>
		<table class="table">
			<tr>
				<th>번호</th>
				<th>성명</th>
				<th>나이</th>
			</tr>
			<c:forEach var="vo" items="${vos }">
				<tr>
					<td>${vo.idx }</td>
					<td>${vo.name }</td>
					<td>${vo.age }</td>
				</tr>
			</c:forEach>
		</table>
  </div>
  <br>
  
  <%@ include file="/include/footer.jsp" %>
</body>
</html>