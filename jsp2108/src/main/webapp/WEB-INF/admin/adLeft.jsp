<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <c:set var="ctp" value="<%=request.getContextPath()%>"/> --%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adLeft</title>
  <%@ include file="../../include/bs4.jsp" %>
</head>
<body>
  <p><br></p>
  <div class="container">
		<h2>메뉴</h2>
		<hr>
		<p><a href="${ctp}/adMemberList.ad" target="adContent">회원관리</a></p>		
		<hr>
		<p><a href="<%=request.getContextPath()%>/" target="_top">돌아가기</a></p>		
		<hr>
  </div>
  <br>
</body>
</html>