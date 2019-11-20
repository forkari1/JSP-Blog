<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" import="java.sql.*,java.util.Date"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	String na = request.getParameter("name");
	String em = request.getParameter("email");
	String sub = request.getParameter("subject");
	String cont = request.getParameter("content");
	String ymd = (new java.util.Date()).toLocaleString();
	String sql = null;
	Connection con = null;
	PreparedStatement st = null;
	int pos = 0;

	int cnt = 0;

	try {
		Class.forName("org.gjt.mm.mysql.Driver");
	} catch (ClassNotFoundException e) {
		out.println(e);
	}

	try {
		con = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/member?useUnicode=true&characterEncoding=utf-8", "root", "1111");

		sql = "insert into guestboard(name,email,inputdate,subject,content) values(?,?,?,?,?)";
		st = con.prepareStatement(sql);
		st.setString(1, na);
		st.setString(2, em);
		st.setString(3, ymd);
		st.setString(4, sub);
		st.setString(5, cont);
		cnt = st.executeUpdate();
		if (cnt > 0) {
			out.println("데이터가 성공적으로 입력되었습니다.");
		} else {
			out.println("데이터가 입력되지 않았습니다. ");
		}
		st.close();
		con.close();
	} catch (SQLException e) {
		out.println(e);
	}
	catch (Exception e) {
		out.println(e);
	}
%>
<jsp:forward page="MainForm.jsp?contentPage=dbgb_show.jsp" />