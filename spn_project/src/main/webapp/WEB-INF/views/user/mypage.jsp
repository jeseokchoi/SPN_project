<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<style>
	#root2{
	width: 1000px;
	height: 1000px;
	margin: auto;
	}
	#root2 > div{
	width: 800px;
	height: 200px;
	background-color: #dadada;
	}
</style>

<main>
<section>
<div id="root">
	<div>${user.user_id }</div>
	<div>${user.user_name }</div>
	<div>${user.user_phone }</div>
	<div>${user.user_email}</div>
	<div>${user.email_check }</div>
	<div>${user.user_role }</div>
	<div>${user.user_grade }</div>
	<div>${user.user_insertDate }</div>
	<div>${user.user_birth}</div>
	<div>${user.user_gender }</div>
	</div>
	<div id="root2">
		<div><h3><a href="${cpath }/user/userOrer">주문조회</a></h3></div>
		<div><h3><a href="${cpath }/user/deliverAddress/${user.user_id}">배송지관리</a></h3></div>
	</div>
	
</section>
</main>
</body>
</html>