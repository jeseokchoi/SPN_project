<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<main>
<section id="viewItem">

	<div class="viewItemInfo">
		<div class="viewItemThumbnail">
			<ul>
				<c:forEach var="t_img" items="${dto.product_t_img }">
					<li><img class="vit" src="${cpath}/itemImg/${t_img}"
						height="110px" width="90px"></li>
				</c:forEach>
			</ul>
		</div>

		<div class="viewItemMainThumbnail">
			<img src="${cpath}/itemImg/${dto.product_t_img[0]}">
		</div>

		<div id="viewItemDetails">
			<div id="viewItemName">${dto.product_name }</div>
			<div id="viewItemPrice">${dto.product_price }</div>

				<select name="product_color">
					<option value="">-[필수]옵션을 선택해주세요-</option>
					<option>아이보리</option>
					<option>소라</option>
					<option>블랙</option>
				</select> <select name="product_size">
					<option>-[필수]옵션을 선택해주세요-</option>
				</select>
			<!-- 옵션 선택된 아이탬 정보 출력 -->
			<div class="buy">
				<input type="hidden" name="product_idx" value="${dto.product_idx }">
			</div>
			<!-- 옵션선택 완료된 아이탬 총 금액 출력 -->
			<form method="POST" action="${cpath }/board/cart/${empty login ? 'nonUser' : 'user'}">
			<div class="buyPrice">
			
			</div>
			<input type="hidden" name="product_opts" value="">
			<div class="btnSubmit">
				<a href="${cpath }/board/order" name="btnBuy"><span>구매하기</span></a>
				<input type="submit" value="장바구니담기">
			</div>
			</form>
		</div>
	</div>
	<div>
		<c:forEach var="d_img" items="${dto.product_d_img }">
			<img src="${cpath}/itemImg/${d_img}" width="1000px">
		</c:forEach>
	</div>
</section>
</main>

<script>
	const color = document.querySelector('select[name="product_color"]')
	const size = document.querySelector('select[name="product_size"]')
	const buy = document.querySelector('div.buy')
	
	function optCheck(event){
		if(color != ""){
			const url = '${cpath}/board/optCheck/' + '${dto.product_idx}/'+color.value
			console.log(url)
			fetch(url)
			.then(resp => resp.json())
			.then(json => {
				
				size.innerHTML = '<option value="0" required>-[필수]옵션을 선택해주세요-</option>'
				
				json.forEach(e => {
					if(e.product_stock == 0){
						size.innerHTML += '<option disabled>' + e.product_size + '  [품절]</option>'
					}
					else{
						size.innerHTML += '<option>' + e.product_size + '</option>'
					}
				})
			})
		}
	}
	
	color.onchange = optCheck
	
	function buyCheck(event){
		if(event.target.value != 0 && color.value != null){
			const selectedItem = document.createElement('div')
			selectedItem.className = 'selectedItem'
			let html = '<div class="itemName">' + '${dto.product_name}' + '</div>'
			html += '<input type="hidden" name="product_idx" value="' + ${dto.product_idx} + '"'
			html += '<div class="itemOpt">'+ color.value + '/' + size.value + '</div>'
			html += '<input type="number" name="product_count" value="1" min="1" required>'
			html += '<div class="totalPrice">' + ${dto.product_price} + '</div>'
			selectedItem.innerHTML = html
			buy.appendChild(selectedItem)
			
			const ttotalPrice = document.createElement('div')
			ttotalPrice.className = 'ttotalPrice'
			let ttHtml = '		<strong>TOTAL : KRW </strong>'
			ttHtml += '		<span class="total">'
			ttHtml += '			<strong>' + totalCalc() + '</strong>'
			ttHtml += '		</span>'
			ttotalPrice.innerHTML = ttHtml
			const buyPrice = document.querySelector('div.buyPrice')
			buyPrice.innerHTML = ''
			buyPrice.appendChild(ttotalPrice)
			
			
			console.log(event.target)
			const itemOptInput = document.querySelectorAll('div.selectedItem input')
			
			itemOptInput.forEach(e => e.onchange = function(event) {
				const value = event.target.value
				const totalPrice = event.target.parentNode.querySelector('div.totalPrice')
				
				const price = +document.querySelector('#viewItem > div:nth-child(3)').innerText
				totalPrice.innerText = price * value
				
				const total = document.querySelector('span.total')
				console.log('total : ', total)
				total.innerHTML = '<strong>' + totalCalc() + '</strong>'
				
				buyPrice.appendChild(total)
			})
		}
	}
	
	function totalCalc() {
		const num = document.querySelectorAll('div.totalPrice')
		let sum = 0;
		if(num == null){
			return +${dto.product_price}
		}
		else{
			num.forEach(e => {
				sum += +e.innerText
		})
				return sum.toLocaleString()
		}
	}

	size.onchange = buyCheck
	
</script>

<script>
	const viewItemMainThumbnail = document.querySelector('div.viewItemMainThumbnail')
	const vitList = document.querySelectorAll('img.vit')
	
	function changeMainImg(event) {
		console.log(event.target)
		viewItemMainThumbnail.innerHTML = '<img src="' + event.target.getAttribute('src') + '">'
	}
	vitList.forEach(e => e.onmouseover = changeMainImg)
	
	const form1 = document.forms[0]
	console.log({form1:form1})
	form1.onsubmit = function(event) {
		event.preventDefault()
		const inputProduct_opts = document.querySelector('input[name="product_opts"]').value
		
		const itemOptDiv = document.querySelectorAll('div.itemOpt')
		let tmp = ''
		itemOptDiv.forEach( e => {
			const eText = e.innerText
		tmp += eText + '.'
		})
 		event.target.submit()
	}
	
</script>
</body>
</html>