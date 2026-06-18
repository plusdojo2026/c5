<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/omoidealbum.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/common.css">
<meta charset="UTF-8">
<title>おもいでアルバム</title>
</head>

<body>
<header>
<!-- ヘッダーをインクルード -->
<%@ include file="header.jsp" %>
</header>
<main>
<div class="page-container">

	<div class="page-header">
		<h1 class="page-title">おもいでアルバム</h1>
			<!-- 登録追加ボタン -->
			<button id="open_modal" class="page-action-btn">＋写真を追加</button>
	</div>
		
	<!-- ソート機能保留ここから -->
	<!--  	<div class=album_bunner>
				<form method="get" action="OmoideAlbumServlet">	
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
		<p class="album_date"><fmt:formatDate value = "${album.createdAt}" pattern="yyyy/MM/dd"/></p>
		
	<!-- 削除。OmoideAlbumServletにポスト -->
		<form method="POST" action="OmoideAlbumServlet">
			<input type="hidden" name ="action" value="delete">
			<input type="hidden" name ="album_id" value="${album.albumId}">
			<button type="submit" class="delete_button">削除</button>
		</form>
		</div>
		
	</c:forEach>
</div>
</div>
		
<!-- モーダル制御 投稿画面-->
<div id=album_modal class="album_modal">
	<div class="photo_modal">
		<button id="close">×</button>							<!-- enctype・・・写真を送るための処理 -->
		<form method="POST" action="OmoideAlbumServlet" enctype="multipart/form-data">
		<input type="hidden" name="action" value="insert">
		
	<!-- 写真追加の枠 -->
		<div class="photobox">
			<label for ="album_photo">📸写真を追加</label>
			<input type="file" id="album_photo" name="album_photo" style="display:none;">
		</div>
		
		<p>コメント(任意)</p>
	<!-- テキストエリアの文字数カウント -->
		<div class=album_textarea>
			<textarea id="album_text" name="comment" maxlength="200" placeholder="今日の出来事やひとことを記録しましょう"></textarea>
			<div id=count>0 / 200</div>
		</div>
		
		<button type="button" id="cancel">キャンセル</button>
		<button type="submit" id="regist">記録する</button>
		</form>
	</div>
	
	<!-- アルバム作成完了の表示 表示のみ完成。OK処理はまだ -->
		<div id="complete_modal" class="complete_modal">
			<div class="complete_box">
				<img src="img/tsuika.png" class="tsuika">
				<p>登録が完了しました！</p>
				<button id="ok">OK</button>
			</div>
		</div>
</div>

</main>
<footer>
<!-- フッターをインクルード -->
<%@ include file="footer.jsp" %>
</footer>

<!-- JavaScriptここから -->
<script>
	'use strict';
		//テキストの文字数をカウントする
		const textarea = document.getElementById("album_text");
		const counter = document.getElementById("count");
		
		textarea.addEventListener("input",()=>{
		counter.textContent = `${textarea.value.length} / 200`;});
		
		//モーダル制御
		const modal = document.getElementById("album_modal");
		document.getElementById("open_modal").onclick = () => modal.style.display = "block";
		document.getElementById("close").onclick = () => modal.style.display = "none";
		document.getElementById("cancel").onclick = () => modal.style.display = "none";
</script>
</body>
</html>