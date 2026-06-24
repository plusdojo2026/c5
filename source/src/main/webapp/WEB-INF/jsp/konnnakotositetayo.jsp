<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="dto.Konnnakotositetayo" %>
<%@ include file="/WEB-INF/jsp/header.jsp" %>
<% 



	String familyId = (String) session.getAttribute("family_id");

//LoginServlet経由 → couple_idはInteger型
//FutarinobalanceServlet経由 →couple_idはString型
//integerでもstringでも対応できるようにtoString「共通の通貨」に変換した後に、parseIntで整数に変換
	Object coupleIdObj = session.getAttribute("couple_id");
	int coupleId = 0;
	if (coupleIdObj != null) {
	coupleId = Integer.parseInt(coupleIdObj.toString());
	}

    // Servletからタイムラインデータを受け取る
    //KonnnakotositetayoServlet.javaのDAOを使ってタイムラインデータを取得の部分と繋がっている。
    List<Konnnakotositetayo> timelineList =
        (List<Konnnakotositetayo>) request.getAttribute("timelineList");

    // エラーメッセージを受け取る
    String message = (String) request.getAttribute("message");
    if (message == null) {
        message = "";
    }
%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>こんなことしてたよ | ふたりごと。</title>
  
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/konnnakotositetayo.css">

</head>
<body>

    
<main>
    <!-- ===== メインコンテンツ ===== -->
    <div class="page-container">
    
    <a href="${pageContext.request.contextPath}/HomeServlet">
	<img src="<%=request.getContextPath()%>/img/ホームに戻る.png" class="back_home">
	</a>

        <!-- エラーメッセージエリア -->
        <% if (!message.equals("")) { %>
            <div class="error-message" id="message">
                <%= message %>
            </div>
        <% } %>

        <!-- ページタイトル -->
        <div class="page-header">
        	<h1 class="page-title">こんなことしてたよ</h1>
        
	       <!-- 記録する・削除ボタン -->
	        <div class="btn-area">
	            <button type="button" class="page-action-btn" id="openModalBtn">
	                ＋ 記録する
	            </button>

	            <!-- すべて削除ボタン -->
	            <form action="KonnnakotositetayoServlet" method="post" id="deleteForm" style="margin:0;">
	                <input type="hidden" name="action" value="delete">
	                <button type="button" class="btn-delete-all" id="deleteAllBtn">
	                    <img src="${pageContext.request.contextPath}/img/gomibako.jpg" alt="削除" class="trash-icon">
	                    すべて削除
	                </button>
	            </form>
	        </div>
	</div>
        <!-- ===== タイムライン ===== -->
        <div class="timeline">

            <% if (timelineList == null || timelineList.isEmpty()) { %>
                <!-- データがない場合 -->
                <p class="no-data">まだ記録がありません。</p>

            <% } else { %>
                <!-- データがある場合はループで表示 拡張FOR文＝リストや配列の中身をひとつづつ取り出して処理をする。-->
                <% for (Konnnakotositetayo bean : timelineList) { %>
                    <div class="timeline-item">

                        <!-- アイコン（妻か夫かで変える） -->
                        <div class="timeline-icon">
                            <% if (bean.getCoupleId() == 0) { %>
                                <img src="img/mama_icon.png" alt="ママ" class="user-icon">
                            <% } else { %>
                                <img src="img/papa_icon.png" alt="パパ" class="user-icon">
                            <% } %>
                        </div>

                        <!-- 記録の内容 -->
                        <div class="timeline-content">

                            <!-- 誰がいつ -->
                            <p class="timeline-meta">
                                <% if (bean.getCoupleId() == 0) { %>
                                    ママ
                                <% } else { %>
                                    パパ
                                <% } %>
                                &nbsp;
                                <%= bean.getRecordedDate() %>
                            </p>

                            <!-- タスク名と回数 -->
                            <p class="timeline-task">
                                <%= bean.getTaskName() %>
                                &nbsp;
                                <span class="timeline-count"><%= bean.getCount() %>回</span>
                            </p>

                            <!-- 補足メモ（ある場合のみ表示） -->
                            <% if (bean.getMemo() != null && !bean.getMemo().equals("")) { %>
                                <p class="timeline-memo"><%= bean.getMemo() %></p>
                            <% } %>

                        </div>

                        
                    </div>
                <% } %>
            <% } %>

        </div>
        <!-- /タイムライン -->

    </div>
    <!-- /wrapper -->


    <!-- ===== モーダル（記録する） ===== -->
    <div class="modal-overlay" id="modalOverlay"></div>

    <div class="modal" id="modal">
        <div class="modal-content">

            <h2 class="modal-title">何をしましたか？</h2>

            <form action="KonnnakotositetayoServlet" method="post">

                <!-- タスク選択 -->
                <div class="form-group">
                    <label class="form-label">項目を選択</label>
 <div class="task-buttons">
    <button type="button" class="task-btn" onclick="selectTask('1')">
    <img src="/c5/img/milk_konnna.png" alt="ミルク" class="btn-icon">ミルク</button>
    
    <button type="button" class="task-btn" onclick="selectTask('2')">
    <img src="/c5/img/yonaki.png" alt="夜泣き" class="btn-icon">夜泣き</button>
    
    <button type="button" class="task-btn" onclick="selectTask('3')">
    <img src="/c5/img/omutsukoukann.png" alt="おむつ交換" class="btn-icon">おむつ交換</button>
    
    <button type="button" class="task-btn" onclick="selectTask('4')">
    <img src="/c5/img/hamigaki.png" alt="歯磨き" class="btn-icon">歯磨き</button>
    
    <button type="button" class="task-btn" onclick="selectTask('5')">
    <img src="/c5/img/ofuro.png" alt="お風呂" class="btn-icon">お風呂</button>
    
    <button type="button" class="task-btn" onclick="selectTask('6')">
    <img src="/c5/img/sonota.png" alt="その他" class="btn-icon">その他</button>
</div>

                    <!-- 選択されたタスクをhiddenで送る -->
                    <input type="hidden" name="task_id" id="selectedTask" value="">
                </div>

                <!-- 回数入力 -->
                <div class="form-group">
                    <label class="form-label">回数</label>
                    <div class="count-area">
                        <button type="button" class="btn-count" onclick="decrementCount()">－</button>
                        <input type="text" name="count" id="countInput" value="1" class="input-text count-input" readonly>
                        <button type="button" class="btn-count" onclick="incrementCount()">＋</button>
                    </div>
                </div>

                <!-- 補足メモ（その他選択時に使用） -->
                <div class="form-group">
                    <label class="form-label">メモ（任意）</label>
                    <input type="text" name="memo" class="input-text" placeholder="メモを入力（任意）" maxlength="20">
                </div>

                <!-- ボタンエリア -->
                <div class="modal-btn-area">
                    <button type="button" class="btn-secondary" id="closeModalBtn">キャンセル</button>
                    <button type="submit" class="btn-primary">記録する</button>
                </div>

            </form>

        </div>
    </div>
    <!-- /モーダル -->
		<!-- 変更完了モーダル -->
<div class="kannryou-modal" id="success-modal">
    <div class="modal-container1 success-container">
        
        <!-- 中央に表示されるチェックマークのイラスト -->
        <!-- 後で画像のリンクちゃんと設定 -->
        <img src="/c5/img/tsuika.png" alt="追加完了マーク" class="success-image">
        <!-- メッセージ部分 -->
        <h2>記録しました！</h2>
        <p>こんなことしてたよの内容が更新されました</p>
        
    </div>
</div>

</main>   

 <%@ include file="footer.jsp" %>
    <!-- ===== JavaScript ===== -->
    <script>

        // ===== モーダルの開閉 =====
        var openBtn  = document.getElementById("openModalBtn");
        var closeBtn = document.getElementById("closeModalBtn");
        var modal    = document.getElementById("modal");
        var overlay  = document.getElementById("modalOverlay");

        // 開く
        openBtn.addEventListener("click", function() {
            modal.style.display   = "block";
            overlay.style.display = "block";
        });

        // 閉じる（キャンセルボタン）
        closeBtn.addEventListener("click", function() {
            modal.style.display   = "none";
            overlay.style.display = "none";
        });

        // 閉じる（背景クリック）
        overlay.addEventListener("click", function() {
            modal.style.display   = "none";
            overlay.style.display = "none";
        });
        
     // ===== すべて削除ボタン =====
        var deleteBtn = document.getElementById("deleteAllBtn");
        deleteBtn.addEventListener("click", function() {
            var ok = confirm("記録をすべて削除します。よろしいですか？");
            if (ok) {
                document.getElementById("deleteForm").submit();
            }
        });


        // ===== タスクボタンの選択 =====
        function selectTask(taskName) {
            // hiddenに選択したタスク名をセット
            document.getElementById("selectedTask").value = taskName;

            // 選択されたボタンの色を変える
            var taskBtns = document.querySelectorAll(".task-btn");
            for (var i = 0; i < taskBtns.length; i++) {
                taskBtns[i].classList.remove("task-btn-selected");
            }
            event.target.classList.add("task-btn-selected");
        }


        // ===== 回数のカウント =====
        function incrementCount() {
            var input = document.getElementById("countInput");
            var count = parseInt(input.value);
            input.value = count + 1;
        }

        function decrementCount() {
            var input = document.getElementById("countInput");
            var count = parseInt(input.value);
            if (count > 1) {
                input.value = count - 1;
            }
        }
     // ===== 記録するボタン押下時のバリデーション =====
        // モーダル内のフォーム要素を取得する
        var recordForm = document.querySelector(".modal form");
        
        // フォームが送信されようとした瞬間にチェック処理を実行
        recordForm.addEventListener("submit", function(e) {
            // 隠しフィールドに保存されているタスクIDを取得
            var selectedTask = document.getElementById("selectedTask").value;
            
            // タスクIDが空の場合(何も選ばれていない場合)
            if (selectedTask === "") {
                // フォームの送信処理を中止する
                e.preventDefault();
                
                // ユーザーに警告を表示する
                alert("項目を選択してください");
            }
        });
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