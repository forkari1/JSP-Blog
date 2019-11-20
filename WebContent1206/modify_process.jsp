<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java"
	import="java.sql.*,java.io.*,java.net.*,java.util.*,java.text.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	String userid = (String) session.getAttribute("member_id"); // 현재 로그인한 member id
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
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/member", "root", "1111");

		query = "update member set username=?, password=?, email=?, zipcode=?, address1=?, address2=?, phone=? where userid=?";
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, username);
		pstmt.setString(2, password);
		pstmt.setString(3, email);
		pstmt.setString(4, zipcode1 + "-" + zipcode2);
		pstmt.setString(5, address1);
		pstmt.setString(6, address2);
		pstmt.setString(7, phone1 + "-" + phone2 + "-" + phone3);
		pstmt.setString(8,userid);
		pstmt.executeUpdate();
		
		
		response.sendRedirect("MainForm.jsp?contentPage=select.jsp");
		
	} catch (SQLException e) {
		out.println(e);
	} catch (ClassNotFoundException e) {
		out.println(e);
	}catch(Exception e){
		out.println(e);
	}finally {
		conn.close();
		pstmt.close();
	}
%>