<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>title</title>
  <%@ include file="/include/bs4.jsp" %>
  <style>
  	#leftWindow {
  		float: left;
  		width: 25%;
  		height: 500px;
  		text-align: center;
  		background-color: #ddd;
  	}
  	#rightWindow {
  		float: left;
  		width: 75%;
  		height: 500px;
  		text-align: left;
  		background-color: #eee;
  		overflow: auto;
  	}
  	.target {
    	-ms-overflow-style: none; /* IE and Edge */
    	scrollbar-width: none; /* Firefox */
		}
		.target::-webkit-scrollbar {
	    display: none; /* Chrome, Safari, Opera*/
		}
  	/* body {
    	-ms-overflow-style: none;
    	scrollbar-width: none;
		}
		body::-webkit-scrollbar {
	    display: none;
		} */
  	h3 {text-align: center;}
  	#footerM {
  		clear: both;
  		margin: 10px;
  	}
  </style>
  <script>
  	function wmDelteAll() {
  		var ans = confirm("휴지통에 있는 메시지를 전부 삭제하시겠습니까?");
  		if(!ans) return false;
  		$.ajax({
  			type: "post",
  			url: "${ctp}/wmDeleteAll.wm",
  			success: function() {
					alert("휴지통에 모든 메시지가 삭제 되었습니다.");
					location.reload();
  			}
  		});
  	}
  </script>
</head>
<body>
  <%@ include file="/include/header_home.jsp" %>
  <jsp:include page="/include/nav.jsp"/>
  <p><br></p>
  <div class="container">
		<h3>메시지 관리</h3>
		<div>현재 접속자 : <font color='red'>${sMid }</font>(${sNickName })</div>
		<div id="leftWindow">
			<p><br></p>
			<p><a href="${ctp }/wmMessage.wm?mSw=0">메시지 작성</a></p>
			<p><a href="${ctp }/wmMessage.wm?mSw=1">받은메시지</a></p>
			<p><a href="${ctp }/wmMessage.wm?mSw=2">안읽은메시지</a></p>
			<p><a href="${ctp }/wmMessage.wm?mSw=3">보낸메시지</a></p>
			<p><a href="${ctp }/wmMessage.wm?mSw=4">수신확인</a></p>
			<p><a href="${ctp }/wmMessage.wm?mSw=5">휴지통</a></p>
			<p><a href="javascript:wmDelteAll()">휴지통비우기</a></p>
		</div>
		<div id="rightWindow" class="target">
			<p>
				<c:if test="${mSw == 0 }">
					<h3>메시지 작성</h3>
					<jsp:include page="wmInput.jsp"/>
				</c:if>
				<c:if test="${mSw == 1 }">
					<h3>받은 메시지</h3>
					<jsp:include page="wmList.jsp"/>
				</c:if>
				<c:if test="${mSw == 2 }">
					<h3>안읽은 메시지</h3>
					<jsp:include page="wmList.jsp"/>
				</c:if>
				<c:if test="${mSw == 3 }">
					<h3>보낸 메시지</h3>
					<jsp:include page="wmList.jsp"/>
				</c:if>
				<c:if test="${mSw == 4 }">
					<h3>수신 확인</h3>
					<jsp:include page="wmList.jsp"/>
				</c:if>
				<c:if test="${mSw == 5 }">
					<h3>휴지통 목록</h3>
					<jsp:include page="wmList.jsp"/>
				</c:if>
				<c:if test="${mSw == 6 }"> <!-- 메시지 내용 상세보기 -->
					<h3>메시지 내용</h3>
					<jsp:include page="wmContent.jsp"/>
				</c:if>
			</p>
		</div>
  </div>
  <br>
  <div id="footerM"><br></div>
  <div class="text-center" id="footer" style="margin-bottom:0; height:100px; padding: 40px 0 0; background-color: #ddd;">
	  <p>Copyright  2021. 11. 08. Design by HS Park</p>
	</div>
</body>
</html>