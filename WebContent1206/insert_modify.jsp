<%@ page info="member modify" errorPage="subForm/error.jsp" %>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page language="java" import="java.sql.*,java.io.*,java.net.*,java.util.*,java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	String mode = request.getParameter("mode");
	String userid = request.getParameter("userid");
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String email = request.getParameter("email");
	String zipcode1 = request.getParameter("zipcode1");
	String zipcode2 = request.getParameter("zipcode2");
	String address1 = request.getParameter("address1");
	String address2 = request.getParameter("address2");
	String phone1 = request.getParameter("phone1");
	String phone2 = request.getParameter("phone2");
	String phone3 = request.getParameter("phone3");
	String query = new String();
	StringTokenizer st_zipcode = null;
	StringTokenizer st_phone = null;

	java.util.Date yymmdd = new java.util.Date();
	SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-d h:mm a");
	String regdate = myformat.format(yymmdd);

	try {
		Class.forName("com.mysql.jdbc.Driver");
	} catch (ClassNotFoundException e) {
		out.println(e);
	}

	try {
		conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/member", "root", "1111");
		stmt = conn.createStatement();
		if (mode.equals("null") || mode.equals("modify")) {
			query = "select * from member where userid='" + userid + "'";
			rs = stmt.executeQuery(query);

			if (rs.next()) {
				username = rs.getString("username");
				password = rs.getString("password");
				email = rs.getString("email");
				st_zipcode = new StringTokenizer(rs.getString("zipcode"), "-");
				address1 = rs.getString("address1");
				address2 = rs.getString("address2");
				st_phone = new StringTokenizer(rs.getString("phone"), "-");

				if (st_zipcode.hasMoreTokens()) {
					zipcode1 = st_zipcode.nextToken();
				}
				if (st_zipcode.hasMoreTokens()) {
					zipcode2 = st_zipcode.nextToken();
				}

				if (st_phone.hasMoreTokens()) {
					phone1 = st_phone.nextToken();
				}
				if (st_phone.hasMoreTokens()) {
					phone2 = st_phone.nextToken();
				}
				if (st_phone.hasMoreTokens()) {
					phone3 = st_phone.nextToken();
				}
			}
			rs.close();

		} else if (mode.equals("update")) {
			query = "update member set username=?, password=?, email=?, zipcode=?, address1=?, address2=?, phone=? where userid='"
					+ userid + "'";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			pstmt.setString(3, email);
			pstmt.setString(4, zipcode1 + "-" + zipcode2);
			pstmt.setString(5, address1);
			pstmt.setString(6, address2);
			pstmt.setString(7, phone1 + "-" + phone2 + "-" + phone3);
			pstmt.executeUpdate();
			response.sendRedirect("MainForm.jsp");
		}
	} catch (SQLException e) {
	} finally {
		conn.close();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="style.css" type="text/css">
<script>

	function MM_openBrWindow(theURL, winName, features) {
		window.open(theURL, winName, features);
	}
	function doSubmit() {
		form = document.join;
		if (!form.username.value) {
			alert('이름을 입력하지 않았습니다.');
			form.username.focus();
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
			alert('Email 주소 형식이 틀립니다.');
			form.email.focus();
			return;
		}
		if (!form.zipcode1.value || !form.zipcode2.value) {
			alert('우편번호를 입력하지 않았습니다.');
			MM_openBrWindow('zipcode_search.jsp', 'zipcode_search',
					'scrollbars=yes,width=500,height=250');
			return;
		}
		if (!form.address1.value) {
			alert('주소1를 입력하지 않았습니다.');
			MM_openBrWindow('zipcode_search.jsp', 'zipcode_search',
					'scrollbars=yes,width=500,height=250');
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
</head>

<body>
	<div align="center">
		<form name="join" method="post" action="modify.jsp">
			아이디&nbsp; <input type="text" name="userid" size="10" maxlength="10" class="box" value="<%=userid%>" readonly> </br></br>
			비밀번호&nbsp;<input type="text" name="password" size="12" maxlength="12" class="box" value="<%=password%>">	
			다시한번&nbsp; <input	type="password" name="password2" size="12" maxlength="12" class="box" value="<%=password%>"> (영문+숫자 4~12자리) </br></br>
			이름&nbsp; <input type="text" name="username" size="10" maxlength="10" class="box" value="<%=username%>"> </br></br>
			이메일&nbsp;<input type="text" name="email" size="20" maxlength="50" class="box" value="<%=email%>"> </br></br>
			
			우편번호&nbsp; <input type="text" name="zipcode1"	size="3" maxlength="3" class="box" readonly value="<%=zipcode1%>">
						- <input type="text" name="zipcode2" size="3" maxlength="3" class="box" readonly value="<%=zipcode2%>"> 
						<input name="button" type="button" onClick="MM_openBrWindow('zipcode_search.jsp','zipcodesearch','scrollbars=yes,width=500,height=250')" value="우편번호 검색"> 
			
			주소&nbsp;<input type="text" name="address1"	size="50" maxlength="100" class="box" readonly value="<%=address1%>">
			나머지 주소&nbsp; <input type="text" name="address2" size="50" maxlength="100" class="box" value="<%=address2%>"> </br></br>
			
			휴대폰&nbsp; <input type="text" name="phone1" size="4" maxlength="4" class="box" value="<%=phone1%>"> 
				- <input type="text" name="phone2" size="4" maxlength="4" class="box" value="<%=phone2%>"> 
				- <input type="text" name="phone3" size="4" maxlength="4" class="box" value="<%=phone3%>"> </br></br>
				
			<input type="hidden" name="mode" value="update"> 
			<input type="button" value="등   록"	onClick="doSubmit()">&nbsp; 
			<input type="button" value="취   소" onClick="javascript:history.go(-1);">
		</form>
	</div>
</body>
</html>