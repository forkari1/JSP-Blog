<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java"
	import="java.sql.*,java.io.*,java.text.*,java.net.*,java.util.*"%>

<%
	String score   	= request.getParameter("score");
	String id 		= request.getParameter("id");
	out.println(id);
	
	int score2 = Integer.parseInt(score);
	 Connection conn 		= null;
	 PreparedStatement  ps 	= null;
	 ResultSet  rs   		= null;
	 String query    		= new String();

 
	try {
		Class.forName("com.mysql.jdbc.Driver");
	} catch (ClassNotFoundException e) {
		out.println(e);
	}
	try {
		conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/member?useUnicode=true&characterEncoding=utf-8", "root", "1111");
		query = "insert into arka(arka_id,arka_score) values(?,?)";
		ps = conn.prepareStatement(query);
		ps.setString(1, id);
		ps.setInt(2, score2);
		ps.executeUpdate(); //rs 결과는 null, 1명의 회원정보 리턴
		out.println("성공");
		
	} catch (SQLException e) {
		out.println(e);
	} catch( Exception e ){
		out.println(e);
	}finally {
		conn.close();
		ps.close();
		
	}
	response.sendRedirect("arka_select.jsp");
%>
