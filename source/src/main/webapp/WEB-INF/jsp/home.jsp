<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ふたりごと。</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
</head>
<body>
<!-- ヘッダー -->
<%@ include file="header.jsp" %>

<!-- メイン -->
<main>
    <div class="menu-grid">
    
    	<!-- おねだり -->
        <a href="${pageContext.request.contextPath}/OnedariServlet" class="home-icon">
            <div class="icon">
            	<img src="${pageContext.request.contextPath}/img/onedari.png"
        			 alt="おねだり">
			</div>
            <div class="title">
                おねだり
            </div>
        </a>

		<!-- こんなことしてたよ -->
        <a href="${pageContext.request.contextPath}/KonnnakotositetayoServlet" class="home-icon">
            <div class="icon">
            	<img src="${pageContext.request.contextPath}/img/konnnakotositetayo.png"
        			 alt="こんなことしてたよ">
			</div>
            <div class="title">
                こんなことしてたよ
            </div>
        </a>

		<!-- ふたりのバランス -->
        <a href="${pageContext.request.contextPath}/FutarinobalanceServlet" class="home-icon">
            <div class="icon">
            	<img src="${pageContext.request.contextPath}/img/futarinobalance.png"
        			 alt="ふたりのバランス">
			</div>
            <div class="title">
                ふたりのバランス
            </div>
        </a>

		<!-- おもいでアルバム -->
        <a href="${pageContext.request.contextPath}/OmoidealbumlbumServlet" class="home-icon">
            <div class="icon">
            	<img src="${pageContext.request.contextPath}/img/omoidealbum.png"
        			 alt="おもいでアルバム">
			</div>
            <div class="title">
                おもいでアルバム
            </div>
        </a>

		<!-- すくすく記録 -->
        <a href="${pageContext.request.contextPath}/SukusukukirokuServlet" class="home-icon">
            <div class="icon">
            	<img src="${pageContext.request.contextPath}/img/sukusukukiroku.png"
        			 alt="すくすく記録">
			</div>
            <div class="title">
                すくすく記録
            </div>
        </a>

		<!-- ママのようす -->
        <a href="${pageContext.request.contextPath}/MamanoyousuServlet" class="home-icon">
            <div class="icon">
            	<img src="${pageContext.request.contextPath}/img/mamanoyousu.png"
        			 alt="ママのようす">
			</div>
            <div class="title">
                ママのようす
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

		<!-- ママのトリセツ -->
        <a href="${pageContext.request.contextPath}/TorisetsuServlet" class="home-icon">
            <div class="icon">
            	<img src="${pageContext.request.contextPath}/img/mamanotorisetsu.png"
        			 alt="ママのトリセツ">
			</div>
            <div class="title">
                ママのトリセツ
            </div>
        </a>
    </div>
</main>

<!-- フッター -->
<%@ include file="footer.jsp" %>

</body>
</html>