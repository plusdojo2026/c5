<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" %>

<header>

    <div class="logo-area">
        <a href="${pageContext.request.contextPath}/HomeServlet">
            <img
                src="${pageContext.request.contextPath}/img/logo.png"
                alt="ふたりごと。"
                class="logo-image">
        </a>
    </div>
    
    <div class="home-header-action">
	    <a href="${pageContext.request.contextPath}/LogoutServlet"
	       class="logout-btn">
	        ログアウト
	    </a>
	</div>

</header>