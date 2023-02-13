function dtoToHTML(dto) {
	const tag = `
	<div class="item">
		<div class="checkb"><input type="checkbox"></div>
		<div class="t_img">${dto.product_t_img}</div>
		<div class="p_info">${dto.product_name}</div>
		<div class="salesPrice">${dto.product_price}</div>
		<div class="count">${dto.product_count}</div>
	</div>
	`
		return tag
}



function loadHandler() {
	const url = cpath + '/board/cart/{product_opt_idx}'
	const opt = {
			method: 'GET'
	}
	fetch(url, opt)
	.then(resp => resp.text())	
	.then(text => {
		console.log(text)
		const arr = JSON.parse(text)	
		console.log(arr)
		const jsonString = JSON.stringify(arr)	
		console.log(jsonString)
		
		items.innerHTML = ''	
		arr.forEach(dto => items.innerHTML += dtoToHTML(dto))
	})
}