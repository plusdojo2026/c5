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
   		<img src="<%=request.getContextPath()%>/img/mama_pic.png">
   		<div>
	   		<h2>今日のママのコンディションを記録しましょう</h2>
	   		<p>1日1回の記録でOKです</p>
		</div>
		
			<div class="condition-row">
				<div class="condition-label">
				<img src="<%=request.getContextPath()%>/img/体調.png">
	        		<div>
	            		<h3>体調(1:悪い~5:良い)</h3>
	            		<p>体の調子はどうですか？</p>
	        		</div>
    			</div>
    			
				<input type="radio" name="physical_score" value="1" required>1
				<input type="radio" name="physical_score" value="2">2
				<input type="radio" name="physical_score" value="3">3
				<input type="radio" name="physical_score" value="4">4
				<input type="radio" name="physical_score" value="5">5
			</div>
			
			<div class="condition-row">
				<div class="condition-label">
				<img src="<%=request.getContextPath()%>/img/メンタル.png">
	        		<div>
	            		<h3>メンタル(1:悪い~5:良い)</h3>
	            		<p>心の調子はどうですか？</p>
	        		</div>
    			</div>
    			
				<input type="radio" name="mental_score" value="1" required>1
				<input type="radio" name="mental_score" value="2">2
				<input type="radio" name="mental_score" value="3">3
				<input type="radio" name="mental_score" value="4">4
				<input type="radio" name="mental_score" value="5">5
			</div>
			
			<div class="condition-row">
				<div class="condition-label">
        		<img src="<%=request.getContextPath()%>/img/睡眠時間.png">
        			<div>
            			<h3>睡眠時間</h3>
            			<p>昨夜の睡眠時間は？</p>
        			</div>
    			</div>
			
				<input type="number" step="0.5" min="0" max="24" name="sleep_hours" required>
			</div>	
			
			<div class="condition-row">	
				<div class="condition-label">
				<img src="<%=request.getContextPath()%>/img/ストレス指数.png">
	        		<div>
	            		<h3>ストレス指数(1:低い~5:高い)</h3>
	            		<p>ストレスを感じていますか？</p>
	        		</div>
    			</div>
			
				<input type="radio" name="stress" value="1" required>1
				<input type="radio" name="stress" value="2">2
				<input type="radio" name="stress" value="3">3
				<input type="radio" name="stress" value="4">4
				<input type="radio" name="stress" value="5">5
			</div>
			
			<div class="condition-row">	
				<div class="condition-label">
				<img src="<%=request.getContextPath()%>/img/ひとことメモ.png">
	        		<div>
	            		<h3>ひとことメモ(任意)</h3>
	            		<p>自由に書けます</p>
	        		</div>
    			</div>
			
				<textarea name="memo"></textarea>
			</div>
				
			<button type="submit">登録する</button>
		</form>	
	</div>
<!-- フッター -->
<%@ include file="footer.jsp" %>
<script>
</script>
</body>
</html>