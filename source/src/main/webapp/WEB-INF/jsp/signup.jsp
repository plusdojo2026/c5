<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新規登録</title>
<link rel="stylesheet" href="/c5/css/common.css">
<link rel="stylesheet" href="/c5/css/login.css">
</head>
<body>
<!-- ヘッダー -->
<%@ include file="header.jsp" %>

<div class="wrapper">
    <!-- 白の四角い箱(login-card) -->
    <div class="login-card">    
        <div class="login-icon">
            <img src="/c5/images/ ここに入れる" alt="新規登録" class="login-header-icon">
        </div>
        <h1>新規登録</h1>
        <p class="login-instruction">以下の情報を入力してアカウントを作成してください</p>
        
        <!-- エラーメッセージの設定 -->
        <c:if test="${not empty errorMsg}">
            <div class="login-error-msg">
                <c:out value="${errorMsg}" />
            </div>
        </c:if>
        
        <!-- サーバー（Servlet）へデータを送るフォーム -->
        <form action="/c5/SignupServlet" method="post">
        
            <!-- ファミリーコード入力の箱（form-group） -->
            <div class="form-group">
                <label for="family_id">ファミリーコード（8桁以上）</label>
                <input type="text" id="family_id" name="family_id" placeholder="例）KATO123456" maxlength="32" required>
                <!-- pタグをform-groupの箱の中に収める -->
                <p class="form-help">夫婦で共通のファミリーコードを入力してください</p>
            </div>
            
            <!-- あなたは？（ママ/パパ選択）の箱（form-group） -->
            <div class="form-group">
                <label>あなたは？</label>
                <div class="user-type-options">
                    <label class="user-type-btn">
                        <!-- 💡 ログイン画面と完全に同じ設定 -->
                        <input type="radio" name="couple_id" value="0" required>
                        <img src="/c5/images/ ここに入れる" alt="ママ" class="user-type-image">
                        <span>ママ</span>
                    </label>
                    <label class="user-type-btn">
                        <!-- 💡 ログイン画面と完全に同じ設定 -->
                        <input type="radio" name="couple_id" value="1">
                        <img src="/c5/images/ ここに入れる" alt="パパ" class="user-type-image">
                        <span>パパ</span>
                    </label>
                </div>
                <p class="form-help">あなたの区分を選択してください</p>
            </div>
            
            <!-- パスワード入力の箱（form-group） -->
            <div class="form-group">
                <label for="password">パスワード</label>    
                <!--  左側の鍵イラストと入力欄をきれいに重ねるための箱 -->
                <div class="password-input-wrapper">
                    <!-- 鍵のイラスト画像（後で画像のリンクちゃんと設定） -->
                    <img src="/c5/images/ 後で入れる" alt="鍵" class="password-icon">
                    <!-- パスワード入力欄 -->
                    <input type="password" id="password" name="password" placeholder="パスワードを入力してください" required>
                </div>
                <!-- パスワードを表示するボタン -->
                <div class="show-password-wrapper">
                    <input type="checkbox" id="show-password">
                    <label for="show-password" class="show-password-label">パスワードを表示する</label>
                </div>
            </div>
		     
            <!-- 新規登録送信ボタン -->
            <div class="form-actions">
                <button type="submit" class="login-btn">登録する</button>
            </div>		
        
        </form> 
    </div> <!--  login-card の閉じタグ -->
    
    <!-- ログイン画面へのリンク -->
    <div class="signup-link">
        アカウントをお持ちの方は <a href="/c5/LoginServlet">ログインはこちら <span>&gt;</span></a>
    </div>
</div> <!-- wrapper の閉じタグ -->

<!-- フッター -->
<%@ include file="footer.jsp" %>

<!-- JavaScript（ログイン画面と完全に同じ、パスワード表示切り替えのみ） -->
<script>
document.addEventListener("DOMContentLoaded", () => {
    const passwordInput = document.getElementById("password");
    const showPasswordCheckbox = document.getElementById("show-password");

    if (showPasswordCheckbox && passwordInput) {
        // チェックボックスの状態が変わった（change）瞬間を監視
        showPasswordCheckbox.addEventListener("change", () => {
            if (showPasswordCheckbox.checked) {
                // チェックが入ったら、中身が見えるようにタイプを「text」に変える
                passwordInput.type = "text";
            } else {
                // チェックが外れたら、隠れるようにタイプを「password」に戻す
                passwordInput.type = "password";
            }
        });
    }
});
</script>
</body>
</html>
