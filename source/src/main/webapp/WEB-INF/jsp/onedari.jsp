<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>おねだりリスト</title>
<link rel="stylesheet" href="/c5/css/common.css">
<link rel="stylesheet" href="/c5/css/onedari.css">
</head>
<body>
<!-- ヘッダー -->
<%@ include file="header.jsp" %>
<div class="wrapper">
<!-- （おねだりリストのタイトルと追加するボタン） -->
<div class ="header-container">
	<div class="header-left">
            <img src="/c5/img/onedari.png" alt="買い物かご" class="cart-icon">
	<h1 class="page-title">おねだりリスト</h1>
	</div>
	 <button id="add-btn">＋追加する</button>
</div>

<!-- おねだりリストのメインエリア -->
<!-- 条件分岐：リストが空の場合 -->
<c:if test="${empty onedariList}">
<main class ="empty-list">
<!--  真ん中のイラスト --> <!-- 後で画像のリンクちゃんと設定 -->
    <img src="/c5/img/onedari_kara.png" alt="空のカート" class="empty-image">
     <h2>おねだりリストは空です</h2>
     <p>右上の「＋追加する」から<br>お願いしたいものを追加してみましょう！</p>
</main>
</c:if>
<!-- おねだりリストの一覧エリア（商品があるときに表示する箱） -->
<!-- 条件分岐：リストに商品があるとき -->
<c:if test="${not empty onedariList}">
<div class="item-list-container">    
   <c:forEach var="item" items="${onedariList}">
                <div class="item-card ${not empty item.updatedAt ? 'is-purchased' : ''}">
                    <div class="item-card-left">
					<c:choose>
						<c:when test="${item.category == '紙おむつ'}">
           				 	<img src="/c5/img/omutsu.png" alt="おむつ" class="item-cat-icon">
        				</c:when>
        				<c:when test="${item.category == 'ミルク'}">
            			<img src="/c5/img/milk.png" alt="ミルク" class="item-cat-icon">
       				 </c:when>
       				 <c:otherwise>
            			<img src="/c5/img/onedari_sonota.png" alt="その他" class="item-cat-icon">
            			</c:otherwise>
					</c:choose>
                        <div class="item-details">
                        	<!-- product_name（パンパース等）を表示 -->
                            <span class="item-brand"><c:out value="${item.productName}" /></span>
                            <!-- categoryマスタの type（テープ型、缶 など）を表示 -->
                            <span class="item-spec"><c:out value="${item.type}" /></span>
                            <!-- categoryマスタの size（新生児、S などのサイズ）を表示 -->
                            <span class="item-size"><c:out value="${item.size}" /></span>
                        </div>
                    </div>                   
                    <div class="item-card-right">
                    	<!-- 1. 添付写真 -->
                        <img src="/c5/upload/${item.imagePath}" alt="添付写真" class="item-thumb">
                        
                        <!-- 2. 削除ボタン -->
					    <a href="/c5/delete?onedariId=${item.onedariId}" class="delete-btn" onclick="return confirm('本当に削除しますか？');">
					        <img src="/c5/img/delete.png" alt="削除" class="delete-icon-img">
					    </a>
                        
                        <!-- 3.購入したらチェックマーク -->
					    <div class="check-wrapper">
                            <input type="checkbox" 
                                   id="check-${item.onedariId}" 
                                   class="check-box" 
                                   data-id="${item.onedariId}" 
                                   ${not empty item.updatedAt ? 'checked' : ''}>
                            <label for="check-${item.onedariId}" class="check-label"></label>
                        </div>						
                    </div>
                </div>
            </c:forEach> 
            </div>           
    </c:if>   
</div>    <!-- ここで div class wrapper 閉じてる -->

<!-- モーダル制御の画面構成1 -->
<div class="modal-overlay" id="add-modal"> 
    <div class="modal-container">      <!-- ミルクオムツその他などの上にくるカードの部分 -->
    <!-- 1つ前のページに戻るボタン（左上の>） -->
    <button class="modal-back-btn">&lt;</button>
    <!-- 閉じるボタン（右上の×） -->
        <button class="modal-close-btn">&times;</button>  
        <!-- [&times;]  綺麗な「×」のバツ印を表示するための書き方 -->
	 <h3>追加するものを選んでください</h3>
	<!-- おむつ・ミルク・その他　３つの選択肢を横並びにするための箱 -->
        <div class="select-options">
    <!-- おむつ選択 -->
    	<button class="option-btn" data-target="omutsu-modal">  <!-- data属性でオムツモーダルを開く -->
    	<img src="/c5/img/omutsu.png" alt="おむつ" class="option-icon">
                <span>おむつ</span>
        </button>  
    <!-- ミルク選択 -->
    	<button class="option-btn" data-target="milk-modal">  <!-- data属性でミルクモーダルを開く -->
    	<img src="/c5/img/milk.png" alt="ミルク" class="option-icon">
    			<span>ミルク</span>
    	</button>
    <!-- その他選択 -->
    	<button class="option-btn" data-target="other-modal">  <!-- data属性でその他モーダルを開く -->
    	<img src="/c5/img/onedari_sonota.png" alt="その他" class="option-icon">
    			<span>その他</span>
    	</button>
    	</div>
	</div>
</div>

<!-- モーダル制御の画面構成２-1 おむつ -->
<div class="modal-overlay" id="omutsu-modal"> 
    <div class="modal-container">
    <!-- １つ前に戻るボタン -->
    <button class="modal-back-btn">&lt;</button>
    <!-- 閉じるボタン -->
    <button class="modal-close-btn">&times;</button>
        <h3>おむつを追加</h3>
        
        <!-- 写真を送信するため enctype="multipart/form-data" を指定 -->
        <form action="/c5/OnedariServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="item-category" value="おむつ">    
            <!-- おむつのブランドを記述 -->
            <div class="form-group">
            <label>①なにを買ってきてほしいか教えてください</label>
            <input type="text" name="omutsu-brand" placeholder="例：パンパース、メリーズなど">
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
                    <label class="size-btn"><input type="radio" name="omutsu-size" value="BIG"> BIG</label>
                </div>
            </div>
            
            <!--  写真添付（任意）-->
            <div class="form-group">
                <label for="omutsu-image">写真を添付（任意）</label>
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
    	<!-- １つ前に戻るボタン -->
    	<button class="modal-back-btn">&lt;</button>
        <!-- 閉じるボタン -->
        <button class="modal-close-btn">&times;</button>
        <h3>ミルクを追加</h3>
        
        <!-- 写真を送信するため enctype="multipart/form-data" を指定 -->
        <form action="/c5/OnedariServlet" method="post" enctype="multipart/form-data">
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

<!-- モーダル制御の画面構成2-3 その他 -->
<div class="modal-overlay" id="other-modal"> 
    <div class="modal-container">
    	<!-- １つ前に戻るボタン -->
    	<button class="modal-back-btn">&lt;</button>
        <!-- 閉じるボタン -->
        <button class="modal-close-btn">&times;</button>
        <h3>その他を追加</h3>
        
        <!-- 写真やテキストを送信するため enctype="multipart/form-data" を指定 -->
        <form action="/c5/OnedariServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="item-category" value="その他">    
            
            <!-- 何を買ってきてほしいか（自由記述・必須） -->
            <div class="form-group">
                <label for="other-name">なにを買ってきてほしいか教えてください</label>
                <textarea id="other-name" name="other-name" placeholder="例：おしりふき、ベビーソープなど" required></textarea>
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
            
            <!-- 送信ボタン -->
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
        <img src="/c5/img/tsuika.png" alt="追加完了マーク" class="success-image">
        <!-- メッセージ部分 -->
        <h2>追加しました！</h2>
        <p>おねだりリストに追加されました</p>
        
    </div>
</div>

<!-- フッター -->
<%@ include file="footer.jsp" %>

<!-- JaveScript　ここから -->
<script>
document.addEventListener("DOMContentLoaded", () => {
    // 1. モーダルの開閉・切り替え制御
    const addBtn = document.getElementById("add-btn");
    const addModal = document.getElementById("add-modal");
    const allModals = document.querySelectorAll(".modal-overlay");
    const optionBtns = document.querySelectorAll(".select-options .option-btn");
    const closeBtns = document.querySelectorAll(".modal-close-btn");
    const backBtns = document.querySelectorAll(".modal-back-btn");
	
    //追加ボタン押されたら、おむつ ミルク その他 を選択する1のモーダルを表示
    if (addBtn && addModal) {
        addBtn.addEventListener("click", () => { addModal.style.display = "flex"; });
    }
	
    //選択された専用の各モーダルを表示 2-1 おむつ 2-2 ミルク  2-3 その他
    optionBtns.forEach(btn => {
        btn.addEventListener("click", () => {
            const targetId = btn.getAttribute("data-target");
            const targetModal = document.getElementById(targetId);
            if (targetModal) {
                if (addModal) addModal.style.display = "none";
                targetModal.style.display = "flex";
            }
        });
    });
	
    // > 戻るボタン押されたら一個前の選択画面に戻る
    backBtns.forEach(btn => {
        btn.addEventListener("click", () => {
            const currentModal = btn.closest(".modal-overlay");
            if (currentModal) currentModal.style.display = "none";
            if (addModal) addModal.style.display = "flex";
        });
    });
	
    // × バツボタン押されたら開いているモーダルをすべて閉じておねだりリストの初期画面に戻る
    closeBtns.forEach(btn => {
        btn.addEventListener("click", () => {
            allModals.forEach(modal => modal.style.display = "none");
        });
    });

    // 2. 画像のリアルタイムプレビュー処理
    const setupPreview = (inputId, previewId) => {
        const fileInput = document.getElementById(inputId);
        const previewImg = document.getElementById(previewId);
        if (!fileInput || !previewImg) return;

        fileInput.addEventListener("change", (event) => {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = (e) => {
                    previewImg.src = e.target.result;
                    previewImg.style.display = "block";
                };
                reader.readAsDataURL(file);
            } else {
                previewImg.src = "";
                previewImg.style.display = "none";
            }
        });
    };

    setupPreview("omutsu-image", "omutsu-preview");
    setupPreview("milk-image", "milk-preview");
    setupPreview("other-image", "other-preview");

 	// 3. 購入完了（チェックボックス）の制御

    const container = document.querySelector(".item-list-container");
    if (container) {
        // changeイベント（チェックボックスのON/OFFが切り替わった瞬間）を監視します
        container.addEventListener("change", async (event) => {
            const checkbox = event.target.closest(".check-box");
            if (!checkbox) return;

            const onedariId = checkbox.getAttribute("data-id");
            const card = checkbox.closest(".item-card");
            
            // チェックボックスが今「チェックされた(true)」か「外された(false)」かを取得
            const isChecked = checkbox.checked;

            try {
                // チェックされたら complete、外されたら cancel をサーバーに送る					
				const action = isChecked ? "complete" : "cancel";
				// FormDataを使ってデータを組み立てるように変更します
				const formData = new FormData();
				formData.append("id", onedariId);
				formData.append("action", action);
					
				// URLの後ろの文字を消し、bodyにformDataを載せます
				const response = await fetch(`/c5/OnedariServlet`, {
					   method: "POST",
					   body: formData
				});

                if (response.ok) {
                    if (isChecked) {
                        // 未購入 ➔ 購入済みにする処理
                        if (card) {
                            card.classList.add("is-purchased"); // gray（半透明）にする
                            container.appendChild(card);        // リストの一番最後（下）へ移動
                        }
                    } else {
                        // 購入済み ➔ 未購入に戻す処理
                        if (card) {
                            card.classList.remove("is-purchased"); // gray（半透明）を解除
                            container.insertBefore(card, container.firstChild); // リストの一番上に戻す
                        }
                    }
                } else {
                    // 通信失敗時は、パパの画面のチェックボックスの見た目を元の状態に強制的に戻します
                    checkbox.checked = !isChecked;
                    alert("通信に失敗しました。");
                }
            } catch (error) {
                checkbox.checked = !isChecked;
                console.error("Error:", error);
            }
        });
    }
    
	//追加完了画面を２秒間表示したのちにリストの一覧に戻る
	const successModal = document.getElementById("success-modal");
	if (successModal && new URLSearchParams(window.location.search).get("msg") === "success") {
	    successModal.style.display = "flex";
	    setTimeout(() => {
	        successModal.style.display = "none";
	        // URLの「?msg=success」を綺麗に消して元のURLに戻す親切機能
	        window.history.replaceState({}, document.title, window.location.pathname);
	    }, 2000); // 2000ミリ秒 ＝ 2秒間表示する
	}
});
</script>
</body>
</html>