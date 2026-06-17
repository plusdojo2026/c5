<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ふたりごと。</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>

<c:choose>
    <c:when test="${sessionScope.couple_id == 0}">
        <body class="mama">
    </c:when>
    <c:otherwise>
        <body class="papa">
    </c:otherwise>
</c:choose>

<!-- ヘッダー -->
<%@ include file="header.jsp" %>

<!-- メイン -->
<main>
    <div class="menu-grid">
    
    <div class="row">
    	<!-- おねだり -->
        <a href="${pageContext.request.contextPath}/OnedariServlet" class="home-icon">
            <div class="icon">
            	<img src="${pageContext.request.contextPath}/img/onedari.png"
        			 alt="おねだり">
			</div>
        </a>

		<!-- こんなことしてたよ -->
        <a href="${pageContext.request.contextPath}/KonnnakotositetayoServlet" class="home-icon">
            <div class="icon">
            	<img src="${pageContext.request.contextPath}/img/konnnakotositetayo.png"
        			 alt="こんなことしてたよ">
			</div>
        </a>

		<!-- ふたりのバランス -->
        <a href="${pageContext.request.contextPath}/FutarinobalanceServlet" class="home-icon">
            <div class="icon">
            	<img src="${pageContext.request.contextPath}/img/futarinobalance.png"
        			 alt="ふたりのバランス">
			</div>
        </a>
	</div>
	
	<div class="row">
		<!-- おもいでアルバム -->
        <a href="${pageContext.request.contextPath}/OmoidealbumServlet" class="home-icon">
            <div class="icon">
            	<img src="${pageContext.request.contextPath}/img/omoidealbum.png"
        			 alt="おもいでアルバム">
			</div>
        </a>

		<!-- すくすく記録 -->
        <a href="${pageContext.request.contextPath}/SukusukukirokuServlet" class="home-icon">
            <div class="icon">
            	<img src="${pageContext.request.contextPath}/img/sukusukukiroku.png"
        			 alt="すくすく記録">
			</div>
        </a>
	</div>

	<div class="row">
	
		<!-- ママのようす -->
		<a href="${pageContext.request.contextPath}/MamanoyousuServlet" class="home-icon">
    	
    	<c:choose>

        <c:when test="${sessionScope.couple_id == 0}">
            <img
                src="${pageContext.request.contextPath}/img/mamanoyousu_mama.png"
                alt="ママのようす">
        </c:when>

        <c:otherwise>
            <div class="condition-preview">
                メンタル：${mama.mental_score}
                <br>
                睡眠:${mama.sleep_hours}時間
            </div>
        </c:otherwise>
    	</c:choose>

		</a>

		<!-- ママのトリセツ -->
        <a href="${pageContext.request.contextPath}/TorisetuServlet" class="home-icon">
            <div class="icon">
            	<img src="${pageContext.request.contextPath}/img/torisetsu.png"
        			 alt="ママのトリセツ">
			</div>
        </a>
	</div>
	
    </div>
</main>

<!-- フッター -->
<%@ include file="footer.jsp" %>


<!-- ポップアップ -->
<div id="popupModal" class="popup-modal ${sessionScope.couple_id == 0 ? 'mama-popup' : 'papa-popup'}">
    <div class="popup-content">
        <h3>今日のひとこと</h3>
        <p id="popupMessage">
            ${popup.message}
        </p>
        <button onclick="closePopup()">
            閉じる
        </button>
    </div>
</div>

<script>
'use strict';

window.onload = function() {
	document.getElementById("popupModal").style.display = "flex";
	};

function closePopup() {
	document.getElementById("popupModal").style.display = "none";
	}
</script>

</body>
</html>