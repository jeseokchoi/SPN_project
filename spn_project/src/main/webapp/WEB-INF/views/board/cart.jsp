<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<style>
        #root {
            margin: 0 auto;
            padding: 0;
            margin-top: 220px;
   			width: 1000px;
        }
        .item {
            font-size: 19px;
            border: 1px solid gray;
            display: flex;
        }
        .item > div {
            padding: 5px 10px;
            flex: 1;
        }
        .item > div:not(div.name) {
            flex: 0.5;
        }
        .item > div.name {
            flex: 2;
        }
        .item.header {
            background-color: #eee;
        }
        .total_price {
            font-size: 19px;
            border: 1px solid grey;
            display: flex;
            background-color: #eee;
            width: 1000px;
    		margin: auto;
        }
        .total_price > div {
            padding: 5px 10px;
            flex: 1;
        }
        .order_btn{
            display: flex;
            justify-content: space-between;
            width: 1000px;
    		margin: auto;
        }
        .order_btn > p {
            padding: 10px;
            border: 1px solid #eee;
            background-color: #eee;
        }
        .order_btn > p:hover {
            padding: 10px;
            border: 1px solid #eee;
            background-color: black;
            color: white;
        }
        .order_btn > p > a {
            text-decoration: none;
        }
        
    </style>

    <div id="root">
        <div class="item header">
            <div class="checkb"><input type="checkbox"></div>
            <div class="t_img">이미지</div>
            <div class="p_info">상품정보</div>
            <div class="salesPrice">판매가</div>
            <div class="count">수량</div>
<!--             <div class="count">배송구분</div> -->
<!--             <div class="count">배송비</div> -->
<!--             <div class="count">합계</div> -->
<!--             <div class="count">선택</div> -->
        </div>
		<div id="items">
			<!-- 장바구니에 담긴 리스트 불러오기 -->
			<img class="loading" src="${cpath }/resources/image/loading.gif">
		</div>
    </div>
    <hr>
    <div class="total_price">
        <div class="tootal">총 상품금액</div>
        <div class="baemin">총 배송비</div>
        <div class="ttotal_price">결제예정금액</div>
    </div>
    <div class="order_btn">
        <p><a href="">전체상품주문</a></p>
        <p><a href="">선택상품주문</a></p>
        <p><a href="">쇼핑계속하기</a></p>
    </div>

<script src="${cpath }/resources/js/function.js"></script>   
<script>
	const cpath = '${cpath}'
	const items = document.getElementById('items')
	
	document.body.onload = loadHandler
</script>    

</body>
</html>