<%@ page info="left_Frame" errorPage="subForm/error.jsp" %>
<%@ page contentType="text/html; charset=utf-8" %> 
<link rel="StyleSheet" href="style.css" type="text/css">
<% request.setCharacterEncoding("utf-8"); %>

	<script>
	
		function keyDown(event)
		{
			if( event.keyCode == "13") login_check();
			console.log( event );
		}
	
		function login_check() {
			if (!document.login.userid.value) {
				alert("ID를 입력하세요!");
				document.login.userid.focus();
				return;
			}
			if (!document.login.password.value) {
				alert("패스워드를 입력하세요!");
				document.login.password.focus();
				return;
			}
			document.login.submit();
		}
		
		function switchPage( index )
		{
			switch( index )
			{
			case 0:
				location.href = "MainForm.jsp";
				break;
			case 1:
				location.href = "MainForm.jsp?contentPage=loginForm.jsp";
				break;
			case 2:
				location.href = "MainForm.jsp?contentPage=insertForm.jsp"
				break;
			case 3:
				location.href = "MainForm.jsp?contentPage=select.jsp"
				break;
			case 4:
				location.href = "MainForm.jsp?contentPage=admin.jsp"
				break;
			}			
		}		
		
	</script>

	<%	
		 Object mem_name = session.getAttribute("member_name"); 
		 Object mem_id = session.getAttribute("member_id"); 
		 session.setAttribute("member_id",mem_id); 
		 if( session.getAttribute( "member_id" ) == null ) { 		 
	%>	
		<form name ="login" class = "login_form" method="post" action="loginProcess.jsp"> 
		     회원 ID&emsp;	<input type="text" 		maxlength="16" name="userid" 	size='10'  onkeydown="keyDown(event);"> </br> </br>
		    PASSWORD 		<input type="password" 	maxlength="12" name="password" 	size='10'  onkeydown="keyDown(event);"> </br> </br>    
		 	<a href="javascript:login_check()">	로그인 </a>&emsp;&emsp;
		 	<a href="javascript:switchPage(2);" > 회원가입	</a> 	
		</form>	
	<% 	
		 }else{
			out.print(mem_name + " 님 환영합니다." );
	%>	    
		</br></br>
	    <a href="logoutProcess.jsp"> 로그아웃 </a> </br>
	    <a href="javascript:switchPage(3);">개인 정보 조회</a> </br>
	    <a href="javascript:switchPage(4);">전체 목록보기</a>	</br>
	<%
	 	}
	%>