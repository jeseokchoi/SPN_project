<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<main>
<section>
<div id="root">
	<div id="wrap">
		<form method="POST" id="loginForm">
			<p>아이디 : <input type="text" name="user_id" required autofocus></p>
			<p>비밀번호 : <input type="password" name="user_pwd" required></p>
			<p><input type="submit" value="로그인"></p>
		</form>
	</div>
</div>
</section>
</main>

</body>
</html>