<%@ page contentType="text/html; charset=EUC-KR" %> 
<%@ page language="java" import="java.sql.*" %> 

<html>
<head>
<title>�츮 ȸ�� ��������</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="StyleSheet" href="style.css" type="text/css">
</head>
<body>
	<table class="style2">
	<TH>������ ����</TH>
	<tr>
		<td>
			<FORM name=form1 method=post action="admin_process.jsp"><BR> 
				������ ��й�ȣ : <INPUT type=password name=password>
				<INPUT type=submit name=change value="Ȯ��"> &nbsp; 
				<INPUT type="button" value="��   ��" onClick="javascript:history.go(-1);">
			</FORM>
		</td>
	</tr>
	</table>
</body>
</html>
