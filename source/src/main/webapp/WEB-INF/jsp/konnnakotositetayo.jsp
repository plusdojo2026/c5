<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="dto.Konnnakotositetayo" %>
<%@ include file="/WEB-INF/jsp/header.jsp" %>
<% 



    // セッションからfamily_idとcouple_idを取得
    String familyId = (String) session.getAttribute("family_id");
    int coupleId    = (int)   session.getAttribute("couple_id");

    // Servletからタイムラインデータを受け取る
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
  
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/konnnakotositetayo.css">
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
</head>
<body>

    

    <!-- ===== メインコンテンツ ===== -->
    <div class="wrapper">

        <!-- エラーメッセージエリア -->
        <% if (!message.equals("")) { %>
            <div class="error-message" id="message">
                <%= message %>
            </div>
        <% } %>

        <!-- ページタイトル -->
        <h1 class="page-title">こんなことしてたよ</h1>

        <!-- 記録するボタン -->
        <div class="btn-area">
            <button type="button" class="btn-add" id="openModalBtn">
                ＋ 記録する
            </button>
        </div>

        <!-- ===== タイムライン ===== -->
        <div class="timeline">

            <% if (timelineList == null || timelineList.isEmpty()) { %>
                <!-- データがない場合 -->
                <p class="no-data">まだ記録がありません。</p>

            <% } else { %>
                <!-- データがある場合はループで表示 -->
                <% for (Konnnakotositetayo bean : timelineList) { %>
                    <div class="timeline-item">

                        <!-- アイコン（妻か夫かで変える） -->
                        <div class="timeline-icon">
                            <% if (bean.getCoupleId() == 0) { %>
                                <img src="images/icon_mama.png" alt="ママ" class="user-icon">
                            <% } else { %>
                                <img src="images/icon_papa.png" alt="パパ" class="user-icon">
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
                                <%= bean.getTaskId() %>
                                &nbsp;
                                <span class="timeline-count"><%= bean.getCount() %>回</span>
                            </p>

                            <!-- 補足メモ（ある場合のみ表示） -->
                            <% if (bean.getMemo() != null && !bean.getMemo().equals("")) { %>
                                <p class="timeline-memo"><%= bean.getMemo() %></p>
                            <% } %>

                        </div>

                        <!-- 既読・未読 -->
                        <div class="timeline-status">
                            <% if (bean.getIsRead() == 1) { %>
                                <span class="status-read">✓ 確認済み</span>
                            <% } else { %>
                                <span class="status-unread">未確認</span>
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
                        <button type="button" class="task-btn" onclick="selectTask('ミルク')">ミルク</button>
                        <button type="button" class="task-btn" onclick="selectTask('夜泣き')">夜泣き</button>
                        <button type="button" class="task-btn" onclick="selectTask('おむつ交換')">おむつ交換</button>
                        <button type="button" class="task-btn" onclick="selectTask('歯磨き')">歯磨き</button>
                        <button type="button" class="task-btn" onclick="selectTask('お風呂')">お風呂</button>
                        <button type="button" class="task-btn" onclick="selectTask('その他')">その他</button>
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

    </script>
 <%@ include file="footer.jsp" %>
</body>
</html>