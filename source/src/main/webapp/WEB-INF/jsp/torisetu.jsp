<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/common.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/torisetu.css">
<meta charset="UTF-8">
<title>ママのトリセツ</title>
</head>

<body>

<!-- ヘッダーをインクルード -->
<%@ include file="header.jsp" %>

<main>
<div class="page-container">

<a href="${pageContext.request.contextPath}/HomeServlet">
<img src="<%=request.getContextPath()%>/img/ホームに戻る.png" class="back_home">
</a>

	<div class="page-header">
		<h1 class="page-title">ママのトリセツ(取り扱い説明書)</h1>
		<p class="page-description">ママのことをもっと知って、もっと仲良く。</p>
	</div>
	
	<div class="torisetu_banner">
		<img src="<%=request.getContextPath()%>/img/mama_pic.png" class="mama_pic">
		<div class="banner_text">
			<h2>ママのことを知ると、毎日がもっと楽しくなるよね。</h2>
			<p>このトリセツは、パパと一緒にずっと共有していく大切なメモだよ。</p>
		</div>
		<!-- 最終更新日時を表示 -->
		<p class="update_at">更新日<br>${torisetu.updateAt}</p>
	</div>

<!-- プロフィール内容をTorisetuServletへポストする。 -->
<form method="POST" action="TorisetuServlet">
<!-- CSSグリッドここから 2列3行のカード配置をするための大枠-->
	<div class="grid">
<!--各項目をそれぞれカードとする。つまり6枚のカード-->
		<div class="card happy">
			<div class="card-header">
				<img src="<%=request.getContextPath()%>/img/よろこぶ.png">
				<h4>喜ぶこと</h4>
			</div>
				<input type="text" name="happy1" value="${torisetu.happy1}" placeholder="例) 「ありがとう」と言われること">
				<input type="text" name="happy2" value="${torisetu.happy2}" placeholder="例) 家族でゆっくりする時間が大好き！">
				<input type="text" name="happy3" value="${torisetu.happy3}" placeholder="例) サプライズも喜びます♡">
		</div>
		
		<div class="card angry">
			<div class="card-header">
				<img src="<%=request.getContextPath()%>/img/怒る.png">
				<h4>怒ること</h4>
			</div>
				<input type="text" name="angry1" value="${torisetu.angry1}" placeholder="例) 約束を忘れられること">
				<input type="text" name="angry2" value="${torisetu.angry2}" placeholder="例) 話を聞いてもらえないこと">
				<input type="text" name="angry3" value="${torisetu.angry3}" placeholder="例) 否定的な言葉を言われること">
		</div>
		
		<div class="card fun">
			<div class="card-header">
				<img src="<%=request.getContextPath()%>/img/楽しむ.png">
				<h4>楽しむこと</h4>
			</div>
				<input type="text" name="fun1" value="${torisetu.fun1}" placeholder="例) 音楽に没頭するのが好き！">
				<input type="text" name="fun2" value="${torisetu.fun2}" placeholder="例) 旅行やおでかけの計画を立てるのも楽しい！">
				<input type="text" name="fun3" value="${torisetu.fun3}" placeholder="例) ご褒美のアイス">
		</div>
		
		<div class="card sad">
			<div class="card-header">
				<img src="<%=request.getContextPath()%>/img/悲しむ.png">
				<h4>悲しむこと</h4>
			</div>
				<input type="text" name="sad1" value="${torisetu.sad1}" placeholder="例) 共感してくれないとき、、">
				<input type="text" name="sad2" value="${torisetu.sad2}" placeholder="例) 話し合いを放棄されること">
				<input type="text" name="sad3" value="${torisetu.sad3}" placeholder="例) 頑張れていないかもと不安になる">
		</div>	
				
		<div class="card charge">
			<div class="card-header">
				<img src="<%=request.getContextPath()%>/img/充電方法.png">
				<h4>充電方法</h4>
			</div>
				<input type="text" name="charge1" value="${torisetu.charge1}" placeholder="例) 映画鑑賞！！">
				<input type="text" name="charge2" value="${torisetu.charge2}" placeholder="例) プリンをちゃんとお皿に出して食べる">
				<input type="text" name="charge3" value="${torisetu.charge3}" placeholder="例) いっぱい寝られたら嬉しいな♪">
		</div>
	<!--『不機嫌かなと思ったら』は、テキストボックスを2列3行にする。-->
	<!-- そのため、不機嫌カード内にグリッドを用意 -->
		<div class="card bad" >
			<div class="card-header">
				<img src="<%=request.getContextPath()%>/img/不機嫌.png">
				<h4>不機嫌かなと思ったら</h4>
			</div>
			<div class="bad_grid">
				<textarea name="bad1" placeholder="状態(こんなときは...)">${torisetu.bad1}</textarea>				
				<textarea name="badaction1" placeholder="対応方法(こうしてみてほしい)">${torisetu.badaction1}</textarea>				
				<textarea name="bad2" placeholder="例) ため息が増えます">${torisetu.bad2}</textarea>
				<textarea name="badaction2" placeholder="例) 気にかけて、話しかけてくれると嬉しいです。">${torisetu.badaction2}</textarea>				
				<textarea name="bad3" placeholder="例) イライラして口調がきつくなります">${torisetu.bad3}</textarea>
				<textarea name="badaction3" placeholder="例) 話し合いでゆっくり解決したいかも">${torisetu.badaction3}</textarea>
			</div>				
		</div>
		
	</div>
	<c:if test="${sessionScope.couple_id == 0}"><!-- 妻の画面でのみ表示 -->
		
		<div class="btn-area">
			<button type="submit" name="torisetu_save" class="page-action-btn">保存</button>
		</div>
	</c:if>
<!-- CSSグリッドここまで-->
</form>

<c:if test="${sessionScope.couple_id == 1}">
	
	<p class="papa-message">
		<img src="img/deco1.png" class="deco1">
		ママも毎日がんばっています。たくさん褒めてあげて下さいね！
		<img src="img/deco2.jpg" class="deco2">
	</p>
	
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
        <h2>保存しました！</h2>
        <p>トリセツの内容が更新されました</p>
        
    </div>
</div>

<footer>
<!-- フッターをインクルード -->
<%@ include file="footer.jsp" %>
</footer>

<!-- 【追加】モーダルを制御するJavaScript -->
<script>
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