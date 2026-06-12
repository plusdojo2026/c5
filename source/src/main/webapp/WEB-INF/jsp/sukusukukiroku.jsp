<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/sukusukukiroku.css">
<meta charset="UTF-8">
<title>すくすく記録</title>
</head>

<!-- ここからすくすく記録 -->
<body>
<hr>
<!-- ヘッダー -->
<%@ include file="header.jsp" %>

<h1>すくすく記録</h1>
	
	<!-- メッセージ -->
	<c:if test="${not empty message}">
    <div class="message">${message}</div>
	</c:if>
	
	<!-- 記録フォーム展開するボタン -->
	<button id="openModal">記録する</button>
	
	 <!-- 記録のモーダル表示 -->
		<div id="modal" class="modal">
			<div class="modal-content">
				<h3>赤ちゃんの健康記録を追加</h3>
				<form action="${pageContext.request.contextPath}/SukusukukirokuServlet" method="post">
					<label>日付</label>
						<input type="text" name="date" value="${now}" readonly> 
					<label>体温</label>
						<input type="text" name="temperature">
					<label>体重</label>
						<input type="text" name="weight">
					<label>メモ（任意）</label>
						<textarea name="note"></textarea>
					<button type="submit">追加する</button>
					<button type="button" id="closeModal">閉じる</button>
				</form>
			</div>
		</div>
		<h2>記録一覧</h2>	
		<table>
			<tr>
				<th>日付</th>
				<th>体温</th>
				<th>体重</th>
				<th>メモ</th>
			</tr>
			<c:forEach var="r" items="${recordList}">
			<tr>
				<td>${r.recordedAt}</td>
   				 <td>${r.temperature}</td>
    			<td>${r.weight}</td>
    			<td>${r.note}</td>				
			</tr>
			</c:forEach>
		</table>	
			
			
	<!-- フッター -->
<%@ include file="footer.jsp" %>
<script>
	const modal = document.getElementById("modal");
	//モーダルの表示
	document.getElementById("openModal").onclick = () => modal.style.display="block";
	//モーダルの非表示
	document.getElementById("closeModal").onclick = () => modal.style.display="none";
</script>
</body>
</html>