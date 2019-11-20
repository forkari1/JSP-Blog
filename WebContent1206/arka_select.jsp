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
 		rs = st.executeQuery("select * from arka order by arka_score desc;");
 %>

<html>
<head>
	<title>우리 회원 정보관리</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="StyleSheet" href="style.css" type="text/css">
	<style>
	
		.style2{
			margin : auto;
		}
	
	</style>
</head>
<body>
	<h1 align="center">미니 게임 성적</h1>
	<table border="1" class=style2>
		
		<TH>등수</TH>
		<TH>사용자ID</TH>
		<TH>점수</TH>
		<%
			if (!(rs.next())) {
		%>
		<TR>
			<TD colspan=4>등록된 회원이 없습니다.</TD>
		</TR>
		<%
			} else {
					int index = 1;
					do {
						out.println("<TR>");
						out.println("<TD align='center'>" + index + "</TD>");
						out.println("<TD align='center'>" + rs.getString("arka_id") + "</TD>");
						out.println("<TD align='center'>" + rs.getString("arka_score") + "</TD>");
						out.println("</TR>");
						if( index == 10 ) break;
						index++;
					} while (rs.next());
				}
		
				rs.close();
				st.close();
				con.close();
				
			} catch (SQLException e) {
				System.out.println(e);
				out.println(e);
			}
		%>
	</TABLE>
</BODY>
</HTML>