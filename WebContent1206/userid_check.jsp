<%@ page info="userid check" errorPage="subForm/error.jsp"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" import="java.sql.*"%>
<%
	String userid = request.getParameter("userid");
	String query = new String();

	int check_count = 0;
	boolean bJoin = false;

	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
	} catch (ClassNotFoundException e) {
		out.println(e);
	}

	try {
		conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/member?useUnicode=true&characterEncoding=utf-8", "root", "1111");

		query = "Select count(*) as count from member where userid = ?";
		stmt = conn.prepareStatement(query);
		rs = stmt.executeQuery();
		rs.next();
		check_count = rs.getInt("count");
		rs.close();
	} catch (SQLException e) {
	} finally {
		conn.close();
	}
%>

<html>
<head>
<title>아이디 중복검사</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="StyleSheet" href="style.css" type="text/css">
<script>

function checkEnd() {
	var form = document.id_check;
	opener.join.userid.value = form.userid.value;
	opener.join.userid_check.value = form.check_count.value;
	self.close();
}

function doCheck() {
	var form = document.id_check;
	if (!checkValue(form.userid, '아이디', 5, 16)) {
		return;
	}
	form.submit();
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

</script>
</head>

<body text="#000000" bgcolor="#FFFFFF" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0">
	<br />
	<br />
	<form name="id_check" method="post" action="userid_check.jsp">
		<input type="hidden" name="check_count" value="<%=check_count%>">
		<table width="300" border="0" cellspacing="0" cellpadding="0"
			align="center" class="style1">
			<tr>
				<td>원하는 아이디를 입력하세요.</td>
			</tr>
		</table>
		<table width="300" border="0" bgcolor="#B6C1D6" height="39"
			align="center" class="style1">
			<tr>
				<td bgcolor="#ffffff" width="40%" align="center"><input
					type="text" name="userid" value="<%=userid%>"
					onFocus="this.value=''" maxlength="16" size="16"
					class="input_style1"> <input type="button" value="중복확인"
					onClick="doCheck()" class="input_style1"></td>
			</tr>
			<tr>
				<td>
					<%
						if (check_count > 0) {
					%> ▶ [<%=userid%>]은 등록되어있는 아이디입니다.<br>▷ 다시 시도해주십시오. <%
						} else {
					%> ▶ [<%=userid%>]은 사용 가능합니다. <%
						}
					%>
				</td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="center">
			<tr>
				<td align="center"><input type="button" value="확인"
					onClick="checkEnd()" class="style1"></td>
			</tr>
		</table>
	</form>
</body>
</html>