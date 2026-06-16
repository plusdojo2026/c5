<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/torisetu.css">
<meta charset="UTF-8">
<title>ママのトリセツ</title>
</head>

<body>
<header>
<!-- ヘッダーをインクルード -->
<%@ include file="header.jsp" %>
</header>
<main>

	<div class="torisetu_h1">
	<h1 class="page-title">ママのトリセツ(取り扱い説明書)</h1>
	<p>ママのことをもっと知って、もっと仲良く。</p>
	</div>
	
	<div class="torisetu_banner">
		<img src="<%=request.getContextPath()%>/img/mama_pic.png">
		<div class="banner_text">
			<h2>ママのことを知ると、毎日がもっと楽しくなるよね。</h2>
			<p>このトリセツは、パパと一緒にずっと共有していく大切なメモだよ。</p>
		</div>
		<!-- 最終更新日時を表示 -->
		<p class="update_at">更新日<br>${update_at}</p>
	</div>

<!-- プロフィール内容をTorisetuservletへポストする。 -->
<form method="POST" action="/webapp/Torisetuservlet">
<!-- CSSグリッドここから 2列3行のカード配置をするための大枠-->
	<div class="grid">
<!--各項目をそれぞれカードとする。つまり6枚のカード-->
		<div class="card happy">
			<div class="card-header">
				<img src="<%=request.getContextPath()%>/img/よろこぶ.png">
				<h4>喜ぶこと</h4>
			</div>
				<input type="text" name="happy1" value="${torisetu.happy1}">
				<input type="text" name="happy2" value="${torisetu.happy2}">
				<input type="text" name="happy3" value="${torisetu.happy3}">
		</div>
		
		<div class="card angry">
			<div class="card-header">
				<img src="<%=request.getContextPath()%>/img/怒る.png">
				<h4>怒ること</h4>
			</div>
				<input type="text" name="angry1" value="${torisetu.angry1}">
				<input type="text" name="angry2" value="${torisetu.angry2}">
				<input type="text" name="angry3" value="${torisetu.angry3}">
		</div>
		
		<div class="card fun">
			<div class="card-header">
				<img src="<%=request.getContextPath()%>/img/楽しむ.png">
				<h4>楽しむこと</h4>
			</div>
				<input type="text" name="fun1" value="${torisetu.fun1}">
				<input type="text" name="fun2" value="${torisetu.fun2}">
				<input type="text" name="fun3" value="${torisetu.fun3}">
		</div>
		
		<div class="card sad">
			<div class="card-header">
				<img src="<%=request.getContextPath()%>/img/悲しむ.png">
				<h4>悲しむこと</h4>
			</div>
				<input type="text" name="sad1" value="${torisetu.sad1}">
				<input type="text" name="sad2" value="${torisetu.sad2}">
				<input type="text" name="sad3" value="${torisetu.sad3}">
		</div>	
				
		<div class="card charge">
			<div class="card-header">
				<img src="<%=request.getContextPath()%>/img/充電方法.png">
				<h4>充電方法</h4>
			</div>
				<input type="text" name="charge1" value="${torisetu.charge1}">
				<input type="text" name="charge2" value="${torisetu.charge2}">
				<input type="text" name="charge3" value="${torisetu.charge3}">
		</div>
	<!--『不機嫌かなと思ったら』は、テキストボックスを2列3行にする。-->
	<!-- そのため、不機嫌カード内にグリッドを用意 -->
		<div class="card bad" >
			<div class="card-header">
				<img src="<%=request.getContextPath()%>/img/不機嫌.png">
				<h4>不機嫌かなと思ったら</h4>
			</div>
			<div class="bad_grid">
				<input type="text" name="bad1" value="${torisetu.bad1}">
				<input type="text" name="bad2" value="${torisetu.bad2}">
				<input type="text" name="bad3" value="${torisetu.bad3}">
				<input type="text" name="badaction1" value="${torisetu.bad_action1}">
				<input type="text" name="badaction2" value="${torisetu.bad_action2}">
				<input type="text" name="badaction3" value="${torisetu.bad_action3}">
			</div>				
		</div>
		
	</div>
	<button type="submit" name="torisetu_save">保存</button>
<!-- CSSグリッドここまで-->
</form>
<p>ママも毎日がんばっています。たくさん褒めてあげて下さいね！</p>
</main>
<footer>
<!-- フッターをインクルード -->
<%@ include file="footer.jsp" %>
</footer>
</body>

</html>