<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

<h1>ママのようす</h1>
	<p>${message }</p>
	<p>体調：${mama.physical_score}</p>
	<p>メンタル：${mama.mental_score}</p>
	<p>睡眠：${mama.sleep_hours}</p>
	<p>ストレス：${mama.stress}</p>
	<p>メモ：${mama.memo}</p>
		
<h3>アドバイス</h3>
	<p>${advice}</p>
	

<!-- フッター -->
<%@ include file="footer.jsp" %>
<script>
</script>
</body>
</html>