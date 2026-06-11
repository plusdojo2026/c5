<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>おねだりリスト</title>
<link rel="stylesheet" href="/webapp/css/common.css">
<link rel="stylesheet" href="/webapp/css/onedari.css">
</head>
<body>
<!-- ヘッダー -->
<%@ include file="header.jsp" %>
<div class="wrapper">
<!-- （おねだりリストのタイトルと追加するボタン） -->
<div class ="header-container">
	<div class="header-left">
            <!--  買い物かごイラスト入れる --> <!-- 後で画像のリンクちゃんと設定 -->
            <img src="/webapp/images/ ここにいれる" alt="買い物かご" class="cart-icon">
	<h1>おねだりリスト</h1>
	</div>
	 <button id="add-btn">＋追加する</button>
</div>
<!-- おねだりリストのメインエリア -->
<main class ="empty-list">
<!--  真ん中のイラスト --> <!-- 後で画像のリンクちゃんと設定 -->
    <img src="/webapp/images/ ここにいれる" alt="空のカート" class="empty-image">
     <h2>おねだりリストは空です</h2>
     <p>右上の「＋追加する」から<br>お願いしたいものを追加してみましょう！</p>
</main>

<!-- おねだりリストの一覧エリア（商品があるときに表示する箱） -->
<div class="item-list-container">    
    <!-- おねだり商品1つ分のカード（おむつの例） -->
    <div class="item-card">
        <div class="item-card-left">
            <img src="/webapp/images/diaper-icon.png" alt="おむつ" class="item-cat-icon">
            <div class="item-details">
                <span class="item-brand">パンパース</span>
                <span class="item-spec">テープタイプ</span>
                <span class="item-size-badge">Mサイズ</span>
            </div>
        </div>
        <div class="item-card-right">
            <img src="/webapp/images/uploaded-diaper.jpg" alt="添付写真" class="item-thumb">
            <button class="delete-btn">
                <img src="/webapp/images/trash-icon.png" alt="削除" class="trash-icon">
            </button>
        </div>
    </div>
</div>

<!-- モーダル制御の画面構成1 -->
<div class="modal-overlay" id="add-modal"> 
    <div class="modal-container">      <!-- ミルクオムツその他などの上にくるカードの部分 -->
    <!-- 閉じるボタン（右上の×） -->
        <button class="modal-close-btn">&times;</button>  
        <!-- [&times;]  綺麗な「×」のバツ印を表示するための書き方 -->
	 <h3>追加するものを選んでください</h3>
	<!-- おむつ・ミルク・その他　３つの選択肢を横並びにするための箱 -->
        <div class="select-options">
    <!-- おむつ選択 -->
    	<button class="option-btn">
    	<img src="/webapp/images/ ここにいれる" alt="おむつ" class="option-icon">
                <span>おむつ</span>
        </button>
    <!-- ミルク選択 -->
    	<button class="option-btn">
    	<img src="/webapp/images/ ここにいれる" alt="ミルク" class="option-icon">
    			<span>ミルク</span>
    	</button>
    <!-- その他選択 -->
    	<button class="option-btn">
    	<img src="/webapp/images/ ここにいれる" alt="その他" class="option-icon">
    			<span>その他</span>
    	</button>
    	</div>
	</div>
</div>

<!-- モーダル制御の画面構成２-1 おむつ -->
<div class="modal-overlay" id="omutsu-modal"> 
    <div class="modal-container">
    <button class="modal-close-btn">&times;</button>
        <h3>おむつを追加</h3>
        
        <!-- 写真を送信するため enctype="multipart/form-data" を指定 -->
        <form action="add-item" method="post" enctype="multipart/form-data">
            <input type="hidden" name="item-category" value="おむつ">    
            <!-- おむつのブランドを記述 -->
            <div class="form-group">
            <label>①なにを買ってきてほしいか教えてください</label>
            <input type="text" name="memo" placeholder="例：パンパース、メリーズなど">
            </div>
            
            <!-- タイプ用の選択肢 -->
            <div class="form-group">
            <label>②タイプを選んでください</label>
            	<div class="type-options">          <!-- required を付けることで必須入力に-->
                    <label class="type-btn"><input type="radio" name="omutsu-type" value="テープ" required> テープ</label>
                    <label class="type-btn"><input type="radio" name="omutsu-type" value="パンツ"> パンツ</label>
    			</div>
    		</div>
    		
    		<!-- サイズの選択肢 -->
            <div class="form-group">
                <label>③サイズを選んでください</label>
                <div class="size-options">
                    <label class="size-btn"><input type="radio" name="omutsu-size" value="新生児" required> 新生児</label>
                    <label class="size-btn"><input type="radio" name="omutsu-size" value="S"> S</label>
                    <label class="size-btn"><input type="radio" name="omutsu-size" value="M"> M</label>
                    <label class="size-btn"><input type="radio" name="omutsu-size" value="L"> L</label>
                    <label class="size-btn"><input type="radio" name="omutsu-size" value="ビッグ"> ビッグ</label>
                </div>
            </div>
            
            <!--  写真添付（任意）-->
            <div class="form-group">
                <label for="diaper-image">写真を添付（任意）</label>
                <input type="file" id="omutsu-image" name="item-image" accept="image/*">
                
                <!-- 選択した画像をその場でパッと表示させるための空の枠 -->
                <div class="image-preview-container">
                    <img id="omutsu-preview" src="" alt="プレビュー" style="display: none; max-width: 100%; max-height: 150px; margin-top: 10px; border-radius: 8px;">
                </div>
            </div>
            
            <!-- 送信ボタン -->
            <div class="form-actions">
                <button type="submit" class="submit-btn">追加する</button>
            </div>
        </form>
</div>
</div>

<!-- モーダル制御の画面構成２-２ ミルク -->
<div class="modal-overlay" id="milk-modal"> 
    <div class="modal-container">
        <!-- 閉じるボタン -->
        <button class="modal-close-btn">&times;</button>
        <h3>ミルクを追加</h3>
        
        <!-- 写真を送信するため enctype="multipart/form-data" を指定 -->
        <form action="add-item" method="post" enctype="multipart/form-data">
            <input type="hidden" name="item-category" value="ミルク">    
            
            <!-- ミルクのブランドを記述 -->
            <div class="form-group">
                <label for="milk-brand">①なにを買ってきてほしいか教えてください</label>
                <input type="text" id="milk-brand" name="milk-brand" placeholder="例：ほほえみ、はぐくみなど">
            </div>
            
            <!-- タイプの選択肢 -->
            <div class="form-group">
                <label>②タイプを選んでください</label>
                <div class="type-options">
                    <label class="type-btn"><input type="radio" name="milk-type" value="缶" required> 缶</label>
                    <label class="type-btn"><input type="radio" name="milk-type" value="スティック"> スティック</label>
                    <label class="type-btn"><input type="radio" name="milk-type" value="キューブ"> キューブ</label>
                </div>
            </div>
            
            <!-- 写真添付（任意） -->
            <div class="form-group">
                <label for="milk-image">写真を添付（任意）</label>
                <input type="file" id="milk-image" name="item-image" accept="image/*">
                
                <!-- 選択した画像をその場で表示するためのプレビュー枠 -->
                <div class="image-preview-container">
                    <img id="milk-preview" src="" alt="プレビュー" style="display: none; max-width: 100%; max-height: 150px; margin-top: 10px; border-radius: 8px;">
                </div>
            </div>
            
            <!-- ④ 送信ボタン -->
            <div class="form-actions">
                <button type="submit" class="submit-btn">追加する</button>
            </div>
        </form>
    </div>
</div>

<!-- モーダル制御の画面構成2-3　その他 -->
<div class="modal-overlay" id="other-modal"> 
    <div class="modal-container">
        <!-- 閉じるボタン -->
        <button class="modal-close-btn">&times;</button>
        <h3>その他を追加</h3>
        
        <!-- 写真やテキストを送信するため enctype="multipart/form-data" を指定 -->
        <form action="add-item" method="post" enctype="multipart/form-data">
            <input type="hidden" name="item-category" value="その他">    
            
            <!-- 何を買ってきてほしいか（自由記述・必須） -->
            <div class="form-group">
                <label for="other-name">なにを買ってきてほしいか教えてください</label>
                <input type="text" id="other-name" name="other-name" placeholder="例：おしりふき、ベビーソープなど" required>
            </div>
            
            <!-- 写真添付（任意） -->
            <div class="form-group">
                <label for="other-image">写真を添付（任意）</label>
                <input type="file" id="other-image" name="item-image" accept="image/*">
                
                <!-- 選択した画像をその場で表示するためのプレビュー枠 -->
                <div class="image-preview-container">
                    <img id="other-preview" src="" alt="プレビュー" style="display: none; max-width: 100%; max-height: 150px; margin-top: 10px; border-radius: 8px;">
                </div>
            </div>
            
            <!-- ③ 送信ボタン -->
            <div class="form-actions">
                <button type="submit" class="submit-btn">追加する</button>
            </div>
        </form>
    </div>
</div>

<!-- モーダル制御の画面構成3 -->
<div class="modal-overlay" id="success-modal">
    <div class="modal-container success-container">
        
        <!-- 中央に表示されるチェックマークのイラスト -->
        <!-- 後で画像のリンクちゃんと設定 -->
        <img src="/webapp/images/ ここに入れる" alt="追加完了マーク" class="success-image">
        <!-- メッセージ部分 -->
        <h2>追加しました！</h2>
        <p>おねだりリストに追加されました</p>
        
    </div>
</div>
</div>    <!-- ここで div class wrapper 閉じてる -->
<!-- フッター -->
<%@ include file="footer.jsp" %>
</body>
</html>