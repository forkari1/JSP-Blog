<%@ page contentType="text/html; charset=utf-8" %> 
<%@ page language="java" import="java.sql.*,java.io.*,java.text.*,java.net.*,java.util.*"%>
<%
	String userid   = request.getParameter("userid");
	 String password = request.getParameter("password");
	 Connection conn = null;
	 PreparedStatement  stmt = null;
	 ResultSet  rs   = null;
	 String query    = new String();
	 String name	 = new String();
 
	try {
		Class.forName("com.mysql.jdbc.Driver");
	} catch (ClassNotFoundException e) {
		out.println(e);
	}
	try {
		conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/member?useUnicode=true&characterEncoding=utf-8", "root", "1111");
	} catch (SQLException e) {
		out.println(e);
	}
	boolean bLogin = false;
	try {
		query = "select * from member where userid = ? and password = ?";
		stmt = conn.prepareStatement(query);
		stmt.setString(1, userid);
		stmt.setString(2, password);
		rs = stmt.executeQuery(); //rs 결과는 null, 1명의 회원정보 리턴
		if (rs.next()) {
			name = rs.getString("username");
			bLogin = true;
		} else {
			bLogin = false;
		}
		rs.close();
	} catch (SQLException e) {
		out.println(e);
	} finally {
		conn.close();
	}
	if (bLogin) {
		session.setAttribute("member_id", userid);
		session.setAttribute("member_name", name);
		response.sendRedirect("MainForm.jsp");
	} else {
		out.println("<script>alert('아이디와 비밀번호를 확인하세요');history.back();</script>");
	}
%>