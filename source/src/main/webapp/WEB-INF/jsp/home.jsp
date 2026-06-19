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
<div class="page-container">
    <div class="menu-grid">
    
    <div class="row">
    	<!-- おねだり -->
        <a href="${pageContext.request.contextPath}/OnedariServlet" class="home-icon">
            <div>
            	<img src="${pageContext.request.contextPath}/img/onedari.png"
        			 alt="おねだり" class="icon">
			</div>
        </a>

		<!-- こんなことしてたよ -->
        <a href="${pageContext.request.contextPath}/KonnnakotositetayoServlet" class="home-icon">
            <div>
            	<img src="${pageContext.request.contextPath}/img/konnnakotositetayo.png"
        			 alt="こんなことしてたよ" class="icon">
			</div>
        </a>

		<!-- ふたりのバランス -->
        <a href="${pageContext.request.contextPath}/FutarinobalanceServlet" class="home-icon">
            <div>
            	<img src="${pageContext.request.contextPath}/img/futarinobalance.png"
        			 alt="ふたりのバランス" class="icon">
			</div>
        </a>
	</div>
	
	<div class="row">
		<!-- おもいでアルバム -->
        <a href="${pageContext.request.contextPath}/OmoidealbumServlet" class="home-icon">
            <div>
            	<img src="${pageContext.request.contextPath}/img/omoidealbum.png"
        			 alt="おもいでアルバム" class="icon">
			</div>
        </a>

		<!-- すくすく記録 -->
        <a href="${pageContext.request.contextPath}/SukusukukirokuServlet" class="home-icon">
            <div>
            	<img src="${pageContext.request.contextPath}/img/sukusukukiroku.png"
        			 alt="すくすく記録" class="icon">
			</div>
        </a>
	</div>

	<div class="row">
	
		<!-- ママのようす -->
    	
    	<c:choose>

        <c:when test="${sessionScope.couple_id == 0}">
        	<a href="${pageContext.request.contextPath}/MamanoyousuServlet" class="home-icon">
	            <img
	                src="${pageContext.request.contextPath}/img/mamanoyousu_mama.png"
	                alt="ママのようす" class="icon">
			</a>
        </c:when>

        <c:otherwise>
        	<a href="${pageContext.request.contextPath}/MamanoyousuServlet"
				class="mama-home-card">

    		<div class="mama-left">
		        <img
		            src="${pageContext.request.contextPath}/img/mamanoyousu_papa.png"
		            alt="ママのようす"
		            class="mama-home-image">
    		</div>

			<div class="mama-right">
			
				<div class="detail-link">
					くわしく見る ＞
        		</div>
        		
        		<div class="mental-box">
            		<div class="mini-title">
                		メンタル
            		</div>
            		<div class="heart-area">
		                <span class="${mama.mentalScore >= 1 ? 'heart-on' : 'heart-off'}">♥</span>
		                <span class="${mama.mentalScore >= 2 ? 'heart-on' : 'heart-off'}">♥</span>
		                <span class="${mama.mentalScore >= 3 ? 'heart-on' : 'heart-off'}">♥</span>
		                <span class="${mama.mentalScore >= 4 ? 'heart-on' : 'heart-off'}">♥</span>
		                <span class="${mama.mentalScore >= 5 ? 'heart-on' : 'heart-off'}">♥</span>
					</div>
        		</div>

        		<div class="sleep-box">
            		<div class="mini-title">
                		睡眠
            		</div>
					<div class="sleep-value">
                		${mama.sleepHours}
                		<span>時間</span>
            		</div>
        		</div>

    		</div>

			</a>
			
        </c:otherwise>
    	</c:choose>

		<!-- ママのトリセツ -->
        <a href="${pageContext.request.contextPath}/TorisetuServlet" class="home-icon">
            <div>
            	<img src="${pageContext.request.contextPath}/img/torisetsu.png"
        			 alt="ママのトリセツ" class="icon">
			</div>
        </a>
	</div>
	
    </div>
</div>
</main>

<!-- フッター -->
<%@ include file="footer.jsp" %>


<!-- ポップアップ -->
<div id="popupModal" class="popup-modal ${sessionScope.couple_id == 0 ? 'mama-popup' : 'papa-popup'}">
    <div class="popup-content">
        <h3>今日もおつかれさまです</h3>
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