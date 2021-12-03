<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>title</title>
  <%@ include file="/include/bs4.jsp" %>
</head>
<body>
	<p><br></p>
	<div class="container">
		<table class="table table-hover">
			<tr class="table-dark text-dark">
				<th>번호</th>
				<th>
					<c:if test="${mSw == 1 || mSw == 2 || mSw == 5 }">보낸사람</c:if>
					<c:if test="${mSw == 3 || mSw == 4 }">받은사람</c:if>
				</th>
				<th>메시지 제목</th>
				<th>
					<c:if test="${mSw == 1 || mSw == 2 || mSw == 5 }">보낸/확인 날짜</c:if>
					<c:if test="${mSw == 3 || mSw == 4 }">받은날짜</c:if>
				</th>
			</tr>
			<c:set var="mCount" value="${fn:length(vos) }"/>
			<c:forEach var="vo" items="${vos }" varStatus="st">
				<tr>
					<td>${mCount }</td>
					<td>
						<c:if test="${mSw == 1 || mSw == 2 || mSw == 5 }">${vo.sendId }</c:if>
						<c:if test="${mSw == 3 || mSw == 4 }">${vo.receiveId }</c:if>
					</td>
					<td><a href="${ctp }/wmMessage.wm?mSw=6&idx=${vo.idx}">
						<c:if test="${vo.sendSw == 'g' && mSw == 5}">[보낸메시지]</c:if>
						${vo.title }</a>
						<c:if test="${vo.receiveSw == 'n' }"><img src="${ctp }/images/new.gif"></c:if>
						<c:if test="${mSw == 3 }">
							<a href="${ctp}/wmDeleteCheck.wm?mFlag=s&idx=${vo.idx }" class="badge badge-secondary">삭제</a>
						</c:if>
					</td>
					<%-- <td>${fn:substring(vo.receiveDate,0,10) }</td> --%>
					<td>
						<c:if test="${mSw == 1 || mSw == 2 || mSw == 5 }">${vo.sendDate }</c:if>
						<c:if test="${mSw == 3 || mSw == 4 }">${vo.receiveDate }</c:if>
					</td>
				</tr>
				<c:set var="mCount" value="${mCount-1 }"/>
			</c:forEach>
		</table>
	</div>
</body>
</html>