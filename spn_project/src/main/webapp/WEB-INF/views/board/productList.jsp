<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<h3>${category }</h3>

<c:forEach var="dto" items="${list }">

<div>${dto.product_name }</div>
<div>${dto.product_price }</div>
</c:forEach>
</body>
</html>