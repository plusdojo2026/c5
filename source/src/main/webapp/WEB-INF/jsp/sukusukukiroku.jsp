<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
      content="width=device-width, initial-scale=1.0">
<title>すくすく記録 | ふたりごと。</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/common.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/sukusukukiroku.css">

</head>



<!-- ここからすくすく記録 -->
<body>

<!-- ヘッダー -->
<%@ include file="header.jsp" %>

<main>
<div class="page-container">
<a href="${pageContext.request.contextPath}/HomeServlet">
<img src="<%=request.getContextPath()%>/img/ホームに戻る.png" class="back_home">
</a>
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
	
	<!-- 条件分岐：リストが空の場合 -->
	<c:if test="${empty recordList}">
	<div class ="empty-list">
	    <img src="/c5/img/weight.png"  class="empty-image">
	     <h2>まだ記録がありません</h2>
	     <p>右上の「＋記録する」から、成長を記録しましょう！</p>
	</div>
	</c:if>

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
		
		
		<c:if test="${not empty recordList}">
		
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
					
					 <!-- 削除ボタン style="display: inline-block;" で改行禁止-->
					 <form action="/c5/SukusukukirokuServlet" method="POST">
					 <!-- サーブレットに送るパラメータ（隠しフィールド） -->
					 <input type="hidden" name="action" value="delete">
					 <input type="hidden" name="sukusukuId" value="${r.sukusukuId}">
					 <input type="image" name="submit" src="/c5/img/gomibako.jpg" alt="削除" class="delete-btn" onclick="return confirm('本当に削除しますか？')">
					 </form>
					
				</div>

			</c:forEach>

		</div>	
		</c:if>
	
</div>			
</main>		

		
		<!-- 変更完了モーダル -->
<div class="modal-overlay" id="success-modal">
    <div class="modal-container success-container">
        
        <!-- 中央に表示されるチェックマークのイラスト -->
        <!-- 後で画像のリンクちゃんと設定 -->
        <img src="/c5/img/tsuika.png" alt="追加完了マーク" class="success-image">
        <!-- メッセージ部分 -->
        <h2>記録しました！</h2>
        <p>すくすく記録の内容が更新されました</p>
        
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
	
	
	//保存済みモーダル
	document.addEventListener("DOMContentLoaded", () => {
	    const successModal = document.getElementById("success-modal");
	    
	    // サーブレットから処理完了後、URLに「?msg=success」が付いて戻ってきたらモーダルを表示
	    if (successModal && new URLSearchParams(window.location.search).get("msg") === "success") {
	        successModal.style.display = "flex";
	        setTimeout(() => {
	            successModal.style.display = "none";
	            // URLの「?msg=success」を綺麗に消して元のURLに戻す
	            window.history.replaceState({}, document.title, window.location.pathname);
	        }, 1000); // 1秒間表示する
	    }
	});
</script>
</body>
</html>