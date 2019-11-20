<%@ page contentType="text/html; charset=EUC-KR" %> 
<%@ page language="java" import="java.sql.*" %> 

<html>
<head>
<title>우리 회원 정보관리</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="StyleSheet" href="style.css" type="text/css">
</head>
<body>
	<table class="style2">
	<TH>관리자 승인</TH>
	<tr>
		<td>
			<FORM name=form1 method=post action="admin_process.jsp"><BR> 
				관리자 비밀번호 : <INPUT type=password name=password>
				<INPUT type=submit name=change value="확인"> &nbsp; 
				<INPUT type="button" value="취   소" onClick="javascript:history.go(-1);">
			</FORM>
		</td>
	</tr>
	</table>
</body>
</html>
