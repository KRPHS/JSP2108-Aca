<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine","\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>title</title>
  <%@ include file="/include/bs4.jsp" %>
  <style type="text/css">
  	th {
  		background-color: #ccc;
  		text-align: center;
  		width: 20%;
  	}
  	td {
  		background-color: #eee;
  	}
  </style>
</head>
<body>
  <p><br></p>
  <div class="container">
		<table class="table table-bordered">
			<tr>
				<th>보내는 사람</th>
				<td>${vo.sendId }</td>
			</tr>
			<tr>
				<th>받는 사람</th>
				<td>${vo.receiveId }</td>
			</tr>
			<tr>
				<th>메시지 제목</th>
				<td>${vo.title }</td>
			</tr>
			<tr>
				<th>메시지 내용</th>
				<td style="height: 150px">${fn:replace(vo.content, newLine, '<br>') }</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
					<input type="button" value="답장쓰기" onclick="location.href='${ctp}/wmMessage.wm?mSw=0&receiveId=${vo.sendId }';" class="btn btn-secondary"> &nbsp;
					<c:if test="${vo.sendId == sMid }">
						<input type="button" value="휴지통" onclick="location.href='${ctp}/wmDeleteCheck.wm?mFlag=s&idx=${vo.idx }';" class="btn btn-secondary"> &nbsp;
					</c:if>
					<c:if test="${vo.sendId != sMid }">
						<input type="button" value="휴지통" onclick="location.href='${ctp}/wmDeleteCheck.wm?mFlag=r&idx=${vo.idx }';" class="btn btn-secondary"> &nbsp;
					</c:if>
					<input type="button" value="돌아가기" onclick="location.href='${ctp}/wmMessage.wm';" class="btn btn-secondary">
				</td>
			</tr>
		</table>
  </div>
  <br>
</body>
</html>