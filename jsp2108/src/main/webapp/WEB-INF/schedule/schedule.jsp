<%@page import="schedule.ScheduleVO"%>
<%@page import="schedule.ScheduleDAO"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%
	String mid = session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
	// Calendar.Month 값? 0~11 => 1월~12월
	// Calendar.DAY_OF_WEEK 값? 1~7 => 일~토
	
	Calendar calToday = Calendar.getInstance(); // 오늘 날짜를 저장
	Calendar cal = Calendar.getInstance(); // 화면에 표시되는 오늘 날짜 용도
	
	int yy = request.getParameter("yy") == null ? cal.get(Calendar.YEAR) : Integer.parseInt(request.getParameter("yy"));
	int mm = request.getParameter("mm") == null ? cal.get(Calendar.MONTH) : Integer.parseInt(request.getParameter("mm"));
	
	cal.set(yy, mm, 1);
	int startWeek = cal.get(Calendar.DAY_OF_WEEK);
	
	if(mm < 0) {
		yy--;
		mm = 11;
	}
	if(mm > 11) {
		yy++;
		mm = 0;
	}
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>schedule.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <style>
  	td:hover {
  		background-color: #0001;
  	}
  </style>
</head>
<body>
  <%@ include file="/include/header_home.jsp" %>
  <jsp:include page="/include/nav.jsp"/>
  <p><br></p>
  <div class="container">
		<font size="5">일정관리</font> &nbsp;
			<a href="${ctp }/schedule.sc?yy=<%=yy-1%>&mm=<%=mm%>" title="이전년도">◁◁</a>
			<a href="${ctp }/schedule.sc?yy=<%=yy%>&mm=<%=mm-1%>" title="전달">◀</a>
			(<%=yy %>년 <%=mm+1 %>월)
			<a href="${ctp }/schedule.sc?yy=<%=yy%>&mm=<%=mm+1%>" title="다음달">▶</a>
			<a href="${ctp }/schedule.sc?yy=<%=yy+1%>&mm=<%=mm%>" title="다음년도">▷▷</a>
			&nbsp;&nbsp;
			<a href="${ctp }/schedule.sc" title="오늘날짜">■</a>
		<br>
		<table class="table table-bordered text-left align-top">
			<tr class="table-secondary text-center">
				<th><font color="red">일</font></th>
				<th>월</th>
				<th>화</th>
				<th>수</th>
				<th>목</th>
				<th>금</th>
				<th><font color="blue">토</font></th>
			</tr>
			<tr style="height: 80px;">
<%
			for(int i = 1; i < startWeek; i++) {
				out.println("<td>&nbsp;</td>");
			}

			ScheduleDAO dao = new ScheduleDAO();

			while(cal.get(Calendar.MONTH) == mm) {
				String ymd = cal.get(Calendar.YEAR)+"-"+(cal.get(Calendar.MONTH)+1)+"-"+cal.get(Calendar.DATE); // 화면에 표시되는 일자 년-월-일를 ymd변수에 담는다
				ScheduleVO vo = dao.getScContent(ymd, mid);
				String part = "";
				String content = "";
				
				if(vo.getPart() != null) part = vo.getPart();
				if(vo.getContent() != null) {
					if(vo.getContent().length() >= 10) content = vo.getContent().substring(0,10) + " . . .";
					else content = vo.getContent();
				}

				if(cal.get(Calendar.DAY_OF_WEEK) == 1) {
					out.println("<td title='"+content+"'><a href='${ctp}/scContent.sc?ymd="+ymd+"&yy="+yy+"&mm="+mm+"' class='align-top' style='height: 150px; color: red;'>"+cal.get(Calendar.DATE)+"</a><br>"+part+"</td>");
				} else if (cal.get(Calendar.DAY_OF_WEEK) == 7) {
					out.println("<td title='"+content+"'><a href='${ctp}/scContent.sc?ymd="+ymd+"&yy="+yy+"&mm="+mm+"' class='align-top' style='height: 150px; color: blue;'>"+cal.get(Calendar.DATE)+"</a><br>"+part+"</td>");
				} else if (cal.get(Calendar.YEAR)==calToday.get(Calendar.YEAR) && cal.get(Calendar.MONTH)==calToday.get(Calendar.MONTH) && cal.get(Calendar.DATE)==calToday.get(Calendar.DATE)) {
					out.println("<td title='"+content+"'><a href='${ctp}/scContent.sc?ymd="+ymd+"&yy="+yy+"&mm="+mm+"' class='align-top' style='height: 150px;'>"+cal.get(Calendar.DATE)+"</a><br>"+part+"</td>");
				} else {
					out.println("<td title='"+content+"'><a href='${ctp}/scContent.sc?ymd="+ymd+"&yy="+yy+"&mm="+mm+"' class='align-top' style='height: 150px; color: black;'>"+cal.get(Calendar.DATE)+"</a><br>"+part+"</td>");
				}
				
				if(cal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY) {
					out.println("</tr><tr style='height: 80px;'>");
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
		<textarea cols="5" style="resize: none; width: 100%" disabled>asdf</textarea>
  </div>
  <br>
  <%@ include file="/include/footer.jsp" %>
</body>
</html>