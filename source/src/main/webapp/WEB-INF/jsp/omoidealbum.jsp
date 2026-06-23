<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/common.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/omoidealbum.css">
<meta charset="UTF-8">
<title>おもいでアルバム</title>

<body>
<!-- ヘッダーをインクルード -->
<%@ include file="header.jsp" %>

<main>
<div class="page-container">

<a href="${pageContext.request.contextPath}/HomeServlet">
<img src="<%=request.getContextPath()%>/img/ホームに戻る.png" class="back_home">
</a>

	<div class="page-header">
		<h1 class="page-title">おもいでアルバム</h1>
			<!-- 登録追加ボタン -->
			<button id="open_modal" class="page-action-btn">＋おもいでを記録する</button>
	</div>
		
	<!-- ソート機能保留ここから -->
	<!--  	<div class=album_bunner>
				<form method="get" action="OmoidealbumServlet">	
						<option value="new">新しい順</option>
						<option value="old">古い順</option>
					</select>
				</form>
			</div>-->
	<!-- ソート機能保留ここまで -->
	


<!-- アルバムの追加が無いときの画面 -->
<c:if test="${empty albumList}">
	<div class="empty_album">
		<img src="img/gazou_arimasenn.png" class="gazou_arimasenn">
        <p class="empty_title">まだ写真がありません</p>
        <p class="empty_text">右上の追加ボタンから、新しいおもいでを記録しましょう</p>
	</div>
</c:if>

<!-- タイムライン形式でのアルバム表示 -->
<div class="album_list">
	<c:forEach var="album" items="${albumList}">
		<div class="album_item">
		
		<img src="${pageContext.request.contextPath}/${album.photoPath}" class="album_photo">
		
		<p class="album_message">${album.comment}</p>
		<!-- 日付を表示(フォーマットを改善) -->
		<p class="album_date"><fmt:formatDate value = "${album.createdAt}" pattern="yyyy年MM月dd日"/></p>
		
	
		
		
		
	<!-- 削除。OmoidealbumServletにポスト  ※実装なし！！！-->
		<form method="POST" action="OmoidealbumServlet">
			<input type="hidden" name ="albumId" value="${album.albumId}">
			<button type="submit" name="action" value="delete" class="delete_button">削除</button>
		</form> 
		</div>
		
	</c:forEach>
</div>
</div>
		
<!-- 写真のポップアップモーダル -->	
	<div id="photom" class="photomodal">
		<img id="modali" class="modalimg">
	</div>
		
<!-- モーダル制御 投稿画面-->
<div id=album_modal class="album_modal">
	<div class="photo_modal">
		<button id="close">×</button>							<!-- enctype・・・写真を送るための処理 -->
		<form method="POST" action="OmoidealbumServlet" enctype="multipart/form-data">
		<input type="hidden" name="action" value="insert">
		
	<!-- 写真追加の枠 -->
		<div class="photobox">
			<label for ="album_photo">📸写真を追加</label>
			<input type="file" id="album_photo" accept="image/*" onchange="previewImage(event)" name="album_photo" style="display:none;">
			<img id="preview" style = "max-width:250px; display:none;">
		</div>
		
		<p>コメント(任意)</p>
	<!-- テキストエリアの文字数カウント -->
		<div class=album_textarea>
			<textarea id="album_text" name="comment" maxlength="200" placeholder="今日の出来事やひとことを記録しましょう"></textarea>
			<div id="count">0 /200</div>
		</div>
		
		<button type="button" id="cancel">キャンセル</button>
		<button type="submit" id="regist">記録する</button>
		</form>
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
        <p>思い出アルバムの内容が更新されました</p>
        
    </div>
</div>


<footer>
<!-- フッターをインクルード -->
<%@ include file="footer.jsp" %> 
</footer>

<!-- JavaScriptここからa -->
<script>
	'use strict';
		//テキストの文字数をカウントする
		document.addEventListener('DOMContentLoaded',()=>{
			
		const textarea = document.getElementById("album_text");
		const counter = document.getElementById("count");
		
		if(textarea && counter){
			
			counter.textContent = `0 / 200`;

			textarea.addEventListener("input",()=>{
			counter.textContent = `${textarea.value.length} / 200`;
			});
			}
		
		//モーダル制御
		const modal = document.getElementById("album_modal");
		document.getElementById("open_modal").onclick = () => modal.style.display = "block";
		document.getElementById("close").onclick = () => modal.style.display = "none";
		document.getElementById("cancel").onclick = () => modal.style.display = "none";
		
		function previewImage(event){
			const file = event.target.files[0];
			const reader = new FileReader();
			
		//投稿前に写真をプレビュー
		reader.onload = function(e){
			const preview = document.getElementById('preview');
			preview.src = e.target.result;
			preview.style.display = 'block';
		}
		if(file){
			reader.readAsDataURL(file);
		}
	}
	window.previewImage = previewImage;
	});
	
		//記録完了モーダル
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

		//写真ポップアップモーダル
		document.addEventListener("DOMContentLoaded",()=>{
			
			const photoModal = document.getElementById("photom");
		    const modalImg = document.getElementById("modali");
			
			document.querySelectorAll(".album_photo").forEach(img =>{
				img.addEventListener("click",()=>{
				photoModal.style.display = "flex";
				modalImg.src = img.src;
			});
		});
			photoModal.addEventListener("click", (e) => {
		        if (e.target === photoModal) {
		            photoModal.style.display = "none";}
		});
	});
		
</script>
</body>
</html>