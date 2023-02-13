<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>


<div id="body1" class="body completed">
</div>
<div id="body2" class="body outOfBound down">
	<div id="body2Main">
		<div id="body2MainTitle">BEST</div>
		<div id="body2MainWrap">
			<c:forEach var="dto" items="${homeList }">
				<div class="homeItem">
					<a href="${cpath }/board/view/${dto.product_idx}"><img src="${cpath}/itemImg/${dto.product_t_img}"></a>
				</div>
			</c:forEach>
		</div>
	</div>
</div>
<div id="body3" class="body outOfBound down">
	
</div>
<div id="body4" class="body outOfBound down">
	<div id="body4Main">
		<div id=tel>1661-2312</div>
		<div class="footerElse">AM11:00-PM05:00 (MON-FRI) LUNCH/ PM01:00-PM02:00</div>
		<div class="footerElse">기업은행 063-080907-01019 송진우</div>
		<div id="lastFooter">
			<span>쇼핀</span>|<span>송진우,정영호</span>|<span>04796 서울특별시 성동구 아차산로13길 33 (성수동2가) 협성빌딩 5층</span>|<span>C.P.O: 정영호<a href="mailto:hello@showpin.co.kr">(hello@showpin.co.kr)</a></span>
                        |<span>License: [290-20-00260]</span>|<span>Online License: [2019-서울성동-01334]</span><span><a href="#none" onclick="window.open('http://www.ftc.go.kr/bizCommPop.do?wrkr_no=2902000260', 'bizCommPop', 'width=750, height=950;');return false;">[사업자정보확인]</a></span>|<span>Hosting by 카페24(주)</span>
		</div>
	</div>
</div>
<script>
const divBody = document.querySelectorAll('div.body')
const body = document.querySelector('body')
	
	function bodyChange(event) {
		if(event.target.classList.contains('completed')){
			if(event.wheelDeltaY < 0){
	        	if(event.target.getAttribute('id') == 'body4'){return}
	        	event.target.classList.remove('completed')
	        	const bodyNum = event.target.getAttribute('id').split('y')[1]
	        	const rename = 'body' + (+bodyNum+1)
	        	const nextBody = document.querySelector('#'+rename)
	        	event.target.classList.add('up')
	        	event.target.classList.add('outOfBound')
	        	nextBody.classList.remove('outOfBound')
	        	nextBody.classList.remove('down')
	        	nextBody.classList.add('loading')
	        }else{
	        	if(event.target.getAttribute('id') == 'body1'){return}
	        	event.target.classList.remove('completed')
	        	const bodyNum = event.target.getAttribute('id').split('y')[1]
	        	const rename = 'body' + (+bodyNum-1)
	        	const nextBody = document.querySelector('#'+rename)
	        	event.target.classList.add('down')
	        	event.target.classList.add('outOfBound')
	        	nextBody.classList.remove('outOfBound')
	        	nextBody.classList.remove('up')
	        	nextBody.classList.add('loading') 
	        }
        	setTimeout(addClass, 1000)
		}
    }
	function addClass(){
		const loading = document.querySelector('.loading')
		loading.classList.add('completed')
		loading.classList.remove('loading')
	}
    
    function body2Wheel(event) {
    	const body2 = document.querySelector('div#body2')
    	if(body2.classList.contains('completed')){
			if(event.wheelDeltaY < 0){
				body2.classList.remove('completed')
	        	const bodyNum = body2.getAttribute('id').split('y')[1]
	        	const rename = 'body' + (+bodyNum+1)
	        	const nextBody = document.querySelector('#'+rename)
	        	body2.classList.add('up')
	        	body2.classList.add('outOfBound')
	        	nextBody.classList.remove('outOfBound')
	        	nextBody.classList.remove('down')
	        	nextBody.classList.add('loading')
	        	function addClass(){
	        		const loading = document.querySelector('.loading')
	        		loading.classList.add('completed')
	        		loading.classList.remove('loading')
	        	}
	        	setTimeout(addClass, 1000)
	        	
	        }else{
	        	body2.classList.remove('completed')
	        	const bodyNum = body2.getAttribute('id').split('y')[1]
	        	const rename = 'body' + (+bodyNum-1)
	        	const nextBody = document.querySelector('#'+rename)
	        	body2.classList.add('down')
	        	body2.classList.add('outOfBound')
	        	nextBody.classList.remove('outOfBound')
	        	nextBody.classList.remove('up')
	        	nextBody.classList.add('loading')
	        	function addClass(){
	        		const loading = document.querySelector('.loading')
	        		loading.classList.add('completed')
	        		loading.classList.remove('loading')
	        	}
	        	setTimeout(addClass, 1000)
	        }
		}
    }
    const body2Main = document.querySelector('div#body2Main')
    body2Main.onmousewheel = body2Wheel
	divBody.forEach(e =>e.onmousewheel = bodyChange)
	
	function body4Wheel(event) {
    	const body4 = document.querySelector('div#body4')
    	if(body4.classList.contains('completed')){
			if(event.wheelDeltaY < 0){
				body4.classList.remove('completed')
	        	const bodyNum = body4.getAttribute('id').split('y')[1]
	        	const rename = 'body' + (+bodyNum+1)
	        	const nextBody = document.querySelector('#'+rename)
	        	body4.classList.add('up')
	        	body4.classList.add('outOfBound')
	        	nextBody.classList.remove('outOfBound')
	        	nextBody.classList.remove('down')
	        	nextBody.classList.add('loading')
	        	function addClass(){
	        		const loading = document.querySelector('.loading')
	        		loading.classList.add('completed')
	        		loading.classList.remove('loading')
	        	}
	        	setTimeout(addClass, 1000)
	        	
	        }else{
	        	body4.classList.remove('completed')
	        	const bodyNum = body4.getAttribute('id').split('y')[1]
	        	const rename = 'body' + (+bodyNum-1)
	        	const nextBody = document.querySelector('#'+rename)
	        	body4.classList.add('down')
	        	body4.classList.add('outOfBound')
	        	nextBody.classList.remove('outOfBound')
	        	nextBody.classList.remove('up')
	        	nextBody.classList.add('loading')
	        	function addClass(){
	        		const loading = document.querySelector('.loading')
	        		loading.classList.add('completed')
	        		loading.classList.remove('loading')
	        	}
	        	setTimeout(addClass, 1000)
	        }
		}
    }
    
    const body4Main = document.querySelector('div#body4Main')
    body4Main.onmousewheel = body4Wheel
</script>
</body>
</html>