<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログイン</title>
<link rel="stylesheet" href="/c5/css/common.css">
<link rel="stylesheet" href="/c5/css/login.css">
</head>
<body>
<!-- ヘッダー -->
<header>

    <div class="logo-area">
        <a href="${pageContext.request.contextPath}/HomeServlet">
            <img
                src="${pageContext.request.contextPath}/img/logo.png"
                alt="ふたりごと。"
                class="logo-image">
        </a>
    </div>
</header>

<div class="wrapper">
    <!-- 白の四角いログインの箱(login-card) -->
    <div class="login-card">    
        <h1>ログイン</h1>
        <p class="login-instruction">ファミリーコードとパスワードを入力してしてください</p>
        
        <!-- エラーメッセージの設定 -->
        <c:if test="${not empty errorMsg}">
            <div class="login-error-msg">
                <c:out value="${errorMsg}" />
            </div>
        </c:if>
        
        <!-- 会員登録できた時のメッセージ -->
         <c:if test="${not empty successMsg}">
            <div class="touroku-success-msg">
                <c:out value="${successMsg}" />
            </div>
        </c:if>
        
        <!-- ログインServletへデータを送るフォーム -->
        <form action="/c5/LoginServlet" method="post">
        
            <!-- ファミリーコード入力の箱だよ（form-group） -->
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
                        <input type="radio" name="couple_id" value="0" required>
                        <img src="/c5/img/mama.png" alt="ママ" class="user-type-image">
                        <span>ママ</span>
                    </label>
                    <label class="user-type-btn">
                        <input type="radio" name="couple_id" value="1">
                        <img src="/c5/img/papa.png" alt="パパ" class="user-type-image">
                        <span>パパ</span>
                    </label>
                </div>
                <p class="form-help">あなたの区分を選択してください</p>
            </div>
            
            <!-- パスワード入力の箱（form-group） -->
            <div class="form-group">
                <label for="password">パスワード（8桁以上）</label>    
                <!--  左側の鍵イラストと入力欄をきれいに重ねるための箱 -->
                <div class="password-input-wrapper">
                    <!-- 鍵のイラスト画像（後で画像のリンクちゃんと設定） -->
                    <img src="/c5/img/password.png" alt="鍵" class="password-icon">
                    <!-- パスワード入力欄 -->
                    <input type="password" id="password" name="password" placeholder="パスワードを入力してください" maxlength="64" required>
                </div>
                <!-- パスワードを表示するボタン -->
                <div class="show-password-wrapper">
        	    <input type="checkbox" id="show-password">
       		    <label for="show-password" class="show-password-label">パスワードを表示する</label>
   			    </div>
            　</div>
		     
            <!-- ログイン送信ボタン -->
            <div class="form-actions">
                <button type="submit" class="login-btn">ログイン</button>
            </div>		
        
        </form> 
    </div> <!--  login-card の閉じタグ -->
    <!-- 新規登録のリンク -->
    <div class="signup-link">
        アカウントをお持ちでない方は <a href="/c5/SignupServlet">新規登録はこちら <span>&gt;</span></a>
    </div>
</div> <!-- wrapper の閉じタグ -->
<!-- フッター -->
<%@ include file="footer.jsp" %>


<!-- JavaScript -->
<script>
		/* HTML要素をオブジェクトとして取得する */
		const passwordInput = document.getElementById('password');
		const showPasswordCheckbox = document.getElementById('show-password');
		
		/* [パスワードを表示する]チェックボックスを切り替えたときの処理 */
		if (showPasswordCheckbox && passwordInput) {
		  showPasswordCheckbox.onchange = function() {
		    if (showPasswordCheckbox.checked) {
		      // チェックが入ったら中身を見せる
		      passwordInput.type = 'text';
		    } else {
		      // チェックが外れたら隠す
		      passwordInput.type = 'password';
		    }
		  };
		}
</script>
</body>
</html>
