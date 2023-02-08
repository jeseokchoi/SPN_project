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
	a {
		text-decoration: none;
		color: inherit;
	}
	ul > li {
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
    .dropDown {
    	padding: 0;
         z-index: -1; 
        height: 0px;
        transition-duration: 0.5s;
         overflow: hidden; 
        opacity: 0;
    }
	.dropDown.selected {
		opacity: 1;
        height: 300px;
        max-height: 1200px;
        transition-duration: 0.5s;
	}
	ol > li {
		font-size: 15px;
		padding: 10px 0;

	}
	
</style>
</head>
<body>

<h1><a href="${cpath }/">서평랭</a></h1>
<hr>

<nav>
	<ul>
		<li>
			WOMAN
			<ol class="dropDown">
				<li><a href="${cpath }/board/w_">All</a></li>
				<li><a href="${cpath }/board/w_outer">Outer</a></li>
				<li><a href="${cpath }/board/w_shirts">Shirts</a></li>
				<li><a href="${cpath }/board/w_top">Top</a></li>
				<li><a href="${cpath }/board/w_bottom">Bottom</a></li>
				<li><a href="${cpath }/board/w_knit">Knit</a></li>
			</ol>
		</li>
		<li>
			MAN
			<ol class="dropDown">
				<li><a href="${cpath }/board/m_">All</a></li>
				<li><a href="${cpath }/board/m_top">top</a></li>
				<li><a href="${cpath }/board/m_suit">Suit</a></li>
				<li><a href="${cpath }/board/m_outer">Outer</a></li>
				<li><a href="${cpath }/board/m_top">Top</a></li>
				<li><a href="${cpath }/board/m_knit">Knit</a></li>
				<li><a href="${cpath }/board/m_shirts">Shirts</a></li>
				<li><a href="${cpath }/board/m_pants">Pants</a></li>
				<li><a href="${cpath }/board/m_shoes">Shoes</a></li>
			</ol>
		</li>
<!-- 		<li> -->
<!-- 			<div class="MTitle">Man</div> -->
<!-- 			<div class="content">Suit</div> -->
<!-- 			<div class="content">Outer</div> -->
<%-- 			<div class="content"><a href="${cpath }/board/man/top">Top</a></div> --%>
<!-- 			<div class="content">Knit</div> -->
<!-- 			<div class="content">Shirts</div> -->
<!-- 			<div class="content">Pants</div> -->
<!-- 			<div class="content">Shoes</div> -->
<!-- 		</li> -->
<!-- 		<li> -->
<!-- 			<div class="BTitle">BOARD</div> -->
<!-- 			<div class="content">Notice</div> -->
<!-- 			<div class="content">Q & A</div> -->
<!-- 		</li> -->
<!-- 		<li> -->
<!-- 			<div class="leftTitle">ABOUT</div> -->
<!-- 			<div class="content">Map</div> -->
<!-- 			<div class="content">About Us</div> -->
<!-- 		</li> -->
	</ul>
</nav>

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

// 	$('ul > li').on('click', function(e) {
// 		const dropDown = event.target.querySelector('ol')
// 		if(dropDown.classList.contains('selected')){
//     		dropDown.classList.remove('selected')
//     		return
//     	}
// 		olList.forEach(e => e.classList.remove('selected'))
		
// 		dropDown.classList.add('selected')
// 		$(dropDwon).show()
// 		$(dropDown).slideDown()
// 	})
</script>


