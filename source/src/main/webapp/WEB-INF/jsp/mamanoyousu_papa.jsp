<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/mamanoyousu_papa.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/common.css">

<meta charset="UTF-8">
<title>ママのようす</title>
</head>
<body>

<!-- ヘッダー -->
<%@ include file="header.jsp" %>

<div class="page-container">

<a href="${pageContext.request.contextPath}/HomeServlet">
<img src="<%=request.getContextPath()%>/img/ホームに戻る.png" class="back_home">
</a>

	<div class="page-header">
		<h1 class="page-title">ママのようす</h1>
	</div>

	<!-- ママが未入力時の時の処理 -->
	<c:if test="${empty mama}">
		<div class="empty-box">
 	 		<p>まだ記録がありません</p>
 	 	</div>
	</c:if>
	
	<!-- ママが入力時の表示処理 -->
	<c:if test="${not empty mama}">
	    <div class="banner">
	        <img src="<%=request.getContextPath()%>/img/mama_pic.png"
	             class="mama-image">
	        <div class="banner-text">
	            <h2>ママが今日のコンディションを記録しました</h2>
	            <p>毎日1回、ママの体調を記録しています。</p>
	            <p>やさしく見守ってあげましょう。</p>
	        </div>
	    </div>
	
	    <div class="content">
	        <div class="status-card">
	            <h2>今日のママのようす</h2>
	            <div class="row">
	                <span>体調</span>
	                <div class="score-circle-area">
				        <span class="score-circle ${mama.physicalScore == 1 ? 'active' : ''}">1</span>
				        <span class="score-circle ${mama.physicalScore == 2 ? 'active' : ''}">2</span>
				        <span class="score-circle ${mama.physicalScore == 3 ? 'active' : ''}">3</span>
				        <span class="score-circle ${mama.physicalScore == 4 ? 'active' : ''}">4</span>
				        <span class="score-circle ${mama.physicalScore == 5 ? 'active' : ''}">5</span>
    				</div>
	            </div>
	            
	            <div class="row">
	                <span>メンタル</span>
	                <div class="score-circle-area">
				        <span class="score-circle ${mama.mentalScore == 1 ? 'active' : ''}">1</span>
				        <span class="score-circle ${mama.mentalScore == 2 ? 'active' : ''}">2</span>
				        <span class="score-circle ${mama.mentalScore == 3 ? 'active' : ''}">3</span>
				        <span class="score-circle ${mama.mentalScore == 4 ? 'active' : ''}">4</span>
				        <span class="score-circle ${mama.mentalScore == 5 ? 'active' : ''}">5</span>
    				</div>
	            </div>
	            
	            <div class="row">
	                <span>睡眠時間</span>
	                <span>${mama.sleepHours} 時間</span>
	          	</div>
	            <div class="row">
	                <span>ストレス指数</span>
	                <div class="score-circle-area">
				        <span class="score-circle ${mama.stress == 1 ? 'active' : ''}">1</span>
				        <span class="score-circle ${mama.stress == 2 ? 'active' : ''}">2</span>
				        <span class="score-circle ${mama.stress == 3 ? 'active' : ''}">3</span>
				        <span class="score-circle ${mama.stress == 4 ? 'active' : ''}">4</span>
				        <span class="score-circle ${mama.stress == 5 ? 'active' : ''}">5</span>
    				</div>
	            </div>
	            
	            <div class="memo-box">
	                <h3>ひとことメモ</h3>
	                <p>${mama.memo}</p>
	            </div>
	        </div>
	
	        <div class="advice-card">
	            <h2>💌 パパへのアドバイス</h2>
	            <p>${advice}</p>
	        </div>
	    </div>
	</c:if>
	
</div>
	
<!-- フッター -->
<%@ include file="footer.jsp" %>
<script>
</script>
</body>
</html>