<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" import="java.io.*,java.sql.*,java.util.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<HTML>
<HEAD>
<TITLE>글 읽기</TITLE>
<link href="databoard.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>
	<CENTER>
		<%
			String sqltext = null;
			Connection conn = null;
			PreparedStatement st = null;
			ResultSet rs = null;
			int cnt = 0;
			int id = Integer.parseInt(request.getParameter("id"));
			String url = application.getRealPath("/upload");

			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				out.println(e);
			}

			try {
				conn = java.sql.DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/member?useUnicode=true&characterEncoding=utf-8", "root", "1111");
			} catch (java.sql.SQLException e) {
				out.println(e);
			}

			try {
				sqltext = "select * from databoard where id=? ";
				st = conn.prepareStatement(sqltext);
				st.setInt(1, id);

				rs = st.executeQuery();
				if (!(rs.next())) {
					out.println("해당 내용이 없습니다");
				} else {
					String finame = rs.getString("filename");
					if ((finame != null) && (!(finame.equals("")))) {
						finame = "<A href=down.jsp?file=" + finame + ">" + finame + "</A>";
						finame = finame + "(" + rs.getInt("filesize") + " Bytes)";
					}
					sqltext = "update databoard set readcount= readcount + 1";
					sqltext = sqltext + " where id= ?";
					st = conn.prepareStatement(sqltext);
					st.setInt(1, id);
					st.executeUpdate();
					sqltext = "select * from databoard where id=? ";
					st = conn.prepareStatement(sqltext);
					st.setInt(1, id);

					rs = st.executeQuery();
					rs.next();
					out.println("<table width='600' cellspacing='0' cellpadding='2'>");
					out.println("<tr align='right'>");
					out.println("<td height='22'>&nbsp;</tr>");
					out.println("<tr align='center'>");
					out.println("<td height='1' bgcolor='#1F4F8F'></td>");
					out.println("</tr>");
					out.println("<tr align='center' bgcolor='#DFEDFF'>");
					out.println("<td class='button' bgcolor='#DFEDFF'>");
					out.println("<div align='left'><font size='2'>" + rs.getString("subject") + "</div></td>");
					out.println("</tr>");
					out.println("<tr align='center' bgcolor='#FFFFFF'>");
					out.println("<td align='center' bgcolor='#F4F4F4'>");
					out.println("<table width='100%' border='0' cellpadding='0' cellspacing='4' height='1'>");
					out.println("<tr bgcolor='#F4F4F4'>");
					out.println("<td width='13%' height='7'></td>");
					out.println("<td width='38%' height='7'>글쓴이 : " + rs.getString("name") + "</td>");
					out.println("<td width='38%' height='7'>파일이름 : " + finame + "</td>");
					out.println("<td width='11%' height='7'></td>");
					out.println("</tr>");
					out.println("<tr bgcolor='#F4F4F4'>");
					out.println("<td width='13%'></td>");
					out.println("<td width='38%'>작성일 : " + rs.getString("inputdate") + "</td>");
					out.println("<td width='38%'>조회 : " + rs.getInt("readcount") + "</td>");
					out.println("<td width='11%'></td>");
					out.println("</tr>");
					out.println("</table>");
					out.println("</td>");
					out.println("</tr>");
					out.println("<tr align='center'>");
					out.println("<td bgcolor='#1F4F8F' height='1'></td>");
					out.println("</tr>");
					out.println("<tr align='center'>");
					out.println("<td style='padding:10 0 0 0'>");
					out.println("<div align='left'><br>");
					out.println("<font size='3' color='#333333'><PRE>" + rs.getString("content") + "</PRE></div>");
					out.println("<br>");
					out.println("</td>");
					out.println("</tr>");
					out.println("<tr align='center'>");
					out.println("<td class='button' height='1'></td>");
					out.println("</tr>");
					out.println("<tr align='center'>");
					out.println("<td bgcolor='#1F4F8F' height='1'></td>");
					out.println("</tr>");
					out.println("</table>");
		%>
		<table width="600" border="0" cellpadding="0" cellspacing="5">
			<tr>
				<td width="56"><A
					href="databoard_upd.jsp?id=<%=request.getParameter("id")%>&page=<%=request.getParameter("page")%>"><img
						src="image/edit.jpg" width="66" height="21" border=0></A></td>
				<td width="56"><A
					href="databoard_del.jsp?id=<%=request.getParameter("id")%>&page=<%=request.getParameter("page")%>"><img
						src="image/del.jpg" width="66" height="21" border=0></A></td>
				<td width="66"><A
					href="databoard_rwrite.jsp?id=<%=request.getParameter("id")%>&page=<%=request.getParameter("page")%>"><img
						src="image/reply.jpg" width="66" height="21" border=0></A></td>
				<td width="406">&nbsp;</td>
				<td width="16"><A
					href="databoard_list.jsp?go=<%=request.getParameter("page")%>"><img
						src="image/list.jpg" width="66" height="21" border=0></a></td>
			</tr>
		</table>
		<%
			}
				rs.close();
				st.close();
				conn.close();
			} catch (java.sql.SQLException e) {
				out.println(e);
			}
		%>
	</CENTER>
</BODY>
</HTML>