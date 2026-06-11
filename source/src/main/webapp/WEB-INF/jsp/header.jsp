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