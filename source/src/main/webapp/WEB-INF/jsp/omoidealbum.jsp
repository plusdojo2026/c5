<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>おもいでアルバム</title>
</head>

<body>
<header>
<!-- ヘッダーをインクルード -->
<%@ include file="header.jsp" %>
</header>
<main>

		<div class="album_h1">
			<h1>おもいでアルバム</h1>
			<!-- 登録追加ボタン -->
			<button id="open_modal">+写真を追加</button>
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
	

<!-- アルバムの追加が無い画面 -->
	<div class="empty_album">
		<p>📷</p>
		<p>まだ写真がありません</p>
		<p>右上の追加ボタンから、新しいおもいでを記録しましょう</p>
	</div>
		
		
<!-- モーダル制御 『+写真を追加』ボタンを押下で表示する-->
<div id=album_modal class="album_modal">
	<div class="photo_modal">
		<button id="close">×</button>
		
	<!-- 写真追加の枠 -->
		<div class="photobox">
			<label for ="album_photo">📸写真を追加</label>
			<input type="file" id="album_photo" style="display:none;">
		</div>
		
		<p>コメント(任意)</p>
	<!-- テキストエリアの文字数カウント -->
		<div class=album_textarea>
			<textarea id="album_text" maxlength="200" placeholder="今日の出来事やひとことを記録しましょう"></textarea>
			<div id=count>0 / 200</div>
		</div>
		
		<button id="cancel">キャンセル</button>
		<button id="regist">記録する</button>
		<button id="delete">削除する</button>
	
	</div>
	
	<!-- アルバム作成完了の表示 表示のみ完成。OK処理はまだ -->
		<div id="complete_modal" class="complete_modal">
			<div class="complete_box">
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
	'use strict';
		<!-- テキストの文字数をカウントする -->
		const textarea = document.getElementById("album_text");
		const counter = document.getElementById("count");
		
		textarea.addEventListener("input",()=>{
		counter.textContent = `${textarea.value.length} / 200`;});
		
</body>
</html>