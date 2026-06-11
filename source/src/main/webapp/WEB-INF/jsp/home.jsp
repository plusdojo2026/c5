<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ふたりごと。</title>
<link rel="stylesheet" href="/css/common.css">
</head>
<body>
<!-- ヘッダー -->
<header>
    <div class="logo-area">
        <h1>ふたりごと。</h1>
        <p>
            ふたりで育児・家事をもっとたのしく
        </p>
    </div>

    <div class="user-area">
    	<c:choose>
            <c:when test="${sessionScope.couple_id == 0}">
                ママ
            </c:when>
            <c:otherwise>
                パパ
            </c:otherwise>
        </c:choose>
    </div>
</header>

<!-- メイン -->
<main>
    <div class="menu-grid">
    
    	<!-- おねだり -->
        <a href="/OnedariServlet" class="home-icon">
            <div class="icon">🛒</div>
            <div class="title">
                おねだり
            </div>
        </a>

		<!-- こんなことしてたよ -->
        <a href="/KonnnakotositetayoServlet" class="home-icon">
            <div class="icon">📋</div>
            <div class="title">
                こんなことしてたよ
            </div>
        </a>

		<!-- ふたりのバランス -->
        <a href="/FutarinobalanceServlet" class="home-icon">
            <div class="icon">📊</div>
            <div class="title">
                ふたりのバランス
            </div>
        </a>

		<!-- おもいでアルバム -->
        <a href="/OmoidealbumlbumServlet" class="home-icon">
            <div class="icon">📷</div>
            <div class="title">
                おもいでアルバム
            </div>
        </a>

		<!-- すくすく記録 -->
        <a href="/SukusukukirokuServlet" class="home-icon">
            <div class="icon">📅</div>
            <div class="title">
                すくすく記録
            </div>
        </a>

		<!-- ママのようす -->
        <a href="/MamanoyousuServlet" class="home-icon">
            <div class="icon">❤</div>
            <div class="title">
                ママのようす
            </div>
            <button>
                記録する
            </button>
        </a>

		<!-- ママのトリセツ -->
        <a href="/TorisetsuServlet" class="home-icon">
            <div class="icon">📖</div>
            <div class="title">
                ママのトリセツ
            </div>
            
            <!-- ママの場合 -->
            <c:if test="${sessionScope.couple_id == 0}">
                <button type="button">
                    記録する
                </button>
            </c:if>

            <!-- パパの場合 -->
            <c:if test="${sessionScope.couple_id == 1}">
                <div class="condition-preview">
                    メンタル： ${メソッド名.引数}
                    <br>
                    睡眠： ${メソッド名.引数}時間
                </div>
            </c:if>
            
        </a>
    </div>
</main>
</body>
</html>