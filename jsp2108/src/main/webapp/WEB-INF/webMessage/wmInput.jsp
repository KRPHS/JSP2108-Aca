<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>wmInput.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <style>
  	th {
  		text-align: center;
  		width: 20%;
  	}
  </style>
  <script type="text/javascript">
  	function fCheck() {
  		var receiveId = myform.receiveId.value;
  		var title = myform.title.value;
  		var content = myform.content.value;
  		
  		if(receiveId == "") {
  			alert("받는 사람 아이디를 입력하세요!");
  			myform.receiveId.focus();
  		}
  		else if(title == "") {
  			alert("제목을 입력하세요!");
  			myform.title.focus();
  		}
  		else if(content == "") {
  			alert("내용을 입력하세요!");
  			myform.content.focus();
  		}
  		else {
  			myform.submit();
  		}
  	}
  </script>
</head>
<body>
	<p><br></p>
  <div class="container">
		<form name="myform" method="post" action="${ctp }/wmInputOk.wm">
			<table class="table table-bordered">
				<tr>
					<th>보내는 사람</th>
					<td><input type="text" name="sendId" value="${sMid }" readonly class="form-control"></td>
				</tr>
				<tr>
					<th>받는 사람</th>
					<td><input type="text" name="receiveId" placeholder="받는사람 아이디를 입력해주세요" value="${param.receiveId}" class="form-control"></td>
				</tr>
				<tr>
					<th>메시지 제목</th>
					<td><input type="text" name="title" placeholder="제목을 입력해주세요" autofocus class="form-control"></td>
				</tr>
				<tr>
					<th>메시지 내용</th>
					<td><textarea rows="5" name="content" class="form-control" style="resize: none"></textarea></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
						<input type="button" value="메시지 전송" onclick="fCheck()" class="btn btn-secondary"> &nbsp;
						<input type="reset" value="다시 쓰기" class="btn btn-secondary"> &nbsp;
						<input type="button" value="돌아가기" onclick="history.back();" class="btn btn-secondary">
					</td>
				</tr>
			</table>
		</form>
  </div>
</body>
</html>