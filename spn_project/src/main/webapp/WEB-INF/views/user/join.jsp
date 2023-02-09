<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<form method="POST" id="joinForm">
	
	<fieldset>
	<textarea class="agreement">${agreement1 }</textarea>
	<p>
		<label>
			[필수]이용약관 동의
			<input type="checkbox" name="agreement" required>
		</label>
	</p>
	</fieldset>
	
		<fieldset>
	<textarea class="agreement">${agreement2 }</textarea>
	<p>
		<label>
			[필수]개인정보 수집 및 이용 동의
			<input type="checkbox" name="agreement" required>
		</label>
	</p>
	</fieldset>
	
		<fieldset>
	<textarea class="agreement">${agreement3 }</textarea>
	<p>
		<label>
			[필수]쇼핑정보 수신 동의
			<input type="checkbox" name="agreement" required>
		</label>
	</p>
	</fieldset>
	
	<p>
	아이디<input type="text" name="user_id" required autofocus><button class="dupCheck">중복확인</button>
	<span class="dupResult"></span>
	<p>
	비밀번호<input type="password" name="user_pwd" required>
	<span class="pw1Check"></span>
	</p>
	
	<p>
	비밀번호 확인<input type="password" name="pwCheck">
	<span class="pw2Check"></span>
	</p>
	<p>이름<input type="text" name="user_name" required></p>
	<p>연락처:<input type="text" name="user_phone" required></p>
	<p>이메일: <input type="email" name="user_email" required></p>
	<p>이메일 수신여부 : 
		<label><input type="radio" name="email_check" value="Y" required>예</label>
		<label><input type="radio" name="email_check" value="N" required>아니오</label>
	</p>
	<p>생년월일 : <input type="date" name="user_birth" required></p>
	<p>성별
		<label><input type="radio" name="user_gender" value="남성" required>남성</label>
		<label><input type="radio" name="user_gender" value="여성" required>여성</label>
	</p>
	<p><input type="submit" value="회원 가입" disabled></p>
	
</form>

<script>

// ##### 비밀번호 형식 확인 코드
 	const user_pwd = document.querySelector('input[name="user_pwd"]')
    const pw1Check = document.querySelector('span.pw1Check')
    
    const pwCheck = document.querySelector('input[name="pwCheck"]')
    const pw2Check = document.querySelector('span.pw2Check')

        function passwordCheck(event) {
            const exp = /^(?=.*?[0-9])(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[!@#$%^&*]).{8,16}$/
            if(event.target.value.match(exp) == null) {
            	pw1Check.innerText = '영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~16자.'
            		pw1Check.style.color = 'red'
            }
            else {
            	pw1Check.innerText = '사용가능합니다.'
            		pw1Check.style.color = 'blue'
            }
        }
	
	 	 function passwordCheck2(event) {
	        
	         console.log(user_pwd.value)
	         console.log(pwCheck.value)
	         
	         if(user_pwd.value == pwCheck.value) {
	         	pw2Check.innerText = '사용가능합니다'
	         		pw2Check.style.color = 'blue'
	         }
	         else {
	         	pw2Check.innerText = '비밀번호가 일치하지 않습니다.'
	         		pw2Check.style.color = 'red'
	         }
	     }
	
 	user_pwd.onkeyup = passwordCheck
 	pwCheck.onkeyup = passwordCheck2

</script>

<script>


// ####################### 아이디 중복 체크
	const inputId = document.querySelector('input[name="user_id"]')
	const dupcheck = document.querySelector('.dupCheck')
	const dupResult = document.querySelector('span.dupResult')
			
	dupcheck.onclick = function(event){
		event.preventDefault()
		const url = '${cpath}/user/join/dupCheck/' + inputId.value
		fetch(url)
		.then(resp => resp.text())
		.then(text => {
			console.log(text)
			dupResult.innerText = text
		})
				
	}
	
</script>

 <script>
 		console.log(dupResult.innerText)
        const agreeLabels = Array.from(document.querySelectorAll('input[name="agreement"]'))
        const btnSubmit = document.querySelector('input[type="submit"]')
        
        pw2Check.innerText.onchange = function(event){
        if(pw1Check.innerText == '사용가능합니다.' && pw2Check.innerText == '사용가능합니다' && dupResult.innerText == '사용 가능한 ID입니다'){
            btnSubmit.removeAttribute('disabled')
        }
 		}
    </script>
    

</body>
</html>