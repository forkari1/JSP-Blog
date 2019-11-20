<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="StyleSheet" href="style.css" type="text/css">
<script>

	function MM_openBrWindow(theURL, winName, features) {	// 새로운 창에서 아이디 중복체크
		form = document.join;
		if (winName == "userid_check") {
			if (!checkValue(form.userid, '아이디', 5, 16)) {
				return;
			}
			theURL = theURL + "?userid=" + form.userid.value;
		}
		window.open(theURL, winName, features);
	}
	
	function checkValue(target, cmt, lmin, lmax) {
		var Alpha = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
		var Digit = '1234567890';
		var astr = Alpha + Digit;
		var i;
		var tValue = target.value;
		
		if (tValue.length < lmin || tValue.length > lmax) {
			if (lmin == lmax)
				alert(cmt + '는' + lmin + 'Byte이어야 합니다.');
			else
				alert(cmt + '는' + lmin + '~' + lmax + 'Byte 이내로 입력하셔야 합니다.');
			target.focus();
			return false;
		}
		if (astr.length > 1) {
			for (i = 0; i < tValue.length; i++) {
				if (astr.indexOf(tValue.substring(i, i + 1)) < 0) {
					alert(cmt + '에 허용할 수 없는 문자가 입력되었습니다.');
					target.focus();
					return false;
				}
			}
		}
		return true;
	}
	
	function doSubmit() {
		form = document.join;
		if (!form.userid.value) {
			alert('아이디를 입력하지 않았습니다.');
			form.userid.focus();
			return;
		}
		if (!checkValue(form.userid, '아이디', 5, 16)) {
			return;
		}
		if (!form.username.value) {
			alert('이름을 입력하지 않았습니다.');
			form.username.focus();
			return;
		}
		if (!form.password.value) {
			alert('비밀번호를 입력하지 않았습니다.');
			form.password.focus();
			return;
		}
		if (form.password.value != form.password2.value) {
			alert('비밀번호가 일치하지 않았습니다.');
			form.password.value = "";
			form.password2.value = "";
			form.password.focus();
			return;
		}
		if (form.userid.value == form.password.value) {
			alert("아이디와 비밀번호를 서로 다르게 입력하세요!");
			form.password.value = "";
			form.password2.value = "";
			form.password.focus();
			return;
		}
		if (!checkValue(form.password, '비밀번호', 4, 12)) {
			return;
		}
	
		if (!form.email.value) {
			alert('Email을 입력하지 않았습니다.');
			form.email.focus();
			return;
		}
		if (form.email.value.indexOf("@") < 0) {
			alert('Email주소 형식이 틀립니다.');
			form.email.focus();
			return;
		}
		if (form.email.value.indexOf(".") < 0) {
			alert('Email 도메인 주소가 틀립니다.');
			form.email.focus();
			return;
		}
		if (!form.zipcode1.value || !form.zipcode2.value) {
			alert('우편번호를 입력하지 않았습니다.');
			MM_openBrWindow('zipcode_search.jsp', 'zipcode_search',
					'scrollbars=yes, width=500, height=250');
			return;
		}
		if (!form.address1.value) {
			alert('주소1를 입력하지 않았습니다.');
			MM_openBrWindow('zipcode_search.jsp', 'zipcode_search',
					'scrollbars=yes, width=500, height=250');
			return;
		}
		if (!form.address2.value) {
			alert('주소2를 입력하지 않았습니다.');
			form.address2.focus();
			return;
		}
		form.submit();
	}
 
</script>
</HEAD>

<body oncontextmenu="return false"	onselectstart="return false" ondragstart="return false">
	<form name="join" method="post" action="insert.jsp">
		아이디 	<input type="text" name="userid" size="16" maxlength="16" >
		중복확인	<input type="button" value="중복확인" onClick="MM_openBrWindow('userid_check.jsp','userid_check','width=330,height=200')"> </br></br>		
		비밀번호	<input type="password" name="password" size="12" maxlength="12">
		재입력&nbsp;&nbsp; <input type="password" name="password2" size="12" maxlength="12">&nbsp;(영문+숫자	4~12자리) </br></br>
		이름		<input type="text" name="username" size="10" maxlength="10"> </br></br>
		EMAIL	<input type="text" name="email" size="20" maxlength="50" > </br></br>
		우편번호	<input type="text" name="zipcode1" size="3" maxlength="3"> - 
				<input type="text" name="zipcode2" size="3" maxlength="3" > 
				<input type="button" name= "button"	onClick="MM_openBrWindow('zipcode_search.jsp','zipcodesearch','scrollbars=yes,width=500,height=250')" value="우편번호 검색"> </br></br> 
		주소		<input type="text" name="address1" size="25" maxlength="100">
		나머지 주소&nbsp;&nbsp; <input type="text" name="address2" size="25" maxlength="100" > </br></br>
		핸드폰
		<select name="phone1">
			<option value="010">010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="017">017</option>
			<option value="018">018</option>
			<option value="019">019</option>
		</select> - <input type="text" name="phone2" size="4" maxlength="4" > - <input type="text" name="phone3" size="4" maxlength="4" >
		<br>
		<br>
		
		<input type="hidden" name="userid_check"> 
		<input type="button" value="등   록" onClick = "doSubmit()"> &nbsp; 
		<input type="reset"	value="다시쓰기"> &nbsp; 
		<input type="button" value="취   소" onClick = "javascript:history.go(-1);">			
	</form>
	
</body>
</html>