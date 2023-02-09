<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>


<section id="viewItem">
	<div>
		<c:forEach var="t_img" items="${dto.product_t_img }">
			<img src="${cpath}/itemImg/${t_img}" height="150px">
		</c:forEach>
	</div>
	<div>
		${dto.product_name }
	</div>
	<div>
		${dto.product_price }
	</div>
	
	<form>
		<select name="product_color">
			<option value="">-[필수]옵션을 선택해주세요-</option>
			<option>아이보리</option>
			<option>소라</option>
			<option>블랙</option>
		</select>
		<select name="product_size">
			<option>-[필수]옵션을 선택해주세요-</option>
		</select>
		<input type="hidden" name="product_idx" value="${dto.product_idx }">
	</form>
	
	<div class="buy">
		
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
		console.log('이게 왜자꾸 돼')
		if(event.target.value != 0 && color.value != null){
			const selectedItem = document.createElement('div')
			selectedItem.className = 'selectedItem'
			let html = '<div class="itemName">' + '${dto.product_name}' + '</div>'
			html += '<div class="itemOpt">'+ color.value + '/' + size.value + '</div>'
			html += '<input type="number" name="' + color.value + '/' + size.value + '" value="1" min="1" required>'
			html += '<div class="totalPrice">' + ${dto.product_price} + '원</div>'
			selectedItem.innerHTML = html
			buy.appendChild(selectedItem)
			
			console.log(event.target)
			const itemOptInput = document.querySelectorAll('div.selectedItem input')
			
			itemOptInput.forEach(e => e.onchange = function(event) {
				const value = event.target.value
				const totalPrice = event.target.parentNode.querySelector('div.totalPrice')
				
				const price = +document.querySelector('#viewItem > div:nth-child(3)').innerText
				totalPrice.innerText = price * value + '원'
			})
		}
	}
	
	function total() {
		const num = document.querySelector('input[name="' + color.value + '/' + size.value + '"]')
		let count = 1;
		if(num != null){
			count = num.value
		}
		return +${dto.product_price} * count
	}

	size.onchange = buyCheck
	
	
	

	
	
	
</script>

</body>
</html>