<%@page import="javax.websocket.SendResult"%>
<%@ page contentType="text/html; charset=utf-8" %> 
<%@ page language="java" import="java.sql.*" %> 
<%
 	Object mem_id = session.getAttribute("member_id");
 	session.putValue(session.getId(), mem_id);
 	String userid = (String) session.getValue(session.getId());
 	if (userid == null)
 		session.putValue(session.getId(), mem_id);
 	String sql = "select * from member where userid=?";
 	Connection con = null;
 	PreparedStatement pst = null;
 	ResultSet rs = null;

 	try {
 		Class.forName("com.mysql.jdbc.Driver");
 	} catch (ClassNotFoundException e) {
 		out.println(e.getMessage());
 	}

 	try {
 		con = DriverManager.getConnection(
 				"jdbc:mysql://localhost:3306/member", "root", "1111");
 	} catch (SQLException e) {
 		out.println(e);
 	}
 	try {
 		pst = con.prepareStatement(sql);
 		pst.setString(1, userid);
 		rs = pst.executeQuery();
 		
 		if (!(rs.next())) {
 			out.println("해당되는 회원이 없습니다.");
 		} else {
 			String username = rs.getString("username");
 			String phone = rs.getString("phone");
 %>
 
<html>
<head>
	<title><%=username%> 회원님 개인 정보관리</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="StyleSheet" href="style.css" type="text/css">
</head>

<body>

	<form name="join" method="post">
		<input type=hidden name="userid" value="<%=userid%>"> 
		<table class=style2>
			<tr align="center">
				<td colspan="2"><%=username%> 회원님의 개인정보는 다음과 같습니다.</td></br>
			</tr>
			<tr>
				<td>아이디</td>
				<td><%=userid%></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><%=username%></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td>보안상 기재하지 않습니다.</td>
			</tr>

			<tr>
				<td>EMAIL</td>
				<td><%=rs.getString("email")%></td>
			</tr>
			<tr>
				<td>우편번호</td>
				<td><%=rs.getString("zipcode")%></td>
			</tr>
			<tr>
				<td>주소1</td>
				<td><%=rs.getString("address1")%></td>
			</tr>
			<tr>
				<td>주소2</td>
				<td><%=rs.getString("address2")%></td>
			</tr>
			<tr>
				<td>휴대폰</td>
				<td>
					<%
						if (phone.equals("--")) {
							out.println("선택하지 않았습니다.");
						} else {
							out.println(phone);
						}
					%>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					</br>
					<input type="button" value="확   인" onClick="location='MainForm.jsp'"> 
					<input type="button" value="수   정" onClick="location.href='MainForm.jsp?contentPage=select_modify.jsp'"> 
					<input type="button" value="회원 탈퇴" onClick="location='delete.jsp'">
				</td>
			</tr>
		</table>
	</form>
</body>
</html> 
<%
 	}
 		rs.close();
 		con.close();
 		pst.close();
 	} catch (SQLException e) {
 		out.println(e);
 	}
 %>