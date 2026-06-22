<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/mamanoyousu_mama.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/common.css">
<meta charset="UTF-8">
<title>ママのようす</title>
</head>

<!--ここからママの様子記録! -->
<body>
<!-- ヘッダー -->
<%@ include file="header.jsp" %>

<div class="page-container">
	<div class="page-header">
		<h1 class="page-title">ママのようす</h1>
		
		<!-- メッセージ -->
			<c:if test="${not empty message}">
		    	<div class="message">${message}</div>
			</c:if>
	</div>

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
			
				<div class="radio-group">
					<label>
						<input type="radio" name="physical_score" value="1" >
						<span>1</span>
					</label>
			
					<label>
						<input type="radio" name="physical_score" value="2">
						<span>2</span>
					</label>
			
					<label>
						<input type="radio" name="physical_score" value="3">
						<span>3</span>
					</label>
			
					<label>
						<input type="radio" name="physical_score" value="4">
						<span>4</span>
					</label>
			
					<label>
						<input type="radio" name="physical_score" value="5">
						<span>5</span>
					</label>
				</div>
			</div>
    			
			
			<div class="condition-row">
				<div class="condition-label">
					<img src="<%=request.getContextPath()%>/img/メンタル.png">
					<div>
						<h3>メンタル(1:悪い~5:良い)</h3>
						<p>心の調子はどうですか？</p>
					</div>
				</div>
			
				<div class="radio-group">
					<label>
						<input type="radio" name="mental_score" value="1" >
						<span>1</span>
					</label>
			
					<label>
						<input type="radio" name="mental_score" value="2">
						<span>2</span>
					</label>
			
					<label>
						<input type="radio" name="mental_score" value="3">
						<span>3</span>
					</label>
			
					<label>
						<input type="radio" name="mental_score" value="4">
						<span>4</span>
					</label>
			
					<label>
						<input type="radio" name="mental_score" value="5">
						<span>5</span>
					</label>
				</div>
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
			
				<div class="radio-group">
					<label>
						<input type="radio" name="stress" value="1" > 
						<span>1</span>
					</label>
			
					<label>
						<input type="radio" name="stress" value="2">
						<span>2</span>
					</label>
			
					<label>
						<input type="radio" name="stress" value="3">
						<span>3</span>
					</label>
			
					<label>
						<input type="radio" name="stress" value="4">
						<span>4</span>
					</label>
			
					<label>
						<input type="radio" name="stress" value="5">
						<span>5</span>
					</label>
				</div>
			</div>
			
			<div class="condition-row">	
				<div class="condition-label">
				<img src="<%=request.getContextPath()%>/img/ひとことメモ.png">
	        		<div>
	            		<h3>ひとことメモ(任意)</h3>
	            		<p>自由に書けます</p>
	        		</div>
    			</div>
			
				<textarea name="memo" placeholder="例) 今日は少し疲れたけど、こどもとたくさん遊べて楽しかった！"></textarea>
			</div>
			
			<div class="btn-area">	
				<button type="submit" class="page-action-btn">登録する</button>
			</div>
		</form>	
	</div>

</div>

<!-- フッター -->
<%@ include file="footer.jsp" %>
<script>

document.getElementById("mamaForm").addEventListener("submit", function(e) {

    let errorMsg = "";

    // ① radioチェック
    const physical = document.querySelector("input[name='physical_score']:checked");
    const mental = document.querySelector("input[name='mental_score']:checked");
    const stress = document.querySelector("input[name='stress']:checked");

    // ② 数値入力取得
    const sleep = document.querySelector("input[name='sleep_hours']").value;

    // ③ 未入力チェック
    if (!physical) {
        errorMsg = "体調を選択してください";
    } else if (!mental) {
        errorMsg = "メンタル値を選択してください";
    } else if (!sleep) {
        errorMsg = "睡眠時間を入力してください";
    } else if (!stress) {
        errorMsg = "ストレス値を選択してください";
    }

    // ④ エラー表示
    if (errorMsg !== "") {
        e.preventDefault(); // 送信ストップ
        document.getElementById("jsError").innerText = errorMsg;
    }

});
</script>
</body>
</html>