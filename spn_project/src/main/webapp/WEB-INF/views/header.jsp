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
	.leftTitle {
		cursor: pointer;
		font-size: 24px;
	}
    .content {
        border: 1px solid black;
        box-sizing: border-box;
        z-index: -1;

        padding: 0;
        height: 0;
        opacity: 0;
        transition-duration: 0.5s;
    }
	.content.selected {
	    padding: 20px;
        height: auto;
        opacity: 1;
        transition-duration: 0.5s;
	}
</style>
</head>
<body>

<h1><a href="${cpath }/">서평랭</a></h1>
<hr>

<nav>
	<ul>
		<li>
			<div class="leftTitle">Man</div>
			<div class="content"><a href="${cpath }/board/man/top">Top</a></div>
		</li>
	</ul>
</nav>


<script>
    const leftTitleArray = Array.from(document.querySelectorAll('.leftTitle'))
    const contentList = document.querySelectorAll('.content')

    function clickHandler(event) {
        const i = leftTitleArray.indexOf(event.target)
        const content = contentList[i];

        if(content.classList.contains('selected')) {
            content.classList.remove('selected')
            return
        }

        contentList.forEach(c => c.classList.remove('selected'))
        content.classList.add('selected')
    } 

    leftTitleArray.forEach(t => t.onclick = clickHandler)
</script>


