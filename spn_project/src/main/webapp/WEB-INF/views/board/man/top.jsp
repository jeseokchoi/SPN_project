<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>   

<h1>TOP</h1>
<hr>

<div class="topList">
	<div class="wrap">
		<c:forEach var="dto" items="${list }">
			<div class="item" idx=${dto.product_idx }>
				<div class="name">${dto.product_name }</div>
				<div class="price">
					<fmt:formatNumber value="${dto.product_price }"/>원
				</div>
			</div>
		</c:forEach>
	</div>
</div>

</body>
</html>