<%@ page contentType="text/html; charset=utf-8" %> 
<%@ page language="java" import="java.sql.*" %> 
<%
 	Connection con = null;
 	Statement st = null;
 	ResultSet rs = null;

 	try {
 		Class.forName("com.mysql.jdbc.Driver");
 	} catch (ClassNotFoundException e) {
 		out.println(e);
 	}

 	try {
 		con = DriverManager.getConnection(
 				"jdbc:mysql://localhost:3306/member?useUnicode=true&characterEncoding=euckr", "root", "1111");
 	} catch (SQLException e) {
 		out.println(e);
 	}

 	try {
 		st = con.createStatement();
 		rs = st.executeQuery("select * from member order by userid");
 %>

<html>
<head>
	<title>우리 회원 정보관리</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="StyleSheet" href="style.css" type="text/css">
</head>
<body>
	<table border="1" class=style2>
		<TH >사용자 ID</TH>
		<TH>이 름</TH>
		<TH>주 소</TH>
		<TH>이메일</TH>
		<TH>전화번호</TH>
		<%
			if (!(rs.next())) {
		%>
		<TR>
			<TD colspan=4>등록된 회원이 없습니다.</TD>
		</TR>
		<%
			} else {
					do {
						out.println("<TR>");
						out.println("<TD align='center'>" + rs.getString("userid") + "</TD>");
						out.println("<TD align='center'>" + rs.getString("username") + "</TD>");
						out.println("<TD align='center'>" + rs.getString("email") + "</TD>");
						out.println("<TD align='center'>" + rs.getString("phone") + "</TD>");
						out.println("<TD> " + rs.getString("address1"));
						out.println(rs.getString("address2") + "</TD>");
						out.println("</TR>");
					} while (rs.next());
				}
		
				rs.close();
				st.close();
				con.close();
				
			} catch (SQLException e) {
				System.out.println(e);
			}
		%>
	</TABLE>
</BODY>
</HTML>