<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<h3>NOTICE</h3>

<div class="wrap">
	<table id="noticeList">
		<thead>
			<tr>
				<th>No</th>
				<th>SUBJECT</th>
				<th>NAME</th>
				<th>DATE</th>
			</tr>
		</thead>
		
		<tbody>
			<c:forEach var="dto" items="${list }">
			<tr>
				<td>${dto.notice_idx }</td>
				<td>${dto.notice_title }</td>
				<td>${dto.notice_writer }</td>
				<td>${dto.notice_writeDate }</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<div class="pageNumber">
		<c:if test="${paging.prev }">
			<a href="${cpath }/board/list?page=${paging.begin - 1}">[이전]</a>
		</c:if>
		
		<c:forEach var="i" begin="${paging.begin }" end="${paging.end }">
			<a class="${paging.page == i ? 'bold' : '' }"
				href="${cpath }/board/list?page=${i}">[${i }]</a>
		</c:forEach>
		
		<c:if test="${paging.next }">
			<a href="${cpath }/board/list?page=${paging.end + 1}">[다음]</a>
		</c:if>
	</div>
	
	<div class="sb">
		<div>
			<form>
				<p>
					<input type="search" name="keyword">
					<input type="submit" value="검색">
				</p>
			</form>
		</div>
		<div>
			<a href="${cpath }/board/write"><button>작성</button></a>
		</div>
	</div>
</div>

</body>
</html>