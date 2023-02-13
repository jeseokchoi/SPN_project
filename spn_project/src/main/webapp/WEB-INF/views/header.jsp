<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cpath" value="${pageContext.request.contextPath }" />     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서평랭</title>
<style>

	main {
		width: 1500px;
		margin: auto;
	}
	.displaynone{
		display: none;
	}
	body {
 		font: 0.80em 'Poppins','Noto Sans KR','맑은 고딕','Malgun Gothic',Verdana,Dotum,AppleGothic,sans-serif;
 		margin: 0;
	}
	section {
		min-width: 500px;
		max-width: 1350px;
		margin: auto;
	}
	a {
		text-decoration: none;
		color: inherit;
	}
	
	
/* 	header */
	aside#left ul > li {
		list-style:none;
		cursor: pointer;
		font-size: 24px;
		padding-left: 0px;
		padding: 10px 0;
		font-size: 17px;
    	font-weight: 600; 
    	color: #000;
    	letter-spacing: 0.01em;
	}
    aside#left .dropDown {
    	padding: 0;
        z-index: -1; 
        height: 0px;
        transition-duration: 0.5s;
        overflow: hidden; 
        opacity: 0;
    }
    aside#left .dropDown.w.selected{
		opacity: 1;
        height: 250px;
        max-height: 1200px;
        transition-duration: 0.5s;
	}
	aside#left .dropDown.m.selected{
		opacity: 1;
        height: 400px;
        max-height: 1200px;
        transition-duration: 0.5s;
	}
	aside#left ol {
		margin-top: 20px;
	}
	aside#left ol > li {
		color: #808080;
		font-size: 15px;
		padding: 10px 0;

	}
	aside#left {
		position: fixed;
		top:0;
		left: 0;
		z-index: 5;
	}
	aside#right{
		display:flex;
		background-color: white;
		position: fixed;
		top: 0;
		right: -300px;
		width: 300px;
		height: 100%;
		transition-duration: 0.5s;
		z-index: 10;
	}
	aside#right.selected{
		right: 0px;
		transition-duration: 0.5s;
	}
	aside#menuBtn {
		position: fixed;
		top:50px;
		right: 100px;
		z-index: 5;
	}

	div#categoryName {
		width: 100px;
		margin: auto;
	}
	button#rightAsideX{
		position: absolute;
		top: 50px;
		right: 50px;
	}
	aside#right ul {
		height: 60%;
		margin: auto 0;
	}
	aside#right ul > li {
		list-style:none;
		cursor: pointer;
		font-size: 24px;
		padding-left: 0px;
		padding: 10px 0;
		font-size: 17px;
    	font-weight: 600; 
    	color: #000;
    	letter-spacing: 0.01em;
	}
	
	
	
/* 	productList */
	section#list .listImg {
		height: 500px;
		width: 400px;
		min-height: 100px;
		object-fit: cover;
		
	}
	section#list #wrap {
		display: flex;
		flex-wrap: wrap;
	}
	section#list div.img {
		padding: auto;
	}
	section#list div.item {
		width: 450px;
 		padding-bottom: 80px;
	}
	section#list div.item div.listName {
		font-size: 13px;
    	color: #555555;
    	font-weight: 600;
	}
	section#list div.item div.listPrice {
		font-size: 12px;
    	color: #242424;
    	font-weight: bold;
	}
	section#list div.item > div {
		padding: 5px 0;
	}

	
/* 	productView */
	div.viewItemMainThumbnail > img {
/* 		min-height: 280px; */
		height: 700px;
/* 		min-width: 220px; */
		width: 550px;
	}
	div.viewItemInfo {
		display: flex;
	}
	
	
/* 	home */
	div#body1 {
		position: fixed;
		top: 0;
		width: 100%;
		height: 100%;
		background-image: url("${cpath}/resources/img/homeBody1.png") ;
		background-size: 105%;
        background-position: center;
        background-repeat: no-repeat;
        transition-duration: 1s;
	}
	div.homeWindow {
		z-index: 7;
		transition-duration: 0.5s;
	}
	.overlay {
	  position: fixed;
	  width: 100%; height: 100%;
	  left: 0; top: 0;
	  background-color: rgba(0,0,0, 0.4);
	  transition-duration: 0.5s;
	}
	div#body2 {
		position: fixed;
		display:flex;
		top: 0;
		width: 100%;
		height: 100%;
        transition-duration: 1s;
	}
	div#body3 {
		position: fixed;
		top: 0;
		width: 100%;
		height: 100%;
		background-image: url("${cpath}/resources/img/10.jpg");
		background-size:100%;
        background-position: center;
        background-repeat: no-repeat;
        transition-duration: 1s;
	}
	div#body4 {
		position: fixed;
		display:flex;
		top: 75%;
		width: 100%;
		height: 25%;
        transition-duration: 1s;
	}
	div#body1.up {
		top: -100%;
		transition-duration: 1s;
	}
	div#body1.down {
		top: 100%;
		transition-duration: 1s;
	}
	div#body2.up {
		top: -100%;
		transition-duration: 1s;
	}
	div#body2.down {
		top: 100%;
		transition-duration: 1s;
	}
	div#body3.up {
		top: -25%;
		transition-duration: 1s;
	}
	div#body3.down {
		top: 100%;
		transition-duration: 1s;
	}
	div#body4.up {
		top: -75%;
		transition-duration: 1s;
	}
	div#body4.down {
		top: 100%;
		transition-duration: 1s;
	}
	div#body2Main{
		width: 100%;
		margin: auto 0;
	}
	div#body2MainWrap {
		display: flex;
		justify-content: space-between;
		width: 70%;
		margin: auto;
	}
	div#body2MainTitle{
		width: 70%;
		margin: auto;
		font-size: 25px;
		text-align: center;
		margin-bottom: 50px;
	}
	div.homeItem img {
		height: 400px;
		width: 300px;
	}
	div#body4Main{
		width: 70%;
		margin: 0 auto;
		margin-top: 100px; 
		text-align: center;
	}
	div#body4Main > div {
		height: 40px;
		margin: 15px 0;
	}
	div#body4Main div#tel {
		font-size: 30px;
	}
	div#body4Main div.footerElse {
		display: flex;
		justify-content: center;
		align-items: center;
		font-size: 15px;
	}
	div#body4Main div#lastFooter {
		margin-top: 40px;
		color: #808080;
	}
	li {
		list-style: none;
		padding-left: 0;
	}

</style>
</head>
<body>
<div class="homeWindow"></div>
<aside id="right">

	<button id="rightAsideX">X</button>
	<ul>
		<c:if test="${empty user }">
			<li><a href="${cpath }/user/login">로그인</a></li>
			<li><a href="${cpath }/user/join">회원가입</a></li>
		</c:if>
		
		<c:if test="${not empty user }">
			<li><h3>${user.user_name }님 환영합니다.</h3></li>
			<li><a href="${cpath }/user/logout">로그아웃</a></li>
			<li><a href="${cpath }/user/mypage">마이페이지</a></li>
		</c:if>
			<li><a href="${cpath }/admin/index">관리자페이지</a></li>
	</ul>
</aside>
<aside id="menuBtn">
	<button id="ham">햄버거</button>
</aside>
<aside id="left">
<a href="${cpath }/"><img src="${cpath }/resources/img/logo.png" width="150px"></a>
	<ul>
		<li>
			WOMAN
			<ol class="dropDown w">
				<li><a href="${cpath }/board/list/w_">All</a></li>
				<li><a href="${cpath }/board/list/w_outer">Outer</a></li>
				<li><a href="${cpath }/board/list/w_shirts">Shirts</a></li>
				<li><a href="${cpath }/board/list/w_top">Top</a></li>
				<li><a href="${cpath }/board/list/w_bottom">Bottom</a></li>
				<li><a href="${cpath }/board/list/w_knit">Knit</a></li>
			</ol>
		</li>
		<li>
			MAN
			<ol class="dropDown m">
				<li><a href="${cpath }/board/list/m_">All</a></li>
				<li><a href="${cpath }/board/list/m_top">top</a></li>
				<li><a href="${cpath }/board/list/m_suit">Suit</a></li>
				<li><a href="${cpath }/board/list/m_outer">Outer</a></li>
				<li><a href="${cpath }/board/list/m_top">Top</a></li>
				<li><a href="${cpath }/board/list/m_knit">Knit</a></li>
				<li><a href="${cpath }/board/list/m_shirts">Shirts</a></li>
				<li><a href="${cpath }/board/list/m_pants">Pants</a></li>
				<li><a href="${cpath }/board/list/m_shoes">Shoes</a></li>
			</ol>
		</li>
		<li>
			Board
			<ol>
				<li><a href="${cpath }/board/notice">Notice</a></li>
				<li><a href="${cpath }/board/qna">Q & A</a></li>
			</ol>
		</li>
	</ul>
</aside>

<!-- <script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script> -->
<script>
    const leftTitleArray = Array.from(document.querySelectorAll('ul > li'))
    const olList = document.querySelectorAll('ol')

    function clickHandler(event) {
    	const dropDown = event.target.querySelector('ol')
    	if(dropDown.classList.contains('selected')){
    		dropDown.classList.remove('selected')
    		return
    	}
    	olList.forEach(e => e.classList.remove('selected'))
    	
    	
    	dropDown.classList.add('selected')
     } 

    leftTitleArray.forEach(t => t.onclick = clickHandler)
    
</script>
<script>
	const ham = document.querySelector('button#ham')
	const rightAsideX = document.querySelector('button#rightAsideX')
	const homeWindow = document.querySelector('div.homeWindow')
	const test1 = document.querySelector('button#test')
	
	function menuClose() {
		const rightAside = document.querySelector('aside#right')
		rightAside.classList.remove('selected')
		homeWindow.classList.remove('overlay')
	}
	
	function menuOpen(event) {
		const rightAside = document.querySelector('aside#right')
		rightAside.classList.add('selected')
		homeWindow.classList.add('overlay')
	}
	ham.onclick = menuOpen
	rightAsideX.onclick = menuClose
	homeWindow.onclick = menuClose
</script>




