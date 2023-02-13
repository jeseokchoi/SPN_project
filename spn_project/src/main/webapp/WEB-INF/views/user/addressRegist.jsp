<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<style>
	#root{
		width:700px;
		height: 500px;
		margin: auto;
		background-color: #dadada;
	}
</style>
<main>
<section>
<div id="root">
	<form method="POST">
	<p>우편번호<input type="text" name="user_address1" required></p>
	<p>주소<input type="text" name="user_address2" required></p>
	<p>상세주소<input type="text" name="user_address3" required></p>
	<p><input type="submit" value="배송지등록"></p>
	</form>
</div>
</section>
</main>


</body>
</html>