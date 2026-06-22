<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/common.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/sukusukukiroku.css">

<meta charset="UTF-8">
</head>
<title>すくすく記録</title>


<!-- ここからすくすく記録 -->
<body>

<!-- ヘッダー -->
<%@ include file="header.jsp" %>

<div class="page-container">
	<div class="page-header">
		<div class="page-title-area">
			<h1 class="page-title">すくすく記録</h1>
			
			<!-- メッセージ -->
			<c:if test="${not empty message}">
		    	<div class="message">${message}</div>
			</c:if>
		</div>
	
		<!-- 記録フォーム展開するボタン -->
		<div class="btn-area">
		<button type="button" id="openModal" class="page-action-btn">
		＋記録する
		</button>
		</div>
	</div>
	
	 <!-- 記録のモーダル表示 -->
		<div id="modal" class="modal">
			<div class="modal-content">
				<h3>赤ちゃんの健康記録を追加</h3>
				<form action="${pageContext.request.contextPath}/SukusukukirokuServlet" method="post">
					
					<label>日付</label>
						<input type="text" name="date" value="${now}" readonly> 
					
					<div class="input-row">
						<div class="input-box">
	                    	<label>体温</label>
	                    	<input type="text" name="temperature" placeholder="例）36.7">
	                    </div>
	                    
						<div class="input-box">
	                    	<label>体重</label>
	                    	<input type="text" name="weight" placeholder="例）7.2">
	                    </div>
                    </div>
                    
					<label>メモ（任意）</label>
						<textarea name="note" placeholder="今日の様子や気づいたことをメモしましょう"></textarea>
				
					<div class="modal-button-area">
		                <button type="button" id="closeModal" class="close-btn">
		                    キャンセル
		                </button>
		                <button type="submit" class="submit-btn">
		                    記録する
		                </button>
					</div>
					
				</form>
			</div>
		</div>
		
		
		<h2>記録一覧</h2>	
		
		<div class="record-list">
			<c:forEach var="r" items="${recordList}">
			
				<div class="record-card">
					<div class="record-date">
						<div class="record-date-main">
						<img src="<%=request.getContextPath()%>/img/calender.png" class="calender">
							${r.recordedAt}
						</div>
					</div>
					
					<div class="record-item">
						<div class="label">
						<img src="<%=request.getContextPath()%>/img/weight.png" class="weight">
							体重
						</div>
						<div class="value">
							${r.weight} kg
						</div>
					</div>

					<div class="record-item">
						<div class="label">
						<img src="<%=request.getContextPath()%>/img/temperature.png" class="temperature">
							体温
						</div>
						<div class="value">
							${r.temperature} ℃
						</div>
					</div>

					<div class="record-memo">
						<div class="label">
						<img src="<%=request.getContextPath()%>/img/memo.png" class="memo">
							メモ
						</div>
						<div class="value">
							${r.note}
						</div>
					</div>
					
				</div>

			</c:forEach>

		</div>	
</div>			
			
	<!-- フッター -->
<%@ include file="footer.jsp" %>
<script>
	const modal = document.getElementById("modal");
	//モーダルの表示
	document.getElementById("openModal").onclick = () => modal.style.display="block";
	//モーダルの非表示
	document.getElementById("closeModal").onclick = () => modal.style.display="none";
</script>
</body>
</html>