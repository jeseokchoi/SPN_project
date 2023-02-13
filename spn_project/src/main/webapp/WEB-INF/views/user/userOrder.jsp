<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>


<main>
<section>
	<div class="titleArea">
		<h2>ORDER</h2>
	</div>
	<ul class="menu">
		<li><a href="${cpath }/user/userOrder">주문 내역 조회(<span id="orderCount"></span>)</a></li>
	</ul>
	
	<h3>주문 상품 정보</h3>
	<table>
		<thead>
			<tr>
				<th>주문일자[주문번호]</th>
				<th>이미지</th>
				<th>상품정보</th>
				<th>수량</th>
				<th>상품구매금액</th>
				<th>주문처리상태</th>
				<th>취소/반품/교환</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="orderList" >
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>		
			</tr>
			</c:forEach>
		</tbody>
	</table>
</section>
</main>
</body>
</html>