<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/mamanoyousu_papa.css">
<meta charset="UTF-8">
<title>ママのようす</title>
</head>
<body>
<hr>
<!-- ヘッダー -->
<%@ include file="header.jsp" %>

<h1 class="page-title">ママのようす</h1>

	<!-- ママが未入力時の時の処理 -->
	<c:if test="${empty mama}">
 	 <p>まだ記録がありません</p>
	</c:if>
	
	<!-- ママが入力時の表示処理 -->
	<p>${message}</p>
	<p>体調：${mama.physical_score}(1:悪い~5:良い)</p>
	<p>メンタル：${mama.mental_score}(1:悪い~5:良い)</p>
	<p>睡眠：${mama.sleep_hours}時間</p>
	<p>ストレス：${mama.stress}(1:低い~5:高い)</p>
	<p>メモ：${mama.memo}</p>
		
<h3>アドバイス</h3>
	<p>${advice}</p>
	

<!-- フッター -->
<%@ include file="footer.jsp" %>
<script>
</script>
</body>
</html>