<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" import="java.sql.*"%>
<%
 	Object mem_id = session.getAttribute("member_id");            
 	session.putValue(session.getId(), mem_id);
 	String userid = (String) session.getValue(session.getId());
 	if (userid == null)
 		session.putValue(session.getId(), mem_id);

 	Connection con = null;
 	PreparedStatement st = null;
 	String sql = null;

 	try {
 		Class.forName("com.mysql.jdbc.Driver");
 	} catch (ClassNotFoundException e) {
 		out.println(e.getMessage());
 	}

 	try {
 		con = DriverManager.getConnection(
 				"jdbc:mysql://localhost:3306/member?useUnicode=true&characterEncoding=utf-8", "root", "1111");
 		sql = "delete from member  where userid= ?";
 		st = con.prepareStatement(sql);
 		st.setString(1, userid);
 		st.executeUpdate();
 		con.close();
 		st.close();
 		session.invalidate();
 	} catch (SQLException e) {
 		out.println(e);
 	}
 %>
<jsp:forward page="MainForm.jsp" />