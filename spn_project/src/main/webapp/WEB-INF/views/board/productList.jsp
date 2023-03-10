<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<main>
<section id="list">
	<div id="categoryName"><h3>${category }</h3></div>

	<div id="wrap">
	<c:forEach var="dto" items="${list }">
		<div class="item">
			<div class="img">
				<a href="${cpath }/board/view/${dto.product_idx}"><img class="listImg" src="${cpath}/itemImg/${dto.product_t_img[0]}"></a>
			</div>
			<div class="listName">${dto.product_name }</div>
			<div class="listPrice">KRW <fmt:formatNumber>${dto.product_price }</fmt:formatNumber></div>
		</div>
	</c:forEach>
	</div>
</section>
</main>
</body>
</html>