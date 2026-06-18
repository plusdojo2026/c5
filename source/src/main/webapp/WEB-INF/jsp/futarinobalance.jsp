<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="dto.Futarinobalance" %>
List<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><Futarinobalance> mamaList =
<%

    // ===== ServletからJSPにデータを受け渡している（今は受け取っている） =====
    // → FutarinobalanceServlet.java(dto) の doGet() で request.setAttribute() したデータ

    // 妻担当リスト（couple_id=0のデータ）
    List<Futarinobalance> mamaList =
        (List<Futarinobalance>) request.getAttribute("mamaList");

    // 夫担当リスト（couple_id=1のデータ）
    List<Futarinobalance> papaList =
        (List<Futarinobalance>) request.getAttribute("papaList");

    // 未割当リスト（couple_id=２のデータ）
    List<Futarinobalance> unassignedList =
        (List<Futarinobalance>) request.getAttribute("unassignedList");

    // nullチェック（念のため空リストにする）
    if (mamaList == null) {
        mamaList = new java.util.ArrayList<Futarinobalance>();
    }
    if (papaList == null) {
        papaList = new java.util.ArrayList<Futarinobalance>();
    }
    if (unassignedList == null) {
        unassignedList = new java.util.ArrayList<Futarinobalance>();
    }
%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ふたりのバランス | ふたりごと。</title>
    <!-- このページ専用CSS（common.cssの内容も含む） -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/futarinobalance.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
</head>
<body>

    <!-- ===== 共通ヘッダー ===== -->
    <%@ include file="/WEB-INF/jsp/header.jsp" %>

    <!-- ===== メインコンテンツ ===== -->
    <div class="balance-wrapper">

        <!-- ページタイトル -->
        	<div class="page-header">
        	<h1 class="page-title">ふたりのバランス</h1>
        	<p class="page-subtitle">家事や育児の分担を見える化して、ふたりで気持ちよく協力し合おう。</p>
        </div>

        <!-- 使い方ヒント spanは文字とか小さい要素を囲むための箱-->
        <div class="hint-area">
            <span class="hint-icon"></span>
            <span class="hint-text">項目をドラッグして、担当を変更できます。</span>
        </div>

        <!-- ===== 3カラムエリア（ママ / 未割当 / パパ） ===== -->
        <div class="columns-area">

            <!-- ===== 左カラム：ママ担当 ===== -->
            <div class="column column-mama">

                <!-- カラムヘッダー -->
                <div class="column-header column-header-mama">
                    <span class="column-icon"></span>
                    <span class="column-title">ママ担当</span>
                    <!-- ママリストの件数を表示 -->
                    <!-- mamaList.size() → Futarinobalance.java のリストの件数 -->
                    <span class="column-count"><%= mamaList.size() %>項目</span>
                </div>	 <%--「<%=  %>」イコール付きはJavaの計算結果をHTMLに出力するループ処理タグ--%>

                <!-- タスクを--並べるドロップゾーン -->
                <!-- id="mama-zone" → JavaScriptでドロップ先を識別するために使う -->
                <%-- data-couple-id="0"はこのゾーンに落とすとcouple_idが0(ママ)になるよ、っていう情報をHTML属性に埋め込んでる--%>
                
                <div class="task-zone" id="mama-zone" data-couple-id="0">

					<c:if test="${empty mamaList}">
                     <!-- c:ifっていうのは、条件が正しい（trueの）ときだけ、↓のHTMLが表示される -->
    				<p class="empty-message">ここにドラッグしてください</p>
					</c:if>
					
                    <!-- mamaListをループして1件ずつ表示する -->
                    <% for (int i = 0; i < mamaList.size(); i++) { %>
                    <% Futarinobalance bean = mamaList.get(i);%>
                    
               		
                        <!-- タスクカード -->
                        <!-- data-balance-id → JavaScriptでどのタスクか識別するために使う -->
                        <!-- draggable="true" → ドラッグできるようにする -->
                        <div class="task-card"
                             draggable="true"
                             data-balance-id="<%= bean.getBalanceId() %>"
                             data-couple-id="<%= bean.getCoupleId() %>"
                             data-display-order="<%= bean.getDisplayOrder() %>">

                            <!-- タスク名 → Futarinobalance.java の getTaskName() で取得 -->
                            <span class="task-name"><%= bean.getTaskName() %></span>
                            <span class="drag-handle">⠿</span>
                        </div>
                    <% } %>

                </div>
            </div>
            <!-- /左カラム -->


            <!-- ===== 中央カラム：未割当 ===== -->
            <div class="column column-unassigned">

                <!-- カラムヘッダー -->
                <div class="column-header column-header-unassigned">
                    <span class="column-title">未割り当て</span>
                    <span class="column-count"><%= unassignedList.size() %>項目</span>
                </div>

                <!-- タスクを並べるドロップゾーン -->
                <div class="task-zone" id="unassigned-zone" data-couple-id="2">

                    <% if (unassignedList.isEmpty()) { %>
                        <div class="empty-unassigned">
                            <span class="empty-icon"></span>
                            <p class="empty-message">ここにドラッグすると<br>未割り当てに戻ります</p>
                        </div>
                    <% } %>

                    <% for (int i = 0; i < unassignedList.size(); i++) { %>
                        <% Futarinobalance bean = unassignedList.get(i); %>
                        <div class="task-card"
                             draggable="true"
                             data-balance-id="<%= bean.getBalanceId() %>"
                             data-couple-id="<%= bean.getCoupleId() %>"
                             data-display-order="<%= bean.getDisplayOrder() %>">
                            <span class="task-name"><%= bean.getTaskName() %></span>
                            <span class="drag-handle">⠿</span>
                        </div>
                    <% } %>

                </div>
            </div>
            <!-- /中央カラム -->


            <!-- ===== 右カラム：パパ担当 ===== -->
            <div class="column column-papa">

                <!-- カラムヘッダー -->
                <div class="column-header column-header-papa">
                    <span class="column-icon"></span>
                    <span class="column-title">パパ担当</span>
                    <span class="column-count"><%= papaList.size() %>項目</span>
                </div>

                <!-- タスクを並べるドロップゾーン -->
                <div class="task-zone" id="papa-zone" data-couple-id="1">

                    <% if (papaList.isEmpty()) { %>
                        <p class="empty-message">ここにドラッグしてください</p>
                    <% } %>

                    <% for (int i = 0; i < papaList.size(); i++) { %>
                        <% Futarinobalance bean = papaList.get(i); %>
                        <div class="task-card"
                             draggable="true"
                             data-balance-id="<%= bean.getBalanceId() %>"
                             data-couple-id="<%= bean.getCoupleId() %>"
                             data-display-order="<%= bean.getDisplayOrder() %>">
                            <span class="task-name"><%= bean.getTaskName() %></span>
                            <span class="drag-handle">⠿</span>
                        </div>
                    <% } %>

                </div>
            </div>
            <!-- /右カラム -->

        </div>
        <!-- /3カラムエリア -->


        <!-- ===== 保存ボタン ===== -->
        <div class="save-area">
            <button type="button" class="btn-save" id="saveBtn">
                 担当を保存する
            </button>
            <!-- 保存結果メッセージ（JavaScriptで表示する） -->
            <p class="save-message" id="saveMessage"></p>
        </div>

    </div>
    <!-- /balance-wrapper -->


    <!-- ===== JavaScript ===== -->
    <script>

        // ===== ドラッグ&ドロップの処理 =====

        // 今ドラッグ中のタスクカードを入れる変数
        var draggingCard = null;

        // ページ上の全タスクカードにドラッグイベントを設定する関数
        // タスクが移動した後にも呼ぶ必要があるので関数にしている
        function setupDragEvents() {

            // class="task-card" の要素を全部取得する
            var cards = document.querySelectorAll(".task-card");

            // 全カードに対してイベントを設定する
            for (var i = 0; i < cards.length; i++) {
                var card = cards[i];

             // ドラッグ開始した時

                card.addEventListener("dragstart", function(e) {

                    // ドラッグ中のカードを記憶する
                    draggingCard = this;
                    // 少し透明にしてドラッグ中とわかるようにする
                    this.style.opacity = "0.5";
                });
                // ドラッグ終了した時（離した時）
                card.addEventListener("dragend", function(e) {
                    // 透明度を元に戻す
                   this.style.opacity = "1";
                    draggingCard = null;
                });
            }
        }

        // ゾーン（ドロップ先）にイベントを設定する
        // id="mama-zone", "unassigned-zone", "papa-zone" の3つ
        var zones = document.querySelectorAll(".task-zone");

        for (var j = 0; j < zones.length; j++) {
            var zone = zones[j];

            // ゾーンの上にドラッグしてきた時（ドロップできるようにする）
            zone.addEventListener("dragover", function(e) {
                // デフォルト動作をキャンセルするとドロップできるようになる
                e.preventDefault();
                // ドロップ可能エリアのハイライト
                this.classList.add("drag-over");
            });

            // ゾーンからドラッグが外れた時
            zone.addEventListener("dragleave", function(e) {
                this.classList.remove("drag-over");
            });

            // ゾーンにドロップした時
            zone.addEventListener("drop", function(e) {
                e.preventDefault();
                this.classList.remove("drag-over");

                // ドラッグ中のカードがない場合は何もしない
                if (draggingCard == null) {
                    return;
                }

                // ドロップ先のゾーンにカードを移動する
                this.appendChild(draggingCard);

                // ドロップ先の couple_id を取得する
                // data-couple-id はゾーンのHTML属性に書いてある値
                var newCoupleId = this.getAttribute("data-couple-id");

                // カードのcouple_idを更新する
                draggingCard.setAttribute("data-couple-id", newCoupleId);

                // 変更済みリストに追加する（保存ボタン用）
                addToChangedList(draggingCard);

                // 件数表示を更新する
                updateCounts();

                // ドラッグイベントを再設定する
                setupDragEvents();
            });
        }

        // 最初にドラッグイベントを設定する
        setupDragEvents();


        // ===== 変更済みリストの管理 =====
        // 保存する時に変更されたカードだけDBに送るために使う
        var changedList = [];

        function addToChangedList(card) {
            // balance_id を取得する
            // data-balance-id はカードのHTML属性に書いてある値
            var balanceId = card.getAttribute("data-balance-id");

            // すでにリストにあれば更新、なければ追加する
            var found = false;
            for (var i = 0; i < changedList.length; i++) {
                if (changedList[i].balanceId == balanceId) {
                    changedList[i].coupleId = card.getAttribute("data-couple-id");
                    found = true;
                    break;
                }
            }
            if (found == false) {
                changedList.push({
                    balanceId: balanceId,
                    coupleId:  card.getAttribute("data-couple-id")
                });
            }
        }


        // ===== 件数表示の更新 =====
        function updateCounts() {
            // 各ゾーンのtask-cardの数を数えて表示する
            var mamaCount       = document.querySelectorAll("#mama-zone .task-card").length;
            var papaCount       = document.querySelectorAll("#papa-zone .task-card").length;
            var unassignedCount = document.querySelectorAll("#unassigned-zone .task-card").length;

            // .column-count の要素を取得して更新する
            var counts = document.querySelectorAll(".column-count");
            counts[0].textContent = mamaCount       + "項目";
            counts[1].textContent = unassignedCount + "項目";
            counts[2].textContent = papaCount       + "項目";
        }


        // ===== 保存ボタンの処理 =====
        var saveBtn     = document.getElementById("saveBtn");
        var saveMessage = document.getElementById("saveMessage");

        saveBtn.addEventListener("click", function() {

            if (changedList.length == 0) {
                saveMessage.textContent = "変更がありません。";
                saveMessage.style.color = "#aaa";
                return;
            }

            var total = changedList.length;
            var done  = 0;
            var error = 0;

            for (var i = 0; i < changedList.length; i++) {
                (function(item) {   // ← クロージャで i を固定
                	var params = "balance_id=" + item.balanceId
                    + "&couple_id=" + item.coupleId
                    + "&display_order=0";

         fetch("/c5/FutarinobalanceServlet", {
             method: "POST",
             headers: {
                 "Content-Type": "application/x-www-form-urlencoded"
             },
             body: params
         })
                    .then(function(res) { return res.text(); })
                    .then(function(text) {
                        if (text === "success") {
                            done++;
                        } else {
                            error++;
                        }
                        // 全件終わったらメッセージ表示
                        if (done + error === total) {
                            if (error === 0) {
                                saveMessage.textContent = "✓ 保存しました！";
                                saveMessage.style.color = "#2ecc71";
                                changedList = [];
                            } else {
                                saveMessage.textContent = "保存に失敗した項目があります。";
                                saveMessage.style.color = "#e00";
                            }
                        }
                    })
                    .catch(function() {
                        error++;
                        if (done + error === total) {
                            saveMessage.textContent = "通信エラーが発生しました。";
                            saveMessage.style.color = "#e00";
                        }
                    });
                })(changedList[i]);
            }
        });

    </script>

</body>
</html>
