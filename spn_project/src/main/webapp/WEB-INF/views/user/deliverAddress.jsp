<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<style>
	#content{
	width: 1000px;
	height: 1000px;
	margin: auto;
	background-color: #dadada;
	
	}
</style>

<main>
<section>
	<div id="content">
		<div class="title"></div>
		<table>
			<thead>
				<tr>
					<th>주소록 고정</th>
					<th>배송지명</th>
					<th>수령인</th>
					<th>휴대전화</th>
					<th>주소</th>
					
				</tr>
			</thead>
			<tbody>
				<tr>
					<td></td>
					<td></td>
					<td>${user.user_name }</td>
					<td>${user.user_phone }</td>
					<td>우편번호 : ${address.user_address1} 주소: ${address.user_address2} 상세주소 :${address.user_address3}</td>
				
				</tr>
			</tbody>
		</table>
		
		<c:if test="${empty address }"><a href="${cpath }/user/addressRegist/"><button>배송지등록</button></a></c:if>
		<c:if test="${not empty address }"><a href="${cpath }/user/addressModify/"><button>배송지수정</button></a></c:if>
		<div class="cause">
			<h3>배송주소록 유의사항</h3>
			<div class="causeList">
				<ol>
					<li>배송 주소록은 최대 10개까지 등록할 수 있으며, 별도로 등록하지 않을 경우 최근 배송 주소록 기준으로 자동 업데이트 됩니다.</li>
					<li>자동 업데이트를 원하지 않을 경우 주소록 고정 선택을 선택하시면 선택된 주소록은 업데이트 대상에서 제외됩니다.</li>
					<li>기본 배송지는 1개만 저장됩니다. 다른 배송지를 기본 배송지로 설정하시면 기본 배송지가 변경됩니다.</li>
				</ol>
			</div>
		</div>
	</div>
</section>
</main>
</body>
</html>