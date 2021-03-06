<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%
	// Calendar.Month 값? 0~11 => 1월~12월
	// Calendar.DAY_OF_WEEK 값? 1~7 => 일~토
	
	Calendar calToday = Calendar.getInstance(); // 오늘 날짜를 저장
	Calendar cal = Calendar.getInstance(); // 화면에 표시되는 오늘 날짜 용도
	
	int yy = request.getParameter("yy") == null ? cal.get(Calendar.YEAR) : Integer.parseInt(request.getParameter("yy"));
	int mm = request.getParameter("mm") == null ? cal.get(Calendar.MONTH) : Integer.parseInt(request.getParameter("mm"));
	
	cal.set(yy, mm, 1);
	int startWeek = cal.get(Calendar.DAY_OF_WEEK);
	
	int prevYear = yy;
	int nextYear = yy;
	
	int prevMonth = mm - 1;
	int nextMonth = mm + 1;

	if(prevMonth < 0) {
		prevYear--;
		prevMonth = 11;
	}
	if(nextMonth > 11) {
		nextYear++;
		nextMonth = 0;
	}
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>title</title>
  <%@ include file="/include/bs4.jsp" %>
</head>
<body>
  <%@ include file="/include/header_home.jsp" %>
  <jsp:include page="/include/nav.jsp"/>
  
  <p><br></p>
  <div class="container">
		<font size="5">달력연습</font> &nbsp;
			<a href="${ctp }/calendar.st?yy=<%=prevYear-1%>&mm=<%=mm%>" title="이전년도">◁◁</a>
			<a href="${ctp }/calendar.st?yy=<%=prevYear%>&mm=<%=prevMonth%>" title="전달">◀</a>
			(<%=yy %>년 <%=mm+1 %>월)
			<a href="${ctp }/calendar.st?yy=<%=nextYear%>&mm=<%=nextMonth%>" title="다음달">▶</a>
			<a href="${ctp }/calendar.st?yy=<%=nextYear+1%>&mm=<%=mm%>" title="다음년도">▷▷</a>
			&nbsp;&nbsp;
			<a href="${ctp }/calendar.st" title="오늘날짜">■</a>
		<br>
		<table class="table table-bordered text-center">
			<tr class="table-secondary">
				<th><font color="red">일</font></th>
				<th>월</th>
				<th>화</th>
				<th>수</th>
				<th>목</th>
				<th>금</th>
				<th><font color="blue">토</font></th>
			</tr>
			<tr>
<%
			for(int i = 1; i < startWeek; i++) {
				out.println("<td>&nbsp;</td>");
			}
			while(cal.get(Calendar.MONTH) == mm) {
				if(cal.get(Calendar.DAY_OF_WEEK) == 1) {
					out.println("<td class='text-danger'>"+cal.get(Calendar.DATE)+"</td>");
				} else if (cal.get(Calendar.DAY_OF_WEEK) == 7) {
					out.println("<td class='text-primary'>"+cal.get(Calendar.DATE)+"</td>");
				} else if (cal.get(Calendar.YEAR)==calToday.get(Calendar.YEAR) && cal.get(Calendar.MONTH)==calToday.get(Calendar.MONTH) && cal.get(Calendar.DATE)==calToday.get(Calendar.DATE)) {
					out.println("<td class='bg-secondary text-white'>"+cal.get(Calendar.DATE)+"</td>");
				} else {
					out.println("<td>"+cal.get(Calendar.DATE)+"</td>");
				}
				
				if(cal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY) {
					out.println("</tr><tr>");
				}
				
				cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cal.get(Calendar.DATE)+1);
			}
			if(cal.get(Calendar.DAY_OF_WEEK) <= 7) {
				for(int i = cal.get(Calendar.DAY_OF_WEEK); i <= 7; i++) {
					out.println("<td>&nbsp;</td>");
				}
			}
%>
			</tr>
		</table>
  </div>
  <br>
  
  <%@ include file="/include/footer.jsp" %>
</body>
</html>