<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/mamanoyousu_mama.css">
<meta charset="UTF-8">
<title>ママのようす</title>
</head>

<!--ここからママの様子記録 -->
<body>
<hr>
<!-- ヘッダー -->
<%@ include file="header.jsp" %>

<h1 class="page-title">ママのようす</h1>
	<div>
		
		<!-- ママのコンディションの入力項目 -->
		<form action="MamanoyousuServlet" method="post">
   		<h2>今日のママのコンディションを記録しましょう</h2>
		
			<label>体調(1:悪い~5:良い)</label>
				<input type="radio" name="physical_score" value="1" required>1
				<input type="radio" name="physical_score" value="2">2
				<input type="radio" name="physical_score" value="3">3
				<input type="radio" name="physical_score" value="4">4
				<input type="radio" name="physical_score" value="5">5
		
			<label>メンタル(1:悪い~5:良い)</label>
				<input type="radio" name="mental_score" value="1" required>1
				<input type="radio" name="mental_score" value="2">2
				<input type="radio" name="mental_score" value="3">3
				<input type="radio" name="mental_score" value="4">4
				<input type="radio" name="mental_score" value="5">5
			
			<label>睡眠時間</label>
				<input type="number" step="0.5" min="0" max="24" name="sleep_hours" required>
				
			<label>ストレス(1:低い~5:高い)</label>
				<input type="radio" name="stress" value="1" required>1
				<input type="radio" name="stress" value="2">2
				<input type="radio" name="stress" value="3">3
				<input type="radio" name="stress" value="4">4
				<input type="radio" name="stress" value="5">5
			
			<label>メモ（任意）</label>
				<textarea name="memo"></textarea>
				
			<button type="submit">登録する</button>
		</form>	
	</div>
<!-- フッター -->
<%@ include file="footer.jsp" %>
<script>
</script>
</body>
</html>